//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC top for Altera de2 board                               ////
///                                                               ////
/// Franck Jullien, franck.jullien@gmail.com                      ////
/// edited by:													  ////
//  Patric Erdmann, pe@perdmann.de								  ////
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

`include "orpsoc-defines.v"

module orpsoc_top #(
	parameter	rom0_aw = 6,
	parameter	uart0_aw = 3
) 
(
	input		sys_clk_pad_i,
	input		rst_n_pad_i,

	output	[17:0]	led_r_pad_o,
	output 	[8:0]		led_g_pad_o,
	input 	[17:0] 	switch_pad_i,
	input		[2:0]		key_pad_i,
	inout		[7:0]		gpio0_io,
	

`ifdef SIM
	output		tdo_pad_o,
	input		tms_pad_i,
	input		tck_pad_i,
	input		tdi_pad_i,
`endif

	output	[1:0]	sdram_ba_pad_o,
	output	[11:0]	sdram_a_pad_o,
	output		sdram_cs_n_pad_o,
	output		sdram_ras_pad_o,
	output		sdram_cas_pad_o,
	output		sdram_we_pad_o,
	inout	[15:0]	sdram_dq_pad_io,
	output	[1:0]	sdram_dqm_pad_o,
	output		sdram_cke_pad_o,
	output		sdram_clk_pad_o,

	input		uart0_srx_pad_i,
	output		uart0_stx_pad_o
);

parameter	IDCODE_VALUE = 32'h14951185;

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	dbg_tck;
wire	sdram_clk;
wire	sdram_rst;

assign	sdram_clk_pad_o = sdram_clk;

clkgen clkgen0 (
	.sys_clk_pad_i	(sys_clk_pad_i),
	.rst_n_pad_i	(rst_n_pad_i),
	.async_rst_o	(async_rst),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),
`ifdef SIM
	.tck_pad_i	(tck_pad_i),
	.dbg_tck_o	(dbg_tck),
`endif
	.sdram_clk_o	(sdram_clk),
	.sdram_rst_o	(sdram_rst)
);

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////

`include "wb_intercon.vh"

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

