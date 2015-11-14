//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC top for Atlys board                                    ////
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

module orpsoc_top #(
	parameter	rom0_aw = 8,
	parameter	uart0_aw = 3
)(
	input		sys_clk_pad_i,
	input		rst_n_pad_i,

	// JTAG
	output		tdo_pad_o,
	input		tms_pad_i,
	input		tck_pad_i,
	input		tdi_pad_i,

	// Ethernet
	input		eth0_tx_clk,
	output [3:0]	eth0_tx_data,
	output		eth0_tx_en,
	output		eth0_tx_er,
	input		eth0_rx_clk,
	input [3:0]	eth0_rx_data,
	input		eth0_dv,
	input		eth0_rx_er,
	input		eth0_col,
	input		eth0_crs,
	output		eth0_mdc_pad_o,
	inout		eth0_md_pad_io,
	output		eth0_rst_n_o,

	// DVI
	output [3:0]	tmds_o,
	output [3:0]	tmdsb_o,

	// DDR2
	output [12:0]	ddr2_a,
	output [2:0]	ddr2_ba,
	output		ddr2_ras_n,
	output		ddr2_cas_n,
	output		ddr2_we_n,
	output		ddr2_rzq,
	output		ddr2_zio,
	output		ddr2_odt,
	output		ddr2_cke,
	output		ddr2_dm,
	output		ddr2_udm,
	inout [15:0]	ddr2_dq,
	inout		ddr2_dqs,
	inout		ddr2_dqs_n,
	inout		ddr2_udqs,
	inout		ddr2_udqs_n,
	output		ddr2_ck,
	output		ddr2_ck_n,

	// UART
	input		uart0_srx_pad_i,
	output		uart0_stx_pad_o,

	// GPIO
	inout	[7:0]	gpio0_io,

	// SPI
	output		spi0_sck_o,
	output		spi0_mosi_o,
	input		spi0_miso_i,
	output [0:0]	spi0_ss_o,

	// AC97
	input		ac97_bit_clk_pad_i,
	output		ac97_sync_pad_o,
	output		ac97_sdata_pad_o,
	input		ac97_sdata_pad_i,
	output		ac97_reset_pad_o,

	// PS2
	inout		ps2_0_clk,
	inout		ps2_0_dat,

	inout		ps2_1_clk,
	inout		ps2_1_dat,

	inout		ps2_2_clk,
	inout		ps2_2_dat
);

parameter	IDCODE_VALUE=32'h14951185;

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	dbg_tck;

wire	dvi_clk;

wire	ddr2_if_clk;
wire	ddr2_if_rst;
wire	clk100;

clkgen clkgen0 (
	.sys_clk_pad_i	(sys_clk_pad_i),
	.rst_n_pad_i	(rst_n_pad_i),
	.async_rst_o	(async_rst),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),

	.tck_pad_i	(tck_pad_i),
	.dbg_tck_o	(dbg_tck),

	.dvi_clk_o	(dvi_clk),

	.ddr2_if_clk_o	(ddr2_if_clk),
	.ddr2_if_rst_o	(ddr2_if_rst),
	.clk100_o	(clk100)
);

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////
`include "wb_intercon.vh"

`ifdef JTAG_DEBUG
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

`endif

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

assign or1k_rst = wb_rst | or1k_dbg_rst;

`ifdef OR1200

