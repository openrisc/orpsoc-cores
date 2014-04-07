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

	output		led_debug_pad_o,

`ifdef VGA_LCD
	output		hsync_n_pad_o,
	output		vsync_n_pad_o,
	output		blank_n_pad_o,
	output [7:0]	lcd_data_pad_o,
	output		pixel_clock_pad_o,
	output		lcd_rst_n_pad_o,
	output		lcd_scen_pad_o,
	output		lcd_scl_pad_o,
	inout		lcd_sda_pad_io,
	output [9:0]	vga_data_pad_o,
	output		vga_clock_pad_o,
	output		vga_hsync_pad_o,
	output		vga_vsync_pad_o,
	output		vga_blank_pad_o,
	output		vga_sync_pad_o,
`endif

`ifdef ETHERNET
	input		eth0_tx_clk_pad_i,
	output	[3:0]	eth0_tx_data_pad_o,
	output		eth0_tx_en_pad_o,
	input		eth0_rx_clk_pad_i,
	input	[3:0]	eth0_rx_data_pad_i,
	input		eth0_rx_dv_pad_i,
	input		eth0_rx_err_pad_i,
	input		eth0_col_pad_i,
	input		eth0_crs_pad_i,
	output		eth0_mdc_pad_o,
	inout		eth0_md_pad_io,
	output		eth0_rst_n_pad_o,
`endif

`ifdef SPI
	output		spi0_sck_pad_o,
	output		spi0_mosi_pad_o,
	input		spi0_miso_pad_i,
	output		spi0_ss_pad_o,
`endif

	inout	[15:0]	flash_dq_pad_io,
	output	[22:0]	flash_adr_pad_o,
	output		flash_adv_n_pad_o,
	output		flash_ce_n_pad_o,
	output		flash_clk_pad_o,
	output		flash_oe_n_pad_o,
	output		flash_rst_n_pad_o,
	output		flash_wait_pad_i,
	output		flash_we_n_pad_o,

	input		uart_rx_pad_i,
	output		uart_tx_pad_o

);

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	wb_clk;
wire	wb_rst;
wire	init_done;
wire	ddr_rst;
wire	async_rst;
wire	pix_clock_x3;
wire	pix_clock;

assign pixel_clock_pad_o = pix_clock_x3;

clkgen clkgen0 (
	.sys_clk_pad_i	(clock_50_pad_i),
	.rst_n_pad_i	(reset_n_pad_i),
	.ddr_init_done	(init_done),
	.async_rst_o	(async_rst),
	.wb_clk_o	(wb_clk),
	.wb_rst_o	(wb_rst),
	.ddr_rst_o	(ddr_rst),
	.pixel_clock	(pix_clock),
	.pixel_clock_x3	(pix_clock_x3)
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

`ifndef SIM
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

`ifdef OR1200_CPU

`ifdef ROM
or1200_top #(.boot_adr(32'hf0000100))
`else
`ifdef SIM
or1200_top #(.boot_adr(32'hf0000100))
`else
or1200_top #(.boot_adr(32'h93120100))
`endif
`endif

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

`ifdef ROM
	.OPTION_RESET_PC		(32'hf0000100)
`else
`ifdef SIM
	.OPTION_RESET_PC		(32'h00000100)
`else
	.OPTION_RESET_PC		(32'h93120100)
`endif
`endif

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

`ifndef SIM
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
`else
assign or1k_dbg_rst = 1'b0;
assign or1k_dbg_stb_i = 1'b0;
assign or1k_dbg_stall_i = 1'b0;
assign wb_m2s_dbg_cyc = 1'b0;
assign wb_m2s_dbg_stb = 1'b0;
`endif

////////////////////////////////////////////////////////////////////////
//
// Ethernet
//
////////////////////////////////////////////////////////////////////////

`ifdef ETHERNET
wire	eth0_irq;

// Management interface wires
wire	eth0_md_i;
wire	eth0_md_o;
wire	eth0_md_oe;

// Tristate control for management interface
assign eth0_md_pad_io = eth0_md_oe ? eth0_md_o : 1'bz;
assign eth0_md_i = eth0_md_pad_io;

assign eth0_rst_n_pad_o = !wb_rst;

ethmac ethmac0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb_m2s_eth0_adr[11:2]),
	.wb_dat_i	(wb_m2s_eth0_dat),
	.wb_sel_i	(wb_m2s_eth0_sel),
	.wb_we_i	(wb_m2s_eth0_we),
	.wb_cyc_i	(wb_m2s_eth0_cyc),
	.wb_stb_i	(wb_m2s_eth0_stb),
	.wb_dat_o	(wb_s2m_eth0_dat),
	.wb_err_o	(wb_s2m_eth0_err),
	.wb_ack_o	(wb_s2m_eth0_ack),

	.m_wb_adr_o	(wb_m2s_eth0_master_adr),
	.m_wb_sel_o	(wb_m2s_eth0_master_sel),
	.m_wb_we_o	(wb_m2s_eth0_master_we),
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
	.mtxd_pad_o	(eth0_tx_data_pad_o),
	.mtxen_pad_o	(eth0_tx_en_pad_o),
	.mtxerr_pad_o	(),
	.mtx_clk_pad_i	(eth0_tx_clk_pad_i),

	// Receive
	.mrx_clk_pad_i	(eth0_rx_clk_pad_i),
	.mrxd_pad_i	(eth0_rx_data_pad_i),
	.mrxdv_pad_i	(eth0_rx_dv_pad_i),
	.mrxerr_pad_i	(eth0_rx_err_pad_i),
	.mcoll_pad_i	(eth0_col_pad_i),
	.mcrs_pad_i	(eth0_crs_pad_i),

	// Management interface
	.md_pad_i	(eth0_md_i),
	.mdc_pad_o	(eth0_mdc_pad_o),
	.md_pad_o	(eth0_md_o),
	.md_padoe_o	(eth0_md_oe),

	// Processor interrupt
	.int_o		(eth0_irq)
);
`else
wire eth0_irq = 0;
assign eth0_tx_data_pad_o = 0;
assign eth0_tx_en_pad_o = 0;
assign eth0_mdc_pad_o = 0;
assign eth0_md_pad_io = 0;
assign eth0_rst_n_pad_o = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_rom0_err = 1'b0;
assign	wb_s2m_rom0_rty = 1'b0;

`ifdef ROM
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
assign	wb_s2m_rom0_ack = 1'b0;
`endif

////////////////////////////////////////////////////////////////////////
//
// LCD controller
//
////////////////////////////////////////////////////////////////////////

`ifdef VGA_LCD