tap_top #(.IDCODE_VALUE(IDCODE_VALUE))
jtag_tap0 (
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

`else
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

assign	or1k_rst = wb_rst | or1k_dbg_rst;

mor1kx	#(
	.FEATURE_DEBUGUNIT		("ENABLED"),
	.FEATURE_CMOV			("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE	("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH	(5),
	.OPTION_ICACHE_SET_WIDTH	(3),
	.OPTION_ICACHE_WAYS		(2),
	.OPTION_ICACHE_LIMIT_WIDTH	(32),
	.FEATURE_IMMU			("ENABLED"),
	.FEATURE_DATACACHE		("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH	(5),
	.OPTION_DCACHE_SET_WIDTH	(3),
	.OPTION_DCACHE_WAYS		(2),
	.OPTION_DCACHE_LIMIT_WIDTH	(31),
	.FEATURE_DMMU			("ENABLED"),
	.OPTION_PIC_TRIGGER		("LATCHED_LEVEL"),

	.IBUS_WB_TYPE			("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE			("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0			("CAPPUCCINO"),
	.OPTION_RESET_PC		(32'hf0000100)
) mor1kx0 (
	.iwbm_adr_o			(wb_m2s_or1k_i_adr),
	.iwbm_stb_o			(wb_m2s_or1k_i_stb),
	.iwbm_cyc_o			(wb_m2s_or1k_i_cyc),
	.iwbm_sel_o			(wb_m2s_or1k_i_sel),
	.iwbm_we_o			(wb_m2s_or1k_i_we),
	.iwbm_cti_o			(wb_m2s_or1k_i_cti),
	.iwbm_bte_o			(wb_m2s_or1k_i_bte),
	.iwbm_dat_o			(wb_m2s_or1k_i_dat),

	.dwbm_adr_o			(wb_m2s_or1k_d_adr),
	.dwbm_stb_o			(wb_m2s_or1k_d_stb),
	.dwbm_cyc_o			(wb_m2s_or1k_d_cyc),
	.dwbm_sel_o			(wb_m2s_or1k_d_sel),
	.dwbm_we_o			(wb_m2s_or1k_d_we ),
	.dwbm_cti_o			(wb_m2s_or1k_d_cti),
	.dwbm_bte_o			(wb_m2s_or1k_d_bte),
	.dwbm_dat_o			(wb_m2s_or1k_d_dat),

	.clk				(wb_clk),
	.rst				(or1k_rst),

	.iwbm_err_i			(wb_s2m_or1k_i_err),
	.iwbm_ack_i			(wb_s2m_or1k_i_ack),
	.iwbm_dat_i			(wb_s2m_or1k_i_dat),
	.iwbm_rty_i			(wb_s2m_or1k_i_rty),

	.dwbm_err_i			(wb_s2m_or1k_d_err),
	.dwbm_ack_i			(wb_s2m_or1k_d_ack),
	.dwbm_dat_i			(wb_s2m_or1k_d_dat),
	.dwbm_rty_i			(wb_s2m_or1k_d_rty),

	.irq_i				(or1k_irq),

	.du_addr_i			(or1k_dbg_adr_i[15:0]),
	.du_stb_i			(or1k_dbg_stb_i),
	.du_dat_i			(or1k_dbg_dat_i),
	.du_we_i			(or1k_dbg_we_i),
	.du_dat_o			(or1k_dbg_dat_o),
	.du_ack_o			(or1k_dbg_ack_o),
	.du_stall_i			(or1k_dbg_stall_i),
	.du_stall_o			(or1k_dbg_bp_o)
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
rom #(.ADDR_WIDTH(rom0_aw))
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
// SDRAM Memory Controller
//
////////////////////////////////////////////////////////////////////////

wire	[15:0]	sdram_dq_i;
wire	[15:0]	sdram_dq_o;
wire		sdram_dq_oe;

assign	sdram_dq_i = sdram_dq_pad_io;
assign	sdram_dq_pad_io = sdram_dq_oe ? sdram_dq_o : 16'bz;
assign	sdram_clk_pad_o = sdram_clk;

assign	wb_s2m_sdram_ibus_err = 0;
assign	wb_s2m_sdram_ibus_rty = 0;

assign	wb_s2m_sdram_dbus_err = 0;
assign	wb_s2m_sdram_dbus_rty = 0;

wb_sdram_ctrl #(
`ifdef ICARUS_SIM
	.TECHNOLOGY			("GENERIC"),
`else
	.TECHNOLOGY			("ALTERA"),
`endif
	.CLK_FREQ_MHZ			(100),	// sdram_clk freq in MHZ
`ifdef SIM
	.POWERUP_DELAY			(1),	// power up delay in us
`endif
	.WB_PORTS			(2),	// Number of wishbone ports
	.BUF_WIDTH			(3),
	.BURST_LENGTH			(8),
	.ROW_WIDTH			(12),	// Row width
	.COL_WIDTH			(8),	// Column width
	.BA_WIDTH			(2),	// Ba width
	.tCAC				(3),	// CAS Latency
	.tRAC				(5),	// RAS Latency
	.tRP				(3),	// Command Period (PRE to ACT)
	.tRC				(7),	// Command Period (REF to REF / ACT to ACT)
	.tMRD				(2)	// Mode Register Set To Command Delay time
)

