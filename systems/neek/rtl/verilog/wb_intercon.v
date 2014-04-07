module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_eth0_master_adr_i,
    input  [31:0] wb_eth0_master_dat_i,
    input   [3:0] wb_eth0_master_sel_i,
    input         wb_eth0_master_we_i,
    input         wb_eth0_master_cyc_i,
    input         wb_eth0_master_stb_i,
    input   [2:0] wb_eth0_master_cti_i,
    input   [1:0] wb_eth0_master_bte_i,
    output [31:0] wb_eth0_master_dat_o,
    output        wb_eth0_master_ack_o,
    output        wb_eth0_master_err_o,
    output        wb_eth0_master_rty_o,
    input  [31:0] wb_vga0_master_adr_i,
    input  [31:0] wb_vga0_master_dat_i,
    input   [3:0] wb_vga0_master_sel_i,
    input         wb_vga0_master_we_i,
    input         wb_vga0_master_cyc_i,
    input         wb_vga0_master_stb_i,
    input   [2:0] wb_vga0_master_cti_i,
    input   [1:0] wb_vga0_master_bte_i,
    output [31:0] wb_vga0_master_dat_o,
    output        wb_vga0_master_ack_o,
    output        wb_vga0_master_err_o,
    output        wb_vga0_master_rty_o,
    input  [31:0] wb_dbg_adr_i,
    input  [31:0] wb_dbg_dat_i,
    input   [3:0] wb_dbg_sel_i,
    input         wb_dbg_we_i,
    input         wb_dbg_cyc_i,
    input         wb_dbg_stb_i,
    input   [2:0] wb_dbg_cti_i,
    input   [1:0] wb_dbg_bte_i,
    output [31:0] wb_dbg_dat_o,
    output        wb_dbg_ack_o,
    output        wb_dbg_err_o,
    output        wb_dbg_rty_o,
    input  [31:0] wb_or1k_i_adr_i,
    input  [31:0] wb_or1k_i_dat_i,
    input   [3:0] wb_or1k_i_sel_i,
    input         wb_or1k_i_we_i,
    input         wb_or1k_i_cyc_i,
    input         wb_or1k_i_stb_i,
    input   [2:0] wb_or1k_i_cti_i,
    input   [1:0] wb_or1k_i_bte_i,
    output [31:0] wb_or1k_i_dat_o,
    output        wb_or1k_i_ack_o,
    output        wb_or1k_i_err_o,
    output        wb_or1k_i_rty_o,
    input  [31:0] wb_or1k_d_adr_i,
    input  [31:0] wb_or1k_d_dat_i,
    input   [3:0] wb_or1k_d_sel_i,
    input         wb_or1k_d_we_i,
    input         wb_or1k_d_cyc_i,
    input         wb_or1k_d_stb_i,
    input   [2:0] wb_or1k_d_cti_i,
    input   [1:0] wb_or1k_d_bte_i,
    output [31:0] wb_or1k_d_dat_o,
    output        wb_or1k_d_ack_o,
    output        wb_or1k_d_err_o,
    output        wb_or1k_d_rty_o,
    output [31:0] wb_spi0_adr_o,
    output  [7:0] wb_spi0_dat_o,
    output  [3:0] wb_spi0_sel_o,
    output        wb_spi0_we_o,
    output        wb_spi0_cyc_o,
    output        wb_spi0_stb_o,
    output  [2:0] wb_spi0_cti_o,
    output  [1:0] wb_spi0_bte_o,
    input   [7:0] wb_spi0_dat_i,
    input         wb_spi0_ack_i,
    input         wb_spi0_err_i,
    input         wb_spi0_rty_i,
    output [31:0] wb_ddr_dbus_adr_o,
    output [31:0] wb_ddr_dbus_dat_o,
    output  [3:0] wb_ddr_dbus_sel_o,
    output        wb_ddr_dbus_we_o,
    output        wb_ddr_dbus_cyc_o,
    output        wb_ddr_dbus_stb_o,
    output  [2:0] wb_ddr_dbus_cti_o,
    output  [1:0] wb_ddr_dbus_bte_o,
    input  [31:0] wb_ddr_dbus_dat_i,
    input         wb_ddr_dbus_ack_i,
    input         wb_ddr_dbus_err_i,
    input         wb_ddr_dbus_rty_i,
    output [31:0] wb_rom0_adr_o,
    output [31:0] wb_rom0_dat_o,
    output  [3:0] wb_rom0_sel_o,
    output        wb_rom0_we_o,
    output        wb_rom0_cyc_o,
    output        wb_rom0_stb_o,
    output  [2:0] wb_rom0_cti_o,
    output  [1:0] wb_rom0_bte_o,
    input  [31:0] wb_rom0_dat_i,
    input         wb_rom0_ack_i,
    input         wb_rom0_err_i,
    input         wb_rom0_rty_i,
    output [31:0] wb_cfi0_adr_o,
    output [31:0] wb_cfi0_dat_o,
    output  [3:0] wb_cfi0_sel_o,
    output        wb_cfi0_we_o,
    output        wb_cfi0_cyc_o,
    output        wb_cfi0_stb_o,
    output  [2:0] wb_cfi0_cti_o,
    output  [1:0] wb_cfi0_bte_o,
    input  [31:0] wb_cfi0_dat_i,
    input         wb_cfi0_ack_i,
    input         wb_cfi0_err_i,
    input         wb_cfi0_rty_i,
    output [31:0] wb_ddr_vga_adr_o,
    output [31:0] wb_ddr_vga_dat_o,
    output  [3:0] wb_ddr_vga_sel_o,
    output        wb_ddr_vga_we_o,
    output        wb_ddr_vga_cyc_o,
    output        wb_ddr_vga_stb_o,
    output  [2:0] wb_ddr_vga_cti_o,
    output  [1:0] wb_ddr_vga_bte_o,
    input  [31:0] wb_ddr_vga_dat_i,
    input         wb_ddr_vga_ack_i,
    input         wb_ddr_vga_err_i,
    input         wb_ddr_vga_rty_i,
    output [31:0] wb_uart0_adr_o,
    output  [7:0] wb_uart0_dat_o,
    output  [3:0] wb_uart0_sel_o,
    output        wb_uart0_we_o,
    output        wb_uart0_cyc_o,
    output        wb_uart0_stb_o,
    output  [2:0] wb_uart0_cti_o,
    output  [1:0] wb_uart0_bte_o,
    input   [7:0] wb_uart0_dat_i,
    input         wb_uart0_ack_i,
    input         wb_uart0_err_i,
    input         wb_uart0_rty_i,
    output [31:0] wb_ddr_ibus_adr_o,
    output [31:0] wb_ddr_ibus_dat_o,
    output  [3:0] wb_ddr_ibus_sel_o,
    output        wb_ddr_ibus_we_o,
    output        wb_ddr_ibus_cyc_o,
    output        wb_ddr_ibus_stb_o,
    output  [2:0] wb_ddr_ibus_cti_o,
    output  [1:0] wb_ddr_ibus_bte_o,
    input  [31:0] wb_ddr_ibus_dat_i,
    input         wb_ddr_ibus_ack_i,
    input         wb_ddr_ibus_err_i,
    input         wb_ddr_ibus_rty_i,
    output [31:0] wb_ddr_eth_adr_o,
    output [31:0] wb_ddr_eth_dat_o,
    output  [3:0] wb_ddr_eth_sel_o,
    output        wb_ddr_eth_we_o,
    output        wb_ddr_eth_cyc_o,
    output        wb_ddr_eth_stb_o,
    output  [2:0] wb_ddr_eth_cti_o,
    output  [1:0] wb_ddr_eth_bte_o,
    input  [31:0] wb_ddr_eth_dat_i,
    input         wb_ddr_eth_ack_i,
    input         wb_ddr_eth_err_i,
    input         wb_ddr_eth_rty_i,
    output [31:0] wb_vga0_adr_o,
    output [31:0] wb_vga0_dat_o,
    output  [3:0] wb_vga0_sel_o,
    output        wb_vga0_we_o,
    output        wb_vga0_cyc_o,
    output        wb_vga0_stb_o,
    output  [2:0] wb_vga0_cti_o,
    output  [1:0] wb_vga0_bte_o,
    input  [31:0] wb_vga0_dat_i,
    input         wb_vga0_ack_i,
    input         wb_vga0_err_i,
    input         wb_vga0_rty_i,
    output [31:0] wb_eth0_adr_o,
    output [31:0] wb_eth0_dat_o,
    output  [3:0] wb_eth0_sel_o,
    output        wb_eth0_we_o,
    output        wb_eth0_cyc_o,
    output        wb_eth0_stb_o,
    output  [2:0] wb_eth0_cti_o,
    output  [1:0] wb_eth0_bte_o,
    input  [31:0] wb_eth0_dat_i,
    input         wb_eth0_ack_i,
    input         wb_eth0_err_i,
    input         wb_eth0_rty_i);

