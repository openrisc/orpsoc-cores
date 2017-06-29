//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC top for SoCKit board                                   ////
///                                                               ////
/// Instantiates modules, depending on ORPSoC defines file        ////
///                                                               ////
/// Copyright (C) 2013 Stefan Kristiansson                        ////
///  <stefan.kristiansson@saunalahti.fi                           ////
///                                                               ////
//////////////////////////////////////////////////////////////////////
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

`include "orpsoc-defines.v"

module orpsoc_top (
	input 	      sys_clk_pad_i,
	input 	      rst_n_pad_i,

	input 	      fpga_ddr3_ref_clk_pad_i,

`ifdef SIM
	output 	      tdo_pad_o,
	input 	      tms_pad_i,
	input 	      tck_pad_i,
	input 	      tdi_pad_i,
`endif

	inout [7:0]   gpio0_io,

	// FPGA DDR3
	output [14:0] fpga_ddr3_mem_a,
	output [2:0]  fpga_ddr3_mem_ba,
	output [0:0]  fpga_ddr3_mem_ck,
	output [0:0]  fpga_ddr3_mem_ck_n,
	output [0:0]  fpga_ddr3_mem_cke,
	output [0:0]  fpga_ddr3_mem_cs_n,
	output [3:0]  fpga_ddr3_mem_dm,
	output [0:0]  fpga_ddr3_mem_ras_n,
	output [0:0]  fpga_ddr3_mem_cas_n,
	output [0:0]  fpga_ddr3_mem_we_n,
	output [0:0]  fpga_ddr3_mem_reset_n,
	inout [31:0]  fpga_ddr3_mem_dq,
	inout [3:0]   fpga_ddr3_mem_dqs,
	inout [3:0]   fpga_ddr3_mem_dqs_n,
	output [0:0]  fpga_ddr3_mem_odt,
	input 	      fpga_ddr3_oct_rzqin,

	// VGA
	output 	      vga0_clk_pad_o,
	output 	      vga0_hsync_pad_o,
	output 	      vga0_vsync_pad_o,
	output 	      vga0_csync_n_pad_o,
	output 	      vga0_blank_n_pad_o,
	output [7:0]  vga0_r_pad_o,
	output [7:0]  vga0_g_pad_o,
	output [7:0]  vga0_b_pad_o,

	// AUDIO
	inout 	      i2c0_sda_io,
	inout 	      i2c0_scl_io,

	output 	      i2s0_mclk,
	output 	      i2s0_sclk,

	output 	      i2s0_tx_lrclk,
	output 	      i2s0_tx_sdata,

	output 	      mute_n,

	//
	// HPS I/O ports
	//

	// DDR3
	output [14:0] memory_mem_a,
	output [2:0]  memory_mem_ba,
	output 	      memory_mem_ck,
	output 	      memory_mem_ck_n,
	output 	      memory_mem_cke,
	output 	      memory_mem_cs_n,
	output 	      memory_mem_ras_n,
	output 	      memory_mem_cas_n,
	output 	      memory_mem_we_n,
	output 	      memory_mem_reset_n,
	inout [31:0]  memory_mem_dq,
	inout [3:0]   memory_mem_dqs,
	inout [3:0]   memory_mem_dqs_n,
	output 	      memory_mem_odt,
	output [3:0]  memory_mem_dm,
	input 	      memory_oct_rzqin,

	// Ethernet
	output 	      hps_io_hps_io_emac1_inst_TX_CLK,
	output 	      hps_io_hps_io_emac1_inst_TXD0,
	output 	      hps_io_hps_io_emac1_inst_TXD1,
	output 	      hps_io_hps_io_emac1_inst_TXD2,
	output 	      hps_io_hps_io_emac1_inst_TXD3,
	input 	      hps_io_hps_io_emac1_inst_RXD0,
	inout 	      hps_io_hps_io_emac1_inst_MDIO,
	output 	      hps_io_hps_io_emac1_inst_MDC,
	input 	      hps_io_hps_io_emac1_inst_RX_CTL,
	output 	      hps_io_hps_io_emac1_inst_TX_CTL,
	input 	      hps_io_hps_io_emac1_inst_RX_CLK,
	input 	      hps_io_hps_io_emac1_inst_RXD1,
	input 	      hps_io_hps_io_emac1_inst_RXD2,
	input 	      hps_io_hps_io_emac1_inst_RXD3,

	// Quad SPI
	inout 	      hps_io_hps_io_qspi_inst_IO0,
	inout 	      hps_io_hps_io_qspi_inst_IO1,
	inout 	      hps_io_hps_io_qspi_inst_IO2,
	inout 	      hps_io_hps_io_qspi_inst_IO3,
	output 	      hps_io_hps_io_qspi_inst_SS0,
	output 	      hps_io_hps_io_qspi_inst_CLK,

	// SD card, mmc
	inout 	      hps_io_hps_io_sdio_inst_CMD,
	inout 	      hps_io_hps_io_sdio_inst_D0,
	inout 	      hps_io_hps_io_sdio_inst_D1,
	output 	      hps_io_hps_io_sdio_inst_CLK,
	inout 	      hps_io_hps_io_sdio_inst_D2,
	inout 	      hps_io_hps_io_sdio_inst_D3,

	// USB
	inout 	      hps_io_hps_io_usb1_inst_D0,
	inout 	      hps_io_hps_io_usb1_inst_D1,
	inout 	      hps_io_hps_io_usb1_inst_D2,
	inout 	      hps_io_hps_io_usb1_inst_D3,
	inout 	      hps_io_hps_io_usb1_inst_D4,
	inout 	      hps_io_hps_io_usb1_inst_D5,
	inout 	      hps_io_hps_io_usb1_inst_D6,
	inout 	      hps_io_hps_io_usb1_inst_D7,
	input 	      hps_io_hps_io_usb1_inst_CLK,
	output 	      hps_io_hps_io_usb1_inst_STP,
	input 	      hps_io_hps_io_usb1_inst_DIR,
	input 	      hps_io_hps_io_usb1_inst_NXT,

	// SPI Master
	output 	      hps_io_hps_io_spim0_inst_CLK,
	output 	      hps_io_hps_io_spim0_inst_MOSI,
	input 	      hps_io_hps_io_spim0_inst_MISO,
	output 	      hps_io_hps_io_spim0_inst_SS0,
	output 	      hps_io_hps_io_spim1_inst_CLK,
	output 	      hps_io_hps_io_spim1_inst_MOSI,
	input 	      hps_io_hps_io_spim1_inst_MISO,
	output 	      hps_io_hps_io_spim1_inst_SS0,

	// UART
	input 	      hps_io_hps_io_uart0_inst_RX,
	output 	      hps_io_hps_io_uart0_inst_TX,

	// I2C
	inout 	      hps_io_hps_io_i2c1_inst_SDA,
	inout 	      hps_io_hps_io_i2c1_inst_SCL,

	// GPIO
	inout 	      hps_io_hps_io_gpio_inst_GPIO00,
	inout 	      hps_io_hps_io_gpio_inst_GPIO09,
	inout 	      hps_io_hps_io_gpio_inst_GPIO35,
	inout 	      hps_io_hps_io_gpio_inst_GPIO48,
	inout 	      hps_io_hps_io_gpio_inst_GPIO53,
	inout 	      hps_io_hps_io_gpio_inst_GPIO54,
	inout 	      hps_io_hps_io_gpio_inst_GPIO55,
	inout 	      hps_io_hps_io_gpio_inst_GPIO56,
	inout 	      hps_io_hps_io_gpio_inst_GPIO61,
	inout 	      hps_io_hps_io_gpio_inst_GPIO62
);

parameter IDCODE_VALUE = 32'h14951185;

localparam uart0_aw = 3;
localparam rom0_aw = 6;
localparam wb_aw = 32;
localparam wb_dw = 32;

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////
`include "wb_intercon.vh"

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	vga0_clk;
wire	dbg_tck;
wire	hps_sys_rst;
wire	hps_cold_rst;
wire	or1k_cpu_rst;

