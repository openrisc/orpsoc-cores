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
	input 		  wb_clk_i,
	input 		  wb_rst_i,
	// Avalon Slave input
	input [AW-1:0] 	  s_av_address_i,
	input [DW/8-1:0]  s_av_byteenable_i,
	input 		  s_av_read_i,
	output [DW-1:0]   s_av_readdata_o,
	input [7:0] 	  s_av_burstcount_i,
	input 		  s_av_write_i,
	input [DW-1:0] 	  s_av_writedata_i,
	output 		  s_av_waitrequest_o,
	output 		  s_av_readdatavalid_o,
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

always @(posedge wb_clk_i)
	if (wb_rst_i)
		read_access <= 0;
	else if (wbm_ack_i | wbm_err_i)
		read_access <= 0;
	else if (s_av_read_i)
		read_access <= 1;

reg readdatavalid;
reg [DW-1:0] readdata;
always @(posedge wb_clk_i) begin
	readdatavalid <= (wbm_ack_i | wbm_err_i) & read_access;
	readdata <= wbm_dat_i;
end

assign wbm_adr_o = s_av_address_i;
assign wbm_dat_o = s_av_writedata_i;
assign wbm_sel_o =  s_av_byteenable_i;
assign wbm_we_o = s_av_write_i;
assign wbm_cyc_o = read_access | s_av_write_i;
assign wbm_stb_o = read_access | s_av_write_i;
assign wbm_cti_o = 3'b111; // TODO: support burst accesses
assign wbm_bte_o = 2'b00;
assign s_av_waitrequest_o = !(wbm_ack_i | wbm_err_i);
assign s_av_readdatavalid_o = readdatavalid;
assign s_av_readdata_o = readdata;

endmodule