wb_sdram_ctrl0 (
	// External SDRAM interface
	.ba_pad_o	(sdram_ba_pad_o[1:0]),
	.a_pad_o	(sdram_a_pad_o[11:0]),
	.cs_n_pad_o	(sdram_cs_n_pad_o),
	.ras_pad_o	(sdram_ras_pad_o),
	.cas_pad_o	(sdram_cas_pad_o),
	.we_pad_o	(sdram_we_pad_o),
	.dq_i		(sdram_dq_i[15:0]),
	.dq_o		(sdram_dq_o[15:0]),
	.dqm_pad_o	(sdram_dqm_pad_o[1:0]),
	.dq_oe		(sdram_dq_oe),
	.cke_pad_o	(sdram_cke_pad_o),

	.sdram_clk	(sdram_clk),
	.sdram_rst	(sdram_rst),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),

	.wb_adr_i	({wb_m2s_sdram_ibus_adr, wb_m2s_sdram_dbus_adr}),
	.wb_stb_i	({wb_m2s_sdram_ibus_stb, wb_m2s_sdram_dbus_stb}),
	.wb_cyc_i	({wb_m2s_sdram_ibus_cyc, wb_m2s_sdram_dbus_cyc}),
	.wb_cti_i	({wb_m2s_sdram_ibus_cti, wb_m2s_sdram_dbus_cti}),
	.wb_bte_i	({wb_m2s_sdram_ibus_bte, wb_m2s_sdram_dbus_bte}),
	.wb_we_i	({wb_m2s_sdram_ibus_we,  wb_m2s_sdram_dbus_we }),
	.wb_sel_i	({wb_m2s_sdram_ibus_sel, wb_m2s_sdram_dbus_sel}),
	.wb_dat_i	({wb_m2s_sdram_ibus_dat, wb_m2s_sdram_dbus_dat}),
	.wb_dat_o	({wb_s2m_sdram_ibus_dat, wb_s2m_sdram_dbus_dat}),
	.wb_ack_o	({wb_s2m_sdram_ibus_ack, wb_s2m_sdram_dbus_ack})
);

////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////

wire	uart0_irq;

assign	wb_s2m_uart0_err = 0;
assign	wb_s2m_uart0_rty = 0;

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
	.wb_we_i		(wb_m2s_gpio0_we),
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

