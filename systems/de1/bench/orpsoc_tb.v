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

//Force simulation stop after timeout cycles
reg	[63:0]	timeout;
initial
	if($value$plusargs("timeout=%d", timeout)) begin
		#timeout $display("Timeout: Forcing end of simulation");
		$finish;
	end

//FIXME: Add more options for VCD logging
initial begin
	if($test$plusargs("vcd")) begin
		$dumpfile("de1.vcd");
		$dumpvars(0);
	end
end

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
// ELF program loading
//
////////////////////////////////////////////////////////////////////////

integer			mem_words;
integer			i;
reg	[31:0]		mem_word;
reg	[1023:0]	elf_file;
reg	[31:0]		temp;

initial begin
	if($value$plusargs("or1k_elf_load=%s", elf_file)) begin
		$or1k_elf_load_file(elf_file);

		mem_words = $or1k_elf_get_size / 4;
		$display("Loading %d words", mem_words);
		for(i = 0; i < mem_words; i = i + 1) begin
			temp = $or1k_elf_read_32(i * 4);
			orpsoc_tb.sdram0.Bank0[(i * 2)] = temp[31:16];
			orpsoc_tb.sdram0.Bank0[(i * 2) + 1] = temp[15:0];
		end
	end else
		$display("No ELF file specified");
end

////////////////////////////////////////////////////////////////////////
//
// DUT
//
////////////////////////////////////////////////////////////////////////

wire	[11:0]	sdram_a_pad_o;
wire	[1:0]	sdram_ba_pad_o;
wire		sdram_cas_pad_o;
wire		sdram_cke_pad_o;
wire		sdram_clk_pad_o;
wire		sdram_cs_n_pad_o;
wire	[15:0]	sdram_dq_pad_io;
wire	[1:0]	sdram_dqm_pad_o;
wire		sdram_ras_pad_o;
wire		sdram_we_pad_o;
wire		uart_tx;

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

	.sdram_ba_pad_o		(sdram_ba_pad_o),
	.sdram_a_pad_o		(sdram_a_pad_o),
	.sdram_cs_n_pad_o	(sdram_cs_n_pad_o),
	.sdram_ras_pad_o	(sdram_ras_pad_o),
	.sdram_cas_pad_o	(sdram_cas_pad_o),
	.sdram_we_pad_o		(sdram_we_pad_o),
	.sdram_dq_pad_io	(sdram_dq_pad_io),
	.sdram_dqm_pad_o	(sdram_dqm_pad_o),
	.sdram_cke_pad_o	(sdram_cke_pad_o),
	.sdram_clk_pad_o	(sdram_clk_pad_o),

	.uart0_srx_pad_i	(),
	.uart0_stx_pad_o	(uart_tx)
);

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

////////////////////////////////////////////////////////////////////////
//
// SDRAM
//
////////////////////////////////////////////////////////////////////////

parameter TPROP_PCB = 2.0;
reg	[11:0]	sdram_a_pad_o_to_sdram;
reg	[1:0]	sdram_ba_pad_o_to_sdram;
reg		sdram_cas_pad_o_to_sdram;
reg		sdram_cke_pad_o_to_sdram;
reg		sdram_cs_n_pad_o_to_sdram;
wire	[15:0]	sdram_dq_pad_io_to_sdram;
reg	[1:0]	sdram_dqm_pad_o_to_sdram;
reg		sdram_ras_pad_o_to_sdram;
reg		sdram_we_pad_o_to_sdram;

always @( * ) begin
	sdram_a_pad_o_to_sdram		<= #(TPROP_PCB) sdram_a_pad_o;
	sdram_ba_pad_o_to_sdram		<= #(TPROP_PCB) sdram_ba_pad_o;
	sdram_cas_pad_o_to_sdram	<= #(TPROP_PCB) sdram_cas_pad_o;
	sdram_cke_pad_o_to_sdram	<= #(TPROP_PCB) sdram_cke_pad_o;
	sdram_cs_n_pad_o_to_sdram	<= #(TPROP_PCB) sdram_cs_n_pad_o;
	sdram_dqm_pad_o_to_sdram	<= #(TPROP_PCB) sdram_dqm_pad_o;
	sdram_ras_pad_o_to_sdram	<= #(TPROP_PCB) sdram_ras_pad_o;
	sdram_we_pad_o_to_sdram		<= #(TPROP_PCB) sdram_we_pad_o;
end

genvar dqwd;
generate
for (dqwd = 0; dqwd < 16; dqwd = dqwd + 1) begin : dq_delay
	wiredelay #(
		.Delay_g	(TPROP_PCB),
		.Delay_rd	(TPROP_PCB))
	u_delay_dq (
		.A		(sdram_dq_pad_io[dqwd]),
		.B		(sdram_dq_pad_io_to_sdram[dqwd]),
		.reset		(rst_n)
	);
end
endgenerate

mt48lc16m16a2 #(
	.addr_bits	(12),
	.col_bits	(8),
	.mem_sizes	(1048576)
) 
sdram0
(
	.Dq		(sdram_dq_pad_io_to_sdram),
	.Addr		(sdram_a_pad_o_to_sdram),
	.Ba		(sdram_ba_pad_o_to_sdram),
	.Clk		(sdram_clk_pad_o),
	.Cke		(sdram_cke_pad_o_to_sdram),
	.Cs_n		(sdram_cs_n_pad_o_to_sdram),
	.Ras_n		(sdram_ras_pad_o_to_sdram),
	.Cas_n		(sdram_cas_pad_o_to_sdram),
	.We_n		(sdram_we_pad_o_to_sdram),
	.Dqm		(sdram_dqm_pad_o_to_sdram)
);

endmodule
