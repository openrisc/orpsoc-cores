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
	parameter AW = 32	// Address width
)(
	input 		  clk,
	input 		  rst,
	// Wishbone Master Input
	input [AW-1:0] 	  wbm_adr_i,
	input [DW-1:0] 	  wbm_dat_i,
	input [DW/8-1:0]  wbm_sel_i,
	input 		  wbm_we_i,
	input 		  wbm_cyc_i,
	input 		  wbm_stb_i,
	input [2:0] 	  wbm_cti_i,
	input [1:0] 	  wbm_bte_i,
	output [DW-1:0]   wbm_dat_o,
	output 		  wbm_ack_o,
	output 		  wbm_err_o,
	output 		  wbm_rty_o,
	// Avalon Master Output
	output [AW-1:0]   avm_address_o,
	output [DW/8-1:0] avm_byteenable_o,
	output 		  avm_read_o,
	input [DW-1:0] 	  avm_readdata_i,
	output [7:0] 	  avm_burstcount_o,
	output 		  avm_write_o,
	output [DW-1:0]   avm_writedata_o,
	input 		  avm_waitrequest_i,
	input 		  avm_readdatavalid_i
);

wire	cycstb;
reg	cycstb_r;
wire	req;
reg	write_ack;

assign cycstb = wbm_cyc_i & wbm_stb_i;

always @(posedge clk)
	cycstb_r <= cycstb & !wbm_ack_o;

assign req = cycstb & (!cycstb_r | avm_waitrequest_i);

always @(posedge clk)
	write_ack <= cycstb & wbm_we_i & !avm_waitrequest_i & !wbm_ack_o;

assign avm_address_o = wbm_adr_i;
assign avm_burstcount_o = 8'h1; // TODO: support bursts
assign avm_byteenable_o = wbm_sel_i;
assign avm_write_o = req & wbm_we_i;
assign avm_writedata_o = wbm_dat_i;
assign avm_read_o = req & !wbm_we_i;
assign wbm_dat_o = avm_readdata_i;
assign wbm_ack_o = write_ack | avm_readdatavalid_i;
assign wbm_err_o = 0;
assign wbm_rty_o = 0;

endmodule
