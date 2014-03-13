//////////////////////////////////////////////////////////////////////
//
// ORPSoC top for de0_nano board
//
// Instantiates modules, depending on ORPSoC defines file
//
// Copyright (C) 2014 Jose T. de Sousa
//  <jts@inesc-id.pt>
// Copyright (C) 2013 Stefan Kristiansson
//  <stefan.kristiansson@saunalahti.fi
//
// Based on de1 board by
// Franck Jullien, franck.jullien@gmail.com
// Which probably was based on the or1200-generic board by
// Olof Kindgren, which in turn was based on orpsocv2 boards by
// Julius Baxter.
//
//////////////////////////////////////////////////////////////////////
//
// This source file may be used and distributed without
// restriction provided that this copyright statement is not
// removed from the file and that any derivative work contains
// the original copyright notice and the associated disclaimer.
//
// This source file is free software; you can redistribute it
// and/or modify it under the terms of the GNU Lesser General
// Public License as published by the Free Software Foundation;
// either version 2.1 of the License, or (at your option) any
// later version.
//
// This source is distributed in the hope that it will be
// useful, but WITHOUT ANY WARRANTY; without even the implied
// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
// PURPOSE.  See the GNU Lesser General Public License for more
// details.
//
// You should have received a copy of the GNU Lesser General
// Public License along with this source; if not, download it
// from http://www.opencores.org/lgpl.shtml
//
//////////////////////////////////////////////////////////////////////

`include "orpsoc-defines.v"

module orpsoc_top #(
	parameter	rom0_aw = 6,
	parameter	uart0_aw = 3,
        parameter       HV1_SADR = 8'h45,
        parameter       i2c0_wb_adr_width = 3,
        parameter       i2c1_wb_adr_width = 3
)(
	input		sys_clk_pad_i,
	input		rst_n_pad_i,

	output		tdo_pad_o,
	input		tms_pad_i,
	input		tck_pad_i,
	input		tdi_pad_i,


	input		uart0_srx_pad_i,
	output		uart0_stx_pad_o

`ifdef I2C0
,	inout	[7:0]	gpio0_io
`endif
  
`ifdef I2C0
,	inout		i2c0_sda_io,
	inout		i2c0_scl_io
`endif

`ifdef I2C1
,	inout		i2c1_sda_io,
	inout		i2c1_scl_io
`endif

`ifdef SPI0
,    output          spi0_sck_o,
    output          spi0_mosi_o,
    input           spi0_miso_i
 `ifdef SPI0_SLAVE_SELECTS
,    output          spi0_ss_o
 `endif
`endif

`ifdef SPI1
,    output          spi1_sck_o,
    output          spi1_mosi_o,
    input           spi1_miso_i
`ifdef SPI1_SLAVE_SELECTS
,    output          spi1_ss_o
 `endif
`endif

`ifdef SPI2
,    output          spi2_sck_o
    output          spi2_mosi_o,
    input           spi2_miso_i,
 `ifdef SPI2_SLAVE_SELECTS
,    output          spi2_ss_o
 `endif
`endif

`ifdef ACCELEROMETER
,    output          accelerometer_cs_o,
    input           accelerometer_irq_i
`endif

);

parameter	IDCODE_VALUE=32'h14951185;

localparam wb_aw = 32;
localparam wb_dw = 32;

localparam MEM_SIZE_BITS = 23;

////////////////////////////////////////////////////////////////////////
//
// Clock and reset generation module
//
////////////////////////////////////////////////////////////////////////

wire	async_rst;
wire	wb_clk, wb_rst;
wire	dbg_tck;

   assign wb_clk = sys_clk_pad_i;
   assign wb_rst = ~rst_n_pad_i;
   assign async_rst = ~rst_n_pad_i;
   
   assign dbg_tck = tck_pad_i;
   
   
////////////////////////////////////////////////////////////////////////
//
// Modules interconnections
//
////////////////////////////////////////////////////////////////////////
`include "wb_intercon.vh"

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

////////////////////////////////////////////////////////////////////////
//
// OR1K CPU
//
////////////////////////////////////////////////////////////////////////

