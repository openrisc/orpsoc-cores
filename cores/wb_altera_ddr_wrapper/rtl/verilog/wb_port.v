/*
 * Copyright (c) 2011, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * Copyright (c) 2014, Franck Jullien <franck.jullien@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module wb_port #(
	parameter BUF_WIDTH = 3
)
(
	// Wishbone
	input			wb_clk,
	input			wb_rst,
	input		[31:0]	wb_adr_i,
	input			wb_stb_i,
	input			wb_cyc_i,
	input		[2:0]	wb_cti_i,
	input		[1:0]	wb_bte_i,
	input			wb_we_i,
	input		[3:0]	wb_sel_i,
	input		[31:0]	wb_dat_i,
	output		[31:0]	wb_dat_o,
	output			wb_ack_o,

	// Internal interface
	input			sdram_rst,
	input			sdram_clk,
	input		[31:0]	adr_i,
	output		[31:0]	adr_o,
	input		[31:0]	dat_i,
	output		[31:0]	dat_o,
	output		[3:0]	sel_o,
	output reg		acc_o,
	input			ack_i,
	output reg		we_o,
	output		[3:0]	buf_width_o,

	// Buffer write
	input [31:0]		bufw_adr_i,
	input [31:0]		bufw_dat_i,
	input [3:0]		bufw_sel_i,
	input			bufw_we_i
);

	reg  [31:0]			wb_adr;
	reg  [31:0]			wb_dat;
	reg  [3:0]			wb_sel;
	reg				wb_read_ack;
	reg				wb_write_ack;
	wire [31:0]			next_wb_adr;

	reg				wb_write_bufram;
	reg				sdram_write_bufram;
	wire [3:0]			wb_bufram_we;
	wire [BUF_WIDTH-1:0]		wb_bufram_addr;
	wire [31:0]			wb_bufram_di;
	wire [3:0]			sdram_bufram_we;

	reg  [31:BUF_WIDTH+2]		buf_adr;
	reg  [(1<<BUF_WIDTH)-1:0]	buf_clean;
	reg  [(1<<BUF_WIDTH)-1:0]	buf_clean_r;
	reg  [(1<<BUF_WIDTH)-1:0]	buf_clean_wb;
	wire				bufhit;
	wire				next_bufhit;
	wire				bufw_hit;

	reg				read_req_wb;
	reg				read_req;
	reg				read_req_sdram;
	reg				read_done;
	reg				read_done_ack;

	reg  [31:0]			dat_r;
	reg  [31:0]			adr_o_r;
	reg  [31:0]			adr_i_r;
	wire				even_adr;
	reg  [31:0]			cycle_count;
	reg  [31:0]			ack_count;

	reg				first_req;

	reg  [2:0]			sdram_state;
	reg  [2:0]			wb_state;

	wire				wrfifo_full;
	wire				wrfifo_empty;
	wire				wrfifo_rdreq;
	wire				wrfifo_wrreq;
	wire [71:0]			wrfifo_rddata;

	wire [3:0]			sdram_sel;
	wire [31:0]			sdram_dat;
	wire [31:0]			sdram_adr;

	reg [3:0]			count;

	assign buf_width_o = BUF_WIDTH;

	localparam [2:0]
		IDLE		= 3'd0,
		READ		= 3'd1,
		WRITE		= 3'd2,
		WRITE_LAST	= 3'd3,
		REFILL		= 3'd4,
		WAIT_LATENCY	= 3'd5,
		READ_DONE	= 3'd6;


	localparam [2:0]
		CLASSIC      = 3'b000,
		CONST_BURST  = 3'b001,
		INC_BURST    = 3'b010,
		END_BURST    = 3'b111;

	localparam [1:0]
		LINEAR_BURST = 2'b00,
		WRAP4_BURST  = 2'b01,
		WRAP8_BURST  = 2'b10,
		WRAP16_BURST = 2'b11;

	assign wrfifo_wrreq  = wb_write_ack & !wrfifo_full;
	assign wb_ack_o      = wb_read_ack | wrfifo_wrreq;

	assign next_wb_adr   = (wb_bte_i == LINEAR_BURST) ?
			       (wb_adr_i[31:0] + 32'd4) :
			       (wb_bte_i == WRAP4_BURST ) ?
			       {wb_adr_i[31:4], wb_adr_i[3:0] + 4'd4} :
			       (wb_bte_i == WRAP8_BURST ) ?
			       {wb_adr_i[31:5], wb_adr_i[4:0] + 5'd4} :
			     /*(wb_bte_i == WRAP16_BURST) ?*/
			       {wb_adr_i[31:6], wb_adr_i[5:0] + 6'd4};

	assign bufhit	     = (buf_adr == wb_adr_i[31:BUF_WIDTH+2]) &
			       buf_clean_wb[wb_adr_i[BUF_WIDTH+1:2]];
	assign next_bufhit   = (buf_adr == next_wb_adr[31:BUF_WIDTH+2]) &
			       buf_clean_wb[next_wb_adr[BUF_WIDTH+1:2]];
	assign bufw_hit      = (bufw_adr_i[31:BUF_WIDTH+2] ==
				buf_adr[31:BUF_WIDTH+2]);

	assign even_adr      = (adr_i[1] == 1'b0);

	assign adr_o	     = (sdram_state == WRITE) ? sdram_adr : adr_o_r;
	assign dat_o	     = sdram_dat;
	assign sel_o	     = sdram_sel;

	assign wrfifo_rdreq  = (sdram_state == IDLE) & !wrfifo_empty;

	assign wb_bufram_we  = bufw_we_i & bufw_hit ? bufw_sel_i :
			       wb_write_bufram ? wb_sel : 4'b0;

	assign wb_bufram_addr = bufw_we_i & bufw_hit ?
			        bufw_adr_i[BUF_WIDTH+1:2] :
			        wb_write_bufram ?
			        wb_adr[BUF_WIDTH+1:2] :
			        (wb_cti_i == INC_BURST) & wb_ack_o ?
			        next_wb_adr[BUF_WIDTH+1:2] :
			        wb_adr_i[BUF_WIDTH+1:2];
	assign wb_bufram_di   = bufw_we_i & bufw_hit ? bufw_dat_i : wb_dat;
	assign sdram_bufram_we = {4{sdram_write_bufram}};

	assign sdram_sel      = wrfifo_rddata[3:0];
	assign sdram_dat      = wrfifo_rddata[35:4];
	assign sdram_adr      = {wrfifo_rddata[65:36], 2'b00};

bufram #(
	.ADDR_WIDTH(BUF_WIDTH)
) bufram (
	.clk_a		(wb_clk),
	.addr_a		(wb_bufram_addr),
	.we_a		(wb_bufram_we),
	.di_a		(wb_bufram_di),
	.do_a		(wb_dat_o),

	.clk_b		(sdram_clk),
	.addr_b		(adr_i_r[BUF_WIDTH+1:2]),
	.we_b		(sdram_bufram_we),
	.di_b		(dat_r),
	.do_b		()
);

dual_clock_fifo #(
	.ADDR_WIDTH(3),
	.DATA_WIDTH(72)
) wrfifo (
	.wr_rst_i	(wb_rst),
	.wr_clk_i	(wb_clk),
	.wr_en_i	(wrfifo_wrreq),
	.wr_data_i	({6'b0, wb_adr_i[31:2],  wb_dat_i,  wb_sel_i}),

	.rd_rst_i	(sdram_rst),
	.rd_clk_i	(sdram_clk),
	.rd_en_i	(wrfifo_rdreq),
	.rd_data_o	(wrfifo_rddata),

	.full_o		(wrfifo_full),
	.empty_o	(wrfifo_empty)
);

	reg	read_done_wb;
	reg	read_done_r;

	//
	// WB clock domain
	//
	always @(posedge wb_clk)
		if (wb_rst) begin
			read_done_r <= 1'b0;
			read_done_wb <= 1'b0;
		end else begin
			read_done_r  <= read_done;
			read_done_wb <= read_done_r;
		end

	always @(posedge wb_clk)
		if (wb_rst) begin
			wb_read_ack <= 1'b0;
			wb_write_ack <= 1'b0;
			wb_write_bufram <= 1'b0;
			read_req_wb <= 1'b0;
			first_req <= 1'b1;
			wb_adr <= 0;
			wb_dat <= 0;
			wb_sel <= 0;
			wb_state <= IDLE;
			buf_adr <= 0;
		end else begin
			wb_read_ack <= 1'b0;
			wb_write_ack <= 1'b0;
			wb_write_bufram <= 1'b0;
			case (wb_state)
			IDLE: begin
				wb_sel <= wb_sel_i;
				wb_dat <= wb_dat_i;
				wb_adr <= wb_adr_i;
				if (wb_cyc_i & wb_stb_i & !wb_we_i) begin
					if (bufhit & !first_req) begin
						wb_read_ack <= 1'b1;
						if ((wb_cti_i == CLASSIC) | read_done_wb)
							wb_state <= READ_DONE;
						else
							wb_state <= READ;

					/*
					 * wait for the ongoing refill to finish
					 * until issuing a new request
					 */
					end else if ((buf_clean_wb[wb_adr_i[BUF_WIDTH+1:2]] |
						     first_req) & !read_done_wb) begin
						first_req <= 1'b0;
						read_req_wb <= 1'b1;
						wb_state <= REFILL;
					end
				end else if (wb_cyc_i & wb_stb_i & wb_we_i &
					     (bufhit & (&buf_clean_wb) | first_req |
					      buf_adr != wb_adr_i[31:BUF_WIDTH+2])) begin
					if (!wrfifo_full)
						wb_write_ack <= 1'b1;

					if (bufhit)
						wb_write_bufram <= 1'b1;

					if (!read_done_wb)
						wb_state <= WRITE;
				end

			end

			READ: begin
				if (wb_cyc_i & wb_stb_i & !wb_we_i &
				   (wb_cti_i == INC_BURST) & next_bufhit) begin
					wb_read_ack <= 1'b1;
				end else begin
					wb_state <= IDLE;
				end
			end

			REFILL: begin
				buf_adr <= wb_adr[31:BUF_WIDTH+2];
				if (read_done_wb) begin
					read_req_wb <= 1'b0;
					wb_state <= IDLE;
				end
			end

			WRITE: begin
				if (wb_cyc_i & wb_stb_i & wb_we_i) begin

					if (!wrfifo_full)
						wb_write_ack <= 1'b1;

					if (bufhit) begin
						wb_sel <= wb_sel_i;
						wb_dat <= wb_dat_i;
						wb_adr <= wb_adr_i;
						wb_write_bufram <= 1'b1;
					end
				end

				if ((wb_cti_i == END_BURST) & wb_ack_o) begin
					wb_state <= WRITE_LAST;
					wb_write_ack <= 1'b0;
				end

				if ((wb_cti_i == CLASSIC) & wb_ack_o) begin
					wb_state <= IDLE;
					wb_write_ack <= 1'b0;
				end

			end

			WRITE_LAST: begin
				wb_state <= IDLE;
			end

			READ_DONE: begin
				wb_read_ack <= 1'b0;
				wb_state <= IDLE;
			end

			endcase
		end

	always @(posedge wb_clk) begin
		buf_clean_r <= buf_clean;
		buf_clean_wb <= buf_clean_r;
	end

	//
	// SDRAM clock domain
	//
	always @(posedge sdram_clk) begin
		read_req <= read_req_wb;
		read_req_sdram <= read_req;
	end

	always @(posedge sdram_clk) begin
		if (sdram_rst) begin
			sdram_state <= IDLE;
			acc_o <= 1'b0;
			we_o <= 1'b0;
			cycle_count <= 0;
			ack_count <= 0;
			read_done <= 1'b0;
			buf_clean <= {(1<<BUF_WIDTH){1'b0}};
			sdram_write_bufram <= 1'b0;
		end else begin
			sdram_write_bufram <= 1'b0;
			dat_r <= dat_i;
			adr_i_r <= adr_i;

			if (ack_i)
				ack_count <= ack_count + 1;

			case (sdram_state)
			IDLE: begin
				we_o <= 1'b0;
				ack_count <= 0;
				if (!wrfifo_empty) begin
					sdram_state <= WRITE;
					acc_o <= 1'b1;
					we_o <= 1'b1;
				end else if (read_req_sdram) begin
					buf_clean <= {(1<<BUF_WIDTH){1'b0}};
					sdram_state <= READ;
					adr_o_r <= {wb_adr[31:2], 2'b00};
					acc_o <= 1'b1;
					count <= 0;
				end
			end

			READ: begin
				if (ack_i) begin
					sdram_write_bufram <= 1'b1;
					buf_clean[adr_i[BUF_WIDTH+1:2]] <= 1'b1;
				end

				if (ack_count == ((1<<BUF_WIDTH)-1) & ack_i) begin
					acc_o <= 1'b0;
					read_done <= 1'b1;
					sdram_state <= WAIT_LATENCY;
				end
			end

			WRITE: begin
				if (ack_i) begin
					acc_o <= 1'b0;
					sdram_state <= IDLE;
				end
			end

			WAIT_LATENCY: begin
				if (!read_req_sdram) begin
					read_done <= 1'b0;
					sdram_state <= IDLE;
				end
			end

			default: begin
				sdram_state <= IDLE;
			end
			endcase
		end
	end
endmodule
