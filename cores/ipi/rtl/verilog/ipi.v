/*
 * Copyright (c) 2014, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
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

module ipi #(
	parameter NUM_CORES = 2
)(
	// Wishbone slave interface
	input 			   wb_clk,
	input 			   wb_rst,
	input [17:0] 		   wb_adr_i,
	input [31:0] 		   wb_dat_i,
	input [3:0] 		   wb_sel_i,
	input 			   wb_we_i,
	input 			   wb_cyc_i,
	input 			   wb_stb_i,
	input [2:0] 		   wb_cti_i,
	input [1:0] 		   wb_bte_i,
	output [31:0] 		   wb_dat_o,
	output reg		   wb_ack_o,
	output 			   wb_err_o,
	output 			   wb_rty_o,

	// Per-core Interrupt output
	output reg [0:NUM_CORES-1] irq
);

localparam
	CONTROL	= 0,
	STATUS	= 1;

localparam
	CTRL_IRQ_ACK	= 31,
	CTRL_IRQ_GEN	= 30;

// Control register
// +---------+---------+----------+---------+
// | 31      | 30      | 29 .. 16 | 15 .. 0 |
// ----------+---------+----------+----------
// | IRQ ACK | IRQ GEN | DST CORE | DATA    |
// +---------+---------+----------+---------+
reg [31:0] control [0:NUM_CORES-1];

// Status register
// +----------+-------------+----------+---------+
// | 31       | 30          | 29 .. 16 | 15 .. 0 |
// -----------+-------------+----------+---------+
// | Reserved | IRQ Pending | SRC CORE | DATA    |
// +----------+-------------+----------+---------+
reg [29:0] status [0:NUM_CORES-1];

// Write logic
always @(posedge wb_clk) begin
	if (wb_ack_o & wb_we_i & (wb_adr_i[3:2] == CONTROL)) begin
		control[wb_adr_i[17:4]] <= wb_dat_i;

		if (wb_dat_i[CTRL_IRQ_GEN]) begin
			irq[wb_dat_i[29:16]] <= 1;
			status[wb_dat_i[29:16]][15:0] <= wb_dat_i[15:0];
			status[wb_dat_i[29:16]][29:16] <= wb_adr_i[17:4];
		end

		if (wb_dat_i[CTRL_IRQ_ACK])
			irq[wb_adr_i[17:4]] <= 0;
	end
end

// Read logic
always @(posedge wb_clk) begin
	if (wb_cyc_i & wb_stb_i & !wb_we_i) begin
		case (wb_adr_i[3:2])
		CONTROL: begin
			wb_dat_o <= control[wb_adr_i[17:4]];
		end
		STATUS: begin
			wb_dat_o <= {1'b0, irq[wb_adr_i[17:4]],
				     status[wb_adr_i[17:4]]};
		end
		endcase
	end
end

// Ack logic
always @(posedge wb_clk)
	wb_ack_o <= wb_cyc_i & wb_stb_i & !wb_ack_o;

assign wb_err_o = 0;
assign wb_rty_o = 0;


endmodule