wire	[30:0]	or1k_irq;

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

`ifdef OR1200
wire		or1k_rst;

assign	or1k_rst= wb_rst | or1k_dbg_rst;

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
	.rst(wb_rst),

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
   // Generic main RAM
   // 
   ////////////////////////////////////////////////////////////////////////
   ram_wb #(.aw(wb_aw),
            .dw(wb_dw),
            .mem_size_bytes(8192*1024), // 8MB
            .mem_adr_width(23)) // log2(8192*1024)
   ram_wb0
     (
      // Wishbone slave interface 0
      .wbm0_dat_i              (wb_m2s_sdram_ibus_dat),
      .wbm0_adr_i              (wb_m2s_sdram_ibus_adr),
      .wbm0_sel_i              (wb_m2s_sdram_ibus_sel),
      .wbm0_cti_i              (wb_m2s_sdram_ibus_cti),
      .wbm0_bte_i              (wb_m2s_sdram_ibus_bte),
      .wbm0_we_i               (wb_m2s_sdram_ibus_we), 
      .wbm0_cyc_i              (wb_m2s_sdram_ibus_cyc),
      .wbm0_stb_i              (wb_m2s_sdram_ibus_stb),
      .wbm0_dat_o              (wb_s2m_sdram_ibus_dat),
      .wbm0_ack_o              (wb_s2m_sdram_ibus_ack),
      .wbm0_err_o              (wb_s2m_sdram_ibus_err),
      .wbm0_rty_o              (wb_s2m_sdram_ibus_rty),
  
      // Wishbone slave interface 1
      .wbm1_dat_i                   (wb_m2s_sdram_dbus_dat),
      .wbm1_adr_i                   (wb_m2s_sdram_dbus_adr),
      .wbm1_sel_i                   (wb_m2s_sdram_dbus_sel),
      .wbm1_cti_i                   (wb_m2s_sdram_dbus_cti),
      .wbm1_bte_i                   (wb_m2s_sdram_dbus_bte),
      .wbm1_we_i                    (wb_m2s_sdram_dbus_we), 
      .wbm1_cyc_i                   (wb_m2s_sdram_dbus_cyc),
      .wbm1_stb_i                   (wb_m2s_sdram_dbus_stb),
      .wbm1_dat_o                   (wb_s2m_sdram_dbus_dat),
      .wbm1_ack_o                   (wb_s2m_sdram_dbus_ack),
      .wbm1_err_o                   (wb_s2m_sdram_dbus_err),
      .wbm1_rty_o		    (wb_s2m_sdram_dbus_rty),

      
      // Wishbone slave interface 2
      .wbm2_dat_i                        (32'd0),
      .wbm2_adr_i                        (32'd0),
      .wbm2_sel_i                        (4'd0),
      .wbm2_cti_i                        (3'd0),
      .wbm2_bte_i                        (2'd0),
      .wbm2_we_i                        (1'd0),
      .wbm2_cyc_i                        (1'd0),
      .wbm2_stb_i                        (1'd0),
      .wbm2_dat_o                        (),
      .wbm2_ack_o                        (),
      .wbm2_err_o                       (),
      .wbm2_rty_o                       (),
      // Clock, reset
      .wb_clk_i                                (wb_clk),
      .wb_rst_i                                (wb_rst));


////////////////////////////////////////////////////////////////////////
//
// UART0
//
////////////////////////////////////////////////////////////////////////

wire	uart0_irq;

wire [31:0]	wb8_m2s_uart0_adr;
wire [1:0]	wb8_m2s_uart0_bte;
wire [2:0]	wb8_m2s_uart0_cti;
wire		wb8_m2s_uart0_cyc;
wire [7:0]	wb8_m2s_uart0_dat;
wire		wb8_m2s_uart0_stb;
wire		wb8_m2s_uart0_we;
wire [7:0] 	wb8_s2m_uart0_dat;
wire		wb8_s2m_uart0_ack;
wire		wb8_s2m_uart0_err;
wire		wb8_s2m_uart0_rty;

assign	wb8_s2m_uart0_err = 0;
assign	wb8_s2m_uart0_rty = 0;

uart_top uart16550_0 (
	// Wishbone slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb8_m2s_uart0_adr[uart0_aw-1:0]),
	.wb_dat_i	(wb8_m2s_uart0_dat),
	.wb_we_i	(wb8_m2s_uart0_we),
	.wb_stb_i	(wb8_m2s_uart0_stb),
	.wb_cyc_i	(wb8_m2s_uart0_cyc),
	.wb_sel_i	(4'b0), // Not used in 8-bit mode
	.wb_dat_o	(wb8_s2m_uart0_dat),
	.wb_ack_o	(wb8_s2m_uart0_ack),

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

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_uart0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_uart0_adr),
	.wbm_dat_i	(wb_m2s_uart0_dat),
	.wbm_sel_i	(wb_m2s_uart0_sel),
	.wbm_we_i	(wb_m2s_uart0_we ),
	.wbm_cyc_i	(wb_m2s_uart0_cyc),
	.wbm_stb_i	(wb_m2s_uart0_stb),
	.wbm_cti_i	(wb_m2s_uart0_cti),
	.wbm_bte_i	(wb_m2s_uart0_bte),
	.wbm_dat_o	(wb_s2m_uart0_dat),
	.wbm_ack_o	(wb_s2m_uart0_ack),
	.wbm_err_o	(wb_s2m_uart0_err),
	.wbm_rty_o	(wb_s2m_uart0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_uart0_adr),
	.wbs_dat_o	(wb8_m2s_uart0_dat),
	.wbs_we_o 	(wb8_m2s_uart0_we ),
	.wbs_cyc_o	(wb8_m2s_uart0_cyc),
	.wbs_stb_o	(wb8_m2s_uart0_stb),
	.wbs_cti_o	(wb8_m2s_uart0_cti),
	.wbs_bte_o	(wb8_m2s_uart0_bte),
	.wbs_dat_i	(wb8_s2m_uart0_dat),
	.wbs_ack_i	(wb8_s2m_uart0_ack),
	.wbs_err_i	(wb8_s2m_uart0_err),
	.wbs_rty_i	(wb8_s2m_uart0_rty)
);

`ifdef I2C0
////////////////////////////////////////////////////////////////////////
//
// I2C controller 0
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire 		i2c0_irq;
wire 		scl0_pad_o;
wire 		scl0_padoen_o;
wire 		sda0_pad_o;
wire 		sda0_padoen_o;

