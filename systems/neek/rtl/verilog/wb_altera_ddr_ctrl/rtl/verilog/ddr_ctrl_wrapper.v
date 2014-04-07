/*
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

module ddr_ctrl_wrapper
(
	// SDRAM interface
	input			ctrl_clk_i,
	input			ctrl_rst_i,

	output			local_clk_o,
	output			local_rst_o,

	output			local_init_done_o,

	/* DDR */
	output	[1:0]		ddr_dm,
	inout	[15:0]		ddr_dq,
	inout	[1:0]		ddr_dqs,
	output	[12:0]		ddr_a,
	output	[1:0]		ddr_ba,
	output			ddr_cas_n,
	output			ddr_cke,
	inout			ddr_clk,
	inout			ddr_clk_n,
	output			ddr_cs_n,
	output			ddr_ras_n,
	output			ddr_we_n,

	// Internal interface
	output			rdy_o,
	output			idle_o,
	input		[31:0]	adr_i,
	output reg	[31:0]	adr_o,
	input		[31:0]	dat_i,
	output		[31:0]	dat_o,
	input		[3:0]	sel_i,
	input			acc_i,
	output			ack_o,
	input			we_i,
	input		[3:0]	buf_width_i
);

	wire	[22:0]	local_address;
	reg		local_write_req;
	reg		local_read_req;
	reg		local_burstbegin;
	wire	[31:0]	local_wdata;
	reg	[6:0]	local_size;
	wire	[31:0]	local_rdata;
	wire		local_rdata_valid;
	wire		local_reset_n;
	wire		local_clk;
	wire		local_ready;

	assign local_rst_o	= ~local_reset_n;
	assign local_clk_o	= local_clk;
	assign dat_o		= local_rdata;
	//assign local_address	= we_i ? adr_i[24:2] : {adr_i[24:BUF_WIDTH+2], {(BUF_WIDTH){1'b0}}};
	assign local_address	= we_i ? adr_i[24:2] : adr_i[24:2] & ~((1 << (buf_width_i)) - 1);
	assign local_wdata	= dat_i;

ddr_ctrl_ip ddr_ctrl_ip
(
	.local_address		(local_address),
	.local_write_req	(local_write_req),
	.local_read_req		(local_read_req),
	.local_burstbegin	(local_burstbegin),
	.local_wdata		(local_wdata),
	.local_be		(sel_i),
	.local_size		(local_size),

	.global_reset_n		(~ctrl_rst_i),
	.pll_ref_clk		(ctrl_clk_i),
	.soft_reset_n		(1'b1),

	.local_ready		(local_ready),
	.local_rdata		(local_rdata),
	.local_rdata_valid	(local_rdata_valid),
	.local_refresh_ack	(),
	.local_init_done	(local_init_done_o),

	.reset_phy_clk_n	(local_reset_n),

	.mem_cs_n		(ddr_cs_n),
	.mem_cke		(ddr_cke),
	.mem_addr		(ddr_a),
	.mem_ba			(ddr_ba),
	.mem_ras_n		(ddr_ras_n),
	.mem_cas_n		(ddr_cas_n),
	.mem_we_n		(ddr_we_n),
	.mem_dm			(ddr_dm),

	.phy_clk		(local_clk),
	.aux_full_rate_clk	(),
	.aux_half_rate_clk	(),
	.reset_request_n	(),

	.mem_clk		(ddr_clk),
	.mem_clk_n		(ddr_clk_n),
	.mem_dq			(ddr_dq),
	.mem_dqs		(ddr_dqs)
);

	reg [3:0]		state;
	reg [31:0]		count;
	reg			ack_w;

	// FSM states
	localparam [3:0]
		WAIT_READY    = 4'h0,
		IDLE          = 4'h1,
		WRITE         = 4'h2,
		READ          = 4'h3;

	assign rdy_o = local_ready;
	assign idle_o = (state == IDLE);

	assign ack_o = acc_i ? (we_i ? ack_w : local_rdata_valid) : 1'b0;

	always @(posedge local_clk) begin
		if (local_reset_n == 1'b0) begin
			local_write_req		<= 1'b0;
			local_read_req		<= 1'b0;
			local_burstbegin	<= 1'b0;
			local_size		<= 6'b1;
			count			<= 0;
			state <= WAIT_READY;
		end else begin

			ack_w <= 1'b0;
			local_burstbegin <= 1'b0;
			local_write_req <= 1'b0;
			local_burstbegin <= 1'b0;
			local_read_req <= 1'b0;

			case (state)

			WAIT_READY: begin
				if (local_ready)
					state <= IDLE;
			end

			IDLE: begin
				if (acc_i) begin
					if (we_i & local_ready) begin
						ack_w			<= 1'b1;
						local_burstbegin	<= 1'b1;
						local_write_req		<= 1'b1;
						local_size		<= 6'b1;
						state			<= WRITE;
					end
					if (!we_i & local_ready) begin
						local_burstbegin	<= 1'b1;
						local_read_req		<= 1'b1;
						state			<= READ;
						local_size		<= (1<<buf_width_i);
						//adr_o			<= {adr_i[31:BUF_WIDTH+2], {(BUF_WIDTH+2){1'b0}}};
						adr_o			<= adr_i & ~((1 << (buf_width_i + 2)) - 1);
						count			<= 0;
					end
				end
			end

			WRITE : begin
				state <= IDLE;
			end

			READ : begin
				if (local_rdata_valid) begin
					count <= count + 1'b1;
					//adr_o[BUF_WIDTH+1:2] <= adr_o[BUF_WIDTH+1:2] + 1;
					adr_o <= (adr_o & ~((1 << (buf_width_i + 2)) - 1)) | ((((adr_o >> 2) + 1) & ((1 << (buf_width_i)) - 1)) << 2);
				end

				if (count == (1<<buf_width_i)) begin
					count <= 0;
					state <= IDLE;
				end
			end


			endcase
		end
	end

endmodule
