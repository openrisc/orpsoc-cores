//////////////////////////////////////////////////////////////////////
///                                                               ////
/// ORPSoC top for Altera NEEK board                              ////
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

`include "orpsoc-defines.v"

module orpsoc_top #(
	parameter	rom0_aw = 6,
	parameter	uart0_aw = 3
)
(
	input		clock_50_pad_i,
	input		reset_n_pad_i,

	output	[1:0]	ddr_dm_pad_o,
	inout	[15:0]	ddr_dq_pad_io,
	inout	[1:0]	ddr_dqs_pad_io,
	output	[12:0]	ddr_a_pad_o,
	output	[1:0]	ddr_ba_pad_o,
	output		ddr_cas_n_pad_o,
	output		ddr_cke_pad_o,
	inout		ddr_clk_pad_o,
	inout		ddr_clk_n_pad_o,
	output		ddr_cs_n_pad_o,
	output		ddr_ras_n_pad_o,
	output		ddr_we_n_pad_o,

	output	[3:0]	led_debug_pad_o,

	input		uart_rx_pad_i,
	output		uart_tx_pad_o
);

parameter	IDCODE_VALUE = 32'h14951185;

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	wb_clk;
wire	wb_rst;
wire	init_done;
wire	ddr_rst;

clkgen clkgen0 (
	.sys_clk_pad_i	(clock_50_pad_i),
	.rst_n_pad_i	(reset_n_pad_i),
	.ddr_init_done	(init_done),
	.async_rst_o	(),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),
	.ddr_rst_o	(ddr_rst)
);

////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////

`include "wb_intercon.vh"

////////////////////////////////////////////////////////////////////////
//
// ALTERA Virtual JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	dbg_tck;
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