wire [31:0]	wb8_m2s_i2c0_adr;
wire [1:0]	wb8_m2s_i2c0_bte;
wire [2:0]	wb8_m2s_i2c0_cti;
wire		wb8_m2s_i2c0_cyc;
wire [7:0]	wb8_m2s_i2c0_dat;
wire		wb8_m2s_i2c0_stb;
wire		wb8_m2s_i2c0_we;
wire [7:0] 	wb8_s2m_i2c0_dat;
wire		wb8_s2m_i2c0_ack;
wire		wb8_s2m_i2c0_err;
wire		wb8_s2m_i2c0_rty;

i2c_master_top
 #
 (
  .DEFAULT_SLAVE_ADDR(HV1_SADR)
 )
i2c0
  (
   .wb_clk_i			     (wb_clk),
   .wb_rst_i			     (wb_rst),
   .arst_i			     (wb_rst),
   .wb_adr_i			     (wb8_m2s_i2c0_adr[i2c0_wb_adr_width-1:0]),
   .wb_dat_i			     (wb8_m2s_i2c0_dat),
   .wb_we_i			     (wb8_m2s_i2c0_we),
   .wb_cyc_i			     (wb8_m2s_i2c0_cyc),
   .wb_stb_i			     (wb8_m2s_i2c0_stb),
   .wb_dat_o			     (wb8_s2m_i2c0_dat),
   .wb_ack_o			     (wb8_s2m_i2c0_ack),
   .scl_pad_i		     	     (i2c0_scl_io        ),
   .scl_pad_o			     (scl0_pad_o	 ),
   .scl_padoen_o		     (scl0_padoen_o	 ),
   .sda_pad_i			     (i2c0_sda_io 	 ),
   .sda_pad_o			     (sda0_pad_o	 ),
   .sda_padoen_o		     (sda0_padoen_o	 ),

   // Interrupt
   .wb_inta_o			     (i2c0_irq)

   );

