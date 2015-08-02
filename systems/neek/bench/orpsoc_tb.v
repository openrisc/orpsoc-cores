/*
 * Copyright (c) 2014, Franck Jullien <franck.jullien@gmail.com>
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
		@(posedge orpsoc_tb.dut.init_done)
			$dumpfile("neek.vcd");
		$dumpvars(0);
	end
end

initial begin
	@(posedge orpsoc_tb.dut.init_done)
		$display("----- DDR init done ----\n");
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

wire	[12:0]	ddr_a_pad_o;
wire	[1:0]	ddr_ba_pad_o;
wire		ddr_cas_pad_o;
wire		ddr_cke_pad_o;
wire		ddr_clk_pad_o;
wire		ddr_clk_n_pad_o;
wire		ddr_cs_n_pad_o;
wire	[15:0]	ddr_dq_pad_io;
wire	[1:0]	ddr_dqs_pad_io;
wire	[1:0]	ddr_dqm_pad_o;
wire		ddr_ras_pad_o;
wire		ddr_we_pad_o;
wire		uart_tx;

wire	[15:0]	flash_dq;
wire	[22:0]	flash_adr;
wire		flash_adv_n;
wire		flash_ce_n;
wire		flash_clk;
wire		flash_oe_n;
wire		flash_rst_n;
wire		flash_wait;
wire		flash_we_n;

orpsoc_top dut
(

	.clock_50_pad_i		(clk),
	.reset_n_pad_i		(rst_n),

	.ddr_dm_pad_o		(ddr_dqm_pad_o),
	.ddr_dq_pad_io		(ddr_dq_pad_io),
	.ddr_dqs_pad_io		(ddr_dqs_pad_io),
	.ddr_a_pad_o		(ddr_a_pad_o),
	.ddr_ba_pad_o		(ddr_ba_pad_o),
	.ddr_cas_n_pad_o	(ddr_cas_pad_o),
	.ddr_cke_pad_o		(ddr_cke_pad_o),
	.ddr_clk_pad_o		(ddr_clk_pad_o),
	.ddr_clk_n_pad_o	(ddr_clk_n_pad_o),
	.ddr_cs_n_pad_o		(ddr_cs_n_pad_o),
	.ddr_ras_n_pad_o	(ddr_ras_pad_o),
	.ddr_we_n_pad_o		(ddr_we_pad_o),

	.led_debug_pad_o	(),

`ifdef VGA_LCD
	.hsync_n_pad_o		(),
	.vsync_n_pad_o		(),
	.blank_n_pad_o		(),
	.lcd_data_pad_o		(),
	.pixel_clock_pad_o	(),
	.lcd_rst_n_pad_o	(),
	.lcd_scen_pad_o		(),
	.lcd_scl_pad_o		(),
	.lcd_sda_pad_io		(),
	.vga_data_pad_o		(),
	.vga_clock_pad_o	(),
	.vga_hsync_pad_o	(),
	.vga_vsync_pad_o	(),
	.vga_blank_pad_o	(),
	.vga_sync_pad_o		(),
`endif

`ifdef ETHERNET
	.eth0_tx_clk_pad_i	(1'b0),
	.eth0_tx_data_pad_o	(),
	.eth0_tx_en_pad_o	(),
	.eth0_rx_clk_pad_i	(1'b0),
	.eth0_rx_data_pad_i	(4'b0),
	.eth0_rx_dv_pad_i	(1'b0),
	.eth0_rx_err_pad_i	(1'b0),
	.eth0_col_pad_i		(1'b0),
	.eth0_crs_pad_i		(1'b0),
	.eth0_mdc_pad_o		(),
	.eth0_md_pad_io		(),
	.eth0_rst_n_pad_o	(),
`endif

`ifdef SPI
	.spi0_sck_pad_o		(),
	.spi0_mosi_pad_o	(),
	.spi0_miso_pad_i	(1'b0),
	.spi0_ss_pad_o		(),
`endif

	.flash_dq_pad_io	(flash_dq),
	.flash_adr_pad_o	(flash_adr),
	.flash_adv_n_pad_o	(flash_adv_n),
	.flash_ce_n_pad_o	(flash_ce_n),
	.flash_clk_pad_o	(flash_clk),
	.flash_oe_n_pad_o	(flash_oe_n),
	.flash_rst_n_pad_o	(flash_rst_n),
	.flash_wait_pad_i	(flash_wait),
	.flash_we_n_pad_o	(flash_we_n),

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

ddr #(.DEBUG(0))
ddr0
(
	.Clk	(ddr_clk_pad_o),
	.Clk_n	(ddr_clk_n_pad_o),
	.Cke	(ddr_cke_pad_o),
	.Cs_n	(ddr_cs_n_pad_o),
	.Ras_n	(ddr_ras_pad_o),
	.Cas_n	(ddr_cas_pad_o),
	.We_n	(ddr_we_pad_o),
	.Ba	(ddr_ba_pad_o),
	.Addr	(ddr_a_pad_o),
	.Dm	(ddr_dqm_pad_o),
	.Dq	(ddr_dq_pad_io),
	.Dqs	(ddr_dqs_pad_io)
);

////////////////////////////////////////////////////////////////////////
//
// FLAH
//
////////////////////////////////////////////////////////////////////////

x28fxxxp30 part
(
	.A	({1'b0, flash_adr}),
	.DQ	(flash_dq),
	.W_N	(flash_we_n),
	.G_N	(flash_oe_n),
	.E_N	(flash_ce_n),
	.L_N	(flash_adv_n),
	.K	(flash_clk),
	.WAIT	(flash_wait),
	.WP_N	(1'b1),
	.RP_N	(flash_rst_n),
	.VDD	(36'd1800),
	.VDDQ	(36'd2500),
	.VPP	(36'd1800),
	.Info	(32'd1)
);

endmodule