`ifdef OR1200_CPU

or1200_top #(.boot_adr(32'hf0000100))
or1200_top0 (
	// Instruction bus, clocks, reset
	.iwb_clk_i		(wb_clk),
	.iwb_rst_i		(wb_rst),
	.iwb_ack_i		(wb_s2m_or1k_i_ack),
	.iwb_err_i		(wb_s2m_or1k_i_err),
	.iwb_rty_i		(wb_s2m_or1k_i_rty),
	.iwb_dat_i		(wb_s2m_or1k_i_dat),

	.iwb_cyc_o		(wb_m2s_or1k_i_cyc),
	.iwb_adr_o		(wb_m2s_or1k_i_adr),
	.iwb_stb_o		(wb_m2s_or1k_i_stb),
	.iwb_we_o		(wb_m2s_or1k_i_we),
	.iwb_sel_o		(wb_m2s_or1k_i_sel),
	.iwb_dat_o		(wb_m2s_or1k_i_dat),
	.iwb_cti_o		(wb_m2s_or1k_i_cti),
	.iwb_bte_o		(wb_m2s_or1k_i_bte),

	// Data bus, clocks, reset
	.dwb_clk_i		(wb_clk),
	.dwb_rst_i		(wb_rst),
	.dwb_ack_i		(wb_s2m_or1k_d_ack),
	.dwb_err_i		(wb_s2m_or1k_d_err),
	.dwb_rty_i		(wb_s2m_or1k_d_rty),
	.dwb_dat_i		(wb_s2m_or1k_d_dat),

	.dwb_cyc_o		(wb_m2s_or1k_d_cyc),
	.dwb_adr_o		(wb_m2s_or1k_d_adr),
	.dwb_stb_o		(wb_m2s_or1k_d_stb),
	.dwb_we_o		(wb_m2s_or1k_d_we),
	.dwb_sel_o		(wb_m2s_or1k_d_sel),
	.dwb_dat_o		(wb_m2s_or1k_d_dat),
	.dwb_cti_o		(wb_m2s_or1k_d_cti),
	.dwb_bte_o		(wb_m2s_or1k_d_bte),

	// Debug interface ports
	.dbg_stall_i		(or1k_dbg_stall_i),
	.dbg_ewt_i		(1'b0),
	.dbg_lss_o		(or1k_dbg_lss_o),
	.dbg_is_o		(or1k_dbg_is_o),
	.dbg_wp_o		(or1k_dbg_wp_o),
	.dbg_bp_o		(or1k_dbg_bp_o),

	.dbg_adr_i		(or1k_dbg_adr_i),
	.dbg_we_i		(or1k_dbg_we_i),
	.dbg_stb_i		(or1k_dbg_stb_i),
	.dbg_dat_i		(or1k_dbg_dat_i),
	.dbg_dat_o		(or1k_dbg_dat_o),
	.dbg_ack_o		(or1k_dbg_ack_o),

	.pm_clksd_o		(),
	.pm_dc_gate_o		(),
	.pm_ic_gate_o		(),
	.pm_dmmu_gate_o		(),
	.pm_immu_gate_o		(),
	.pm_tt_gate_o		(),
	.pm_cpu_gate_o		(),
	.pm_wakeup_o		(),
	.pm_lvolt_o		(),

	// Core clocks, resets
	.clk_i			(wb_clk),
	.rst_i			(or1k_rst),

	.clmode_i		(2'b00),

	// Interrupts
	.pic_ints_i		(or1k_irq[30:0]),
	.sig_tick		(sig_tick),

	.pm_cpustall_i		(1'b0)
);

`else

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
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),

	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_cab_o	(),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte),

	.wb_jsp_adr_i	(32'b0),
	.wb_jsp_dat_o	(),
	.wb_jsp_dat_i	(32'b0),
	.wb_jsp_cyc_i	(1'b0),
	.wb_jsp_stb_i	(1'b0),
	.wb_jsp_sel_i	(4'b0),
	.wb_jsp_we_i	(1'b0),
	.wb_jsp_ack_o	(),
	.wb_jsp_cab_i	(1'b0),
	.wb_jsp_err_o	(),
	.wb_jsp_cti_i	(3'b0),
	.wb_jsp_bte_i	(2'b0),
	.int_o		()

);

////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_rom0_err = 1'b0;
assign	wb_s2m_rom0_rty = 1'b0;

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

////////////////////////////////////////////////////////////////////////
//
// DDR2 Memory Controller
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_sdram_ibus_err = 0;
assign	wb_s2m_sdram_ibus_rty = 0;

assign	wb_s2m_sdram_dbus_err = 0;
assign	wb_s2m_sdram_dbus_rty = 0;

wb_ddr_ctrl #(
	.TECHNOLOGY		("ALTERA"),
	.WB_PORTS		(2),	// Number of wishbone ports
	.BUF_WIDTH		(3)
)
wb_ddr_ctrl0
(
	// DDR Interface
	.dm_pad_o		(ddr_dm_pad_o),
	.dq_pad_io		(ddr_dq_pad_io),
	.dqs_pad_io		(ddr_dqs_pad_io),
	.a_pad_o		(ddr_a_pad_o),
	.ba_pad_o		(ddr_ba_pad_o),
	.cas_n_pad_o		(ddr_cas_n_pad_o),
	.cke_pad_o		(ddr_cke_pad_o),
	.clk_pad_io		(ddr_clk_pad_o),
	.clk_n_pad_io		(ddr_clk_n_pad_o),
	.cs_n_pad_o		(ddr_cs_n_pad_o),
	.ras_n_pad_o		(ddr_ras_n_pad_o),
	.we_n_pad_o		(ddr_we_n_pad_o),

	// Need synchro because in local clock domain
	.init_done_o		(init_done),

	.wb_clk			(wb_clk),
	.wb_rst			(ddr_rst),

	.wb_adr_i		({wb_m2s_sdram_ibus_adr, wb_m2s_sdram_dbus_adr}),
	.wb_stb_i		({wb_m2s_sdram_ibus_stb, wb_m2s_sdram_dbus_stb}),
	.wb_cyc_i		({wb_m2s_sdram_ibus_cyc, wb_m2s_sdram_dbus_cyc}),
	.wb_cti_i		({wb_m2s_sdram_ibus_cti, wb_m2s_sdram_dbus_cti}),
	.wb_bte_i		({wb_m2s_sdram_ibus_bte, wb_m2s_sdram_dbus_bte}),
	.wb_we_i		({wb_m2s_sdram_ibus_we,  wb_m2s_sdram_dbus_we }),
	.wb_sel_i		({wb_m2s_sdram_ibus_sel, wb_m2s_sdram_dbus_sel}),
	.wb_dat_i		({wb_m2s_sdram_ibus_dat, wb_m2s_sdram_dbus_dat}),
	.wb_dat_o		({wb_s2m_sdram_ibus_dat, wb_s2m_sdram_dbus_dat}),
	.wb_ack_o		({wb_s2m_sdram_ibus_ack, wb_s2m_sdram_dbus_ack})
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
	.stx_pad_o	(uart_tx_pad_o),
	.rts_pad_o	(),
	.dtr_pad_o	(),

	// Inputs
	.srx_pad_i	(uart_rx_pad_i),
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

gpio gpio0 (
	// GPIO bus
	.gpio_i		(8'b0),
	.gpio_o		(led_debug_pad_o),
	.gpio_dir_o	(),

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


