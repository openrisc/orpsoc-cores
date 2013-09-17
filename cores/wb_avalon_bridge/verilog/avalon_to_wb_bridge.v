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

module avalon_to_wb_bridge #(
	parameter DW = 32,	// Data width
	parameter AW = 32	// Address width
)(
	input 		  clk,
	input 		  rst,
	// Avalon Master input
	input [AW-1:0] 	  avm_address_i,
	input [DW/8-1:0]  avm_byteenable_i,
	input 		  avm_read_i,
	output [DW-1:0]   avm_readdata_o,
	input [7:0] 	  avm_burstcount_i,
	input 		  avm_write_i,
	input [DW-1:0] 	  avm_writedata_i,
	output 		  avm_waitrequest_o,
	output 		  avm_readdatavalid_o,
	// Wishbone Master Output
	output [AW-1:0]   wbm_adr_o,
	output [DW-1:0]   wbm_dat_o,
	output [DW/8-1:0] wbm_sel_o,
	output 		  wbm_we_o,
	output 		  wbm_cyc_o,
	output 		  wbm_stb_o,
	output [2:0] 	  wbm_cti_o,
	output [1:0] 	  wbm_bte_o,
	input [DW-1:0] 	  wbm_dat_i,
	input 		  wbm_ack_i,
	input 		  wbm_err_i,
	input 		  wbm_rty_i
);

reg read_access;

always @(posedge clk)
	if (rst)
		read_access <= 0;
	else if (wbm_ack_i)
		read_access <= 0;
	else if (avm_read_i)
		read_access <= 1;

reg readdatavalid;
reg [DW-1:0] readdata;
always @(posedge clk) begin
	readdatavalid <= (wbm_ack_i | wbm_err_i) & read_access;
	readdata <= wbm_dat_i;
end

assign wbm_adr_o = avm_address_i;
assign wbm_dat_o = avm_writedata_i;
assign wbm_sel_o =  avm_byteenable_i;
assign wbm_we_o = avm_write_i;
assign wbm_cyc_o = read_access | avm_write_i;
assign wbm_stb_o = read_access | avm_write_i;
assign wbm_cti_o = 3'b111; // TODO: support burst accesses
assign wbm_bte_o = 2'b00;
assign avm_waitrequest_o = !(wbm_ack_i | wbm_err_i);
assign avm_readdatavalid_o = readdatavalid;
assign avm_readdata_o = readdata;

endmodule