wire [31:0] wb_m2s_dbg_ddr_dbus_adr;
wire [31:0] wb_m2s_dbg_ddr_dbus_dat;
wire  [3:0] wb_m2s_dbg_ddr_dbus_sel;
wire        wb_m2s_dbg_ddr_dbus_we;
wire        wb_m2s_dbg_ddr_dbus_cyc;
wire        wb_m2s_dbg_ddr_dbus_stb;
wire  [2:0] wb_m2s_dbg_ddr_dbus_cti;
wire  [1:0] wb_m2s_dbg_ddr_dbus_bte;
wire [31:0] wb_s2m_dbg_ddr_dbus_dat;
wire        wb_s2m_dbg_ddr_dbus_ack;
wire        wb_s2m_dbg_ddr_dbus_err;
wire        wb_s2m_dbg_ddr_dbus_rty;
wire [31:0] wb_m2s_dbg_cfi0_adr;
wire [31:0] wb_m2s_dbg_cfi0_dat;
wire  [3:0] wb_m2s_dbg_cfi0_sel;
wire        wb_m2s_dbg_cfi0_we;
wire        wb_m2s_dbg_cfi0_cyc;
wire        wb_m2s_dbg_cfi0_stb;
wire  [2:0] wb_m2s_dbg_cfi0_cti;
wire  [1:0] wb_m2s_dbg_cfi0_bte;
wire [31:0] wb_s2m_dbg_cfi0_dat;
wire        wb_s2m_dbg_cfi0_ack;
wire        wb_s2m_dbg_cfi0_err;
wire        wb_s2m_dbg_cfi0_rty;
wire [31:0] wb_m2s_or1k_i_cfi0_adr;
wire [31:0] wb_m2s_or1k_i_cfi0_dat;
wire  [3:0] wb_m2s_or1k_i_cfi0_sel;
wire        wb_m2s_or1k_i_cfi0_we;
wire        wb_m2s_or1k_i_cfi0_cyc;
wire        wb_m2s_or1k_i_cfi0_stb;
wire  [2:0] wb_m2s_or1k_i_cfi0_cti;
wire  [1:0] wb_m2s_or1k_i_cfi0_bte;
wire [31:0] wb_s2m_or1k_i_cfi0_dat;
wire        wb_s2m_or1k_i_cfi0_ack;
wire        wb_s2m_or1k_i_cfi0_err;
wire        wb_s2m_or1k_i_cfi0_rty;
wire [31:0] wb_m2s_or1k_d_ddr_dbus_adr;
wire [31:0] wb_m2s_or1k_d_ddr_dbus_dat;
wire  [3:0] wb_m2s_or1k_d_ddr_dbus_sel;
wire        wb_m2s_or1k_d_ddr_dbus_we;
wire        wb_m2s_or1k_d_ddr_dbus_cyc;
wire        wb_m2s_or1k_d_ddr_dbus_stb;
wire  [2:0] wb_m2s_or1k_d_ddr_dbus_cti;
wire  [1:0] wb_m2s_or1k_d_ddr_dbus_bte;
wire [31:0] wb_s2m_or1k_d_ddr_dbus_dat;
wire        wb_s2m_or1k_d_ddr_dbus_ack;
wire        wb_s2m_or1k_d_ddr_dbus_err;
wire        wb_s2m_or1k_d_ddr_dbus_rty;
wire [31:0] wb_m2s_or1k_d_cfi0_adr;
wire [31:0] wb_m2s_or1k_d_cfi0_dat;
wire  [3:0] wb_m2s_or1k_d_cfi0_sel;
wire        wb_m2s_or1k_d_cfi0_we;
wire        wb_m2s_or1k_d_cfi0_cyc;
wire        wb_m2s_or1k_d_cfi0_stb;
wire  [2:0] wb_m2s_or1k_d_cfi0_cti;
wire  [1:0] wb_m2s_or1k_d_cfi0_bte;
wire [31:0] wb_s2m_or1k_d_cfi0_dat;
wire        wb_s2m_or1k_d_cfi0_ack;
wire        wb_s2m_or1k_d_cfi0_err;
wire        wb_s2m_or1k_d_cfi0_rty;
wire [31:0] wb_m2s_resize_spi0_adr;
wire [31:0] wb_m2s_resize_spi0_dat;
wire  [3:0] wb_m2s_resize_spi0_sel;
wire        wb_m2s_resize_spi0_we;
wire        wb_m2s_resize_spi0_cyc;
wire        wb_m2s_resize_spi0_stb;
wire  [2:0] wb_m2s_resize_spi0_cti;
wire  [1:0] wb_m2s_resize_spi0_bte;
wire [31:0] wb_s2m_resize_spi0_dat;
wire        wb_s2m_resize_spi0_ack;
wire        wb_s2m_resize_spi0_err;
wire        wb_s2m_resize_spi0_rty;
wire [31:0] wb_m2s_resize_uart0_adr;
wire [31:0] wb_m2s_resize_uart0_dat;
wire  [3:0] wb_m2s_resize_uart0_sel;
wire        wb_m2s_resize_uart0_we;
wire        wb_m2s_resize_uart0_cyc;
wire        wb_m2s_resize_uart0_stb;
wire  [2:0] wb_m2s_resize_uart0_cti;
wire  [1:0] wb_m2s_resize_uart0_bte;
wire [31:0] wb_s2m_resize_uart0_dat;
wire        wb_s2m_resize_uart0_ack;
wire        wb_s2m_resize_uart0_err;
wire        wb_s2m_resize_uart0_rty;