clkgen clkgen0 (
	.sys_clk_pad_i	(sys_clk_pad_i),
	.rst_n_pad_i	(rst_n_pad_i),
	.async_rst_o	(async_rst),
`ifdef SIM
	.tck_pad_i	(tck_pad_i),
	.dbg_tck_o	(dbg_tck),
`endif

	.vga0_clk_o	(vga0_clk),

	.i2s0_mclk_o	(i2s0_mclk),

	.hps_sys_rst_o	(hps_sys_rst),
	.hps_cold_rst_o	(hps_cold_rst),
	.or1k_cpu_rst_o	(or1k_cpu_rst),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),
	// Wishbone Slave Interface
	.wb_adr_i	(wb_m2s_clkgen_adr[7:0]),
	.wb_dat_i	(wb_m2s_clkgen_dat),
	.wb_we_i	(wb_m2s_clkgen_we),
	.wb_cyc_i	(wb_m2s_clkgen_cyc),
	.wb_stb_i	(wb_m2s_clkgen_stb),
	.wb_cti_i	(wb_m2s_clkgen_cti),
	.wb_bte_i	(wb_m2s_clkgen_bte),
	.wb_dat_o	(wb_s2m_clkgen_dat),
	.wb_ack_o	(wb_s2m_clkgen_ack),
	.wb_err_o	(wb_s2m_clkgen_err),
	.wb_rty_o	(wb_s2m_clkgen_rty)
);

`ifdef SIM
////////////////////////////////////////////////////////////////////////
//
// GENERIC JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

tap_top jtag_tap0 (
	.tdo_pad_o			(tdo_pad_o),
	.tms_pad_i			(tms_pad_i),
	.tck_pad_i			(dbg_tck),
	.trst_pad_i			(async_rst),
	.tdi_pad_i			(tdi_pad_i),

	.tdo_padoe_o			(tdo_padoe_o),

	.tdo_o				(jtag_tap_tdo),

	.shift_dr_o			(jtag_tap_shift_dr),
	.pause_dr_o			(jtag_tap_pause_dr),
	.update_dr_o			(jtag_tap_update_dr),
	.capture_dr_o			(jtag_tap_capture_dr),

	.extest_select_o		(),
	.sample_preload_select_o	(),
	.mbist_select_o			(),
	.debug_select_o			(dbg_if_select),


	.bs_chain_tdi_i			(1'b0),
	.mbist_tdi_i			(1'b0),
	.debug_tdi_i			(dbg_if_tdo)
);

`elsif ALTERA_JTAG_TAP
////////////////////////////////////////////////////////////////////////
//
// ALTERA Virtual JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