assign wb8_s2m_i2c0_err = 0;
assign wb8_s2m_i2c0_rty = 0;

// i2c phy lines
assign i2c0_scl_io = scl0_padoen_o ? 1'bz : scl0_pad_o;
assign i2c0_sda_io = sda0_padoen_o ? 1'bz : sda0_pad_o;

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_i2c0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_i2c0_adr),
	.wbm_dat_i	(wb_m2s_i2c0_dat),
	.wbm_sel_i	(wb_m2s_i2c0_sel),
	.wbm_we_i	(wb_m2s_i2c0_we ),
	.wbm_cyc_i	(wb_m2s_i2c0_cyc),
	.wbm_stb_i	(wb_m2s_i2c0_stb),
	.wbm_cti_i	(wb_m2s_i2c0_cti),
	.wbm_bte_i	(wb_m2s_i2c0_bte),
	.wbm_dat_o	(wb_s2m_i2c0_dat),
	.wbm_ack_o	(wb_s2m_i2c0_ack),
	.wbm_err_o	(wb_s2m_i2c0_err),
	.wbm_rty_o	(wb_s2m_i2c0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_i2c0_adr),
	.wbs_dat_o	(wb8_m2s_i2c0_dat),
	.wbs_we_o 	(wb8_m2s_i2c0_we ),
	.wbs_cyc_o	(wb8_m2s_i2c0_cyc),
	.wbs_stb_o	(wb8_m2s_i2c0_stb),
	.wbs_cti_o	(wb8_m2s_i2c0_cti),
	.wbs_bte_o	(wb8_m2s_i2c0_bte),
	.wbs_dat_i	(wb8_s2m_i2c0_dat),
	.wbs_ack_i	(wb8_s2m_i2c0_ack),
	.wbs_err_i	(wb8_s2m_i2c0_err),
	.wbs_rty_i	(wb8_s2m_i2c0_rty)
);

////////////////////////////////////////////////////////////////////////
`else // !`ifdef I2C0

assign wb8_s2m_i2c0_dat = 0;
assign wb8_s2m_i2c0_ack = 0;
assign wb8_s2m_i2c0_err = 0;
assign wb8_s2m_i2c0_rty = 0;

////////////////////////////////////////////////////////////////////////
`endif // !`ifdef I2C0