gpio key0 (
	// Key bus
	.gpio_i		({4'h0, key_pad_i}),
	.gpio_o		(),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_key_adr[0]),
	.wb_dat_i	(wb_m2s_key_dat),
	.wb_we_i		(wb_m2s_key_we),
	.wb_cyc_i	(wb_m2s_key_cyc),
	.wb_stb_i	(wb_m2s_key_stb),
	.wb_cti_i	(wb_m2s_key_cti),
	.wb_bte_i	(wb_m2s_key_bte),
	.wb_dat_o	(wb_s2m_key_dat),
	.wb_ack_o	(wb_s2m_key_ack),
	.wb_err_o	(wb_s2m_key_err),
	.wb_rty_o	(wb_s2m_key_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);




gpio ledr0 (
	// LED R bus 0 
	.gpio_i		(),
	.gpio_o		(led_r_pad_o[7:0]),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_ledr0_adr[0]),
	.wb_dat_i	(wb_m2s_ledr0_dat),
	.wb_we_i		(wb_m2s_ledr0_we),
	.wb_cyc_i	(wb_m2s_ledr0_cyc),
	.wb_stb_i	(wb_m2s_ledr0_stb),
	.wb_cti_i	(wb_m2s_ledr0_cti),
	.wb_bte_i	(wb_m2s_ledr0_bte),
	.wb_dat_o	(wb_s2m_ledr0_dat),
	.wb_ack_o	(wb_s2m_ledr0_ack),
	.wb_err_o	(wb_s2m_ledr0_err),
	.wb_rty_o	(wb_s2m_ledr0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

gpio ledr1 (
	// LED R bus 1
	.gpio_i		(),
	.gpio_o		(led_r_pad_o[15:8]),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_ledr1_adr[0]),
	.wb_dat_i	(wb_m2s_ledr1_dat),
	.wb_we_i		(wb_m2s_ledr1_we),
	.wb_cyc_i	(wb_m2s_ledr1_cyc),
	.wb_stb_i	(wb_m2s_ledr1_stb),
	.wb_cti_i	(wb_m2s_ledr1_cti),
	.wb_bte_i	(wb_m2s_ledr1_bte),
	.wb_dat_o	(wb_s2m_ledr1_dat),
	.wb_ack_o	(wb_s2m_ledr1_ack),
	.wb_err_o	(wb_s2m_ledr1_err),
	.wb_rty_o	(wb_s2m_ledr1_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

gpio ledg0 (
	// GPIO bus
	.gpio_i		(),
	.gpio_o		(led_g_pad_o),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_ledg0_adr[0]),
	.wb_dat_i	(wb_m2s_ledg0_dat),
	.wb_we_i		(wb_m2s_ledg0_we),
	.wb_cyc_i	(wb_m2s_ledg0_cyc),
	.wb_stb_i	(wb_m2s_ledg0_stb),
	.wb_cti_i	(wb_m2s_ledg0_cti),
	.wb_bte_i	(wb_m2s_ledg0_bte),
	.wb_dat_o	(wb_s2m_ledg0_dat),
	.wb_ack_o	(wb_s2m_ledg0_ack),
	.wb_err_o	(wb_s2m_ledg0_err),
	.wb_rty_o	(wb_s2m_ledg0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

gpio switch0 (
	// GPIO bus
	.gpio_i		(switch_pad_i[7:0]),
	.gpio_o		(),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_switch0_adr[0]),
	.wb_dat_i	(wb_m2s_switch0_dat),
	.wb_we_i		(wb_m2s_switch0_we),
	.wb_cyc_i	(wb_m2s_switch0_cyc),
	.wb_stb_i	(wb_m2s_switch0_stb),
	.wb_cti_i	(wb_m2s_switch0_cti),
	.wb_bte_i	(wb_m2s_switch0_bte),
	.wb_dat_o	(wb_s2m_switch0_dat),
	.wb_ack_o	(wb_s2m_switch0_ack),
	.wb_err_o	(wb_s2m_switch0_err),
	.wb_rty_o	(wb_s2m_switch0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

gpio switch1 (
	// GPIO bus
	.gpio_i		(switch_pad_i[15:8]),
	.gpio_o		(),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_switch1_adr[0]),
	.wb_dat_i	(wb_m2s_switch1_dat),
	.wb_we_i		(wb_m2s_switch1_we),
	.wb_cyc_i	(wb_m2s_switch1_cyc),
	.wb_stb_i	(wb_m2s_switch1_stb),
	.wb_cti_i	(wb_m2s_switch1_cti),
	.wb_bte_i	(wb_m2s_switch1_bte),
	.wb_dat_o	(wb_s2m_switch1_dat),
	.wb_ack_o	(wb_s2m_switch1_ack),
	.wb_err_o	(wb_s2m_switch1_err),
	.wb_rty_o	(wb_s2m_switch1_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

gpio switch2 (
	// GPIO bus
	.gpio_i		({6'h0, switch_pad_i[17:16]}),
	.gpio_o		(),
	.gpio_dir_o	(),

	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_switch2_adr[0]),
	.wb_dat_i	(wb_m2s_switch2_dat),
	.wb_we_i		(wb_m2s_switch2_we),
	.wb_cyc_i	(wb_m2s_switch2_cyc),
	.wb_stb_i	(wb_m2s_switch2_stb),
	.wb_cti_i	(wb_m2s_switch2_cti),
	.wb_bte_i	(wb_m2s_switch2_bte),
	.wb_dat_o	(wb_s2m_switch2_dat),
	.wb_ack_o	(wb_s2m_switch2_ack),
	.wb_err_o	(wb_s2m_switch2_err),
	.wb_rty_o	(wb_s2m_switch2_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
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
assign or1k_irq[8] = 0;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = 0;
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


