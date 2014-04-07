//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC testbench for Altera Neek board                        ////
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
// Generate clock (50MHz) and external reset
//
////////////////////////////////////////////////////////////////////////

always
	#10 clk <= ~clk;

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
		$dumpfile("neek.vcd");
		$dumpvars(0);
	end
end

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
	if($value$plusargs("elf_load=%s", elf_file)) begin
		$elf_load_file(elf_file);

		mem_words = $elf_get_size / 4;
		$display("Loading %d words", mem_words);
		for(i = 0; i < mem_words; i = i + 1) begin
			temp = $elf_read_32(i * 4);
			orpsoc_tb.ddr0.write_mem((i * 2), temp[15:0]);
			orpsoc_tb.ddr0.write_mem((i * 2) + 1, temp[31:16]);
		end

	end else
		$display("No ELF file specified");
end

////////////////////////////////////////////////////////////////////////
//
// DUT
//
////////////////////////////////////////////////////////////////////////

wire	[12:0]	sdram_a_pad_o;
wire	[1:0]	sdram_ba_pad_o;
wire		sdram_cas_pad_o;
wire		sdram_cke_pad_o;
wire		sdram_clk_pad_o;
wire		sdram_clk_n_pad_o;
wire		sdram_cs_n_pad_o;
wire	[15:0]	sdram_dq_pad_io;
wire	[1:0]	sdram_dqs_pad_io;
wire	[1:0]	sdram_dqm_pad_o;
wire		sdram_ras_pad_o;
wire		sdram_we_pad_o;
wire		uart_tx;

orpsoc_top dut
(

	.clock_50_pad_i		(clk),
	.reset_n_pad_i		(rst_n),

	.ddr_dm_pad_o		(sdram_dqm_pad_o),
	.ddr_dq_pad_io		(sdram_dq_pad_io),
	.ddr_dqs_pad_io		(sdram_dqs_pad_io),
	.ddr_a_pad_o		(sdram_a_pad_o),
	.ddr_ba_pad_o		(sdram_ba_pad_o),
	.ddr_cas_n_pad_o	(sdram_cas_pad_o),
	.ddr_cke_pad_o		(sdram_cke_pad_o),
	.ddr_clk_pad_o		(sdram_clk_pad_o),
	.ddr_clk_n_pad_o	(sdram_clk_n_pad_o),
	.ddr_cs_n_pad_o		(sdram_cs_n_pad_o),
	.ddr_ras_n_pad_o	(sdram_ras_pad_o),
	.ddr_we_n_pad_o		(sdram_we_pad_o),

	.led_debug_pad_o	(),

	.uart_rx_pad_i		(),
	.uart_tx_pad_o		(uart_tx)
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

ddr ddr0
(
	.Clk	(sdram_clk_pad_o),
	.Clk_n	(sdram_clk_n_pad_o),
	.Cke	(sdram_cke_pad_o),
	.Cs_n	(sdram_cs_n_pad_o),
	.Ras_n	(sdram_ras_pad_o),
	.Cas_n	(sdram_cas_pad_o),
	.We_n	(sdram_we_pad_o),
	.Ba	(sdram_ba_pad_o),
	.Addr	(sdram_a_pad_o),
	.Dm	(sdram_dqm_pad_o),
	.Dq	(sdram_dq_pad_io),
	.Dqs	(sdram_dqs_pad_io)
);

endmodule