or1200_top #(.boot_adr(32'hf0000100))
or1200_top0 (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk),
	.iwb_rst_i			(wb_rst),
	.iwb_ack_i			(wb_s2m_or1k_i_ack),
	.iwb_err_i			(wb_s2m_or1k_i_err),
	.iwb_rty_i			(wb_s2m_or1k_i_rty),
	.iwb_dat_i			(wb_s2m_or1k_i_dat),

	.iwb_cyc_o			(wb_m2s_or1k_i_cyc),
	.iwb_adr_o			(wb_m2s_or1k_i_adr),
	.iwb_stb_o			(wb_m2s_or1k_i_stb),
	.iwb_we_o			(wb_m2s_or1k_i_we),
	.iwb_sel_o			(wb_m2s_or1k_i_sel),
	.iwb_dat_o			(wb_m2s_or1k_i_dat),
	.iwb_cti_o			(wb_m2s_or1k_i_cti),
	.iwb_bte_o			(wb_m2s_or1k_i_bte),

	// Data bus, clocks, reset
	.dwb_clk_i			(wb_clk),
	.dwb_rst_i			(wb_rst),
	.dwb_ack_i			(wb_s2m_or1k_d_ack),
	.dwb_err_i			(wb_s2m_or1k_d_err),
	.dwb_rty_i			(wb_s2m_or1k_d_rty),
	.dwb_dat_i			(wb_s2m_or1k_d_dat),

	.dwb_cyc_o			(wb_m2s_or1k_d_cyc),
	.dwb_adr_o			(wb_m2s_or1k_d_adr),
	.dwb_stb_o			(wb_m2s_or1k_d_stb),
	.dwb_we_o			(wb_m2s_or1k_d_we),
	.dwb_sel_o			(wb_m2s_or1k_d_sel),
	.dwb_dat_o			(wb_m2s_or1k_d_dat),
	.dwb_cti_o			(wb_m2s_or1k_d_cti),
	.dwb_bte_o			(wb_m2s_or1k_d_bte),

	// Debug interface ports
	.dbg_stall_i			(or1k_dbg_stall_i),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(or1k_dbg_lss_o),
	.dbg_is_o			(or1k_dbg_is_o),
	.dbg_wp_o			(or1k_dbg_wp_o),
	.dbg_bp_o			(or1k_dbg_bp_o),

	.dbg_adr_i			(or1k_dbg_adr_i),
	.dbg_we_i			(or1k_dbg_we_i),
	.dbg_stb_i			(or1k_dbg_stb_i),
	.dbg_dat_i			(or1k_dbg_dat_i),
	.dbg_dat_o			(or1k_dbg_dat_o),
	.dbg_ack_o			(or1k_dbg_ack_o),

	.pm_clksd_o			(),
	.pm_dc_gate_o			(),
	.pm_ic_gate_o			(),
	.pm_dmmu_gate_o			(),
	.pm_immu_gate_o			(),
	.pm_tt_gate_o			(),
	.pm_cpu_gate_o			(),
	.pm_wakeup_o			(),
	.pm_lvolt_o			(),

	// Core clocks, resets
	.clk_i				(wb_clk),
	.rst_i				(or1k_rst),

	.clmode_i			(2'b00),

	// Interrupts
	.pic_ints_i			(or1k_irq),
	.sig_tick			(sig_tick),

	.pm_cpustall_i			(1'b0)
);
`endif

`ifdef MOR1KX
mor1kx #(
	.FEATURE_DEBUGUNIT("ENABLED"),
	.FEATURE_CMOV("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH(5),
	.OPTION_ICACHE_SET_WIDTH(8),
	.OPTION_ICACHE_WAYS(4),
	.OPTION_ICACHE_LIMIT_WIDTH(32),
	.FEATURE_IMMU("ENABLED"),
	.OPTION_IMMU_SET_WIDTH(7),
	.FEATURE_DATACACHE("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH(5),
	.OPTION_DCACHE_SET_WIDTH(8),
	.OPTION_DCACHE_WAYS(4),
	.OPTION_DCACHE_LIMIT_WIDTH(31),
	.FEATURE_DMMU("ENABLED"),
	.OPTION_DMMU_SET_WIDTH(7),
	.OPTION_PIC_TRIGGER("LATCHED_LEVEL"),

	.IBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0("CAPPUCCINO"),
	.OPTION_RESET_PC(32'hf0000000)
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

`endif
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
	.wb_rst_i	(wb_rst),
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
// DDR2 SDRAM Memory Controller
//
////////////////////////////////////////////////////////////////////////

xilinx_ddr2 xilinx_ddr2_0 (
	.wbm0_adr_i	(wb_m2s_ddr2_eth0_adr),
	.wbm0_bte_i	(wb_m2s_ddr2_eth0_bte),
	.wbm0_cti_i	(wb_m2s_ddr2_eth0_cti),
	.wbm0_cyc_i	(wb_m2s_ddr2_eth0_cyc),
	.wbm0_dat_i	(wb_m2s_ddr2_eth0_dat),
	.wbm0_sel_i	(wb_m2s_ddr2_eth0_sel),
	.wbm0_stb_i	(wb_m2s_ddr2_eth0_stb),
	.wbm0_we_i	(wb_m2s_ddr2_eth0_we),
	.wbm0_ack_o	(wb_s2m_ddr2_eth0_ack),
	.wbm0_err_o	(wb_s2m_ddr2_eth0_err),
	.wbm0_rty_o	(wb_s2m_ddr2_eth0_rty),
	.wbm0_dat_o	(wb_s2m_ddr2_eth0_dat),

	.wbm1_adr_i	(wb_m2s_ddr2_dbus_adr),
	.wbm1_bte_i	(wb_m2s_ddr2_dbus_bte),
	.wbm1_cti_i	(wb_m2s_ddr2_dbus_cti),
	.wbm1_cyc_i	(wb_m2s_ddr2_dbus_cyc),
	.wbm1_dat_i	(wb_m2s_ddr2_dbus_dat),
	.wbm1_sel_i	(wb_m2s_ddr2_dbus_sel),
	.wbm1_stb_i	(wb_m2s_ddr2_dbus_stb),
	.wbm1_we_i	(wb_m2s_ddr2_dbus_we),
	.wbm1_ack_o	(wb_s2m_ddr2_dbus_ack),
	.wbm1_err_o	(wb_s2m_ddr2_dbus_err),
	.wbm1_rty_o	(wb_s2m_ddr2_dbus_rty),
	.wbm1_dat_o	(wb_s2m_ddr2_dbus_dat),

	.wbm2_adr_i	(wb_m2s_ddr2_ibus_adr),
	.wbm2_bte_i	(wb_m2s_ddr2_ibus_bte),
	.wbm2_cti_i	(wb_m2s_ddr2_ibus_cti),
	.wbm2_cyc_i	(wb_m2s_ddr2_ibus_cyc),
	.wbm2_dat_i	(wb_m2s_ddr2_ibus_dat),
	.wbm2_sel_i	(wb_m2s_ddr2_ibus_sel),
	.wbm2_stb_i	(wb_m2s_ddr2_ibus_stb),
	.wbm2_we_i	(wb_m2s_ddr2_ibus_we),
	.wbm2_ack_o	(wb_s2m_ddr2_ibus_ack),
	.wbm2_err_o	(wb_s2m_ddr2_ibus_err),
	.wbm2_rty_o	(wb_s2m_ddr2_ibus_rty),
	.wbm2_dat_o	(wb_s2m_ddr2_ibus_dat),

	.wbm3_adr_i	(wb_m2s_ddr2_vga0_adr),
	.wbm3_bte_i	(wb_m2s_ddr2_vga0_bte),
	.wbm3_cti_i	(wb_m2s_ddr2_vga0_cti),
	.wbm3_cyc_i	(wb_m2s_ddr2_vga0_cyc),
	.wbm3_dat_i	(wb_m2s_ddr2_vga0_dat),
	.wbm3_sel_i	(wb_m2s_ddr2_vga0_sel),
	.wbm3_stb_i	(wb_m2s_ddr2_vga0_stb),
	.wbm3_we_i	(wb_m2s_ddr2_vga0_we),
	.wbm3_ack_o	(wb_s2m_ddr2_vga0_ack),
	.wbm3_err_o	(wb_s2m_ddr2_vga0_err),
	.wbm3_rty_o	(wb_s2m_ddr2_vga0_rty),
	.wbm3_dat_o	(wb_s2m_ddr2_vga0_dat),

	.wbm4_adr_i	(0),
	.wbm4_bte_i	(0),
	.wbm4_cti_i	(0),
	.wbm4_cyc_i	(0),
	.wbm4_dat_i	(0),
	.wbm4_sel_i	(0),
	.wbm4_stb_i	(0),
	.wbm4_we_i	(0),
	.wbm4_ack_o	(),
	.wbm4_err_o	(),
	.wbm4_rty_o	(),
	.wbm4_dat_o	(),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),

	.ddr2_a		(ddr2_a[12:0]),
	.ddr2_ba	(ddr2_ba),
	.ddr2_ras_n	(ddr2_ras_n),
	.ddr2_cas_n	(ddr2_cas_n),
	.ddr2_we_n	(ddr2_we_n),
	.ddr2_rzq	(ddr2_rzq),
	.ddr2_zio	(ddr2_zio),
	.ddr2_odt	(ddr2_odt),
	.ddr2_cke	(ddr2_cke),
	.ddr2_dm	(ddr2_dm),
	.ddr2_udm	(ddr2_udm),
	.ddr2_ck	(ddr2_ck),
	.ddr2_ck_n	(ddr2_ck_n),
	.ddr2_dq	(ddr2_dq),
	.ddr2_dqs	(ddr2_dqs),
	.ddr2_dqs_n	(ddr2_dqs_n),
	.ddr2_udqs	(ddr2_udqs),
	.ddr2_udqs_n	(ddr2_udqs_n),
	.ddr2_if_clk	(ddr2_if_clk),
	.ddr2_if_rst	(ddr2_if_rst)
);

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
	.stx_pad_o	(uart0_stx_pad_o),
	.rts_pad_o	(),
	.dtr_pad_o	(),

	// Inputs
	.srx_pad_i	(uart0_srx_pad_i),
	.cts_pad_i	(1'b0),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);

`ifdef SPI0
////////////////////////////////////////////////////////////////////////
//
// SPI0 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi0_irq;

//
// Assigns
//
assign  wb_s2m_spi0_err = 0;
assign  wb_s2m_spi0_rty = 0;
assign  spi0_hold_n_o = 1;
assign  spi0_w_n_o = 1;

simple_spi spi0(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb_m2s_spi0_adr[2:0]),
	.dat_i	(wb_m2s_spi0_dat),
	.we_i	(wb_m2s_spi0_we),
	.stb_i	(wb_m2s_spi0_stb),
	.cyc_i	(wb_m2s_spi0_cyc),
	.dat_o	(wb_s2m_spi0_dat),
	.ack_o	(wb_s2m_spi0_ack),

	// Outputs
	.inta_o		(spi0_irq),
	.sck_o		(spi0_sck_o),
	.ss_o		(spi0_ss_o[0]),
	.mosi_o		(spi0_mosi_o),

	// Inputs
	.miso_i		(spi0_miso_i)
);

`endif

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
// VGA/LCD
//
////////////////////////////////////////////////////////////////////////
`ifdef VGA0
wire		vga0_irq;
wire		pclk;
wire [7:0]	r;
wire [7:0]	g;
wire [7:0]	b;
wire		hsync;
wire		vsync;
wire		blank;
wire		gate;
reg [15:0]	hlen;
reg [15:0]	vlen;

vga_enh_top #(
	.LINE_FIFO_AWIDTH(10)
) vga0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.rst_i		(1'b1),
	.wb_inta_o	(vga0_irq),
	// Wishbone slave connections
	.wbs_adr_i	(wb_m2s_vga0_adr),
	.wbs_dat_i	(wb_m2s_vga0_dat),
	.wbs_sel_i	(wb_m2s_vga0_sel),
	.wbs_we_i	(wb_m2s_vga0_we),
	.wbs_stb_i	(wb_m2s_vga0_stb),
	.wbs_cyc_i	(wb_m2s_vga0_cyc),
	.wbs_dat_o	(wb_s2m_vga0_dat),
	.wbs_ack_o	(wb_s2m_vga0_ack),
	.wbs_rty_o	(wb_s2m_vga0_rty),
	.wbs_err_o	(wb_s2m_vga0_err),
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
	.clk_p_i	(pclk),
	.clk_p_o	(),
	.hsync_pad_o	(hsync),
	.vsync_pad_o	(vsync),
	.csync_pad_o	(),
	.blank_pad_o	(blank),
	.r_pad_o	(r),
	.g_pad_o	(g),
	.b_pad_o	(b)
);

// Snoop wishbone bus for accesses to hlen and vlen
always @(posedge wb_clk)
	if (wb_rst) begin
		hlen <= 0;
		vlen <= 0;
	end else if ((wb_m2s_vga0_adr[7:0] == 8'h16) &
		     wb_m2s_vga0_stb & wb_m2s_vga0_cyc) begin
		hlen <= wb_m2s_vga0_dat[31:16];
		vlen <= wb_m2s_vga0_dat[15:0];
	end

dvi_gen_top dvi_gen0 (
	.rst_n_pad_i	(rst_n_pad_i),
	.dvi_clk_i	(dvi_clk),
	.hlen		(hlen),
	.vlen		(vlen),
	.TMDS		(tmds_o),
	.TMDSB		(tmdsb_o),
	.pclk_o		(pclk),
	.hsync_i	(hsync),
	.vsync_i	(vsync),
	.blank_i	(blank),
	.red_data_i	(r),
	.green_data_i	(g),
	.blue_data_i	(b)
);
`else
wire		vga0_irq = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// Ethernet
//
////////////////////////////////////////////////////////////////////////
`ifdef ETH0
wire		eth0_irq;
wire [3:0]	eth0_mtxd;
wire		eth0_mtxen;
wire		eth0_mtxerr;
wire		eth0_mtx_clk;
wire		eth0_mrx_clk;
wire [3:0]	eth0_mrxd;
wire		eth0_mrxdv;
wire		eth0_mrxerr;
wire		eth0_mcoll;
wire		eth0_mcrs;
wire		eth0_speed;
wire		eth0_duplex;
wire		eth0_link;
// Management interface wires
wire		eth0_md_i;
wire		eth0_md_o;
wire		eth0_md_oe;

// Hook up MII wires
assign eth0_mtx_clk   = eth0_tx_clk;
assign eth0_tx_data   = eth0_mtxd[3:0];
assign eth0_tx_en     = eth0_mtxen;
assign eth0_tx_er     = eth0_mtxerr;
assign eth0_mrxd[3:0] = eth0_rx_data;
assign eth0_mrxdv     = eth0_dv;
assign eth0_mrxerr    = eth0_rx_er;
assign eth0_mrx_clk   = eth0_rx_clk;
assign eth0_mcoll     = eth0_col;
assign eth0_mcrs      = eth0_crs;

// Tristate control for management interface
assign eth0_md_pad_io = eth0_md_oe ? eth0_md_o : 1'bz;
assign eth0_md_i = eth0_md_pad_io;

assign eth0_rst_n_o = !wb_rst;

ethmac ethmac0 (
	// Wishbone Slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb_m2s_eth0_adr[11:2]),
	.wb_dat_i	(wb_m2s_eth0_dat),
	.wb_sel_i	(wb_m2s_eth0_sel),
	.wb_we_i 	(wb_m2s_eth0_we),
	.wb_cyc_i	(wb_m2s_eth0_cyc),
	.wb_stb_i	(wb_m2s_eth0_stb),
	.wb_dat_o	(wb_s2m_eth0_dat),
	.wb_err_o	(wb_s2m_eth0_err),
	.wb_ack_o	(wb_s2m_eth0_ack),
	// Wishbone Master Interface
	.m_wb_adr_o	(wb_m2s_eth0_master_adr),
	.m_wb_sel_o	(wb_m2s_eth0_master_sel),
	.m_wb_we_o 	(wb_m2s_eth0_master_we),
	.m_wb_dat_o	(wb_m2s_eth0_master_dat),
	.m_wb_cyc_o	(wb_m2s_eth0_master_cyc),
	.m_wb_stb_o	(wb_m2s_eth0_master_stb),
	.m_wb_cti_o	(wb_m2s_eth0_master_cti),
	.m_wb_bte_o	(wb_m2s_eth0_master_bte),
	.m_wb_dat_i	(wb_s2m_eth0_master_dat),
	.m_wb_ack_i	(wb_s2m_eth0_master_ack),
	.m_wb_err_i	(wb_s2m_eth0_master_err),

	// Ethernet MII interface
	// Transmit
	.mtxd_pad_o	(eth0_mtxd[3:0]),
	.mtxen_pad_o	(eth0_mtxen),
	.mtxerr_pad_o	(eth0_mtxerr),
	.mtx_clk_pad_i	(eth0_mtx_clk),
	// Receive
	.mrx_clk_pad_i	(eth0_mrx_clk),
	.mrxd_pad_i	(eth0_mrxd[3:0]),
	.mrxdv_pad_i	(eth0_mrxdv),
	.mrxerr_pad_i	(eth0_mrxerr),
	.mcoll_pad_i	(eth0_mcoll),
	.mcrs_pad_i	(eth0_mcrs),
	// Management interface
	.md_pad_i	(eth0_md_i),
	.mdc_pad_o	(eth0_mdc_pad_o),
	.md_pad_o	(eth0_md_o),
	.md_padoe_o	(eth0_md_oe),

	// Processor interrupt
	.int_o		(eth0_irq)
      );
`else
assign eth0_irq = 0;
assign eth0_tx_data = 0;
assign eth0_tx_en = 0;
assign eth0_tx_er = 0;
assign eth0_mdc_pad_o = 0;
assign eth0_md_pad_io = 0;
assign eth0_rst_n_o = 0;

`endif

////////////////////////////////////////////////////////////////////////
//
// AC97
//
////////////////////////////////////////////////////////////////////////
`ifdef AC97
wire ac97_irq;
wire ac97_dma_req;
wire ac97_dma_ack = 0;

ac97_top ac97 (
	.clk_i			(wb_clk),
	.rst_i			(!wb_rst),
	.wb_data_i		(wb_m2s_ac97_dat),
	.wb_data_o		(wb_s2m_ac97_dat),
	.wb_addr_i		(wb_m2s_ac97_adr),
	.wb_sel_i		(wb_m2s_ac97_sel),
	.wb_we_i		(wb_m2s_ac97_we),
	.wb_cyc_i		(wb_m2s_ac97_cyc),
	.wb_stb_i		(wb_m2s_ac97_stb),
	.wb_ack_o		(wb_s2m_ac97_ack),
	.wb_err_o		(wb_s2m_ac97_err),
	.int_o			(ac97_irq),
	.dma_req_o		(ac97_dma_req),
	.dma_ack_i		(ac97_dma_ack),
	.suspended_o		(),
	.bit_clk_pad_i		(ac97_bit_clk_pad_i),
	.sync_pad_o		(ac97_sync_pad_o),
	.sdata_pad_o		(ac97_sdata_pad_o),
	.sdata_pad_i		(ac97_sdata_pad_i),
	.ac97_reset_pad_o_	(ac97_reset_pad_o)
    );
`else
wire ac97_irq = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// PS2_0
//
////////////////////////////////////////////////////////////////////////
wire ps2_0_irq;

assign wb_s2m_ps2_0_err = 0;
assign wb_s2m_ps2_0_rty = 0;

`ifdef PS2_0
wire ps2_0_cycstb = wb_m2s_ps2_0_cyc & wb_m2s_ps2_0_stb;

ps2_wb ps2_0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_dat_i	(wb_m2s_ps2_0_dat),
	.wb_dat_o	(wb_s2m_ps2_0_dat),
	.wb_adr_i	(wb_m2s_ps2_0_adr),
	.wb_stb_i	(ps2_0_cycstb),
	.wb_we_i	(wb_m2s_ps2_0_we),
	.wb_ack_o	(wb_s2m_ps2_0_ack),

	// IRQ output
	.irq_o		(ps2_0_irq),

	// PS2 signals
	.ps2_clk	(ps2_0_clk),
	.ps2_dat	(ps2_0_dat)
);
`else
assign ps2_0_irq = 0;
assign wb_s2m_ps2_0_dat = 0;
assign wb_s2m_ps2_0_ack = 0;
`endif // PS2_0

////////////////////////////////////////////////////////////////////////
//
// PS2_1
//
////////////////////////////////////////////////////////////////////////
wire ps2_1_irq;

assign wb_s2m_ps2_1_err = 0;
assign wb_s2m_ps2_1_rty = 0;

`ifdef PS2_1
wire ps2_1_cycstb = wb_m2s_ps2_1_cyc & wb_m2s_ps2_1_stb;

ps2_wb ps2_1 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_dat_i	(wb_m2s_ps2_1_dat),
	.wb_dat_o	(wb_s2m_ps2_1_dat),
	.wb_adr_i	(wb_m2s_ps2_1_adr),
	.wb_stb_i	(ps2_1_cycstb),
	.wb_we_i	(wb_m2s_ps2_1_we),
	.wb_ack_o	(wb_s2m_ps2_1_ack),

	// IRQoutput
	.irq_o		(ps2_1_irq),

	// PS2 signals
	.ps2_clk	(ps2_1_clk),
	.ps2_dat	(ps2_1_dat)
);
`else
assign ps2_1_irq = 0;
assign wb_s2m_ps2_1_dat = 0;
assign wb_s2m_ps2_1_ack = 0;
`endif // PS2_1

////////////////////////////////////////////////////////////////////////
//
// PS2_2
//
////////////////////////////////////////////////////////////////////////
wire ps2_2_irq;

assign wb_s2m_ps2_2_err = 0;
assign wb_s2m_ps2_2_rty = 0;

`ifdef PS2_2
wire ps2_2_cycstb = wb_m2s_ps2_2_cyc & wb_m2s_ps2_2_stb;

ps2_wb ps2_2 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_dat_i	(wb_m2s_ps2_2_dat),
	.wb_dat_o	(wb_s2m_ps2_2_dat),
	.wb_adr_i	(wb_m2s_ps2_2_adr),
	.wb_stb_i	(ps2_2_cycstb),
	.wb_we_i	(wb_m2s_ps2_2_we),
	.wb_ack_o	(wb_s2m_ps2_2_ack),

	// IRQ output
	.irq_o		(ps2_2_irq),

	// PS2 signals
	.ps2_clk	(ps2_2_clk),
	.ps2_dat	(ps2_2_dat)
);
`else
assign ps2_2_irq = 0;
assign wb_s2m_ps2_2_dat = 0;
assign wb_s2m_ps2_2_ack = 0;
`endif // PS2_2

////////////////////////////////////////////////////////////////////////
//
// diila - Device Independent Integrated Logic Analyzer
//
////////////////////////////////////////////////////////////////////////
wire [31:0] diila_trig;
wire [31:0] diila_data [5:0];

assign diila_trig = {
		     30'h0,
		     wb_m2s_dbg_stb,
		     wb_m2s_dbg_cyc
		     };

assign diila_data[0] = wb_m2s_ddr2_dbus_adr;
assign diila_data[1] = wb_m2s_ddr2_dbus_dat;
assign diila_data[2] = wb_s2m_ddr2_dbus_dat;
assign diila_data[3] = {
			7'h0,
			wb_m2s_or1k_d_cyc,	// 1
			wb_m2s_or1k_d_stb,	// 1
			wb_m2s_diila_cyc,	// 1
			wb_m2s_eth0_cyc,	// 1
			wb_m2s_vga0_cyc,	// 1
			wb_m2s_spi0_cyc,	// 1
			wb_m2s_gpio0_cyc,	// 1
			wb_m2s_uart0_cyc,	// 1
			wb_s2m_dbg_ack,		// 1
			wb_m2s_dbg_we,		// 1
			wb_m2s_ddr2_dbus_stb,	// 1
			wb_m2s_ddr2_dbus_cyc,	// 1
			wb_m2s_ddr2_dbus_bte,	// 2
			wb_m2s_ddr2_dbus_cti,	// 3
			wb_m2s_ddr2_dbus_sel,	// 4
			wb_m2s_ddr2_dbus_we,	// 1
			wb_s2m_ddr2_dbus_ack,	// 1
			wb_s2m_ddr2_dbus_err,	// 1
			wb_s2m_ddr2_dbus_rty	// 1
			};
assign diila_data[4] = wb_m2s_dbg_adr;
assign diila_data[5] = 0;

diila
      #(
	.DATA_WIDTH(32*6)
)
diila (
	.wb_rst_i             (wb_rst),
	.wb_clk_i             (wb_clk),
	.wb_dat_i             (wb_m2s_diila_dat),
	.wb_adr_i             (wb_m2s_diila_adr[23:2]),
	.wb_sel_i             (wb_m2s_diila_sel),
	.wb_we_i              (wb_m2s_diila_we),
	.wb_cyc_i             (wb_m2s_diila_cyc),
	.wb_stb_i             (wb_m2s_diila_stb),
	.wb_dat_o             (wb_s2m_diila_dat),
	.wb_ack_o             (wb_s2m_diila_ack),
	.wb_err_o             (wb_s2m_diila_err),
	.wb_rty_o             (wb_s2m_diila_rty),
	.storage_en           (1'b1/*diila_storage_en*/),
	.trig_i               (diila_trig),
	.data_i               ({
				diila_data[0],
				diila_data[1],
				diila_data[2],
				diila_data[3],
				diila_data[4],
				diila_data[5]
				})
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
assign or1k_irq[4] = eth0_irq;
assign or1k_irq[5] = ps2_0_irq;
assign or1k_irq[6] = spi0_irq;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = vga0_irq;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = 0;
assign or1k_irq[11] = 0;
assign or1k_irq[12] = ac97_irq;
assign or1k_irq[13] = ps2_1_irq;
assign or1k_irq[14] = ps2_2_irq;
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
