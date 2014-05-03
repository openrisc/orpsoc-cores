//////////////////////////////////////////////////////////////////////
////                                                              ////
////  Xilinx DDR2 controller Wishbone Interface                   ////
////                                                              ////
////  Description                                                 ////
////  Simple interface to the Xilinx MIG generated DDR2 controller////
////  The interface presents five wishbone slaves,                ////
////  which are mapped into 32-bit user ports of the MIG          ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Stefan Kristiansson, stefan.kristiansson@saunalahti.fi////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2010 Authors and OPENCORES.ORG                 ////
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

module xilinx_ddr2_if ( 
    input [31:0]       wb0_adr_i,
    input 	           wb0_stb_i,
    input 	           wb0_cyc_i,
    input  [2:0]       wb0_cti_i,
    input  [1:0]       wb0_bte_i,
    input 	           wb0_we_i,
    input  [3:0]       wb0_sel_i,
    input  [31:0]      wb0_dat_i,
    output [31:0]      wb0_dat_o,
    output             wb0_ack_o,

    input [31:0]       wb1_adr_i,
    input              wb1_stb_i,
    input              wb1_cyc_i,
    input  [2:0]       wb1_cti_i,
    input  [1:0]       wb1_bte_i,
    input              wb1_we_i,
    input  [3:0]       wb1_sel_i,
    input  [31:0]      wb1_dat_i,
    output [31:0]      wb1_dat_o,
    output             wb1_ack_o,

    input [31:0]       wb2_adr_i,
    input              wb2_stb_i,
    input              wb2_cyc_i,
    input  [2:0]       wb2_cti_i,
    input  [1:0]       wb2_bte_i,
    input              wb2_we_i,
    input  [3:0]       wb2_sel_i,
    input  [31:0]      wb2_dat_i,
    output [31:0]      wb2_dat_o,
    output             wb2_ack_o,

    input [31:0]       wb3_adr_i,
    input              wb3_stb_i,
    input              wb3_cyc_i,
    input  [2:0]       wb3_cti_i,
    input  [1:0]       wb3_bte_i,
    input              wb3_we_i,
    input  [3:0]       wb3_sel_i,
    input  [31:0]      wb3_dat_i,
    output [31:0]      wb3_dat_o,
    output             wb3_ack_o,

    input [31:0]       wb4_adr_i,
    input              wb4_stb_i,
    input              wb4_cyc_i,
    input  [2:0]       wb4_cti_i,
    input  [1:0]       wb4_bte_i,
    input              wb4_we_i,
    input  [3:0]       wb4_sel_i,
    input  [31:0]      wb4_dat_i,
    output [31:0]      wb4_dat_o,
    output             wb4_ack_o,

    output [12:0]      ddr2_a,
    output [2:0]       ddr2_ba,
    output 	           ddr2_ras_n,
    output 	           ddr2_cas_n,
    output 	           ddr2_we_n,
    output             ddr2_rzq,
    output             ddr2_zio,
    output             ddr2_odt,
    output             ddr2_cke,
    output             ddr2_dm,
    output             ddr2_udm,

    inout [15:0]       ddr2_dq,		  
    inout              ddr2_dqs,
    inout              ddr2_dqs_n,
    inout              ddr2_udqs,
    inout              ddr2_udqs_n,
    output             ddr2_ck,
    output             ddr2_ck_n,

    input 	           ddr2_if_clk,
    input 	           ddr2_if_rst,
    input 	           wb_clk,
    input 	           wb_rst
,
   output [31:0] 		     ddr2_trace_data0_o,
   output [31:0] 		     ddr2_trace_data1_o,
   output [31:0] 		     ddr2_trace_data2_o,
   output [31:0] 		     ddr2_trace_data3_o,
   output [31:0] 		     ddr2_trace_data4_o,
   output [31:0] 		     ddr2_trace_data5_o
);
   
