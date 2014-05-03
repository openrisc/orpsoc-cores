//////////////////////////////////////////////////////////////////////
///                                                               //// 
/// Wishbone multiplexer, burst-compatible                        ////
///                                                               ////
/// Simple mux with an arbitrary number of slaves.                ////
///                                                               ////
/// The parameters MATCH_ADDR and MATCH_MASK are flattened arrays ////
/// aw*NUM_SLAVES sized arrays that are used to calculate the     ////
/// active slave. slave i is selected when                        ////
/// (wb_adr_i & MATCH_MASK[(i+1)*aw-1:i*aw] is equal to           ////
/// MATCH_ADDR[(i+1)*aw-1:i*aw]                                   ////
/// If several regions are overlapping, the slave with the lowest ////
/// index is selected. This can be used to have fallback          ////
/// functionality in the last slave, in case no other slave was   ////
/// selected.                                                     ////
///                                                               ////
/// If no match is found, the wishbone transaction will stall and ////
/// an external watchdog is required to abort the transaction     ////
///                                                               ////
/// Olof Kindgren, olof@opencores.org                             ////
///                                                               ////
/// Todo:                                                         ////
/// Registered master/slave connections                           ////
/// Rewrite with System Verilog 2D arrays when tools support them ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2013 Authors and OPENCORES.ORG                 ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

module wb_mux
  #(parameter dw = 32,        // Data width
    parameter aw = 32,        // Address width
    parameter num_slaves = 2, // Number of slaves
    parameter [num_slaves*aw-1:0] MATCH_ADDR = 0,
    parameter [num_slaves*aw-1:0] MATCH_MASK = 0)
   
   (input                      wb_clk_i,
    input 		       wb_rst_i,

    // Master Interface
    input [aw-1:0] 	       wbm_adr_i,
    input [dw-1:0] 	       wbm_dat_i,
    input [3:0] 	       wbm_sel_i,
    input 		       wbm_we_i,
    input 		       wbm_cyc_i,
    input 		       wbm_stb_i,
    input [2:0] 	       wbm_cti_i,
    input [1:0] 	       wbm_bte_i,
    output [dw-1:0] 	       wbm_dat_o,
    output 		       wbm_ack_o,
    output 		       wbm_err_o,
    output 		       wbm_rty_o, 
    // Wishbone Slave interface
    output [num_slaves*aw-1:0] wbs_adr_o,
    output [num_slaves*dw-1:0] wbs_dat_o,
    output [num_slaves*4-1:0]  wbs_sel_o, 
    output [num_slaves-1:0]    wbs_we_o,
    output [num_slaves-1:0]    wbs_cyc_o,
    output [num_slaves-1:0]    wbs_stb_o,
    output [num_slaves*3-1:0]  wbs_cti_o,
    output [num_slaves*2-1:0]  wbs_bte_o,
    input [num_slaves*dw-1:0]  wbs_dat_i,
    input [num_slaves-1:0]     wbs_ack_i,
    input [num_slaves-1:0]     wbs_err_i,
    input [num_slaves-1:0]     wbs_rty_i);

`include "verilog_utils.vh"

///////////////////////////////////////////////////////////////////////////////
// Master/slave connection
///////////////////////////////////////////////////////////////////////////////

   localparam slave_sel_bits = num_slaves > 1 ? `clog2(num_slaves) : 1;

   reg  			 wbm_err;
   wire [slave_sel_bits-1:0] 	 slave_sel;
   wire [num_slaves-1:0] 	 match;

   genvar 			 idx;

   generate
      for(idx=0; idx<num_slaves ; idx=idx+1) begin : addr_match
	 assign match[idx] = (wbm_adr_i & MATCH_MASK[idx*aw+:aw]) == MATCH_ADDR[idx*aw+:aw];
      end
   endgenerate

   assign slave_sel = ff1(match, num_slaves);

   always @(posedge wb_clk_i)
     wbm_err <= wbm_cyc_i & !(|match);

   assign wbs_adr_o = {num_slaves{wbm_adr_i}};
   assign wbs_dat_o = {num_slaves{wbm_dat_i}};
   assign wbs_sel_o = {num_slaves{wbm_sel_i}};
   assign wbs_we_o  = {num_slaves{wbm_we_i}};

   assign wbs_cyc_o = match & (wbm_cyc_i << slave_sel);
   assign wbs_stb_o = {num_slaves{wbm_stb_i}};
   
   assign wbs_cti_o = {num_slaves{wbm_cti_i}};
   assign wbs_bte_o = {num_slaves{wbm_bte_i}};

   assign wbm_dat_o = wbs_dat_i[slave_sel*dw+:dw];
   assign wbm_ack_o = wbs_ack_i[slave_sel];
   assign wbm_err_o = wbs_err_i[slave_sel] | wbm_err;
   assign wbm_rty_o = wbs_rty_i[slave_sel];

endmodule