wire		hsync;
wire		vsync;
wire		blank;
wire	[7:0]	r;
wire	[7:0]	g;
wire	[7:0]	b;
wire		vga0_irq;

wire		hsync_n;
wire		vsync_n;
wire		blank_n;
wire	[7:0]	lcd_data;

assign		vga_data_pad_o = {lcd_data, 2'b0};
assign		vga_clock_pad_o = pix_clock_x3;
assign		vga_hsync_pad_o = hsync_n;
assign		vga_vsync_pad_o = vsync_n;
assign		vga_blank_pad_o = blank_n;
assign		vga_sync_pad_o = 1'b0;

assign		hsync_n_pad_o = hsync_n;
assign		vsync_n_pad_o = vsync_n;
assign		blank_n_pad_o = blank_n;
assign		lcd_data_pad_o = lcd_data;

vga_enh_top #(
	.LINE_FIFO_AWIDTH(10)
) vga0 (
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.rst_i		(~async_rst),

	.wb_inta_o	(vga0_irq),

	.wbs_adr_i	(wb_m2s_vga0_adr),
	.wbs_dat_i	(wb_m2s_vga0_dat),
	.wbs_dat_o	(wb_s2m_vga0_dat),
	.wbs_sel_i	(wb_m2s_vga0_sel),
	.wbs_we_i	(wb_m2s_vga0_we),
	.wbs_stb_i	(wb_m2s_vga0_stb),
	.wbs_cyc_i	(wb_m2s_vga0_cyc),
	.wbs_ack_o	(wb_s2m_vga0_ack),
	.wbs_rty_o	(wb_s2m_vga0_rty),
	.wbs_err_o	(wb_s2m_vga0_err),

	.wbm_adr_o	(wb_m2s_vga0_master_adr),
	.wbm_dat_i	(wb_s2m_vga0_master_dat),
	.wbm_cti_o	(wb_m2s_vga0_master_cti),
	.wbm_bte_o	(wb_m2s_vga0_master_bte),
	.wbm_sel_o	(wb_m2s_vga0_master_sel),
	.wbm_we_o	(wb_m2s_vga0_master_we),
	.wbm_stb_o	(wb_m2s_vga0_master_stb),
	.wbm_cyc_o	(wb_m2s_vga0_master_cyc),
	.wbm_ack_i	(wb_s2m_vga0_master_ack),
	.wbm_err_i	(wb_s2m_vga0_master_err),

	.clk_p_i	(pix_clock),

	.clk_p_o	(),
	.hsync_pad_o	(hsync),
	.vsync_pad_o	(vsync),
	.csync_pad_o	(),
	.blank_pad_o	(blank),
	.r_pad_o	(r),
	.g_pad_o	(g),
	.b_pad_o	(b)
);