wb_mux
  #(.num_slaves (1),
    .MATCH_ADDR ({32'h00000000}),
    .MATCH_MASK ({32'hfe000000}))
 wb_mux_eth0_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_eth0_master_adr_i),
    .wbm_dat_i (wb_eth0_master_dat_i),
    .wbm_sel_i (wb_eth0_master_sel_i),
    .wbm_we_i  (wb_eth0_master_we_i),
    .wbm_cyc_i (wb_eth0_master_cyc_i),
    .wbm_stb_i (wb_eth0_master_stb_i),
    .wbm_cti_i (wb_eth0_master_cti_i),
    .wbm_bte_i (wb_eth0_master_bte_i),
    .wbm_dat_o (wb_eth0_master_dat_o),
    .wbm_ack_o (wb_eth0_master_ack_o),
    .wbm_err_o (wb_eth0_master_err_o),
    .wbm_rty_o (wb_eth0_master_rty_o),
    .wbs_adr_o ({wb_ddr_eth_adr_o}),
    .wbs_dat_o ({wb_ddr_eth_dat_o}),
    .wbs_sel_o ({wb_ddr_eth_sel_o}),
    .wbs_we_o  ({wb_ddr_eth_we_o}),
    .wbs_cyc_o ({wb_ddr_eth_cyc_o}),
    .wbs_stb_o ({wb_ddr_eth_stb_o}),
    .wbs_cti_o ({wb_ddr_eth_cti_o}),
    .wbs_bte_o ({wb_ddr_eth_bte_o}),
    .wbs_dat_i ({wb_ddr_eth_dat_i}),
    .wbs_ack_i ({wb_ddr_eth_ack_i}),
    .wbs_err_i ({wb_ddr_eth_err_i}),
    .wbs_rty_i ({wb_ddr_eth_rty_i}));

wb_mux
  #(.num_slaves (1),
    .MATCH_ADDR ({32'h00000000}),
    .MATCH_MASK ({32'hfe000000}))
 wb_mux_vga0_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_vga0_master_adr_i),
    .wbm_dat_i (wb_vga0_master_dat_i),
    .wbm_sel_i (wb_vga0_master_sel_i),
    .wbm_we_i  (wb_vga0_master_we_i),
    .wbm_cyc_i (wb_vga0_master_cyc_i),
    .wbm_stb_i (wb_vga0_master_stb_i),
    .wbm_cti_i (wb_vga0_master_cti_i),
    .wbm_bte_i (wb_vga0_master_bte_i),
    .wbm_dat_o (wb_vga0_master_dat_o),
    .wbm_ack_o (wb_vga0_master_ack_o),
    .wbm_err_o (wb_vga0_master_err_o),
    .wbm_rty_o (wb_vga0_master_rty_o),
    .wbs_adr_o ({wb_ddr_vga_adr_o}),
    .wbs_dat_o ({wb_ddr_vga_dat_o}),
    .wbs_sel_o ({wb_ddr_vga_sel_o}),
    .wbs_we_o  ({wb_ddr_vga_we_o}),
    .wbs_cyc_o ({wb_ddr_vga_cyc_o}),
    .wbs_stb_o ({wb_ddr_vga_stb_o}),
    .wbs_cti_o ({wb_ddr_vga_cti_o}),
    .wbs_bte_o ({wb_ddr_vga_bte_o}),
    .wbs_dat_i ({wb_ddr_vga_dat_i}),
    .wbs_ack_i ({wb_ddr_vga_ack_i}),
    .wbs_err_i ({wb_ddr_vga_err_i}),
    .wbs_rty_i ({wb_ddr_vga_rty_i}));

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h00000000, 32'h93000000}),
    .MATCH_MASK ({32'hfe000000, 32'hff000000}))
 wb_mux_dbg
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_dbg_adr_i),
    .wbm_dat_i (wb_dbg_dat_i),
    .wbm_sel_i (wb_dbg_sel_i),
    .wbm_we_i  (wb_dbg_we_i),
    .wbm_cyc_i (wb_dbg_cyc_i),
    .wbm_stb_i (wb_dbg_stb_i),
    .wbm_cti_i (wb_dbg_cti_i),
    .wbm_bte_i (wb_dbg_bte_i),
    .wbm_dat_o (wb_dbg_dat_o),
    .wbm_ack_o (wb_dbg_ack_o),
    .wbm_err_o (wb_dbg_err_o),
    .wbm_rty_o (wb_dbg_rty_o),
    .wbs_adr_o ({wb_m2s_dbg_ddr_dbus_adr, wb_m2s_dbg_cfi0_adr}),
    .wbs_dat_o ({wb_m2s_dbg_ddr_dbus_dat, wb_m2s_dbg_cfi0_dat}),
    .wbs_sel_o ({wb_m2s_dbg_ddr_dbus_sel, wb_m2s_dbg_cfi0_sel}),
    .wbs_we_o  ({wb_m2s_dbg_ddr_dbus_we, wb_m2s_dbg_cfi0_we}),
    .wbs_cyc_o ({wb_m2s_dbg_ddr_dbus_cyc, wb_m2s_dbg_cfi0_cyc}),
    .wbs_stb_o ({wb_m2s_dbg_ddr_dbus_stb, wb_m2s_dbg_cfi0_stb}),
    .wbs_cti_o ({wb_m2s_dbg_ddr_dbus_cti, wb_m2s_dbg_cfi0_cti}),
    .wbs_bte_o ({wb_m2s_dbg_ddr_dbus_bte, wb_m2s_dbg_cfi0_bte}),
    .wbs_dat_i ({wb_s2m_dbg_ddr_dbus_dat, wb_s2m_dbg_cfi0_dat}),
    .wbs_ack_i ({wb_s2m_dbg_ddr_dbus_ack, wb_s2m_dbg_cfi0_ack}),
    .wbs_err_i ({wb_s2m_dbg_ddr_dbus_err, wb_s2m_dbg_cfi0_err}),
    .wbs_rty_i ({wb_s2m_dbg_ddr_dbus_rty, wb_s2m_dbg_cfi0_rty}));

wb_mux
  #(.num_slaves (3),
    .MATCH_ADDR ({32'h00000000, 32'hf0000100, 32'h93000000}),
    .MATCH_MASK ({32'hfe000000, 32'hffffffc0, 32'hff000000}))
 wb_mux_or1k_i
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k_i_adr_i),
    .wbm_dat_i (wb_or1k_i_dat_i),
    .wbm_sel_i (wb_or1k_i_sel_i),
    .wbm_we_i  (wb_or1k_i_we_i),
    .wbm_cyc_i (wb_or1k_i_cyc_i),
    .wbm_stb_i (wb_or1k_i_stb_i),
    .wbm_cti_i (wb_or1k_i_cti_i),
    .wbm_bte_i (wb_or1k_i_bte_i),
    .wbm_dat_o (wb_or1k_i_dat_o),
    .wbm_ack_o (wb_or1k_i_ack_o),
    .wbm_err_o (wb_or1k_i_err_o),
    .wbm_rty_o (wb_or1k_i_rty_o),
    .wbs_adr_o ({wb_ddr_ibus_adr_o, wb_rom0_adr_o, wb_m2s_or1k_i_cfi0_adr}),
    .wbs_dat_o ({wb_ddr_ibus_dat_o, wb_rom0_dat_o, wb_m2s_or1k_i_cfi0_dat}),
    .wbs_sel_o ({wb_ddr_ibus_sel_o, wb_rom0_sel_o, wb_m2s_or1k_i_cfi0_sel}),
    .wbs_we_o  ({wb_ddr_ibus_we_o, wb_rom0_we_o, wb_m2s_or1k_i_cfi0_we}),
    .wbs_cyc_o ({wb_ddr_ibus_cyc_o, wb_rom0_cyc_o, wb_m2s_or1k_i_cfi0_cyc}),
    .wbs_stb_o ({wb_ddr_ibus_stb_o, wb_rom0_stb_o, wb_m2s_or1k_i_cfi0_stb}),
    .wbs_cti_o ({wb_ddr_ibus_cti_o, wb_rom0_cti_o, wb_m2s_or1k_i_cfi0_cti}),
    .wbs_bte_o ({wb_ddr_ibus_bte_o, wb_rom0_bte_o, wb_m2s_or1k_i_cfi0_bte}),
    .wbs_dat_i ({wb_ddr_ibus_dat_i, wb_rom0_dat_i, wb_s2m_or1k_i_cfi0_dat}),
    .wbs_ack_i ({wb_ddr_ibus_ack_i, wb_rom0_ack_i, wb_s2m_or1k_i_cfi0_ack}),
    .wbs_err_i ({wb_ddr_ibus_err_i, wb_rom0_err_i, wb_s2m_or1k_i_cfi0_err}),
    .wbs_rty_i ({wb_ddr_ibus_rty_i, wb_rom0_rty_i, wb_s2m_or1k_i_cfi0_rty}));

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h00000000, 32'h90000000, 32'h97000000, 32'h92000000, 32'hb0000000, 32'h93000000}),
    .MATCH_MASK ({32'hfe000000, 32'hffffffe0, 32'hfffff000, 32'hffff0000, 32'hfffffff8, 32'hff000000}))
 wb_mux_or1k_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k_d_adr_i),
    .wbm_dat_i (wb_or1k_d_dat_i),
    .wbm_sel_i (wb_or1k_d_sel_i),
    .wbm_we_i  (wb_or1k_d_we_i),
    .wbm_cyc_i (wb_or1k_d_cyc_i),
    .wbm_stb_i (wb_or1k_d_stb_i),
    .wbm_cti_i (wb_or1k_d_cti_i),
    .wbm_bte_i (wb_or1k_d_bte_i),
    .wbm_dat_o (wb_or1k_d_dat_o),
    .wbm_ack_o (wb_or1k_d_ack_o),
    .wbm_err_o (wb_or1k_d_err_o),
    .wbm_rty_o (wb_or1k_d_rty_o),
    .wbs_adr_o ({wb_m2s_or1k_d_ddr_dbus_adr, wb_m2s_resize_uart0_adr, wb_vga0_adr_o, wb_eth0_adr_o, wb_m2s_resize_spi0_adr, wb_m2s_or1k_d_cfi0_adr}),
    .wbs_dat_o ({wb_m2s_or1k_d_ddr_dbus_dat, wb_m2s_resize_uart0_dat, wb_vga0_dat_o, wb_eth0_dat_o, wb_m2s_resize_spi0_dat, wb_m2s_or1k_d_cfi0_dat}),
    .wbs_sel_o ({wb_m2s_or1k_d_ddr_dbus_sel, wb_m2s_resize_uart0_sel, wb_vga0_sel_o, wb_eth0_sel_o, wb_m2s_resize_spi0_sel, wb_m2s_or1k_d_cfi0_sel}),
    .wbs_we_o  ({wb_m2s_or1k_d_ddr_dbus_we, wb_m2s_resize_uart0_we, wb_vga0_we_o, wb_eth0_we_o, wb_m2s_resize_spi0_we, wb_m2s_or1k_d_cfi0_we}),
    .wbs_cyc_o ({wb_m2s_or1k_d_ddr_dbus_cyc, wb_m2s_resize_uart0_cyc, wb_vga0_cyc_o, wb_eth0_cyc_o, wb_m2s_resize_spi0_cyc, wb_m2s_or1k_d_cfi0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k_d_ddr_dbus_stb, wb_m2s_resize_uart0_stb, wb_vga0_stb_o, wb_eth0_stb_o, wb_m2s_resize_spi0_stb, wb_m2s_or1k_d_cfi0_stb}),
    .wbs_cti_o ({wb_m2s_or1k_d_ddr_dbus_cti, wb_m2s_resize_uart0_cti, wb_vga0_cti_o, wb_eth0_cti_o, wb_m2s_resize_spi0_cti, wb_m2s_or1k_d_cfi0_cti}),
    .wbs_bte_o ({wb_m2s_or1k_d_ddr_dbus_bte, wb_m2s_resize_uart0_bte, wb_vga0_bte_o, wb_eth0_bte_o, wb_m2s_resize_spi0_bte, wb_m2s_or1k_d_cfi0_bte}),
    .wbs_dat_i ({wb_s2m_or1k_d_ddr_dbus_dat, wb_s2m_resize_uart0_dat, wb_vga0_dat_i, wb_eth0_dat_i, wb_s2m_resize_spi0_dat, wb_s2m_or1k_d_cfi0_dat}),
    .wbs_ack_i ({wb_s2m_or1k_d_ddr_dbus_ack, wb_s2m_resize_uart0_ack, wb_vga0_ack_i, wb_eth0_ack_i, wb_s2m_resize_spi0_ack, wb_s2m_or1k_d_cfi0_ack}),
    .wbs_err_i ({wb_s2m_or1k_d_ddr_dbus_err, wb_s2m_resize_uart0_err, wb_vga0_err_i, wb_eth0_err_i, wb_s2m_resize_spi0_err, wb_s2m_or1k_d_cfi0_err}),
    .wbs_rty_i ({wb_s2m_or1k_d_ddr_dbus_rty, wb_s2m_resize_uart0_rty, wb_vga0_rty_i, wb_eth0_rty_i, wb_s2m_resize_spi0_rty, wb_s2m_or1k_d_cfi0_rty}));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_spi0
   (.wbm_adr_i (wb_m2s_resize_spi0_adr),
    .wbm_dat_i (wb_m2s_resize_spi0_dat),
    .wbm_sel_i (wb_m2s_resize_spi0_sel),
    .wbm_we_i  (wb_m2s_resize_spi0_we),
    .wbm_cyc_i (wb_m2s_resize_spi0_cyc),
    .wbm_stb_i (wb_m2s_resize_spi0_stb),
    .wbm_cti_i (wb_m2s_resize_spi0_cti),
    .wbm_bte_i (wb_m2s_resize_spi0_bte),
    .wbm_dat_o (wb_s2m_resize_spi0_dat),
    .wbm_ack_o (wb_s2m_resize_spi0_ack),
    .wbm_err_o (wb_s2m_resize_spi0_err),
    .wbm_rty_o (wb_s2m_resize_spi0_rty),
    .wbs_adr_o (wb_spi0_adr_o),
    .wbs_dat_o (wb_spi0_dat_o),
    .wbs_we_o  (wb_spi0_we_o),
    .wbs_cyc_o (wb_spi0_cyc_o),
    .wbs_stb_o (wb_spi0_stb_o),
    .wbs_cti_o (wb_spi0_cti_o),
    .wbs_bte_o (wb_spi0_bte_o),
    .wbs_dat_i (wb_spi0_dat_i),
    .wbs_ack_i (wb_spi0_ack_i),
    .wbs_err_i (wb_spi0_err_i),
    .wbs_rty_i (wb_spi0_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_ddr_dbus
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_ddr_dbus_adr, wb_m2s_dbg_ddr_dbus_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_ddr_dbus_dat, wb_m2s_dbg_ddr_dbus_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_ddr_dbus_sel, wb_m2s_dbg_ddr_dbus_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_ddr_dbus_we, wb_m2s_dbg_ddr_dbus_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_ddr_dbus_cyc, wb_m2s_dbg_ddr_dbus_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_ddr_dbus_stb, wb_m2s_dbg_ddr_dbus_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_ddr_dbus_cti, wb_m2s_dbg_ddr_dbus_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_ddr_dbus_bte, wb_m2s_dbg_ddr_dbus_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_ddr_dbus_dat, wb_s2m_dbg_ddr_dbus_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_ddr_dbus_ack, wb_s2m_dbg_ddr_dbus_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_ddr_dbus_err, wb_s2m_dbg_ddr_dbus_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_ddr_dbus_rty, wb_s2m_dbg_ddr_dbus_rty}),
    .wbs_adr_o (wb_ddr_dbus_adr_o),
    .wbs_dat_o (wb_ddr_dbus_dat_o),
    .wbs_sel_o (wb_ddr_dbus_sel_o),
    .wbs_we_o  (wb_ddr_dbus_we_o),
    .wbs_cyc_o (wb_ddr_dbus_cyc_o),
    .wbs_stb_o (wb_ddr_dbus_stb_o),
    .wbs_cti_o (wb_ddr_dbus_cti_o),
    .wbs_bte_o (wb_ddr_dbus_bte_o),
    .wbs_dat_i (wb_ddr_dbus_dat_i),
    .wbs_ack_i (wb_ddr_dbus_ack_i),
    .wbs_err_i (wb_ddr_dbus_err_i),
    .wbs_rty_i (wb_ddr_dbus_rty_i));