altera_virtual_jtag jtag_tap0 (
	.tck_o			(dbg_tck),
	.debug_tdo_i		(dbg_if_tdo),
	.tdi_o			(jtag_tap_tdo),
	.test_logic_reset_o	(),
	.run_test_idle_o	(),
	.shift_dr_o		(jtag_tap_shift_dr),
	.capture_dr_o		(jtag_tap_capture_dr),
	.pause_dr_o		(jtag_tap_pause_dr),
	.update_dr_o		(jtag_tap_update_dr),
	.debug_select_o		(dbg_if_select)
);
`endif
////////////////////////////////////////////////////////////////////////
//
// Hard Processor System (HPS)
//
////////////////////////////////////////////////////////////////////////

wire 			uart0_txd;
wire 			uart0_rxd;

wire [29:0] hps_0_f2h_sdram0_data_address;
wire [7:0]  hps_0_f2h_sdram0_data_burstcount;
wire        hps_0_f2h_sdram0_data_waitrequest;
wire [31:0] hps_0_f2h_sdram0_data_readdata;
wire        hps_0_f2h_sdram0_data_readdatavalid;
wire        hps_0_f2h_sdram0_data_read;
wire [31:0] hps_0_f2h_sdram0_data_writedata;
wire [3:0]  hps_0_f2h_sdram0_data_byteenable;
wire        hps_0_f2h_sdram0_data_write;

wire [27:0] fpga_ddr3_avl_address;
wire [5:0]  fpga_ddr3_avl_burstcount;
wire        fpga_ddr3_avl_waitrequest_n;
wire        fpga_ddr3_avl_waitrequest = !fpga_ddr3_avl_waitrequest_n;
wire [31:0] fpga_ddr3_avl_readdata;
wire        fpga_ddr3_avl_readdatavalid;
wire        fpga_ddr3_avl_read;
wire [31:0] fpga_ddr3_avl_writedata;
wire [3:0]  fpga_ddr3_avl_byteenable;
wire        fpga_ddr3_avl_write;

wire [27:0] vga0_ddr3_avl_address;
wire [5:0]  vga0_ddr3_avl_burstcount;
wire        vga0_ddr3_avl_waitrequest_n;
wire        vga0_ddr3_avl_waitrequest = !vga0_ddr3_avl_waitrequest_n;
wire [31:0] vga0_ddr3_avl_readdata;
wire        vga0_ddr3_avl_readdatavalid;
wire        vga0_ddr3_avl_read;
wire [31:0] vga0_ddr3_avl_writedata;
wire [3:0]  vga0_ddr3_avl_byteenable;
wire        vga0_ddr3_avl_write;

wire [20:0] h2f_lw_avl_address;
wire [0:0]  h2f_lw_avl_burstcount;
wire        h2f_lw_avl_waitrequest;
wire [31:0] h2f_lw_avl_readdata;
wire        h2f_lw_avl_readdatavalid;
wire        h2f_lw_avl_read;
wire [31:0] h2f_lw_avl_writedata;
wire [3:0]  h2f_lw_avl_byteenable;
wire        h2f_lw_avl_write;

// Instantiate the qsys generated system.
/* sockit AUTO_TEMPLATE (
	.clk_clk			(wb_clk),
	.reset_reset_n			(!hps_sys_rst),
	.fpga_ddr3_pll_ref_clk_clk      (fpga_ddr3_ref_clk_pad_i),
	.hps_0_uart1_cts		(1'b0),
	.hps_0_uart1_dsr		(1'b0),
	.hps_0_uart1_dcd		(1'b0),
	.hps_0_uart1_ri			(1'b0),
	.hps_0_uart1_dtr		(),
	.hps_0_uart1_rts		(),
	.hps_0_uart1_out1_n		(),
	.hps_0_uart1_out2_n		(),
	.hps_0_uart1_rxd		(uart0_txd),
	.hps_0_uart1_txd		(uart0_rxd),
	.hps_0_emac0_phy_txd_o		(),
	.hps_0_emac0_phy_txen_o		(),
	.hps_0_emac0_phy_txer_o		(),
	.hps_0_emac0_phy_rxdv_i		(),
	.hps_0_emac0_phy_rxer_i		(),
	.hps_0_emac0_phy_rxd_i		(),
	.hps_0_emac0_phy_col_i		(),
	.hps_0_emac0_phy_crs_i		(),
	.hps_0_emac0_gmii_mdo_o		(),
	.hps_0_emac0_gmii_mdo_o_e	(),
	.hps_0_emac0_gmii_mdi_i		(),
	.hps_0_emac0_ptp_pps_o		(),
	.hps_0_emac0_ptp_aux_ts_trig_i	(),
	.hps_0_emac0_md_clk_clk		(),
	.hps_0_emac0_rx_clk_in_clk	(),
	.hps_0_emac0_tx_clk_in_clk	(),
	.hps_0_emac0_gtx_clk_clk	(),
	.hps_0_emac0_tx_reset_reset_n	(),
	.hps_0_emac0_rx_reset_reset_n	(),
	.hps_0_emac_ptp_ref_clock_clk	(),
	.hps_0_f2h_cold_reset_req_reset_n(!hps_cold_rst),
);*/
sockit hps
       (
	/*AUTOINST*/
	// Outputs
	.memory_mem_a			(memory_mem_a[14:0]),
	.memory_mem_ba			(memory_mem_ba[2:0]),
	.memory_mem_ck			(memory_mem_ck),
	.memory_mem_ck_n		(memory_mem_ck_n),
	.memory_mem_cke			(memory_mem_cke),
	.memory_mem_cs_n		(memory_mem_cs_n),
	.memory_mem_ras_n		(memory_mem_ras_n),
	.memory_mem_cas_n		(memory_mem_cas_n),
	.memory_mem_we_n		(memory_mem_we_n),
	.memory_mem_reset_n		(memory_mem_reset_n),
	.memory_mem_odt			(memory_mem_odt),
	.memory_mem_dm			(memory_mem_dm[3:0]),
	.hps_io_hps_io_emac1_inst_TX_CLK(hps_io_hps_io_emac1_inst_TX_CLK),
	.hps_io_hps_io_emac1_inst_TXD0	(hps_io_hps_io_emac1_inst_TXD0),
	.hps_io_hps_io_emac1_inst_TXD1	(hps_io_hps_io_emac1_inst_TXD1),
	.hps_io_hps_io_emac1_inst_TXD2	(hps_io_hps_io_emac1_inst_TXD2),
	.hps_io_hps_io_emac1_inst_TXD3	(hps_io_hps_io_emac1_inst_TXD3),
	.hps_io_hps_io_emac1_inst_MDC	(hps_io_hps_io_emac1_inst_MDC),
	.hps_io_hps_io_emac1_inst_TX_CTL(hps_io_hps_io_emac1_inst_TX_CTL),
	.hps_io_hps_io_qspi_inst_SS0	(hps_io_hps_io_qspi_inst_SS0),
	.hps_io_hps_io_qspi_inst_CLK	(hps_io_hps_io_qspi_inst_CLK),
	.hps_io_hps_io_sdio_inst_CLK	(hps_io_hps_io_sdio_inst_CLK),
	.hps_io_hps_io_usb1_inst_STP	(hps_io_hps_io_usb1_inst_STP),
	.hps_io_hps_io_spim0_inst_CLK	(hps_io_hps_io_spim0_inst_CLK),
	.hps_io_hps_io_spim0_inst_MOSI	(hps_io_hps_io_spim0_inst_MOSI),
	.hps_io_hps_io_spim0_inst_SS0	(hps_io_hps_io_spim0_inst_SS0),
	.hps_io_hps_io_spim1_inst_CLK	(hps_io_hps_io_spim1_inst_CLK),
	.hps_io_hps_io_spim1_inst_MOSI	(hps_io_hps_io_spim1_inst_MOSI),
	.hps_io_hps_io_spim1_inst_SS0	(hps_io_hps_io_spim1_inst_SS0),
	.hps_io_hps_io_uart0_inst_TX	(hps_io_hps_io_uart0_inst_TX),
	.hps_0_uart1_dtr		(),			 // Templated
	.hps_0_uart1_rts		(),			 // Templated
	.hps_0_uart1_out1_n		(),			 // Templated
	.hps_0_uart1_out2_n		(),			 // Templated
	.hps_0_uart1_txd		(uart0_rxd),		 // Templated
	.hps_0_emac0_phy_txd_o		(),			 // Templated
	.hps_0_emac0_phy_txen_o		(),			 // Templated
	.hps_0_emac0_phy_txer_o		(),			 // Templated
	.hps_0_emac0_gmii_mdo_o		(),			 // Templated
	.hps_0_emac0_gmii_mdo_o_e	(),			 // Templated
	.hps_0_emac0_ptp_pps_o		(),			 // Templated
	.hps_0_emac0_md_clk_clk		(),			 // Templated
	.hps_0_emac0_gtx_clk_clk	(),			 // Templated
	.hps_0_emac0_tx_reset_reset_n	(),			 // Templated
	.hps_0_emac0_rx_reset_reset_n	(),			 // Templated
	.hps_0_f2h_sdram0_data_waitrequest(hps_0_f2h_sdram0_data_waitrequest),
	.hps_0_f2h_sdram0_data_readdata	(hps_0_f2h_sdram0_data_readdata[31:0]),
	.hps_0_f2h_sdram0_data_readdatavalid(hps_0_f2h_sdram0_data_readdatavalid),
	.fpga_ddr3_mem_a		(fpga_ddr3_mem_a[14:0]),
	.fpga_ddr3_mem_ba		(fpga_ddr3_mem_ba[2:0]),
	.fpga_ddr3_mem_ck		(fpga_ddr3_mem_ck[0:0]),
	.fpga_ddr3_mem_ck_n		(fpga_ddr3_mem_ck_n[0:0]),
	.fpga_ddr3_mem_cke		(fpga_ddr3_mem_cke[0:0]),
	.fpga_ddr3_mem_cs_n		(fpga_ddr3_mem_cs_n[0:0]),
	.fpga_ddr3_mem_dm		(fpga_ddr3_mem_dm[3:0]),
	.fpga_ddr3_mem_ras_n		(fpga_ddr3_mem_ras_n[0:0]),
	.fpga_ddr3_mem_cas_n		(fpga_ddr3_mem_cas_n[0:0]),
	.fpga_ddr3_mem_we_n		(fpga_ddr3_mem_we_n[0:0]),
	.fpga_ddr3_mem_reset_n		(fpga_ddr3_mem_reset_n),
	.fpga_ddr3_mem_odt		(fpga_ddr3_mem_odt[0:0]),
	.fpga_ddr3_status_local_init_done(fpga_ddr3_status_local_init_done),
	.fpga_ddr3_status_local_cal_success(fpga_ddr3_status_local_cal_success),
	.fpga_ddr3_status_local_cal_fail(fpga_ddr3_status_local_cal_fail),
	.fpga_ddr3_avl_waitrequest_n	(fpga_ddr3_avl_waitrequest_n),
	.fpga_ddr3_avl_readdatavalid	(fpga_ddr3_avl_readdatavalid),
	.fpga_ddr3_avl_readdata		(fpga_ddr3_avl_readdata[31:0]),
	.h2f_lw_avl_burstcount		(h2f_lw_avl_burstcount[0:0]),
	.h2f_lw_avl_writedata		(h2f_lw_avl_writedata[31:0]),
	.h2f_lw_avl_address		(h2f_lw_avl_address[20:0]),
	.h2f_lw_avl_write		(h2f_lw_avl_write),
	.h2f_lw_avl_read		(h2f_lw_avl_read),
	.h2f_lw_avl_byteenable		(h2f_lw_avl_byteenable[3:0]),
	.h2f_lw_avl_debugaccess		(h2f_lw_avl_debugaccess),
	.vga0_ddr3_avl_waitrequest_n	(vga0_ddr3_avl_waitrequest_n),
	.vga0_ddr3_avl_readdatavalid	(vga0_ddr3_avl_readdatavalid),
	.vga0_ddr3_avl_readdata		(vga0_ddr3_avl_readdata[31:0]),
	// Inouts
	.memory_mem_dq			(memory_mem_dq[31:0]),
	.memory_mem_dqs			(memory_mem_dqs[3:0]),
	.memory_mem_dqs_n		(memory_mem_dqs_n[3:0]),
	.hps_io_hps_io_emac1_inst_MDIO	(hps_io_hps_io_emac1_inst_MDIO),
	.hps_io_hps_io_qspi_inst_IO0	(hps_io_hps_io_qspi_inst_IO0),
	.hps_io_hps_io_qspi_inst_IO1	(hps_io_hps_io_qspi_inst_IO1),
	.hps_io_hps_io_qspi_inst_IO2	(hps_io_hps_io_qspi_inst_IO2),
	.hps_io_hps_io_qspi_inst_IO3	(hps_io_hps_io_qspi_inst_IO3),
	.hps_io_hps_io_sdio_inst_CMD	(hps_io_hps_io_sdio_inst_CMD),
	.hps_io_hps_io_sdio_inst_D0	(hps_io_hps_io_sdio_inst_D0),
	.hps_io_hps_io_sdio_inst_D1	(hps_io_hps_io_sdio_inst_D1),
	.hps_io_hps_io_sdio_inst_D2	(hps_io_hps_io_sdio_inst_D2),
	.hps_io_hps_io_sdio_inst_D3	(hps_io_hps_io_sdio_inst_D3),
	.hps_io_hps_io_usb1_inst_D0	(hps_io_hps_io_usb1_inst_D0),
	.hps_io_hps_io_usb1_inst_D1	(hps_io_hps_io_usb1_inst_D1),
	.hps_io_hps_io_usb1_inst_D2	(hps_io_hps_io_usb1_inst_D2),
	.hps_io_hps_io_usb1_inst_D3	(hps_io_hps_io_usb1_inst_D3),
	.hps_io_hps_io_usb1_inst_D4	(hps_io_hps_io_usb1_inst_D4),
	.hps_io_hps_io_usb1_inst_D5	(hps_io_hps_io_usb1_inst_D5),
	.hps_io_hps_io_usb1_inst_D6	(hps_io_hps_io_usb1_inst_D6),
	.hps_io_hps_io_usb1_inst_D7	(hps_io_hps_io_usb1_inst_D7),
	.hps_io_hps_io_i2c1_inst_SDA	(hps_io_hps_io_i2c1_inst_SDA),
	.hps_io_hps_io_i2c1_inst_SCL	(hps_io_hps_io_i2c1_inst_SCL),
	.hps_io_hps_io_gpio_inst_GPIO00	(hps_io_hps_io_gpio_inst_GPIO00),
	.hps_io_hps_io_gpio_inst_GPIO09	(hps_io_hps_io_gpio_inst_GPIO09),
	.hps_io_hps_io_gpio_inst_GPIO35	(hps_io_hps_io_gpio_inst_GPIO35),
	.hps_io_hps_io_gpio_inst_GPIO48	(hps_io_hps_io_gpio_inst_GPIO48),
	.hps_io_hps_io_gpio_inst_GPIO53	(hps_io_hps_io_gpio_inst_GPIO53),
	.hps_io_hps_io_gpio_inst_GPIO54	(hps_io_hps_io_gpio_inst_GPIO54),
	.hps_io_hps_io_gpio_inst_GPIO55	(hps_io_hps_io_gpio_inst_GPIO55),
	.hps_io_hps_io_gpio_inst_GPIO56	(hps_io_hps_io_gpio_inst_GPIO56),
	.hps_io_hps_io_gpio_inst_GPIO61	(hps_io_hps_io_gpio_inst_GPIO61),
	.hps_io_hps_io_gpio_inst_GPIO62	(hps_io_hps_io_gpio_inst_GPIO62),
	.fpga_ddr3_mem_dq		(fpga_ddr3_mem_dq[31:0]),
	.fpga_ddr3_mem_dqs		(fpga_ddr3_mem_dqs[3:0]),
	.fpga_ddr3_mem_dqs_n		(fpga_ddr3_mem_dqs_n[3:0]),
	// Inputs
	.clk_clk			(wb_clk),		 // Templated
	.reset_reset_n			(!hps_sys_rst),		 // Templated
	.fpga_ddr3_pll_ref_clk_clk      (fpga_ddr3_ref_clk_pad_i),
	.memory_oct_rzqin		(memory_oct_rzqin),
	.hps_io_hps_io_emac1_inst_RXD0	(hps_io_hps_io_emac1_inst_RXD0),
	.hps_io_hps_io_emac1_inst_RX_CTL(hps_io_hps_io_emac1_inst_RX_CTL),
	.hps_io_hps_io_emac1_inst_RX_CLK(hps_io_hps_io_emac1_inst_RX_CLK),
	.hps_io_hps_io_emac1_inst_RXD1	(hps_io_hps_io_emac1_inst_RXD1),
	.hps_io_hps_io_emac1_inst_RXD2	(hps_io_hps_io_emac1_inst_RXD2),
	.hps_io_hps_io_emac1_inst_RXD3	(hps_io_hps_io_emac1_inst_RXD3),
	.hps_io_hps_io_usb1_inst_CLK	(hps_io_hps_io_usb1_inst_CLK),
	.hps_io_hps_io_usb1_inst_DIR	(hps_io_hps_io_usb1_inst_DIR),
	.hps_io_hps_io_usb1_inst_NXT	(hps_io_hps_io_usb1_inst_NXT),
	.hps_io_hps_io_spim0_inst_MISO	(hps_io_hps_io_spim0_inst_MISO),
	.hps_io_hps_io_spim1_inst_MISO	(hps_io_hps_io_spim1_inst_MISO),
	.hps_io_hps_io_uart0_inst_RX	(hps_io_hps_io_uart0_inst_RX),
	.hps_0_uart1_cts		(1'b0),			 // Templated
	.hps_0_uart1_dsr		(1'b0),			 // Templated
	.hps_0_uart1_dcd		(1'b0),			 // Templated
	.hps_0_uart1_ri			(1'b0),			 // Templated
	.hps_0_uart1_rxd		(uart0_txd),		 // Templated
	.hps_0_emac0_phy_rxdv_i		(),			 // Templated
	.hps_0_emac0_phy_rxer_i		(),			 // Templated
	.hps_0_emac0_phy_rxd_i		(),			 // Templated
	.hps_0_emac0_phy_col_i		(),			 // Templated
	.hps_0_emac0_phy_crs_i		(),			 // Templated
	.hps_0_emac0_gmii_mdi_i		(),			 // Templated
	.hps_0_emac0_ptp_aux_ts_trig_i	(),			 // Templated
	.hps_0_emac0_rx_clk_in_clk	(),			 // Templated
	.hps_0_emac0_tx_clk_in_clk	(),			 // Templated
	.hps_0_emac_ptp_ref_clock_clk	(),			 // Templated
	.hps_0_f2h_sdram0_data_address	(hps_0_f2h_sdram0_data_address[29:0]),
	.hps_0_f2h_sdram0_data_burstcount(hps_0_f2h_sdram0_data_burstcount[7:0]),
	.hps_0_f2h_sdram0_data_read	(hps_0_f2h_sdram0_data_read),
	.hps_0_f2h_sdram0_data_writedata(hps_0_f2h_sdram0_data_writedata[31:0]),
	.hps_0_f2h_sdram0_data_byteenable(hps_0_f2h_sdram0_data_byteenable[3:0]),
	.hps_0_f2h_sdram0_data_write	(hps_0_f2h_sdram0_data_write),
	.hps_0_f2h_cold_reset_req_reset_n(!hps_cold_rst),	 // Templated
	.fpga_ddr3_oct_rzqin		(fpga_ddr3_oct_rzqin),
	.fpga_ddr3_avl_beginbursttransfer(fpga_ddr3_avl_beginbursttransfer),
	.fpga_ddr3_avl_address		(fpga_ddr3_avl_address[27:0]),
	.fpga_ddr3_avl_writedata	(fpga_ddr3_avl_writedata[31:0]),
	.fpga_ddr3_avl_byteenable	(fpga_ddr3_avl_byteenable[3:0]),
	.fpga_ddr3_avl_read		(fpga_ddr3_avl_read),
	.fpga_ddr3_avl_write		(fpga_ddr3_avl_write),
	.fpga_ddr3_avl_burstcount	(fpga_ddr3_avl_burstcount[5:0]),
	.h2f_lw_avl_waitrequest		(h2f_lw_avl_waitrequest),
	.h2f_lw_avl_readdata		(h2f_lw_avl_readdata[31:0]),
	.h2f_lw_avl_readdatavalid	(h2f_lw_avl_readdatavalid),
	.vga0_ddr3_avl_beginbursttransfer(vga0_ddr3_avl_beginbursttransfer),
	.vga0_ddr3_avl_address		(vga0_ddr3_avl_address[27:0]),
	.vga0_ddr3_avl_writedata	(vga0_ddr3_avl_writedata[31:0]),
	.vga0_ddr3_avl_byteenable	(vga0_ddr3_avl_byteenable[3:0]),
	.vga0_ddr3_avl_read		(vga0_ddr3_avl_read),
	.vga0_ddr3_avl_write		(vga0_ddr3_avl_write),
	.vga0_ddr3_avl_burstcount	(vga0_ddr3_avl_burstcount[5:0]));

// HPS DDR3 interface
wire [31:0] avm_hps_ddr3_address;
assign hps_0_f2h_sdram0_data_address = {2'h0, avm_hps_ddr3_address[29:2]};

wb_to_avalon_bridge #(
	.DW			(32),
	.AW			(32),
	.BURST_SUPPORT		(1)
) hps_ddr3_wb2avl_bridge (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	// Wishbone Slave Input
	.wb_adr_i		(wb_m2s_hps_ddr3_adr),
	.wb_dat_i		(wb_m2s_hps_ddr3_dat),
	.wb_sel_i		(wb_m2s_hps_ddr3_sel),
	.wb_we_i		(wb_m2s_hps_ddr3_we),
	.wb_cyc_i		(wb_m2s_hps_ddr3_cyc),
	.wb_stb_i		(wb_m2s_hps_ddr3_stb),
	.wb_cti_i		(wb_m2s_hps_ddr3_cti),
	.wb_bte_i		(wb_m2s_hps_ddr3_bte),
	.wb_dat_o		(wb_s2m_hps_ddr3_dat),
	.wb_ack_o		(wb_s2m_hps_ddr3_ack),
	.wb_err_o		(wb_s2m_hps_ddr3_err),
	.wb_rty_o		(wb_s2m_hps_ddr3_rty),
	// Avalon Master Output
	.m_av_address_o		(avm_hps_ddr3_address),
	.m_av_byteenable_o	(hps_0_f2h_sdram0_data_byteenable),
	.m_av_read_o		(hps_0_f2h_sdram0_data_read),
	.m_av_readdata_i	(hps_0_f2h_sdram0_data_readdata),
	.m_av_burstcount_o	(hps_0_f2h_sdram0_data_burstcount),
	.m_av_write_o		(hps_0_f2h_sdram0_data_write),
	.m_av_writedata_o	(hps_0_f2h_sdram0_data_writedata),
	.m_av_waitrequest_i	(hps_0_f2h_sdram0_data_waitrequest),
	.m_av_readdatavalid_i	(hps_0_f2h_sdram0_data_readdatavalid)
);

// FPGA DDR3 interface - common port
wire [31:0] avm_fpga_ddr3_address;
assign fpga_ddr3_avl_address = avm_fpga_ddr3_address[29:2];

wb_to_avalon_bridge #(
	.DW			(32),
	.AW			(32),
	.BURST_SUPPORT		(1)
) fpga_ddr3_wb2avl_bridge (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	// Wishbone Slave Input
	.wb_adr_i		(wb_m2s_fpga_ddr3_adr),
	.wb_dat_i		(wb_m2s_fpga_ddr3_dat),
	.wb_sel_i		(wb_m2s_fpga_ddr3_sel),
	.wb_we_i		(wb_m2s_fpga_ddr3_we),
	.wb_cyc_i		(wb_m2s_fpga_ddr3_cyc),
	.wb_stb_i		(wb_m2s_fpga_ddr3_stb),
	.wb_cti_i		(wb_m2s_fpga_ddr3_cti),
	.wb_bte_i		(wb_m2s_fpga_ddr3_bte),
	.wb_dat_o		(wb_s2m_fpga_ddr3_dat),
	.wb_ack_o		(wb_s2m_fpga_ddr3_ack),
	.wb_err_o		(wb_s2m_fpga_ddr3_err),
	.wb_rty_o		(wb_s2m_fpga_ddr3_rty),
	// Avalon Master Output
	.m_av_address_o		(avm_fpga_ddr3_address),
	.m_av_byteenable_o	(fpga_ddr3_avl_byteenable),
	.m_av_read_o		(fpga_ddr3_avl_read),
	.m_av_readdata_i	(fpga_ddr3_avl_readdata),
	.m_av_burstcount_o	(fpga_ddr3_avl_burstcount),
	.m_av_write_o		(fpga_ddr3_avl_write),
	.m_av_writedata_o	(fpga_ddr3_avl_writedata),
	.m_av_waitrequest_i	(fpga_ddr3_avl_waitrequest),
	.m_av_readdatavalid_i	(fpga_ddr3_avl_readdatavalid)
);

// FPGA DDR3 interface - VGA port

wire [31:0] avm_vga0_ddr3_address;
assign vga0_ddr3_avl_address = avm_vga0_ddr3_address[29:2];

wb_to_avalon_bridge #(
	.DW			(32),
	.AW			(32),
	.BURST_SUPPORT		(1)
) vga0_ddr3_wb2avl_bridge (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	// Wishbone slave Input
	.wb_adr_i		(wb_m2s_vga0_ddr3_adr),
	.wb_dat_i		(wb_m2s_vga0_ddr3_dat),
	.wb_sel_i		(wb_m2s_vga0_ddr3_sel),
	.wb_we_i		(wb_m2s_vga0_ddr3_we),
	.wb_cyc_i		(wb_m2s_vga0_ddr3_cyc),
	.wb_stb_i		(wb_m2s_vga0_ddr3_stb),
	.wb_cti_i		(wb_m2s_vga0_ddr3_cti),
	.wb_bte_i		(wb_m2s_vga0_ddr3_bte),
	.wb_dat_o		(wb_s2m_vga0_ddr3_dat),
	.wb_ack_o		(wb_s2m_vga0_ddr3_ack),
	.wb_err_o		(wb_s2m_vga0_ddr3_err),
	.wb_rty_o		(wb_s2m_vga0_ddr3_rty),
	// Avalon Master Output
	.m_av_address_o		(avm_vga0_ddr3_address),
	.m_av_byteenable_o	(vga0_ddr3_avl_byteenable),
	.m_av_read_o		(vga0_ddr3_avl_read),
	.m_av_readdata_i	(vga0_ddr3_avl_readdata),
	.m_av_burstcount_o	(vga0_ddr3_avl_burstcount),
	.m_av_write_o		(vga0_ddr3_avl_write),
	.m_av_writedata_o	(vga0_ddr3_avl_writedata),
	.m_av_waitrequest_i	(vga0_ddr3_avl_waitrequest),
	.m_av_readdatavalid_i	(vga0_ddr3_avl_readdatavalid)
);

//
// HPS lightweight bus to wishbone bridge
//
// TODO: currently the native AXI bus of the HPS is bridged to an avalon bus
// inside the qsys system, we should bridge directly from AXI to WB here
// instead.

// Adress recoding
// The LWHPS2FPGA bridge is mapped (on the ARM side) at:
// 0xff200000 - 0xff3fffff
// We translate that into the wishbone bus in the following way:
// 0xff200000 - 0xff2fffff = 0x96000000 - 0x960fffff
// 0xff300000 - 0xff3fffff = h2f[20:13] : 11'h0 : h2f[12:0]
wire [31:0] h2f_lw_avm_address;
assign h2f_lw_avm_address = !h2f_lw_avl_address[20] ?
			    {8'h96, 3'h0, h2f_lw_avl_address} :
			    {h2f_lw_avl_address[20:13], 11'h0,
			     h2f_lw_avl_address[12:0]};
avalon_to_wb_bridge #(
	.DW			(32),
 	.AW			(32)
) h2f_lw_avl2wb_bridge (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	// Avalon Slave Input
	.s_av_address_i		(h2f_lw_avm_address),
	.s_av_byteenable_i	(h2f_lw_avl_byteenable),
	.s_av_read_i		(h2f_lw_avl_read),
	.s_av_readdata_o	(h2f_lw_avl_readdata),
	.s_av_burstcount_i	(h2f_lw_avl_burstcount),
	.s_av_write_i		(h2f_lw_avl_write),
	.s_av_writedata_i	(h2f_lw_avl_writedata),
	.s_av_waitrequest_o	(h2f_lw_avl_waitrequest),
	.s_av_readdatavalid_o	(h2f_lw_avl_readdatavalid),
	// Wishbone Master Output
	.wbm_adr_o		(wb_m2s_h2f_lw_adr),
	.wbm_dat_o		(wb_m2s_h2f_lw_dat),
	.wbm_sel_o		(wb_m2s_h2f_lw_sel),
	.wbm_we_o		(wb_m2s_h2f_lw_we),
	.wbm_cyc_o		(wb_m2s_h2f_lw_cyc),
	.wbm_stb_o		(wb_m2s_h2f_lw_stb),
	.wbm_cti_o		(wb_m2s_h2f_lw_cti),
	.wbm_bte_o		(wb_m2s_h2f_lw_bte),
	.wbm_dat_i		(wb_s2m_h2f_lw_dat),
	.wbm_ack_i		(wb_s2m_h2f_lw_ack),
	.wbm_err_i		(wb_s2m_h2f_lw_err),
	.wbm_rty_i		(wb_s2m_h2f_lw_rty)
);

////////////////////////////////////////////////////////////////////////
//
// OR1K CPU
//
////////////////////////////////////////////////////////////////////////

wire	[31:0]	or1k_irq;

wire	[31:0]	or1k_dbg_dat_i;
wire	[31:0]	or1k_dbg_adr_i;
wire		or1k_dbg_we_i;
wire		or1k_dbg_stb_i;
wire		or1k_dbg_ack_o;
wire	[31:0]	or1k_dbg_dat_o;

wire		or1k_dbg_stall_i;
wire		or1k_dbg_ewt_i;
wire	[3:0]	or1k_dbg_lss_o;
wire	[1:0]	or1k_dbg_is_o;
wire	[10:0]	or1k_dbg_wp_o;
wire		or1k_dbg_bp_o;
wire		or1k_dbg_rst;

wire		sig_tick;
wire		or1k_rst;

assign or1k_rst = wb_rst | or1k_cpu_rst;

mor1kx #(
	.FEATURE_DEBUGUNIT("ENABLED"),
	.FEATURE_CMOV("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH(5),
	.OPTION_ICACHE_SET_WIDTH(8),
	.OPTION_ICACHE_WAYS(2),
	.OPTION_ICACHE_LIMIT_WIDTH(32),
	.FEATURE_IMMU("ENABLED"),
	.FEATURE_DATACACHE("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH(5),
	.OPTION_DCACHE_SET_WIDTH(8),
	.OPTION_DCACHE_WAYS(2),
	.OPTION_DCACHE_LIMIT_WIDTH(31),
	.FEATURE_DMMU("ENABLED"),
	.OPTION_PIC_TRIGGER("LATCHED_LEVEL"),

	.IBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0("CAPPUCCINO"),
	.OPTION_RESET_PC(32'hf0000100)
) mor1kx0 (
	.iwbm_adr_o(wb_m2s_or1k_i_adr),
	.iwbm_stb_o(wb_m2s_or1k_i_stb),
	.iwbm_cyc_o(wb_m2s_or1k_i_cyc),
	.iwbm_sel_o(wb_m2s_or1k_i_sel),
	.iwbm_we_o (wb_m2s_or1k_i_we),
	.iwbm_cti_o(wb_m2s_or1k_i_cti),
	.iwbm_bte_o(wb_m2s_or1k_i_bte),
	.iwbm_dat_o(wb_m2s_or1k_i_dat),

	.dwbm_adr_o(wb_m2s_or1k_d_adr),
	.dwbm_stb_o(wb_m2s_or1k_d_stb),
	.dwbm_cyc_o(wb_m2s_or1k_d_cyc),
	.dwbm_sel_o(wb_m2s_or1k_d_sel),
	.dwbm_we_o (wb_m2s_or1k_d_we ),
	.dwbm_cti_o(wb_m2s_or1k_d_cti),
	.dwbm_bte_o(wb_m2s_or1k_d_bte),
	.dwbm_dat_o(wb_m2s_or1k_d_dat),

	.clk(wb_clk),
	.rst(or1k_rst),

	.iwbm_err_i(wb_s2m_or1k_i_err),
	.iwbm_ack_i(wb_s2m_or1k_i_ack),
	.iwbm_dat_i(wb_s2m_or1k_i_dat),
	.iwbm_rty_i(wb_s2m_or1k_i_rty),

	.dwbm_err_i(wb_s2m_or1k_d_err),
	.dwbm_ack_i(wb_s2m_or1k_d_ack),
	.dwbm_dat_i(wb_s2m_or1k_d_dat),
	.dwbm_rty_i(wb_s2m_or1k_d_rty),

	.irq_i(or1k_irq),

	.du_addr_i(or1k_dbg_adr_i[15:0]),
	.du_stb_i(or1k_dbg_stb_i),
	.du_dat_i(or1k_dbg_dat_i),
	.du_we_i(or1k_dbg_we_i),
	.du_dat_o(or1k_dbg_dat_o),
	.du_ack_o(or1k_dbg_ack_o),
	.du_stall_i(or1k_dbg_stall_i),
	.du_stall_o(or1k_dbg_bp_o)
);

////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

adbg_top dbg_if0 (
	// OR1K interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(or1k_dbg_rst),
	.cpu0_addr_o	(or1k_dbg_adr_i),
	.cpu0_data_o	(or1k_dbg_dat_i),
	.cpu0_stb_o	(or1k_dbg_stb_i),
	.cpu0_we_o	(or1k_dbg_we_i),
	.cpu0_data_i	(or1k_dbg_dat_o),
	.cpu0_ack_i	(or1k_dbg_ack_o),
	.cpu0_stall_o	(or1k_dbg_stall_i),
	.cpu0_bp_i	(or1k_dbg_bp_o),

	// TAP interface
	.tck_i		(dbg_tck),
	.tdi_i		(jtag_tap_tdo),
	.tdo_o		(dbg_if_tdo),
	.rst_i		(wb_rst),
	.capture_dr_i	(jtag_tap_capture_dr),
	.shift_dr_i	(jtag_tap_shift_dr),
	.pause_dr_i	(jtag_tap_pause_dr),
	.update_dr_i	(jtag_tap_update_dr),
	.debug_select_i	(dbg_if_select),

	// Wishbone debug master
	.wb_clk_i	(wb_clk),
	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte)
);

////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_rom0_err = 1'b0;
assign	wb_s2m_rom0_rty = 1'b0;

`ifdef BOOTROM
rom #(.addr_width(rom0_aw))
rom0 (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.wb_adr_i	(wb_m2s_rom0_adr[(rom0_aw + 2) - 1 : 2]),
	.wb_cyc_i	(wb_m2s_rom0_cyc),
	.wb_stb_i	(wb_m2s_rom0_stb),
	.wb_cti_i	(wb_m2s_rom0_cti),
	.wb_bte_i	(wb_m2s_rom0_bte),
	.wb_dat_o	(wb_s2m_rom0_dat),
	.wb_ack_o	(wb_s2m_rom0_ack)
);
`else
assign	wb_s2m_rom0_dat_o = 0;
assign	wb_s2m_rom0_ack_o = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// Internal SRAM
//
////////////////////////////////////////////////////////////////////////

wb_ram #(
	.depth(65536) // 64KB
) ram_wb0 (
	.wb_clk_i		(wb_clk),
	.wb_rst_i		(wb_rst),
	.wb_adr_i		(wb_m2s_sram0_adr),
	.wb_dat_i		(wb_m2s_sram0_dat),
	.wb_sel_i		(wb_m2s_sram0_sel),
	.wb_we_i		(wb_m2s_sram0_we),
	.wb_cyc_i		(wb_m2s_sram0_cyc),
	.wb_stb_i		(wb_m2s_sram0_stb),
	.wb_cti_i		(wb_m2s_sram0_cti),
	.wb_bte_i		(wb_m2s_sram0_bte),
	.wb_dat_o		(wb_s2m_sram0_dat),
	.wb_ack_o		(wb_s2m_sram0_ack),
	.wb_err_o		(wb_s2m_sram0_err));

////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////

wire	uart0_irq;

uart_top uart16550_0 (
	// Wishbone slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb_m2s_uart0_adr[uart0_aw-1:0]),
	.wb_dat_i	(wb_m2s_uart0_dat),
	.wb_we_i	(wb_m2s_uart0_we),
	.wb_stb_i	(wb_m2s_uart0_stb),
	.wb_cyc_i	(wb_m2s_uart0_cyc),
	.wb_sel_i	(4'b0), // Not used in 8-bit mode
	.wb_dat_o	(wb_s2m_uart0_dat),
	.wb_ack_o	(wb_s2m_uart0_ack),

	// Outputs
	.int_o		(uart0_irq),
	.stx_pad_o	(uart0_txd),
	.rts_pad_o	(),
	.dtr_pad_o	(),

	// Inputs
	.srx_pad_i	(uart0_rxd),
	.cts_pad_i	(1'b0),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);

////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

wire [7:0]	gpio0_in;
wire [7:0]	gpio0_out;
wire [7:0]	gpio0_dir;

// Tristate logic for IO
// 0 = input, 1 = output
genvar                    i;
generate
	for (i = 0; i < 8; i = i+1) begin: gpio0_tris
		assign gpio0_io[i] = gpio0_dir[i] ? gpio0_out[i] : 1'bz;
		assign gpio0_in[i] = gpio0_dir[i] ? gpio0_out[i] : gpio0_io[i];
	end
endgenerate

gpio gpio0 (
	// GPIO bus
	.gpio_i		(gpio0_in),
	.gpio_o		(gpio0_out),
	.gpio_dir_o	(gpio0_dir),
	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_gpio0_adr[0]),
	.wb_dat_i	(wb_m2s_gpio0_dat),
	.wb_we_i	(wb_m2s_gpio0_we),
	.wb_cyc_i	(wb_m2s_gpio0_cyc),
	.wb_stb_i	(wb_m2s_gpio0_stb),
	.wb_cti_i	(wb_m2s_gpio0_cti),
	.wb_bte_i	(wb_m2s_gpio0_bte),
	.wb_dat_o	(wb_s2m_gpio0_dat),
	.wb_ack_o	(wb_s2m_gpio0_ack),
	.wb_err_o	(wb_s2m_gpio0_err),
	.wb_rty_o	(wb_s2m_gpio0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

////////////////////////////////////////////////////////////////////////
//
// I2C
//
////////////////////////////////////////////////////////////////////////
wire		i2c0_irq;
wire		scl0_pad_o;
wire		scl0_padoen_o;
wire		sda0_pad_o;
wire		sda0_padoen_o;

assign i2c0_scl_io = scl0_padoen_o ? 1'bz : scl0_pad_o;
assign i2c0_sda_io = sda0_padoen_o ? 1'bz : sda0_pad_o;

i2c_master_top #(
	.ARST_LVL	(1'b0)
) i2c0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.arst_i		(1'b1),
	.wb_adr_i	(wb_m2s_i2c0_adr),
	.wb_dat_i	(wb_m2s_i2c0_dat),
	.wb_we_i	(wb_m2s_i2c0_we),
	.wb_cyc_i	(wb_m2s_i2c0_cyc),
	.wb_stb_i	(wb_m2s_i2c0_stb),
	.wb_dat_o	(wb_s2m_i2c0_dat),
	.wb_ack_o	(wb_s2m_i2c0_ack),
	.scl_pad_i	(i2c0_scl_io),
	.scl_pad_o	(scl0_pad_o),
	.scl_padoen_o	(scl0_padoen_o),
	.sda_pad_i	(i2c0_sda_io),
	.sda_pad_o	(sda0_pad_o),
	.sda_padoen_o	(sda0_padoen_o),

	// Interrupt
	.wb_inta_o	(i2c0_irq)
);

////////////////////////////////////////////////////////////////////////
//
// VGA
//
////////////////////////////////////////////////////////////////////////
wire	vga0_csync_pad;
wire	vga0_blank_pad;
wire	vga0_irq;

assign vga0_csync_n_pad_o = !vga0_csync_pad;
assign vga0_blank_n_pad_o = !vga0_blank_pad;

vga_enh_top #(
	.LINE_FIFO_AWIDTH(10)
) vga0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.rst_i		(1'b1),
	.wb_inta_o	(vga0_irq),
	// Wishbone slave connections
	.wbs_adr_i	(wb_m2s_vga0_slave_adr),
	.wbs_dat_i	(wb_m2s_vga0_slave_dat),
	.wbs_sel_i	(wb_m2s_vga0_slave_sel),
	.wbs_we_i	(wb_m2s_vga0_slave_we),
	.wbs_stb_i	(wb_m2s_vga0_slave_stb),
	.wbs_cyc_i	(wb_m2s_vga0_slave_cyc),
	.wbs_dat_o	(wb_s2m_vga0_slave_dat),
	.wbs_ack_o	(wb_s2m_vga0_slave_ack),
	.wbs_rty_o	(wb_s2m_vga0_slave_rty),
	.wbs_err_o	(wb_s2m_vga0_slave_err),
	// Wishbone master connections
	.wbm_adr_o	(wb_m2s_vga0_master_adr),
	.wbm_cti_o	(wb_m2s_vga0_master_cti),
	.wbm_bte_o	(wb_m2s_vga0_master_bte),
	.wbm_sel_o	(wb_m2s_vga0_master_sel),
	.wbm_we_o	(wb_m2s_vga0_master_we),
	.wbm_stb_o	(wb_m2s_vga0_master_stb),
	.wbm_cyc_o	(wb_m2s_vga0_master_cyc),
	.wbm_dat_i	(wb_s2m_vga0_master_dat),
	.wbm_ack_i	(wb_s2m_vga0_master_ack),
	.wbm_err_i	(wb_s2m_vga0_master_err),
	.clk_p_i	(vga0_clk),
	.clk_p_o	(vga0_clk_pad_o),
	.hsync_pad_o	(vga0_hsync_pad_o),
	.vsync_pad_o	(vga0_vsync_pad_o),
	.csync_pad_o	(vga0_csync_pad),
	.blank_pad_o	(vga0_blank_pad),
	.r_pad_o	(vga0_r_pad_o),
	.g_pad_o	(vga0_g_pad_o),
	.b_pad_o	(vga0_b_pad_o)
);

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign or1k_irq[0] = 0; // Non-maskable inside OR1K
assign or1k_irq[1] = 0; // Non-maskable inside OR1K
assign or1k_irq[2] = uart0_irq;
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
assign or1k_irq[6] = 0;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = vga0_irq;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = i2c0_irq;
assign or1k_irq[11] = 0;
assign or1k_irq[12] = 0;
assign or1k_irq[13] = 0;
assign or1k_irq[14] = 0;
assign or1k_irq[15] = 0;
assign or1k_irq[16] = 0;
assign or1k_irq[17] = 0;
assign or1k_irq[18] = 0;
assign or1k_irq[19] = 0;
assign or1k_irq[20] = 0;
assign or1k_irq[21] = 0;
assign or1k_irq[22] = 0;
assign or1k_irq[23] = 0;
assign or1k_irq[24] = 0;
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;
assign or1k_irq[31] = 0;

endmodule // orpsoc_top