lcd_ctrl #(
	.WB_CLOCK_FREQUENCY(66666666)
) lcd_ctrl0
(
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),

	.hsync_n_o	(hsync_n),
	.vsync_n_o	(vsync_n),
	.blank_n_o	(blank_n),
	.lcd_data_o	(lcd_data),
	.lcd_rst_n_o	(lcd_rst_n_pad_o),

	.lcd_scen_o	(lcd_scen_pad_o),
	.lcd_scl_o	(lcd_scl_pad_o),
	.lcd_sda_o	(lcd_sda_pad_io),

	.pixel_clk_i	(pix_clock_x3),
	.pixel_rst_i	(async_rst),

	.hsync_i	(hsync),
	.vsync_i	(vsync),
	.blank_i	(blank),
	.r_i		(r),
	.g_i		(g),
	.b_i		(b)
);
`else
wire	vga0_irq = 0;
assign	wb_s2m_vga0_rty = 0;
assign	wb_s2m_vga0_err= 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// SDRAM Memory Controller
//
////////////////////////////////////////////////////////////////////////

wire [22:0]	local_address;
wire		local_write_req;
wire		local_read_req;
wire		local_burstbegin;
wire [31:0]	local_wdata;
wire [3:0]	local_be;
wire [6:0]	local_size;
wire [31:0]	local_rdata;
wire		local_rdata_valid;
wire		local_reset_n;
wire		local_clk;
wire		local_ready;

assign		wb_s2m_ddr_ibus_err = 0;
assign		wb_s2m_ddr_ibus_rty = 0;

assign		wb_s2m_ddr_dbus_err = 0;
assign		wb_s2m_ddr_dbus_rty = 0;

wb_ddr_ctrl
#(
	.ADDR_WIDTH	(25),				// Memory size = 2^ADDR_WIDTH = 32MB
	.WB_PORTS	(4),				// Number of wishbone ports
	.BUF_WIDTH	({3'd3, 3'd3, 3'd5, 3'd4})	// Buffer size = 2^BUF_WIDTH
)
wb_ddr_ctrl0
(
	// Wishbone interface
	.wb_clk			(wb_clk),
	.wb_rst			(ddr_rst),

	.wb_adr_i		({wb_m2s_ddr_ibus_adr, wb_m2s_ddr_dbus_adr, wb_m2s_ddr_vga_adr, wb_m2s_ddr_eth_adr}),
	.wb_stb_i		({wb_m2s_ddr_ibus_stb, wb_m2s_ddr_dbus_stb, wb_m2s_ddr_vga_stb, wb_m2s_ddr_eth_stb}),
	.wb_cyc_i		({wb_m2s_ddr_ibus_cyc, wb_m2s_ddr_dbus_cyc, wb_m2s_ddr_vga_cyc, wb_m2s_ddr_eth_cyc}),
	.wb_cti_i		({wb_m2s_ddr_ibus_cti, wb_m2s_ddr_dbus_cti, wb_m2s_ddr_vga_cti, wb_m2s_ddr_eth_cti}),
	.wb_bte_i		({wb_m2s_ddr_ibus_bte, wb_m2s_ddr_dbus_bte, wb_m2s_ddr_vga_bte, wb_m2s_ddr_eth_bte}),
	.wb_we_i		({wb_m2s_ddr_ibus_we,  wb_m2s_ddr_dbus_we , wb_m2s_ddr_vga_we , wb_m2s_ddr_eth_we }),
	.wb_sel_i		({wb_m2s_ddr_ibus_sel, wb_m2s_ddr_dbus_sel, wb_m2s_ddr_vga_sel, wb_m2s_ddr_eth_sel}),
	.wb_dat_i		({wb_m2s_ddr_ibus_dat, wb_m2s_ddr_dbus_dat, wb_m2s_ddr_vga_dat, wb_m2s_ddr_eth_dat}),
	.wb_dat_o		({wb_s2m_ddr_ibus_dat, wb_s2m_ddr_dbus_dat, wb_s2m_ddr_vga_dat, wb_s2m_ddr_eth_dat}),
	.wb_ack_o		({wb_s2m_ddr_ibus_ack, wb_s2m_ddr_dbus_ack, wb_s2m_ddr_vga_ack, wb_s2m_ddr_eth_ack}),

	// DDR controller local interface
	.local_address_o	(local_address),
	.local_write_req_o	(local_write_req),
	.local_read_req_o	(local_read_req),
	.local_burstbegin_o	(local_burstbegin),
	.local_wdata_o		(local_wdata),
	.local_be_o		(local_be),
	.local_size_o		(local_size),
	.local_rdata_i		(local_rdata),
	.local_rdata_valid_i	(local_rdata_valid),
	.local_reset_n_i	(local_reset_n),
	.local_clk_i		(local_clk),
	.local_ready_i		(local_ready)
);

ddr_ctrl_ip ddr_ctrl_ip
(
	.local_address		(local_address),
	.local_write_req	(local_write_req),
	.local_read_req		(local_read_req),
	.local_burstbegin	(local_burstbegin),
	.local_wdata		(local_wdata),
	.local_be		(local_be),
	.local_size		(local_size),

	.global_reset_n		(~async_rst),
	.pll_ref_clk		(clock_50_pad_i),
	.soft_reset_n		(1'b1),

	.local_ready		(local_ready),
	.local_rdata		(local_rdata),
	.local_rdata_valid	(local_rdata_valid),
	.local_refresh_ack	(),
	.local_init_done	(init_done),

	.reset_phy_clk_n	(local_reset_n),

	.mem_cs_n		(ddr_cs_n_pad_o),
	.mem_cke		(ddr_cke_pad_o),
	.mem_addr		(ddr_a_pad_o),
	.mem_ba			(ddr_ba_pad_o),
	.mem_ras_n		(ddr_ras_n_pad_o),
	.mem_cas_n		(ddr_cas_n_pad_o),
	.mem_we_n		(ddr_we_n_pad_o),
	.mem_dm			(ddr_dm_pad_o),

	.phy_clk		(local_clk),
	.aux_full_rate_clk	(),
	.aux_half_rate_clk	(),
	.reset_request_n	(),

	.mem_clk		(ddr_clk_pad_o),
	.mem_clk_n		(ddr_clk_n_pad_o),
	.mem_dq			(ddr_dq_pad_io),
	.mem_dqs		(ddr_dqs_pad_io)
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
// SPI0 controller
//
////////////////////////////////////////////////////////////////////////


wire    spi0_irq;

assign  wb_s2m_spi0_err = 0;
assign  wb_s2m_spi0_rty = 0;

`ifdef SPI
simple_spi spi0(
	// Wishbone slave interface
	.clk_i		(wb_clk),
	.rst_i		(wb_rst),
	.adr_i		(wb_m2s_spi0_adr[2:0]),
	.dat_i		(wb_m2s_spi0_dat),
	.we_i		(wb_m2s_spi0_we),
	.stb_i		(wb_m2s_spi0_stb),
	.cyc_i		(wb_m2s_spi0_cyc),
	.dat_o		(wb_s2m_spi0_dat),
	.ack_o		(wb_s2m_spi0_ack),

	// Outputs
	.inta_o		(spi0_irq),
	.sck_o		(spi0_sck_pad_o),
	.ss_o		(spi0_ss_pad_o),
	.mosi_o		(spi0_mosi_pad_o),

	// Inputs
	.miso_i		(spi0_miso_pad_i)
);
`else
assign spi0_irq = 0;
assign wb_s2m_spi0_dat = 0;
assign wb_s2m_spi0_ack = 0;
`endif