`ifdef I2C1
////////////////////////////////////////////////////////////////////////
//
// I2C controller 1
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire 		i2c1_irq;
wire 		scl1_pad_o;
wire 		scl1_padoen_o;
wire 		sda1_pad_o;
wire 		sda1_padoen_o;

wire [31:0]	wb8_m2s_i2c1_adr;
wire [1:0]	wb8_m2s_i2c1_bte;
wire [2:0]	wb8_m2s_i2c1_cti;
wire		wb8_m2s_i2c1_cyc;
wire [7:0]	wb8_m2s_i2c1_dat;
wire		wb8_m2s_i2c1_stb;
wire		wb8_m2s_i2c1_we;
wire [7:0] 	wb8_s2m_i2c1_dat;
wire		wb8_s2m_i2c1_ack;
wire		wb8_s2m_i2c1_err;
wire		wb8_s2m_i2c1_rty;

i2c_master_top
 #
 (
  .DEFAULT_SLAVE_ADDR(HV1_SADR)
 )
i2c1
  (
   .wb_clk_i			     (wb_clk),
   .wb_rst_i			     (wb_rst),
   .arst_i			     (wb_rst),
   .wb_adr_i			     (wb8_m2s_i2c1_adr[i2c1_wb_adr_width-1:0]),
   .wb_dat_i			     (wb8_m2s_i2c1_dat),
   .wb_we_i			     (wb8_m2s_i2c1_we),
   .wb_cyc_i			     (wb8_m2s_i2c1_cyc),
   .wb_stb_i			     (wb8_m2s_i2c1_stb),
   .wb_dat_o			     (wb8_s2m_i2c1_dat),
   .wb_ack_o			     (wb8_s2m_i2c1_ack),
   .scl_pad_i		     	     (i2c1_scl_io        ),
   .scl_pad_o			     (scl1_pad_o	 ),
   .scl_padoen_o		     (scl1_padoen_o	 ),
   .sda_pad_i			     (i2c1_sda_io 	 ),
   .sda_pad_o			     (sda1_pad_o	 ),
   .sda_padoen_o		     (sda1_padoen_o	 ),

   // Interrupt
   .wb_inta_o			     (i2c1_irq)

   );

assign wb8_s2m_i2c1_err = 0;
assign wb8_s2m_i2c1_rty = 0;

// i2c phy lines
assign i2c1_scl_io = scl1_padoen_o ? 1'bz : scl1_pad_o;
assign i2c1_sda_io = sda1_padoen_o ? 1'bz : sda1_pad_o;

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_i2c1 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_i2c1_adr),
	.wbm_dat_i	(wb_m2s_i2c1_dat),
	.wbm_sel_i	(wb_m2s_i2c1_sel),
	.wbm_we_i	(wb_m2s_i2c1_we ),
	.wbm_cyc_i	(wb_m2s_i2c1_cyc),
	.wbm_stb_i	(wb_m2s_i2c1_stb),
	.wbm_cti_i	(wb_m2s_i2c1_cti),
	.wbm_bte_i	(wb_m2s_i2c1_bte),
	.wbm_dat_o	(wb_s2m_i2c1_dat),
	.wbm_ack_o	(wb_s2m_i2c1_ack),
	.wbm_err_o	(wb_s2m_i2c1_err),
	.wbm_rty_o	(wb_s2m_i2c1_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_i2c1_adr),
	.wbs_dat_o	(wb8_m2s_i2c1_dat),
	.wbs_we_o 	(wb8_m2s_i2c1_we ),
	.wbs_cyc_o	(wb8_m2s_i2c1_cyc),
	.wbs_stb_o	(wb8_m2s_i2c1_stb),
	.wbs_cti_o	(wb8_m2s_i2c1_cti),
	.wbs_bte_o	(wb8_m2s_i2c1_bte),
	.wbs_dat_i	(wb8_s2m_i2c1_dat),
	.wbs_ack_i	(wb8_s2m_i2c1_ack),
	.wbs_err_i	(wb8_s2m_i2c1_err),
	.wbs_rty_i	(wb8_s2m_i2c1_rty)
);

////////////////////////////////////////////////////////////////////////
`else // !`ifdef I2C1

assign wb8_s2m_i2c1_dat = 0;
assign wb8_s2m_i2c1_ack = 0;
assign wb8_s2m_i2c1_err = 0;
assign wb8_s2m_i2c1_rty = 0;

////////////////////////////////////////////////////////////////////////
`endif // !`ifdef I2C1

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

wire [31:0]	wb8_m2s_spi0_adr;
wire [1:0]	wb8_m2s_spi0_bte;
wire [2:0]	wb8_m2s_spi0_cti;
wire		wb8_m2s_spi0_cyc;
wire [7:0]	wb8_m2s_spi0_dat;
wire		wb8_m2s_spi0_stb;
wire		wb8_m2s_spi0_we;
wire [7:0] 	wb8_s2m_spi0_dat;
wire		wb8_s2m_spi0_ack;
wire		wb8_s2m_spi0_err;
wire		wb8_s2m_spi0_rty;

//
// Assigns
//
assign  wbs_d_spi0_err_o = 0;
assign  wbs_d_spi0_rty_o = 0;
assign  spi0_hold_n_o = 1;
assign  spi0_w_n_o = 1;