wb_arbiter
  #(.num_masters (3))
 wb_arbiter_cfi0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_i_cfi0_adr, wb_m2s_or1k_d_cfi0_adr, wb_m2s_dbg_cfi0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_i_cfi0_dat, wb_m2s_or1k_d_cfi0_dat, wb_m2s_dbg_cfi0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_i_cfi0_sel, wb_m2s_or1k_d_cfi0_sel, wb_m2s_dbg_cfi0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_i_cfi0_we, wb_m2s_or1k_d_cfi0_we, wb_m2s_dbg_cfi0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_i_cfi0_cyc, wb_m2s_or1k_d_cfi0_cyc, wb_m2s_dbg_cfi0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_i_cfi0_stb, wb_m2s_or1k_d_cfi0_stb, wb_m2s_dbg_cfi0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_i_cfi0_cti, wb_m2s_or1k_d_cfi0_cti, wb_m2s_dbg_cfi0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_i_cfi0_bte, wb_m2s_or1k_d_cfi0_bte, wb_m2s_dbg_cfi0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_i_cfi0_dat, wb_s2m_or1k_d_cfi0_dat, wb_s2m_dbg_cfi0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_i_cfi0_ack, wb_s2m_or1k_d_cfi0_ack, wb_s2m_dbg_cfi0_ack}),
    .wbm_err_o ({wb_s2m_or1k_i_cfi0_err, wb_s2m_or1k_d_cfi0_err, wb_s2m_dbg_cfi0_err}),
    .wbm_rty_o ({wb_s2m_or1k_i_cfi0_rty, wb_s2m_or1k_d_cfi0_rty, wb_s2m_dbg_cfi0_rty}),
    .wbs_adr_o (wb_cfi0_adr_o),
    .wbs_dat_o (wb_cfi0_dat_o),
    .wbs_sel_o (wb_cfi0_sel_o),
    .wbs_we_o  (wb_cfi0_we_o),
    .wbs_cyc_o (wb_cfi0_cyc_o),
    .wbs_stb_o (wb_cfi0_stb_o),
    .wbs_cti_o (wb_cfi0_cti_o),
    .wbs_bte_o (wb_cfi0_bte_o),
    .wbs_dat_i (wb_cfi0_dat_i),
    .wbs_ack_i (wb_cfi0_ack_i),
    .wbs_err_i (wb_cfi0_err_i),
    .wbs_rty_i (wb_cfi0_rty_i));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_uart0
   (.wbm_adr_i (wb_m2s_resize_uart0_adr),
    .wbm_dat_i (wb_m2s_resize_uart0_dat),
    .wbm_sel_i (wb_m2s_resize_uart0_sel),
    .wbm_we_i  (wb_m2s_resize_uart0_we),
    .wbm_cyc_i (wb_m2s_resize_uart0_cyc),
    .wbm_stb_i (wb_m2s_resize_uart0_stb),
    .wbm_cti_i (wb_m2s_resize_uart0_cti),
    .wbm_bte_i (wb_m2s_resize_uart0_bte),
    .wbm_dat_o (wb_s2m_resize_uart0_dat),
    .wbm_ack_o (wb_s2m_resize_uart0_ack),
    .wbm_err_o (wb_s2m_resize_uart0_err),
    .wbm_rty_o (wb_s2m_resize_uart0_rty),
    .wbs_adr_o (wb_uart0_adr_o),
    .wbs_dat_o (wb_uart0_dat_o),
    .wbs_we_o  (wb_uart0_we_o),
    .wbs_cyc_o (wb_uart0_cyc_o),
    .wbs_stb_o (wb_uart0_stb_o),
    .wbs_cti_o (wb_uart0_cti_o),
    .wbs_bte_o (wb_uart0_bte_o),
    .wbs_dat_i (wb_uart0_dat_i),
    .wbs_ack_i (wb_uart0_ack_i),
    .wbs_err_i (wb_uart0_err_i),
    .wbs_rty_i (wb_uart0_rty_i));

endmodule