`include "orpsoc-defines.v"
`include "xilinx_ddr2_params.v"
    parameter NUM_USERPORTS = 5;
    parameter P0_BURST_ADDR_WIDTH = 4;
    parameter P0_BURST_ADDR_ALIGN = P0_BURST_ADDR_WIDTH + 2;
	 parameter P0_WB_BURSTING      = "TRUE";
	 
    parameter P1_BURST_ADDR_WIDTH = 5;
    parameter P1_BURST_ADDR_ALIGN = P1_BURST_ADDR_WIDTH + 2;
	 parameter P1_WB_BURSTING      = "TRUE";
  
    parameter P2_BURST_ADDR_WIDTH = 6;
    parameter P2_BURST_ADDR_ALIGN = P2_BURST_ADDR_WIDTH + 2;
	 parameter P2_WB_BURSTING      = "TRUE";
  
    parameter P3_BURST_ADDR_WIDTH = 4;
    parameter P3_BURST_ADDR_ALIGN = P3_BURST_ADDR_WIDTH + 2;
	 parameter P3_WB_BURSTING      = "TRUE";

    parameter P4_BURST_ADDR_WIDTH = 4;
    parameter P4_BURST_ADDR_ALIGN = P4_BURST_ADDR_WIDTH + 2;
	 parameter P4_WB_BURSTING      = "TRUE";

    wire 	              ddr2_clk; // DDR2 iface domain clock.
    wire 	              ddr2_rst; // reset from the ddr2 module
 
    wire  [31:0]        wb_px_adr_i[NUM_USERPORTS-1:0];
    wire 	              wb_px_stb_i[NUM_USERPORTS-1:0];
    wire 	              wb_px_cyc_i[NUM_USERPORTS-1:0];
    wire  [2:0]         wb_px_cti_i[NUM_USERPORTS-1:0];
    wire  [1:0]         wb_px_bte_i[NUM_USERPORTS-1:0];
    wire 	              wb_px_we_i[NUM_USERPORTS-1:0];
    wire  [3:0]         wb_px_sel_i[NUM_USERPORTS-1:0];
    wire  [31:0]        wb_px_dat_i[NUM_USERPORTS-1:0];
    wire  [31:0]        wb_px_dat_o[NUM_USERPORTS-1:0];
    wire                wb_px_ack_o[NUM_USERPORTS-1:0];
 
    wire 	              wb_px_req[NUM_USERPORTS-1:0];
    reg 		            wb_px_req_r[NUM_USERPORTS-1:0];
    wire 	              wb_px_req_new[NUM_USERPORTS-1:0];
    wire                wb_px_wr_req[NUM_USERPORTS-1:0];
   
    // DDR2 MIG interface wires
    wire                ddr2_px_cmd_full[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_full[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_en[NUM_USERPORTS-1:0];
    wire                ddr2_px_cmd_en[NUM_USERPORTS-1:0];
    wire [29:0]         ddr2_px_cmd_byte_addr[NUM_USERPORTS-1:0];
    wire [2:0]          ddr2_px_cmd_instr[NUM_USERPORTS-1:0];
    wire [31:0]         ddr2_px_wr_data[NUM_USERPORTS-1:0];
    wire [3:0]          ddr2_px_wr_mask[NUM_USERPORTS-1:0];
    wire [31:0]         ddr2_px_rd_data[NUM_USERPORTS-1:0];
    wire [5:0]          ddr2_px_cmd_bl[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_en[NUM_USERPORTS-1:0];
    wire                ddr2_px_cmd_empty[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_empty[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_count[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_underrun[NUM_USERPORTS-1:0];
    wire                ddr2_px_wr_error[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_full[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_empty[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_count[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_overflow[NUM_USERPORTS-1:0];
    wire                ddr2_px_rd_error[NUM_USERPORTS-1:0];
    wire 	              ddr2_calib_done;
    reg [1:0]           ddr2_calib_done_r;

    assign wb_px_adr_i[0] = wb0_adr_i;
    assign wb_px_stb_i[0] = wb0_stb_i;
    assign wb_px_cyc_i[0] = wb0_cyc_i;
    assign wb_px_cti_i[0] = wb0_cti_i;
    assign wb_px_bte_i[0] = wb0_bte_i;
    assign wb_px_we_i[0]  = wb0_we_i;
    assign wb_px_sel_i[0] = wb0_sel_i;
    assign wb_px_dat_i[0] = wb0_dat_i;
    assign wb0_dat_o = wb_px_dat_o[0];
    assign wb0_ack_o = wb_px_ack_o[0];

    assign wb_px_adr_i[1] = wb1_adr_i;
    assign wb_px_stb_i[1] = wb1_stb_i;
    assign wb_px_cyc_i[1] = wb1_cyc_i;
    assign wb_px_cti_i[1] = wb1_cti_i;
    assign wb_px_bte_i[1] = wb1_bte_i;
    assign wb_px_we_i[1]  = wb1_we_i;
    assign wb_px_sel_i[1] = wb1_sel_i;
    assign wb_px_dat_i[1] = wb1_dat_i;
    assign wb1_dat_o = wb_px_dat_o[1];
    assign wb1_ack_o = wb_px_ack_o[1];

    assign wb_px_adr_i[2] = wb2_adr_i;
    assign wb_px_stb_i[2] = wb2_stb_i;
    assign wb_px_cyc_i[2] = wb2_cyc_i;
    assign wb_px_cti_i[2] = wb2_cti_i;
    assign wb_px_bte_i[2] = wb2_bte_i;
    assign wb_px_we_i[2]  = wb2_we_i;
    assign wb_px_sel_i[2] = wb2_sel_i;
    assign wb_px_dat_i[2] = wb2_dat_i;
    assign wb2_dat_o = wb_px_dat_o[2];
    assign wb2_ack_o = wb_px_ack_o[2];

    assign wb_px_adr_i[3] = wb3_adr_i;
    assign wb_px_stb_i[3] = wb3_stb_i;
    assign wb_px_cyc_i[3] = wb3_cyc_i;
    assign wb_px_cti_i[3] = wb3_cti_i;
    assign wb_px_bte_i[3] = wb3_bte_i;
    assign wb_px_we_i[3]  = wb3_we_i;
    assign wb_px_sel_i[3] = wb3_sel_i;
    assign wb_px_dat_i[3] = wb3_dat_i;
    assign wb3_dat_o = wb_px_dat_o[3];
    assign wb3_ack_o = wb_px_ack_o[3];

    assign wb_px_adr_i[4] = wb4_adr_i;
    assign wb_px_stb_i[4] = wb4_stb_i;
    assign wb_px_cyc_i[4] = wb4_cyc_i;
    assign wb_px_cti_i[4] = wb4_cti_i;
    assign wb_px_bte_i[4] = wb4_bte_i;
    assign wb_px_we_i[4]  = wb4_we_i;
    assign wb_px_sel_i[4] = wb4_sel_i;
    assign wb_px_dat_i[4] = wb4_dat_i;
    assign wb4_dat_o = wb_px_dat_o[4];
    assign wb4_ack_o = wb_px_ack_o[4];

    // Map wishbone signals to/from DDR2 MIG controller

    wire        px_addr_dirty[NUM_USERPORTS-1:0];
    wire [31:0] px_cache_addr[NUM_USERPORTS-1:0];

    // Let the port know if another port have wrote to its current cache buffer address
    // TODO: own writes to own cache
    assign px_addr_dirty[0] = ((wb0_adr_i[31:P0_BURST_ADDR_ALIGN] == px_cache_addr[0][31:P0_BURST_ADDR_ALIGN]) & wb_px_wr_req[0]) |
                              ((wb1_adr_i[31:P0_BURST_ADDR_ALIGN] == px_cache_addr[0][31:P0_BURST_ADDR_ALIGN]) & wb_px_wr_req[1]) | 
                              ((wb2_adr_i[31:P0_BURST_ADDR_ALIGN] == px_cache_addr[0][31:P0_BURST_ADDR_ALIGN]) & wb_px_wr_req[2]) |
                              ((wb3_adr_i[31:P0_BURST_ADDR_ALIGN] == px_cache_addr[0][31:P0_BURST_ADDR_ALIGN]) & wb_px_wr_req[3]) |
                              ((wb4_adr_i[31:P0_BURST_ADDR_ALIGN] == px_cache_addr[0][31:P0_BURST_ADDR_ALIGN]) & wb_px_wr_req[4]);
                           
    assign px_addr_dirty[1] = ((wb0_adr_i[31:P1_BURST_ADDR_ALIGN] == px_cache_addr[1][31:P1_BURST_ADDR_ALIGN]) & wb_px_wr_req[0]) | 
                              ((wb1_adr_i[31:P1_BURST_ADDR_ALIGN] == px_cache_addr[1][31:P1_BURST_ADDR_ALIGN]) & wb_px_wr_req[1]) | 
                              ((wb2_adr_i[31:P1_BURST_ADDR_ALIGN] == px_cache_addr[1][31:P1_BURST_ADDR_ALIGN]) & wb_px_wr_req[2]) |
                              ((wb3_adr_i[31:P1_BURST_ADDR_ALIGN] == px_cache_addr[1][31:P1_BURST_ADDR_ALIGN]) & wb_px_wr_req[3]) |
                              ((wb4_adr_i[31:P1_BURST_ADDR_ALIGN] == px_cache_addr[1][31:P1_BURST_ADDR_ALIGN]) & wb_px_wr_req[4]);
                           
    assign px_addr_dirty[2] = ((wb0_adr_i[31:P2_BURST_ADDR_ALIGN] == px_cache_addr[2][31:P2_BURST_ADDR_ALIGN]) & wb_px_wr_req[0]) | 
                              ((wb1_adr_i[31:P2_BURST_ADDR_ALIGN] == px_cache_addr[2][31:P2_BURST_ADDR_ALIGN]) & wb_px_wr_req[1]) |
                              ((wb2_adr_i[31:P2_BURST_ADDR_ALIGN] == px_cache_addr[2][31:P2_BURST_ADDR_ALIGN]) & wb_px_wr_req[2]) |
                              ((wb3_adr_i[31:P2_BURST_ADDR_ALIGN] == px_cache_addr[2][31:P2_BURST_ADDR_ALIGN]) & wb_px_wr_req[3]) |
                              ((wb4_adr_i[31:P2_BURST_ADDR_ALIGN] == px_cache_addr[2][31:P2_BURST_ADDR_ALIGN]) & wb_px_wr_req[4]);
    
    assign px_addr_dirty[3] = ((wb0_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[3][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[0]) | 
                              ((wb1_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[3][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[1]) |
                              ((wb2_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[3][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[2]) |
                              ((wb3_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[3][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[3]) |
                              ((wb4_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[3][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[4]);

    assign px_addr_dirty[4] = ((wb0_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[4][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[0]) | 
                              ((wb1_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[4][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[1]) |
                              ((wb2_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[4][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[2]) |
                              ((wb3_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[4][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[3]) |
                              ((wb4_adr_i[31:P3_BURST_ADDR_ALIGN] == px_cache_addr[4][31:P3_BURST_ADDR_ALIGN]) & wb_px_wr_req[4]);

   always @ (posedge wb_clk)
     ddr2_calib_done_r[1:0] <= {ddr2_calib_done, ddr2_calib_done_r[1]};

   assign ddr2_trace_data3_o = wb_px_adr_i[1];
   assign ddr2_trace_data4_o = ddr2_px_rd_data[1];
   assign ddr2_trace_data5_o = {
				ddr2_px_cmd_full[1],
				ddr2_px_wr_full[1],
				ddr2_px_wr_en[1],
				ddr2_px_cmd_en[1],
				ddr2_px_cmd_instr[1], // =3
				ddr2_px_rd_en[1],
				ddr2_px_cmd_empty[1],
				ddr2_px_wr_empty[1],
				ddr2_px_rd_full[1],
				ddr2_px_rd_empty[1],
				ddr2_px_rd_error[1],
				ddr2_px_wr_error[1],
				18'h0
				};

      assign wb_px_req[0]     = wb_px_stb_i[0] & wb_px_cyc_i[0] & ddr2_calib_done_r[0]; 
      assign wb_px_req_new[0] = wb_px_req[0] & !wb_px_req_r[0];
      assign wb_px_wr_req[0]  = wb_px_req_new[0] & wb_px_we_i[0];

      always @(posedge wb_clk)
        wb_px_req_r[0] <= wb_px_req[0] & !wb_px_ack_o[0];

       wb_to_userport #(
        .BURST_ADDR_WIDTH(P0_BURST_ADDR_WIDTH),
        .BURST_ADDR_ALIGN(P0_BURST_ADDR_ALIGN),
        .WB_BURSTING(P0_WB_BURSTING)
       )
       wb2up0 (
        .wb_clk                     (wb_clk),
        .wb_rst                     (wb_rst),
        .wb_adr_i                   (wb_px_adr_i[0]),
        .wb_stb_i                   (wb_px_stb_i[0]),
        .wb_cyc_i                   (wb_px_cyc_i[0]),
        .wb_cti_i                   (wb_px_cti_i[0]),
        .wb_bte_i                   (wb_px_bte_i[0]),
        .wb_we_i                    (wb_px_we_i[0]),
        .wb_sel_i                   (wb_px_sel_i[0]),
        .wb_dat_i                   (wb_px_dat_i[0]),
        .wb_dat_o                   (wb_px_dat_o[0]),
        .wb_ack_o                   (wb_px_ack_o[0]),

        .addr_dirty                 (px_addr_dirty[0]),
        .cache_addr                 (px_cache_addr[0]),

        .ddr2_px_cmd_full           (ddr2_px_cmd_full[0]),
        .ddr2_px_wr_full            (ddr2_px_wr_full[0]),
        .ddr2_px_wr_en              (ddr2_px_wr_en[0]),
        .ddr2_px_cmd_en             (ddr2_px_cmd_en[0]),
        .ddr2_px_cmd_byte_addr      (ddr2_px_cmd_byte_addr[0]),
        .ddr2_px_cmd_instr          (ddr2_px_cmd_instr[0]),
        .ddr2_px_wr_data            (ddr2_px_wr_data[0]),
        .ddr2_px_wr_mask            (ddr2_px_wr_mask[0]),
        .ddr2_px_rd_data            (ddr2_px_rd_data[0]),
        .ddr2_px_cmd_bl             (ddr2_px_cmd_bl[0]),
        .ddr2_px_rd_en              (ddr2_px_rd_en[0]),
        .ddr2_px_cmd_empty          (ddr2_px_cmd_empty[0]),
        .ddr2_px_wr_empty           (ddr2_px_wr_empty[0]),
        .ddr2_px_rd_full            (ddr2_px_rd_full[0]),
        .ddr2_px_rd_empty           (ddr2_px_rd_empty[0]),
        .ddr2_calib_done            (ddr2_calib_done)
        );

      assign wb_px_req[1]     = wb_px_stb_i[1] & wb_px_cyc_i[1] & ddr2_calib_done_r[0]; 
      assign wb_px_req_new[1] = wb_px_req[1] & !wb_px_req_r[1];
      assign wb_px_wr_req[1]  = wb_px_req_new[1] & wb_px_we_i[1];

      always @(posedge wb_clk)
        wb_px_req_r[1] <= wb_px_req[1] & !wb_px_ack_o[1];

       wb_to_userport #(
        .BURST_ADDR_WIDTH(P1_BURST_ADDR_WIDTH),
        .BURST_ADDR_ALIGN(P1_BURST_ADDR_ALIGN),
        .WB_BURSTING(P1_WB_BURSTING)
       )
       wb2up1 (
        .wb_clk                     (wb_clk),
        .wb_rst                     (wb_rst),
        .wb_adr_i                   (wb_px_adr_i[1]),
        .wb_stb_i                   (wb_px_stb_i[1]),
        .wb_cyc_i                   (wb_px_cyc_i[1]),
        .wb_cti_i                   (wb_px_cti_i[1]),
        .wb_bte_i                   (wb_px_bte_i[1]),
        .wb_we_i                    (wb_px_we_i[1]),
        .wb_sel_i                   (wb_px_sel_i[1]),
        .wb_dat_i                   (wb_px_dat_i[1]),
        .wb_dat_o                   (wb_px_dat_o[1]),
        .wb_ack_o                   (wb_px_ack_o[1]),

        .addr_dirty                 (px_addr_dirty[1]),
        .cache_addr                 (px_cache_addr[1]),

        .ddr2_px_cmd_full           (ddr2_px_cmd_full[1]),
        .ddr2_px_wr_full            (ddr2_px_wr_full[1]),
        .ddr2_px_wr_en              (ddr2_px_wr_en[1]),
        .ddr2_px_cmd_en             (ddr2_px_cmd_en[1]),
        .ddr2_px_cmd_byte_addr      (ddr2_px_cmd_byte_addr[1]),
        .ddr2_px_cmd_instr          (ddr2_px_cmd_instr[1]),
        .ddr2_px_wr_data            (ddr2_px_wr_data[1]),
        .ddr2_px_wr_mask            (ddr2_px_wr_mask[1]),
        .ddr2_px_rd_data            (ddr2_px_rd_data[1]),
        .ddr2_px_cmd_bl             (ddr2_px_cmd_bl[1]),
        .ddr2_px_rd_en              (ddr2_px_rd_en[1]),
        .ddr2_px_cmd_empty          (ddr2_px_cmd_empty[1]),
        .ddr2_px_wr_empty           (ddr2_px_wr_empty[1]),
        .ddr2_px_rd_full            (ddr2_px_rd_full[1]),
        .ddr2_px_rd_empty           (ddr2_px_rd_empty[1]),
        .ddr2_calib_done            (ddr2_calib_done)
        );

      assign wb_px_req[2]     = wb_px_stb_i[2] & wb_px_cyc_i[2] & ddr2_calib_done_r[0]; 
      assign wb_px_req_new[2] = wb_px_req[2] & !wb_px_req_r[2];
      assign wb_px_wr_req[2]  = wb_px_req_new[2] & wb_px_we_i[2];

      always @(posedge wb_clk)
        wb_px_req_r[2] <= wb_px_req[2] & !wb_px_ack_o[2];

       wb_to_userport #(
        .BURST_ADDR_WIDTH(P2_BURST_ADDR_WIDTH),
        .BURST_ADDR_ALIGN(P2_BURST_ADDR_ALIGN),
        .WB_BURSTING(P2_WB_BURSTING)
       )
       wb2up2 (
        .wb_clk                     (wb_clk),
        .wb_rst                     (wb_rst),
        .wb_adr_i                   (wb_px_adr_i[2]),
        .wb_stb_i                   (wb_px_stb_i[2]),
        .wb_cyc_i                   (wb_px_cyc_i[2]),
        .wb_cti_i                   (wb_px_cti_i[2]),
        .wb_bte_i                   (wb_px_bte_i[2]),
        .wb_we_i                    (wb_px_we_i[2]),
        .wb_sel_i                   (wb_px_sel_i[2]),
        .wb_dat_i                   (wb_px_dat_i[2]),
        .wb_dat_o                   (wb_px_dat_o[2]),
        .wb_ack_o                   (wb_px_ack_o[2]),

        .addr_dirty                 (px_addr_dirty[2]),
        .cache_addr                 (px_cache_addr[2]),

        .ddr2_px_cmd_full           (ddr2_px_cmd_full[2]),
        .ddr2_px_wr_full            (ddr2_px_wr_full[2]),
        .ddr2_px_wr_en              (ddr2_px_wr_en[2]),
        .ddr2_px_cmd_en             (ddr2_px_cmd_en[2]),
        .ddr2_px_cmd_byte_addr      (ddr2_px_cmd_byte_addr[2]),
        .ddr2_px_cmd_instr          (ddr2_px_cmd_instr[2]),
        .ddr2_px_wr_data            (ddr2_px_wr_data[2]),
        .ddr2_px_wr_mask            (ddr2_px_wr_mask[2]),
        .ddr2_px_rd_data            (ddr2_px_rd_data[2]),
        .ddr2_px_cmd_bl             (ddr2_px_cmd_bl[2]),
        .ddr2_px_rd_en              (ddr2_px_rd_en[2]),
        .ddr2_px_cmd_empty          (ddr2_px_cmd_empty[2]),
        .ddr2_px_wr_empty           (ddr2_px_wr_empty[2]),
        .ddr2_px_rd_full            (ddr2_px_rd_full[2]),
        .ddr2_px_rd_empty           (ddr2_px_rd_empty[2]),
        .ddr2_calib_done            (ddr2_calib_done)
        );

      assign wb_px_req[3]     = wb_px_stb_i[3] & wb_px_cyc_i[3] & ddr2_calib_done_r[0]; 
      assign wb_px_req_new[3] = wb_px_req[3] & !wb_px_req_r[3];
      assign wb_px_wr_req[3]  = wb_px_req_new[3] & wb_px_we_i[3];

      always @(posedge wb_clk)
        wb_px_req_r[3] <= wb_px_req[3] & !wb_px_ack_o[3];

       wb_to_userport #(
        .BURST_ADDR_WIDTH(P3_BURST_ADDR_WIDTH),
        .BURST_ADDR_ALIGN(P3_BURST_ADDR_ALIGN),
        .WB_BURSTING(P3_WB_BURSTING)
       )
       wb2up3 (
        .wb_clk                     (wb_clk),
        .wb_rst                     (wb_rst),
        .wb_adr_i                   (wb_px_adr_i[3]),
        .wb_stb_i                   (wb_px_stb_i[3]),
        .wb_cyc_i                   (wb_px_cyc_i[3]),
        .wb_cti_i                   (wb_px_cti_i[3]),
        .wb_bte_i                   (wb_px_bte_i[3]),
        .wb_we_i                    (wb_px_we_i[3]),
        .wb_sel_i                   (wb_px_sel_i[3]),
        .wb_dat_i                   (wb_px_dat_i[3]),
        .wb_dat_o                   (wb_px_dat_o[3]),
        .wb_ack_o                   (wb_px_ack_o[3]),

        .addr_dirty                 (px_addr_dirty[3]),
        .cache_addr                 (px_cache_addr[3]),

        .ddr2_px_cmd_full           (ddr2_px_cmd_full[3]),
        .ddr2_px_wr_full            (ddr2_px_wr_full[3]),
        .ddr2_px_wr_en              (ddr2_px_wr_en[3]),
        .ddr2_px_cmd_en             (ddr2_px_cmd_en[3]),
        .ddr2_px_cmd_byte_addr      (ddr2_px_cmd_byte_addr[3]),
        .ddr2_px_cmd_instr          (ddr2_px_cmd_instr[3]),
        .ddr2_px_wr_data            (ddr2_px_wr_data[3]),
        .ddr2_px_wr_mask            (ddr2_px_wr_mask[3]),
        .ddr2_px_rd_data            (ddr2_px_rd_data[3]),
        .ddr2_px_cmd_bl             (ddr2_px_cmd_bl[3]),
        .ddr2_px_rd_en              (ddr2_px_rd_en[3]),
        .ddr2_px_cmd_empty          (ddr2_px_cmd_empty[3]),
        .ddr2_px_wr_empty           (ddr2_px_wr_empty[3]),
        .ddr2_px_rd_full            (ddr2_px_rd_full[3]),
        .ddr2_px_rd_empty           (ddr2_px_rd_empty[3]),
        .ddr2_calib_done            (ddr2_calib_done)
        );

      assign wb_px_req[4]     = wb_px_stb_i[4] & wb_px_cyc_i[4] & ddr2_calib_done_r[0]; 
      assign wb_px_req_new[4] = wb_px_req[4] & !wb_px_req_r[4];
      assign wb_px_wr_req[4]  = wb_px_req_new[4] & wb_px_we_i[4];

      always @(posedge wb_clk)
        wb_px_req_r[4] <= wb_px_req[4] & !wb_px_ack_o[4];

       wb_to_userport #(
        .BURST_ADDR_WIDTH(P4_BURST_ADDR_WIDTH),
        .BURST_ADDR_ALIGN(P4_BURST_ADDR_ALIGN),
        .WB_BURSTING(P4_WB_BURSTING)
       )
       wb2up4 (
        .wb_clk                     (wb_clk),
        .wb_rst                     (wb_rst),
        .wb_adr_i                   (wb_px_adr_i[4]),
        .wb_stb_i                   (wb_px_stb_i[4]),
        .wb_cyc_i                   (wb_px_cyc_i[4]),
        .wb_cti_i                   (wb_px_cti_i[4]),
        .wb_bte_i                   (wb_px_bte_i[4]),
        .wb_we_i                    (wb_px_we_i[4]),
        .wb_sel_i                   (wb_px_sel_i[4]),
        .wb_dat_i                   (wb_px_dat_i[4]),
        .wb_dat_o                   (wb_px_dat_o[4]),
        .wb_ack_o                   (wb_px_ack_o[4]),

        .addr_dirty                 (px_addr_dirty[4]),
        .cache_addr                 (px_cache_addr[4]),

        .ddr2_px_cmd_full           (ddr2_px_cmd_full[4]),
        .ddr2_px_wr_full            (ddr2_px_wr_full[4]),
        .ddr2_px_wr_en              (ddr2_px_wr_en[4]),
        .ddr2_px_cmd_en             (ddr2_px_cmd_en[4]),
        .ddr2_px_cmd_byte_addr      (ddr2_px_cmd_byte_addr[4]),
        .ddr2_px_cmd_instr          (ddr2_px_cmd_instr[4]),
        .ddr2_px_wr_data            (ddr2_px_wr_data[4]),
        .ddr2_px_wr_mask            (ddr2_px_wr_mask[4]),
        .ddr2_px_rd_data            (ddr2_px_rd_data[4]),
        .ddr2_px_cmd_bl             (ddr2_px_cmd_bl[4]),
        .ddr2_px_rd_en              (ddr2_px_rd_en[4]),
        .ddr2_px_cmd_empty          (ddr2_px_cmd_empty[4]),
        .ddr2_px_wr_empty           (ddr2_px_wr_empty[4]),
        .ddr2_px_rd_full            (ddr2_px_rd_full[4]),
        .ddr2_px_rd_empty           (ddr2_px_rd_empty[4]),
        .ddr2_calib_done            (ddr2_calib_done)
        );

/*
	 // Forward parameters to WB to userports
    defparam wb2up[0].BURST_ADDR_WIDTH = P0_BURST_ADDR_WIDTH;
    defparam wb2up[0].BURST_ADDR_ALIGN = P0_BURST_ADDR_ALIGN;
    defparam wb2up[0].WB_BURSTING      = P0_WB_BURSTING;

    defparam wb2up[1].BURST_ADDR_WIDTH = P1_BURST_ADDR_WIDTH;
    defparam wb2up[1].BURST_ADDR_ALIGN = P1_BURST_ADDR_ALIGN;
    defparam wb2up[1].WB_BURSTING      = P1_WB_BURSTING;

    defparam wb2up[2].BURST_ADDR_WIDTH = P2_BURST_ADDR_WIDTH;
    defparam wb2up[2].BURST_ADDR_ALIGN = P2_BURST_ADDR_ALIGN;
    defparam wb2up[2].WB_BURSTING      = P2_WB_BURSTING;

    defparam wb2up[3].BURST_ADDR_WIDTH = P3_BURST_ADDR_WIDTH;
    defparam wb2up[3].BURST_ADDR_ALIGN = P3_BURST_ADDR_ALIGN;
    defparam wb2up[3].WB_BURSTING      = P3_WB_BURSTING;

    defparam wb2up[4].BURST_ADDR_WIDTH = P4_BURST_ADDR_WIDTH;
    defparam wb2up[4].BURST_ADDR_ALIGN = P4_BURST_ADDR_ALIGN;
    defparam wb2up[4].WB_BURSTING      = P4_WB_BURSTING;
*/
  // The user ports are configured as follows:
  // P0 = 32 bit, Read and Write
  // P1 = 32 bit, Read and Write
  // P2 = 32 bit, Read only
  // P3 = 32 bit, Write only
  // P4 = 32 bit, Read only
  // P5 = 32 bit, Read only
  ddr2_mig  #
  (
   .C3_P0_MASK_SIZE       (C3_P0_MASK_SIZE),
   .C3_P0_DATA_PORT_SIZE  (C3_P0_DATA_PORT_SIZE),
   .C3_P1_MASK_SIZE       (C3_P1_MASK_SIZE),
   .C3_P1_DATA_PORT_SIZE  (C3_P1_DATA_PORT_SIZE),
   .DEBUG_EN              (DEBUG_EN),       
   .C3_MEMCLK_PERIOD      (C3_MEMCLK_PERIOD),       
   .C3_CALIB_SOFT_IP      (C3_CALIB_SOFT_IP),       
   .C3_SIMULATION         (C3_SIMULATION),       
   .C3_RST_ACT_LOW        (C3_RST_ACT_LOW),       
   .C3_INPUT_CLK_TYPE     (C3_INPUT_CLK_TYPE),       
   .C3_MEM_ADDR_ORDER     (C3_MEM_ADDR_ORDER),       
   .C3_NUM_DQ_PINS        (C3_NUM_DQ_PINS),       
   .C3_MEM_ADDR_WIDTH     (C3_MEM_ADDR_WIDTH),       
   .C3_MEM_BANKADDR_WIDTH (C3_MEM_BANKADDR_WIDTH)       
   )
   ddr2_mig
   (
    .mcb3_dram_dq         (ddr2_dq),
    .mcb3_dram_a          (ddr2_a),
    .mcb3_dram_ba         (ddr2_ba),
    .mcb3_dram_ras_n      (ddr2_ras_n),
    .mcb3_dram_cas_n      (ddr2_cas_n),
    .mcb3_dram_we_n       (ddr2_we_n),
    .mcb3_dram_odt        (ddr2_odt),
    .mcb3_dram_cke        (ddr2_cke),
    .mcb3_dram_dm         (ddr2_dm),
    .mcb3_dram_udqs       (ddr2_udqs),        
    .mcb3_dram_udqs_n     (ddr2_udqs_n), 
    .mcb3_rzq             (ddr2_rzq),
    .mcb3_zio             (ddr2_zio),
    .mcb3_dram_udm        (ddr2_udm),
    .c3_sys_clk           (ddr2_if_clk),
    .c3_sys_rst_n         (ddr2_if_rst),
    .c3_calib_done        (ddr2_calib_done),
    .c3_clk0              (ddr2_clk),
    .c3_rst0              (ddr2_rst),
    .mcb3_dram_dqs        (ddr2_dqs),
    .mcb3_dram_dqs_n      (ddr2_dqs_n),
    .mcb3_dram_ck         (ddr2_ck),          
    .mcb3_dram_ck_n       (ddr2_ck_n),
    .c3_p0_cmd_clk        (wb_clk),
    .c3_p0_cmd_en         (ddr2_px_cmd_en[0]),
    .c3_p0_cmd_instr      (ddr2_px_cmd_instr[0]),
    .c3_p0_cmd_bl         (ddr2_px_cmd_bl[0]),
    .c3_p0_cmd_byte_addr  (ddr2_px_cmd_byte_addr[0]),
    .c3_p0_cmd_empty      (ddr2_px_cmd_empty[0]),
    .c3_p0_cmd_full       (ddr2_px_cmd_full[0]),
    .c3_p0_wr_clk         (wb_clk),
    .c3_p0_wr_en          (ddr2_px_wr_en[0]),
    .c3_p0_wr_mask        (ddr2_px_wr_mask[0]),
    .c3_p0_wr_data        (ddr2_px_wr_data[0]),
    .c3_p0_wr_full        (ddr2_px_wr_full[0]),
    .c3_p0_wr_empty       (ddr2_px_wr_empty[0]),
    .c3_p0_wr_count       (ddr2_px_wr_count[0]),
    .c3_p0_wr_underrun    (ddr2_px_wr_underrun[0]),
    .c3_p0_wr_error       (ddr2_px_wr_error[0]),
    .c3_p0_rd_clk         (wb_clk),
    .c3_p0_rd_en          (ddr2_px_rd_en[0]),
    .c3_p0_rd_data        (ddr2_px_rd_data[0]),
    .c3_p0_rd_full        (ddr2_px_rd_full[0]),
    .c3_p0_rd_empty       (ddr2_px_rd_empty[0]),
    .c3_p0_rd_count       (ddr2_px_rd_count[0]),
    .c3_p0_rd_overflow    (ddr2_px_rd_overflow[0]),
    .c3_p0_rd_error       (ddr2_px_rd_error[0]),
    .c3_p1_cmd_clk        (wb_clk),
    .c3_p1_cmd_en         (ddr2_px_cmd_en[1]),
    .c3_p1_cmd_instr      (ddr2_px_cmd_instr[1]),
    .c3_p1_cmd_bl         (ddr2_px_cmd_bl[1]),
    .c3_p1_cmd_byte_addr  (ddr2_px_cmd_byte_addr[1]),
    .c3_p1_cmd_empty      (ddr2_px_cmd_empty[1]),
    .c3_p1_cmd_full       (ddr2_px_cmd_full[1]),
    .c3_p1_wr_clk         (wb_clk),
    .c3_p1_wr_en          (ddr2_px_wr_en[1]),
    .c3_p1_wr_mask        (ddr2_px_wr_mask[1]),
    .c3_p1_wr_data        (ddr2_px_wr_data[1]),
    .c3_p1_wr_full        (ddr2_px_wr_full[1]),
    .c3_p1_wr_empty       (ddr2_px_wr_empty[1]),
    .c3_p1_wr_count       (ddr2_px_wr_count[1]),
    .c3_p1_wr_underrun    (ddr2_px_wr_underrun[1]),
    .c3_p1_wr_error       (ddr2_px_wr_error[1]),
    .c3_p1_rd_clk         (wb_clk),
    .c3_p1_rd_en          (ddr2_px_rd_en[1]),
    .c3_p1_rd_data        (ddr2_px_rd_data[1]),
    .c3_p1_rd_full        (ddr2_px_rd_full[1]),
    .c3_p1_rd_empty       (ddr2_px_rd_empty[1]),
    .c3_p1_rd_count       (ddr2_px_rd_count[1]),
    .c3_p1_rd_overflow    (ddr2_px_rd_overflow[1]),
    .c3_p1_rd_error       (ddr2_px_rd_error[1]),
    .c3_p2_cmd_clk        (wb_clk),
    .c3_p2_cmd_en         (ddr2_px_cmd_en[2] & !wb_px_we_i[2]),
    .c3_p2_cmd_instr      (ddr2_px_cmd_instr[2]),
    .c3_p2_cmd_bl         (ddr2_px_cmd_bl[2]),
    .c3_p2_cmd_byte_addr  (ddr2_px_cmd_byte_addr[2]),
    .c3_p2_cmd_empty      (),
    .c3_p2_cmd_full       (),
    .c3_p2_rd_clk         (wb_clk),
    .c3_p2_rd_en          (ddr2_px_rd_en[2]),
    .c3_p2_rd_data        (ddr2_px_rd_data[2]),
    .c3_p2_rd_full        (ddr2_px_rd_full[2]),
    .c3_p2_rd_empty       (ddr2_px_rd_empty[2]),
    .c3_p2_rd_count       (ddr2_px_rd_count[2]),
    .c3_p2_rd_overflow    (ddr2_px_rd_overflow[2]),
    .c3_p2_rd_error       (ddr2_px_rd_error[2]),
    .c3_p3_cmd_clk        (wb_clk),
    .c3_p3_cmd_en         (ddr2_px_cmd_en[2] & wb_px_we_i[2]),
    .c3_p3_cmd_instr      (ddr2_px_cmd_instr[2]),
    .c3_p3_cmd_bl         (ddr2_px_cmd_bl[2]),
    .c3_p3_cmd_byte_addr  (ddr2_px_cmd_byte_addr[2]),
    .c3_p3_cmd_empty      (ddr2_px_cmd_empty[2]),
    .c3_p3_cmd_full       (ddr2_px_cmd_full[2]),
    .c3_p3_wr_clk         (wb_clk),
    .c3_p3_wr_en          (ddr2_px_wr_en[2]),
    .c3_p3_wr_mask        (ddr2_px_wr_mask[2]),
    .c3_p3_wr_data        (ddr2_px_wr_data[2]),
    .c3_p3_wr_full        (ddr2_px_wr_full[2]),
    .c3_p3_wr_empty       (ddr2_px_wr_empty[2]),
    .c3_p3_wr_count       (ddr2_px_wr_count[2]),
    .c3_p3_wr_underrun    (ddr2_px_wr_underrun[2]),
    .c3_p3_wr_error       (ddr2_px_wr_error[2]),
    .c3_p4_cmd_clk        (wb_clk),
    .c3_p4_cmd_en         (ddr2_px_cmd_en[3]),
    .c3_p4_cmd_instr      (ddr2_px_cmd_instr[3]),
    .c3_p4_cmd_bl         (ddr2_px_cmd_bl[3]),
    .c3_p4_cmd_byte_addr  (ddr2_px_cmd_byte_addr[3]),
    .c3_p4_cmd_empty      (ddr2_px_cmd_empty[3]),
    .c3_p4_cmd_full       (ddr2_px_cmd_full[3]),
    .c3_p4_rd_clk         (wb_clk),
    .c3_p4_rd_en          (ddr2_px_rd_en[3]),
    .c3_p4_rd_data        (ddr2_px_rd_data[3]),
    .c3_p4_rd_full        (ddr2_px_rd_full[3]),
    .c3_p4_rd_empty       (ddr2_px_rd_empty[3]),
    .c3_p4_rd_count       (ddr2_px_rd_count[3]),
    .c3_p4_rd_overflow    (ddr2_px_rd_overflow[3]),
    .c3_p4_rd_error       (ddr2_px_rd_error[3]),
	 
    .c3_p5_cmd_clk        (wb_clk),
    .c3_p5_cmd_en         (ddr2_px_cmd_en[4]),
    .c3_p5_cmd_instr      (ddr2_px_cmd_instr[4]),
    .c3_p5_cmd_bl         (ddr2_px_cmd_bl[4]),
    .c3_p5_cmd_byte_addr  (ddr2_px_cmd_byte_addr[4]),
    .c3_p5_cmd_empty      (ddr2_px_cmd_empty[4]),
    .c3_p5_cmd_full       (ddr2_px_cmd_full[4]),
    .c3_p5_rd_clk         (wb_clk),
    .c3_p5_rd_en          (ddr2_px_rd_en[4]),
    .c3_p5_rd_data        (ddr2_px_rd_data[4]),
    .c3_p5_rd_full        (ddr2_px_rd_full[4]),
    .c3_p5_rd_empty       (ddr2_px_rd_empty[4]),
    .c3_p5_rd_count       (ddr2_px_rd_count[4]),
    .c3_p5_rd_overflow    (ddr2_px_rd_overflow[4]),
    .c3_p5_rd_error       (ddr2_px_rd_error[4])    

   );

endmodule // atlys_ddr2_if

module wb_to_userport (
    input  wire         wb_clk,
    input  wire         wb_rst,
    input  wire [31:0]  wb_adr_i,
    input  wire         wb_stb_i,
    input  wire         wb_cyc_i,
    input  wire [2:0]   wb_cti_i,
    input  wire [1:0]   wb_bte_i,
    input  wire         wb_we_i,
    input  wire [3:0]   wb_sel_i,
    input  wire [31:0]  wb_dat_i,
    output wire [31:0]  wb_dat_o,
    output wire         wb_ack_o,
    
    input  wire         addr_dirty,
    output wire [31:0]  cache_addr,
    
    input  wire         ddr2_px_cmd_full,
    input  wire         ddr2_px_wr_full,
    output wire         ddr2_px_wr_en,
    output wire         ddr2_px_cmd_en,
    output wire [29:0]  ddr2_px_cmd_byte_addr,
    output wire [2:0]   ddr2_px_cmd_instr,
    output wire [31:0]  ddr2_px_wr_data,
    output wire [3:0]   ddr2_px_wr_mask,
    input  wire [31:0]  ddr2_px_rd_data,
    output wire [5:0]   ddr2_px_cmd_bl,
    output wire         ddr2_px_rd_en,
    input  wire         ddr2_px_cmd_empty,
    input  wire         ddr2_px_wr_empty,
    input  wire         ddr2_px_rd_full,
    input  wire         ddr2_px_rd_empty,
    input  wire         ddr2_calib_done
);
   parameter BURST_ADDR_WIDTH = 4;
   parameter BURST_ADDR_ALIGN = BURST_ADDR_WIDTH + 2;
   parameter BURST_LENGTH     = 2**BURST_ADDR_WIDTH;
	parameter WB_BURSTING      = "FALSE";

   reg [31:0]                      burst_data_buf[BURST_LENGTH-1:0];
   reg [31:BURST_ADDR_ALIGN]       burst_addr;
   reg [BURST_ADDR_WIDTH-1:0]      burst_cnt;
   reg                             bursting;
   wire                            addr_match;
   reg                             burst_start;
   reg                             read_done;
   reg                             addr_dirty_r;
   reg                             wb_ack_read;
   wire                            wb_req;
   reg                             wb_req_r;
   reg                             wb_ack_write;
   wire                            wb_req_new;
   wire                            wb_read_req;
   reg                             wb_bursting;
   reg [3:0]                       wb_burst_addr;
   
   // dummy signal to align address with a variable amount of zeroes
   wire [BURST_ADDR_ALIGN-1:0]     addr_align_zeroes; 
   assign addr_align_zeroes = 0;
   
   assign cache_addr = {burst_addr, addr_align_zeroes};
   assign wb_req = wb_stb_i & wb_cyc_i & ddr2_calib_done & !ddr2_px_cmd_full &
		   (!wb_we_i | !ddr2_px_wr_full);
   assign wb_req_new  = wb_req & !wb_req_r;
   
   always @(posedge wb_clk) begin
     wb_req_r <= wb_req & !wb_ack_o;
   end
   
   // Wishbone bursting defines
`define WB_CLASSIC     3'b000
`define WB_CONST_ADDR  3'b001
`define WB_INC_BURST   3'b010
`define WB_END_BURST   3'b111

   // register incoming dirty address signal, and hold it until a new burst read has started
   always @(posedge wb_clk) begin
     if (wb_rst)
       addr_dirty_r <= 1; // Initially dirty to force read in from mem
     else if (addr_dirty)
       addr_dirty_r <= 1;
     else if (burst_start)
       addr_dirty_r <= 0;          
   end

   // In case of WB bursting, we can ack on each clock edge
   // We don't take account for the type of bursting, since we can't perform wrapping bursts anyway
   // We wait for the wr fifo to be empty, then at least all writes have been
   // committed to the memory controller.
   assign wb_read_req = wb_req & !wb_we_i & /*ddr2_px_wr_empty &*/
			(!wb_ack_read | ((wb_cti_i == `WB_INC_BURST) &
					 (WB_BURSTING == "TRUE")));
   assign addr_match  = (burst_addr == wb_adr_i[31:BURST_ADDR_ALIGN]) & !addr_dirty_r;
   
   // Check if addr is in read cache, and that no other port have written to that address
   // If not, start reading it in from ddr2
   always @(posedge wb_clk) begin
     burst_start <= 0;
     wb_ack_read <= 0;
     if (wb_read_req) begin
       if (addr_match & !bursting & !burst_start) begin
         wb_ack_read <= 1;
// SJK: I had this block commented out for a while
/*
       end else if (addr_match & bursting & (burst_cnt > wb_adr_i[BURST_ADDR_ALIGN-1:2])) begin
         wb_ack_read <= 1;
 */
// SJK: Block end
// SJK: I had this block commented out for a while
/*
       end else if (addr_match & read_done) begin
         wb_ack_read <= 1;
 */
// SJK: Block end
       end else if (!bursting & !burst_start) begin
         burst_start <= 1;
       end
     end
   end
   
   // Read data from ddr2 into read cache
   always @(posedge wb_clk) begin
     read_done <= 0;
     if (wb_rst) begin
       burst_cnt  <= 0;
       bursting   <= 0;
       burst_addr <= 0;
     end else if (burst_start & !bursting) begin
       burst_cnt <= 0;
       bursting  <= 1;
       burst_addr <= wb_adr_i[31:BURST_ADDR_ALIGN];
     end else if (!ddr2_px_rd_empty) begin
       burst_data_buf[burst_cnt] <= ddr2_px_rd_data;
       burst_cnt <= burst_cnt + 1;
       if (&burst_cnt)
         bursting <= 0;      
       if (burst_cnt >= wb_adr_i[BURST_ADDR_ALIGN-1:2])
         read_done <= 1;
     end
   end
   
   always @(posedge wb_clk) begin
      wb_ack_write <= ddr2_px_wr_en;/*wb_req & wb_we_i & !wb_ack_write & !ddr2_px_wr_full &
		      !ddr2_px_cmd_full*/;
   end
   
   
   assign ddr2_px_cmd_byte_addr = wb_ack_write ? {wb_adr_i[29:2],2'b0} : {wb_adr_i[29:BURST_ADDR_ALIGN], addr_align_zeroes};
//wb_we_i ? {wb_adr_i[29:2],2'b0} : {wb_adr_i[29:BURST_ADDR_ALIGN], addr_align_zeroes};
   assign ddr2_px_cmd_instr     = {2'b0, !wb_ack_write};//{2'b0, !wb_we_i};
   assign ddr2_px_cmd_en        = wb_ack_write | burst_start;//wb_we_i ? wb_ack_write : burst_start;
   assign ddr2_px_cmd_bl        = wb_ack_write ? 0 : BURST_LENGTH-1;//wb_we_i ? 0 : BURST_LENGTH-1;
   assign ddr2_px_rd_en         = 1;
   assign ddr2_px_wr_en         = wb_we_i ? wb_req_new : 1'b0;
   assign ddr2_px_wr_data       = wb_dat_i;
   assign ddr2_px_wr_mask       = ~wb_sel_i;
   assign wb_ack_o              = wb_ack_write | wb_ack_read;//(wb_we_i ? wb_ack_write : wb_ack_read) & wb_stb_i;
   assign wb_dat_o              = burst_data_buf[wb_adr_i[BURST_ADDR_ALIGN-1:2]];
   
endmodule // wb_to_userport