simple_spi spi0(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi0_adr[2:0]),
	.dat_i	(wb8_m2s_spi0_dat),
	.we_i	(wb8_m2s_spi0_we),
	.stb_i	(wb8_m2s_spi0_stb),
	.cyc_i	(wb8_m2s_spi0_cyc),
	.dat_o	(wb8_s2m_spi0_dat),
	.ack_o	(wb8_s2m_spi0_ack),

	// Outputs
	.inta_o		(spi0_irq),
	.sck_o		(spi0_sck_o),
 `ifdef SPI0_SLAVE_SELECTS
	.ss_o		(spi0_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi0_mosi_o),

	// Inputs
	.miso_i		(spi0_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi0_adr),
	.wbm_dat_i	(wb_m2s_spi0_dat),
	.wbm_sel_i	(wb_m2s_spi0_sel),
	.wbm_we_i	(wb_m2s_spi0_we ),
	.wbm_cyc_i	(wb_m2s_spi0_cyc),
	.wbm_stb_i	(wb_m2s_spi0_stb),
	.wbm_cti_i	(wb_m2s_spi0_cti),
	.wbm_bte_i	(wb_m2s_spi0_bte),
	.wbm_dat_o	(wb_s2m_spi0_dat),
	.wbm_ack_o	(wb_s2m_spi0_ack),
	.wbm_err_o	(wb_s2m_spi0_err),
	.wbm_rty_o	(wb_s2m_spi0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi0_adr),
	.wbs_dat_o	(wb8_m2s_spi0_dat),
	.wbs_we_o 	(wb8_m2s_spi0_we ),
	.wbs_cyc_o	(wb8_m2s_spi0_cyc),
	.wbs_stb_o	(wb8_m2s_spi0_stb),
	.wbs_cti_o	(wb8_m2s_spi0_cti),
	.wbs_bte_o	(wb8_m2s_spi0_bte),
	.wbs_dat_i	(wb8_s2m_spi0_dat),
	.wbs_ack_i	(wb8_s2m_spi0_ack),
	.wbs_err_i	(wb8_s2m_spi0_err),
	.wbs_rty_i	(wb8_s2m_spi0_rty)
);
`endif

`ifdef SPI1
////////////////////////////////////////////////////////////////////////
//
// SPI1 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi1_irq;

wire [31:0]	wb8_m2s_spi1_adr;
wire [1:0]	wb8_m2s_spi1_bte;
wire [2:0]	wb8_m2s_spi1_cti;
wire		wb8_m2s_spi1_cyc;
wire [7:0]	wb8_m2s_spi1_dat;
wire		wb8_m2s_spi1_stb;
wire		wb8_m2s_spi1_we;
wire [7:0] 	wb8_s2m_spi1_dat;
wire		wb8_s2m_spi1_ack;
wire		wb8_s2m_spi1_err;
wire		wb8_s2m_spi1_rty;

//
// Assigns
//
assign  wbs_d_spi1_err_o = 0;
assign  wbs_d_spi1_rty_o = 0;
assign  spi1_hold_n_o = 1;
assign  spi1_w_n_o = 1;

simple_spi spi1(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi1_adr[2:0]),
	.dat_i	(wb8_m2s_spi1_dat),
	.we_i	(wb8_m2s_spi1_we),
	.stb_i	(wb8_m2s_spi1_stb),
	.cyc_i	(wb8_m2s_spi1_cyc),
	.dat_o	(wb8_s2m_spi1_dat),
	.ack_o	(wb8_s2m_spi1_ack),

	// Outputs
	.inta_o		(spi1_irq),
	.sck_o		(spi1_sck_o),
 `ifdef SPI1_SLAVE_SELECTS
	.ss_o		(spi1_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi1_mosi_o),

	// Inputs
	.miso_i		(spi1_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi1 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi1_adr),
	.wbm_dat_i	(wb_m2s_spi1_dat),
	.wbm_sel_i	(wb_m2s_spi1_sel),
	.wbm_we_i	(wb_m2s_spi1_we ),
	.wbm_cyc_i	(wb_m2s_spi1_cyc),
	.wbm_stb_i	(wb_m2s_spi1_stb),
	.wbm_cti_i	(wb_m2s_spi1_cti),
	.wbm_bte_i	(wb_m2s_spi1_bte),
	.wbm_dat_o	(wb_s2m_spi1_dat),
	.wbm_ack_o	(wb_s2m_spi1_ack),
	.wbm_err_o	(wb_s2m_spi1_err),
	.wbm_rty_o	(wb_s2m_spi1_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi1_adr),
	.wbs_dat_o	(wb8_m2s_spi1_dat),
	.wbs_we_o 	(wb8_m2s_spi1_we ),
	.wbs_cyc_o	(wb8_m2s_spi1_cyc),
	.wbs_stb_o	(wb8_m2s_spi1_stb),
	.wbs_cti_o	(wb8_m2s_spi1_cti),
	.wbs_bte_o	(wb8_m2s_spi1_bte),
	.wbs_dat_i	(wb8_s2m_spi1_dat),
	.wbs_ack_i	(wb8_s2m_spi1_ack),
	.wbs_err_i	(wb8_s2m_spi1_err),
	.wbs_rty_i	(wb8_s2m_spi1_rty)
);
`endif

`ifdef SPI2
////////////////////////////////////////////////////////////////////////
//
// SPI2 controller
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire            spi2_irq;