////////////////////////////////////////////////////////////////////////
//
// CFI0 controller
//
////////////////////////////////////////////////////////////////////////

assign	wb_s2m_cfi0_err = 1'b0;
assign	wb_s2m_cfi0_rty = 1'b0;

cfi_ctrl #(	.flash_adr_width(23),
		.cfi_engine("DISABLED"))
cfi_ctrl0
(
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),

	.wb_dat_i	(wb_m2s_cfi0_dat),
	.wb_adr_i	(wb_m2s_cfi0_adr),
	.wb_stb_i	(wb_m2s_cfi0_stb),
	.wb_cyc_i	(wb_m2s_cfi0_cyc),
	.wb_we_i	(wb_m2s_cfi0_we),
	.wb_sel_i	(wb_m2s_cfi0_sel),
	.wb_dat_o	(wb_s2m_cfi0_dat),
	.wb_ack_o	(wb_s2m_cfi0_ack),
	.wb_err_o	(),
	.wb_rty_o	(),

	.flash_dq_io	(flash_dq_pad_io),
	.flash_adr_o	(flash_adr_pad_o),
	.flash_adv_n_o	(flash_adv_n_pad_o),
	.flash_ce_n_o	(flash_ce_n_pad_o),
	.flash_clk_o	(flash_clk_pad_o),
	.flash_oe_n_o	(flash_oe_n_pad_o),
	.flash_rst_n_o	(flash_rst_n_pad_o),
	.flash_wait_i	(flash_wait_pad_i),
	.flash_we_n_o	(flash_we_n_pad_o),
	.flash_wp_n_o	()
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
assign or1k_irq[5] = 0;
assign or1k_irq[6] = spi0_irq;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = vga0_irq;
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


