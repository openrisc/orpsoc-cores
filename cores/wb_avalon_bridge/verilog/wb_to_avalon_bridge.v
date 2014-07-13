/*
 * Copyright (c) 2013, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
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

module wb_to_avalon_bridge #(
	parameter DW = 32,	// Data width
	parameter AW = 32,	// Address width
	parameter BURST_SUPPORT = 0
)(
	input 		  wb_clk_i,
	input 		  wb_rst_i,
	// Wishbone Slave Input
	input [AW-1:0] 	  wb_adr_i,
	input [DW-1:0] 	  wb_dat_i,
	input [DW/8-1:0]  wb_sel_i,
	input 		  wb_we_i,
	input 		  wb_cyc_i,
	input 		  wb_stb_i,
	input [2:0] 	  wb_cti_i,
	input [1:0] 	  wb_bte_i,
	output [DW-1:0]   wb_dat_o,
	output 		  wb_ack_o,
	output 		  wb_err_o,
	output 		  wb_rty_o,
	// Avalon Master Output
	output [AW-1:0]   m_av_address_o,
	output [DW/8-1:0] m_av_byteenable_o,
	output 		  m_av_read_o,
	input [DW-1:0] 	  m_av_readdata_i,
	output [7:0] 	  m_av_burstcount_o,
	output 		  m_av_write_o,
	output [DW-1:0]   m_av_writedata_o,
	input 		  m_av_waitrequest_i,
	input 		  m_av_readdatavalid_i
);

wire cycstb = wb_cyc_i & wb_stb_i;

generate if (BURST_SUPPORT == 1) begin : burst_enable
localparam IDLE		= 3'd0;
localparam READ		= 3'd1;
localparam WRITE	= 3'd2;
localparam BURST	= 3'd3;
localparam FLUSH_PIPE	= 3'd4;

localparam CLASSIC	= 3'b000;
localparam CONST_BURST	= 3'b001;
localparam INC_BURST	= 3'b010;
localparam END_BURST	= 3'b111;

localparam LINEAR_BURST	= 2'b00;
localparam WRAP4_BURST	= 2'b01;
localparam WRAP8_BURST	= 2'b10;
localparam WRAP16_BURST	= 2'b11;

reg [2:0]	state;

reg [3:0]	pending_reads;
reg [3:0]	reads_left;

reg [AW-1:0] 	adr;
wire [AW-1:0] 	curr_adr;
wire [AW-1:0] 	next_adr;
reg		read_req;
wire [AW-1:0] 	wb_burst_req;

//
// Avalon bursts can be either linear or wrapped, but that is a synthesis,
// not a runtime option.
// We have no way to know what kind of bursts are supported by the slaves we
// connect to, so instead of doing real bursts, we pipeline (up to) the number
// of reads that the wishbone side have requested in the burst.
// For linear bursts, 8 accesses are pipelined.
// This implies that only bursted reads are curently supported,
// A future improvement would be to let the user choose one of the burst
// modes by parameters and handle those as proper bursts.
//
assign curr_adr = (state == IDLE) ? wb_adr_i : adr;
assign next_adr = (wb_bte_i == LINEAR_BURST) ?
		  (curr_adr[AW-1:0] + 32'd4) :
		  (wb_bte_i == WRAP4_BURST ) ?
		  {curr_adr[AW-1:4], curr_adr[3:0] + 4'd4} :
		  (wb_bte_i == WRAP8_BURST ) ?
		  {curr_adr[AW-1:5], curr_adr[4:0] + 5'd4} :
		/*(wb_bte_i == WRAP16_BURST) ?*/
		  {curr_adr[AW-1:6], curr_adr[5:0] + 6'd4};

assign wb_burst_req = cycstb & (wb_cti_i == INC_BURST);

always @(posedge wb_clk_i) begin
	read_req <= 0;
	case (state)
	IDLE: begin
		pending_reads <= 0;
		adr <= wb_adr_i;
		if (cycstb & !m_av_waitrequest_i) begin
			if (wb_we_i)
				state <= WRITE;
			else if (wb_burst_req) begin
				// Set counter for number of reads left,
				// calculated by the burst count minus one
				// for the current read (performed by the
				// bypass) and one for the read initiated
				// here.
				case (wb_bte_i)
				WRAP4_BURST:
					reads_left <= 4 - 2;

				LINEAR_BURST,
				WRAP8_BURST:
					reads_left <= 8 - 2;

				WRAP16_BURST:
					reads_left <= 16 - 2;
				endcase

				pending_reads <= 1;
				read_req <= 1;
				adr <= next_adr;

				state <= BURST;
			end else
				state <= READ;
		end
	end

	READ: begin
		if (m_av_readdatavalid_i)
			state <= IDLE;
	end

	BURST: begin
		// Pipeline remaining reads.
		// pending_reads increase when a new read is pipelined and
		// decrease when a pending read is acknowledged.
		// On cycles where both a read is pipelined and a pending read
		// is acked, pending_reads do not change.
		read_req <= 1;
		if (m_av_readdatavalid_i)
			pending_reads <= pending_reads - 1;

		if (!m_av_waitrequest_i && reads_left != 0) begin
			pending_reads <= pending_reads + 1;
			if (m_av_readdatavalid_i)
				pending_reads <= pending_reads;
			reads_left <= reads_left - 1;
			adr <= next_adr;
		end

		// All reads pipelined?
		if (reads_left == 0 && !(m_av_waitrequest_i & read_req)) begin
			read_req <= 0;
			// Last transaction done, go back to IDLE
			if (m_av_readdatavalid_i && pending_reads == 0)
				state <= IDLE;
		end

		// If the burst ends prematurely, we have to wait out the
		// already pipelined reads before we can accept new requests.
		if (m_av_readdatavalid_i & !wb_burst_req & pending_reads != 0)
			state <= FLUSH_PIPE;
	end

	FLUSH_PIPE: begin
		if (m_av_readdatavalid_i) begin
			if (pending_reads == 0)
				state <= IDLE;
			pending_reads <= pending_reads - 1;
		end
	end

	WRITE: begin
		state <= IDLE;
	end

	default:
		state <= IDLE;
	endcase

	if (wb_rst_i) begin
		read_req <= 0;
		state <= IDLE;
	end
end

assign m_av_address_o = curr_adr;
assign m_av_read_o = cycstb & !wb_we_i & (state == IDLE) | read_req;
assign m_av_write_o = cycstb & wb_we_i & (state == IDLE);

assign wb_ack_o = m_av_readdatavalid_i & (state != FLUSH_PIPE) |
		   (state == WRITE);

end else begin : burst_disable

reg	cycstb_r;
wire	req;
reg	write_ack;

always @(posedge wb_clk_i)
	cycstb_r <= cycstb & !wb_ack_o;

assign req = cycstb & (!cycstb_r | m_av_waitrequest_i);

always @(posedge wb_clk_i)
	write_ack <= cycstb & wb_we_i & !m_av_waitrequest_i & !wb_ack_o;

assign m_av_address_o = wb_adr_i;
assign m_av_write_o = req & wb_we_i;
assign m_av_read_o = req & !wb_we_i;
assign wb_ack_o = write_ack | m_av_readdatavalid_i;
end
endgenerate

assign m_av_burstcount_o = 8'h1;
assign m_av_writedata_o = wb_dat_i;
assign m_av_byteenable_o = wb_sel_i;
assign wb_dat_o = m_av_readdata_i;
assign wb_err_o = 0;
assign wb_rty_o = 0;

endmodule