wire [31:0]	wb8_m2s_spi2_adr;
wire [1:0]	wb8_m2s_spi2_bte;
wire [2:0]	wb8_m2s_spi2_cti;
wire		wb8_m2s_spi2_cyc;
wire [7:0]	wb8_m2s_spi2_dat;
wire		wb8_m2s_spi2_stb;
wire		wb8_m2s_spi2_we;
wire [7:0] 	wb8_s2m_spi2_dat;
wire		wb8_s2m_spi2_ack;
wire		wb8_s2m_spi2_err;
wire		wb8_s2m_spi2_rty;

//
// Assigns
//
assign  wbs_d_spi2_err_o = 0;
assign  wbs_d_spi2_rty_o = 0;
assign  spi2_hold_n_o = 1;
assign  spi2_w_n_o = 1;

simple_spi spi2(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi2_adr[2:0]),
	.dat_i	(wb8_m2s_spi2_dat),
	.we_i	(wb8_m2s_spi2_we),
	.stb_i	(wb8_m2s_spi2_stb),
	.cyc_i	(wb8_m2s_spi2_cyc),
	.dat_o	(wb8_s2m_spi2_dat),
	.ack_o	(wb8_s2m_spi2_ack),

	// Outputs
	.inta_o		(spi2_irq),
	.sck_o		(spi2_sck_o),
 `ifdef SPI2_SLAVE_SELECTS
	.ss_o		(spi2_ss_o),
 `else
	.ss_o		(),
 `endif
	.mosi_o		(spi2_mosi_o),

	// Inputs
	.miso_i		(spi2_miso_i)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi2 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi2_adr),
	.wbm_dat_i	(wb_m2s_spi2_dat),
	.wbm_sel_i	(wb_m2s_spi2_sel),
	.wbm_we_i	(wb_m2s_spi2_we ),
	.wbm_cyc_i	(wb_m2s_spi2_cyc),
	.wbm_stb_i	(wb_m2s_spi2_stb),
	.wbm_cti_i	(wb_m2s_spi2_cti),
	.wbm_bte_i	(wb_m2s_spi2_bte),
	.wbm_dat_o	(wb_s2m_spi2_dat),
	.wbm_ack_o	(wb_s2m_spi2_ack),
	.wbm_err_o	(wb_s2m_spi2_err),
	.wbm_rty_o	(wb_s2m_spi2_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi2_adr),
	.wbs_dat_o	(wb8_m2s_spi2_dat),
	.wbs_we_o 	(wb8_m2s_spi2_we ),
	.wbs_cyc_o	(wb8_m2s_spi2_cyc),
	.wbs_stb_o	(wb8_m2s_spi2_stb),
	.wbs_cti_o	(wb8_m2s_spi2_cti),
	.wbs_bte_o	(wb8_m2s_spi2_bte),
	.wbs_dat_i	(wb8_s2m_spi2_dat),
	.wbs_ack_i	(wb8_s2m_spi2_ack),
	.wbs_err_i	(wb8_s2m_spi2_err),
	.wbs_rty_i	(wb8_s2m_spi2_rty)
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

wire [31:0]	wb8_m2s_gpio0_adr;
wire [1:0]	wb8_m2s_gpio0_bte;
wire [2:0]	wb8_m2s_gpio0_cti;
wire		wb8_m2s_gpio0_cyc;
wire [7:0]	wb8_m2s_gpio0_dat;
wire		wb8_m2s_gpio0_stb;
wire		wb8_m2s_gpio0_we;
wire [7:0] 	wb8_s2m_gpio0_dat;
wire		wb8_s2m_gpio0_ack;
wire		wb8_s2m_gpio0_err;
wire		wb8_s2m_gpio0_rty;

`ifdef GPIO0   
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
	.wb_adr_i	(wb8_m2s_gpio0_adr[0]),
	.wb_dat_i	(wb8_m2s_gpio0_dat),
	.wb_we_i	(wb8_m2s_gpio0_we),
	.wb_cyc_i	(wb8_m2s_gpio0_cyc),
	.wb_stb_i	(wb8_m2s_gpio0_stb),
	.wb_cti_i	(wb8_m2s_gpio0_cti),
	.wb_bte_i	(wb8_m2s_gpio0_bte),
	.wb_dat_o	(wb8_s2m_gpio0_dat),
	.wb_ack_o	(wb8_s2m_gpio0_ack),
	.wb_err_o	(wb8_s2m_gpio0_err),
	.wb_rty_o	(wb8_s2m_gpio0_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

   
// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_gpio0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_gpio0_adr),
	.wbm_dat_i	(wb_m2s_gpio0_dat),
	.wbm_sel_i	(wb_m2s_gpio0_sel),
	.wbm_we_i	(wb_m2s_gpio0_we ),
	.wbm_cyc_i	(wb_m2s_gpio0_cyc),
	.wbm_stb_i	(wb_m2s_gpio0_stb),
	.wbm_cti_i	(wb_m2s_gpio0_cti),
	.wbm_bte_i	(wb_m2s_gpio0_bte),
	.wbm_dat_o	(wb_s2m_gpio0_dat),
	.wbm_ack_o	(wb_s2m_gpio0_ack),
	.wbm_err_o	(wb_s2m_gpio0_err),
	.wbm_rty_o	(wb_s2m_gpio0_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_gpio0_adr),
	.wbs_dat_o	(wb8_m2s_gpio0_dat),
	.wbs_we_o	(wb8_m2s_gpio0_we ),
	.wbs_cyc_o	(wb8_m2s_gpio0_cyc),
	.wbs_stb_o	(wb8_m2s_gpio0_stb),
	.wbs_cti_o	(wb8_m2s_gpio0_cti),
	.wbs_bte_o	(wb8_m2s_gpio0_bte),
	.wbs_dat_i	(wb8_s2m_gpio0_dat),
	.wbs_ack_i	(wb8_s2m_gpio0_ack),
	.wbs_err_i	(wb8_s2m_gpio0_err),
	.wbs_rty_i	(wb8_s2m_gpio0_rty)
);
`endif //  `ifdef GPIO0

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign or1k_irq[0] = 0; // Non-maskable inside OR1K
assign or1k_irq[1] = 0; // Non-maskable inside OR1K
`ifdef UART0
assign or1k_irq[2] = uart0_irq;
`else
assign or1k_irq[2] = 0;
`endif
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
`ifdef SPI0
   assign or1k_irq[6] = spi0_irq;
`else
   assign or1k_irq[6] = 0;
`endif
`ifdef SPI1
   assign or1k_irq[7] = spi1_irq;
`else
   assign or1k_irq[7] = 0;
`endif
`ifdef SPI2
   assign or1k_irq[8] = spi1_irq;
`else
   assign or1k_irq[8] = 0;
`endif
assign or1k_irq[9] = 0;
`ifdef I2C0
   assign or1k_irq[10] = i2c0_irq;
`else
   assign or1k_irq[10] = 0;
`endif
`ifdef I2C1
   assign or1k_irq[11] = i2c1_irq;
`else
   assign or1k_irq[11] = 0;
`endif
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
`ifdef ACCELEROMETER
assign or1k_irq[24] = accelerometer_irq_i;
`else
assign or1k_irq[24] = 0;
`endif
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;

endmodule // orpsoc_top