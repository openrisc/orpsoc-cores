//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC testbench for Altera de1 board                         ////
///                                                               ////
/// Franck Jullien, franck.jullien@gmail.com                      ////
///                                                               ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009, 2010 Authors and OPENCORES.ORG           ////
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

`include "timescale.v"

module orpsoc_tb;

reg clk   = 0;
reg rst_n = 0;

////////////////////////////////////////////////////////////////////////
//
// Generate clock (100MHz) and external reset
//
////////////////////////////////////////////////////////////////////////

always
	#5 clk <= ~clk;

initial begin
	#100 rst_n <= 0;
	#200 rst_n <= 1;
end

////////////////////////////////////////////////////////////////////////
//
// Add --vcd and --timeout options to the simulation
//
////////////////////////////////////////////////////////////////////////
vlog_tb_utils vlog_tb_utils0();


////////////////////////////////////////////////////////////////////////
//
// JTAG VPI interface
//
////////////////////////////////////////////////////////////////////////

reg enable_jtag_vpi;
initial enable_jtag_vpi = $test$plusargs("enable_jtag_vpi");

jtag_vpi jtag_vpi0
(
	.tms		(tms),
	.tck		(tck),
	.tdi		(tdi),
	.tdo		(tdo),
	.enable		(enable_jtag_vpi),
	.init_done	(orpsoc_tb.dut.wb_rst));

////////////////////////////////////////////////////////////////////////
//
// SDRAM
//
////////////////////////////////////////////////////////////////////////

wire	[11:0]	sdram_addr;
wire	[1:0]	sdram_ba;
wire		sdram_cas;
wire		sdram_cke;
wire		sdram_clk;
wire		sdram_cs_n;
wire	[15:0]	sdram_dq;
wire	[1:0]	sdram_dqm;
wire		sdram_ras;
wire		sdram_we;
wire		uart_tx;

mt48lc16m16a2_wrapper
  #(.ADDR_BITS (12),
    .COL_BITS (8),
    .MEM_SIZES (1048576))
sdram_wrapper0
  (.clk_i   (sdram_clk),
   .rst_n_i (rst_n),
   .dq_io   (sdram_dq),
   .addr_i  (sdram_addr),
   .ba_i    (sdram_ba),
   .cas_i   (sdram_cas),
   .cke_i   (sdram_cke),
   .cs_n_i  (sdram_cs_n),
   .dqm_i   (sdram_dqm),
   .ras_i   (sdram_ras),
   .we_i    (sdram_we));

////////////////////////////////////////////////////////////////////////
//
// DUT
//
////////////////////////////////////////////////////////////////////////

orpsoc_top dut
(
	.sys_clk_pad_i		(clk),
	.rst_n_pad_i		(rst_n),

	.led_r_pad_o		(),
	.gpio0_io		(),

	.tms_pad_i		(tms),
	.tck_pad_i		(tck),
	.tdi_pad_i		(tdi),
	.tdo_pad_o		(tdo),

	.sdram_ba_pad_o		(sdram_ba),
	.sdram_a_pad_o		(sdram_addr),
	.sdram_cs_n_pad_o	(sdram_cs_n),
	.sdram_ras_pad_o	(sdram_ras),
	.sdram_cas_pad_o	(sdram_cas),
	.sdram_we_pad_o		(sdram_we),
	.sdram_dq_pad_io	(sdram_dq),
	.sdram_dqm_pad_o	(sdram_dqm),
	.sdram_cke_pad_o	(sdram_cke),
	.sdram_clk_pad_o	(sdram_clk),

	.uart0_srx_pad_i	(),
	.uart0_stx_pad_o	(uart_tx)
);

`ifdef OR1200_CPU
   or1200_monitor i_monitor();
`else
   mor1kx_monitor #(.LOG_DIR(".")) i_monitor();
`endif

////////////////////////////////////////////////////////////////////////
//
// UART decoder
//
////////////////////////////////////////////////////////////////////////

//FIXME: Get correct baud rate from parameter
uart_decoder
	#(.uart_baudrate_period_ns(8680 / 2))
uart_decoder0
(
	.clk(clk),
	.uart_tx(uart_tx)
);


endmodule
