`timescale 1ns/1ps
`include "orpsoc-defines.v"

module orpsoc_tb;

////////////////////////////////////////////////////////////////////////
//
// Boot ROM selection
//
////////////////////////////////////////////////////////////////////////
   parameter bootrom_file = "../src/de0_nano_0/sw/clear_r3_and_jump_to_0x100.vh";
   //parameter bootrom_file = "../src/de0_nano_0/sw/spi_uimage_loader.vh";

   /*
    When the SPI uimage loader is used, the following parameter can be
    set to provide alternative SPI Flash contents
    */
   parameter spi_flash_file = "../src/de0_nano_0/bench/spi_image.vh";

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
vlog_tb_utils vlog_tb_utils0();


////////////////////////////////////////////////////////////////////////
//
// SDRAM
//
////////////////////////////////////////////////////////////////////////

	wire	[1:0]	sdram_ba;
	wire	[12:0]	sdram_addr;
	wire		sdram_cs_n;
	wire		sdram_ras;
	wire		sdram_cas;
	wire		sdram_we;
	wire	[15:0]	sdram_dq;
	wire	[1:0]	sdram_dqm;
	wire		sdram_cke;
	wire		sdram_clk;

mt48lc16m16a2_wrapper
  #(.ADDR_BITS (13))
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
// SPI Flash
//
////////////////////////////////////////////////////////////////////////

   wire spi0_sck;
   wire spi0_mosi;
   wire spi0_miso;
   wire spi0_ss;

   s25fl064p
     #(.UserPreload (1'b1),
       .mem_file_name (spi_flash_file))
       spi_flash
     (.SCK     (spi0_sck),
      .SI      (spi0_mosi),
      .CSNeg   (spi0_ss),
      .HOLDNeg (), //Internal pull-up
      .WPNeg   (), //Internal pull-up
      .SO      (spi0_miso));

orpsoc_top
  #(.bootrom_file (bootrom_file))
   dut
(
	.sys_clk_pad_i		(clk),
	.rst_n_pad_i		(rst_n),
 .gpio0_io (),
 .gpio1_i (4'h0),
	//JTAG interface
	.tms_pad_i		(tms),
	.tck_pad_i		(tck),
	.tdi_pad_i		(tdi),
	.tdo_pad_o		(tdo),
        //SDRAM Interface
	.sdram_ba_pad_o   (sdram_ba),
	.sdram_a_pad_o	  (sdram_addr),
	.sdram_cs_n_pad_o (sdram_cs_n),
	.sdram_ras_pad_o  (sdram_ras),
	.sdram_cas_pad_o  (sdram_cas),
	.sdram_we_pad_o   (sdram_we),
	.sdram_dq_pad_io  (sdram_dq),
	.sdram_dqm_pad_o  (sdram_dqm),
	.sdram_cke_pad_o  (sdram_cke),
	.sdram_clk_pad_o  (sdram_clk),
	//UART interface
	.uart0_srx_pad_i	(),
	.uart0_stx_pad_o	(uart_tx),

        .i2c0_sda_io (),
	.i2c0_scl_io (),

        .i2c1_sda_io (),
	.i2c1_scl_io (),

 .spi0_sck_o  (spi0_sck),
 .spi0_mosi_o (spi0_mosi),
 .spi0_miso_i (spi0_miso),
 .spi0_ss_o (spi0_ss),

 .spi1_sck_o  (),
 .spi1_mosi_o (),
 .spi1_miso_i (),
 .spi1_ss_o (),

 .spi2_sck_o  (),
 .spi2_mosi_o (),
 .spi2_miso_i (),
 .spi2_ss_o (),

 .accelerometer_cs_o (),
 .accelerometer_irq_i (1'b0)
);

`ifdef OR1200
   or1200_monitor i_monitor();
`endif
`ifdef MOR1KX
   mor1kx_monitor #(.LOG_DIR(".")) i_monitor();
`endif
////////////////////////////////////////////////////////////////////////
//
// UART decoder
//
////////////////////////////////////////////////////////////////////////

//FIXME: Get correct baud rate from parameter
uart_decoder
	#(.uart_baudrate_period_ns(8680))
uart_decoder0
(
	.clk(clk),
	.uart_tx(uart_tx)
);

endmodule
