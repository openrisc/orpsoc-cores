module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
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
    output [31:0] wb_sdram_dbus_adr_o,
    output [31:0] wb_sdram_dbus_dat_o,
    output  [3:0] wb_sdram_dbus_sel_o,
    output        wb_sdram_dbus_we_o,
    output        wb_sdram_dbus_cyc_o,
    output        wb_sdram_dbus_stb_o,
    output  [2:0] wb_sdram_dbus_cti_o,
    output  [1:0] wb_sdram_dbus_bte_o,
    input  [31:0] wb_sdram_dbus_dat_i,
    input         wb_sdram_dbus_ack_i,
    input         wb_sdram_dbus_err_i,
    input         wb_sdram_dbus_rty_i,
    output [31:0] wb_gpio0_adr_o,
    output  [7:0] wb_gpio0_dat_o,
    output  [3:0] wb_gpio0_sel_o,
    output        wb_gpio0_we_o,
    output        wb_gpio0_cyc_o,
    output        wb_gpio0_stb_o,
    output  [2:0] wb_gpio0_cti_o,
    output  [1:0] wb_gpio0_bte_o,
    input   [7:0] wb_gpio0_dat_i,
    input         wb_gpio0_ack_i,
    input         wb_gpio0_err_i,
    input         wb_gpio0_rty_i,
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
    output [31:0] wb_sdram_ibus_adr_o,
    output [31:0] wb_sdram_ibus_dat_o,
    output  [3:0] wb_sdram_ibus_sel_o,
    output        wb_sdram_ibus_we_o,
    output        wb_sdram_ibus_cyc_o,
    output        wb_sdram_ibus_stb_o,
    output  [2:0] wb_sdram_ibus_cti_o,
    output  [1:0] wb_sdram_ibus_bte_o,
    input  [31:0] wb_sdram_ibus_dat_i,
    input         wb_sdram_ibus_ack_i,
    input         wb_sdram_ibus_err_i,
    input         wb_sdram_ibus_rty_i);

wire [31:0] wb_m2s_dbg_sdram_dbus_adr;
wire [31:0] wb_m2s_dbg_sdram_dbus_dat;
wire  [3:0] wb_m2s_dbg_sdram_dbus_sel;
wire        wb_m2s_dbg_sdram_dbus_we;
wire        wb_m2s_dbg_sdram_dbus_cyc;
wire        wb_m2s_dbg_sdram_dbus_stb;
wire  [2:0] wb_m2s_dbg_sdram_dbus_cti;
wire  [1:0] wb_m2s_dbg_sdram_dbus_bte;
wire [31:0] wb_s2m_dbg_sdram_dbus_dat;
wire        wb_s2m_dbg_sdram_dbus_ack;
wire        wb_s2m_dbg_sdram_dbus_err;
wire        wb_s2m_dbg_sdram_dbus_rty;
wire [31:0] wb_m2s_dbg_uart0_adr;
wire [31:0] wb_m2s_dbg_uart0_dat;
wire  [3:0] wb_m2s_dbg_uart0_sel;
wire        wb_m2s_dbg_uart0_we;
wire        wb_m2s_dbg_uart0_cyc;
wire        wb_m2s_dbg_uart0_stb;
wire  [2:0] wb_m2s_dbg_uart0_cti;
wire  [1:0] wb_m2s_dbg_uart0_bte;
wire [31:0] wb_s2m_dbg_uart0_dat;
wire        wb_s2m_dbg_uart0_ack;
wire        wb_s2m_dbg_uart0_err;
wire        wb_s2m_dbg_uart0_rty;
wire [31:0] wb_m2s_dbg_gpio0_adr;
wire [31:0] wb_m2s_dbg_gpio0_dat;
wire  [3:0] wb_m2s_dbg_gpio0_sel;
wire        wb_m2s_dbg_gpio0_we;
wire        wb_m2s_dbg_gpio0_cyc;
wire        wb_m2s_dbg_gpio0_stb;
wire  [2:0] wb_m2s_dbg_gpio0_cti;
wire  [1:0] wb_m2s_dbg_gpio0_bte;
wire [31:0] wb_s2m_dbg_gpio0_dat;
wire        wb_s2m_dbg_gpio0_ack;
wire        wb_s2m_dbg_gpio0_err;
wire        wb_s2m_dbg_gpio0_rty;
wire [31:0] wb_m2s_or1k_d_sdram_dbus_adr;
wire [31:0] wb_m2s_or1k_d_sdram_dbus_dat;
wire  [3:0] wb_m2s_or1k_d_sdram_dbus_sel;
wire        wb_m2s_or1k_d_sdram_dbus_we;
wire        wb_m2s_or1k_d_sdram_dbus_cyc;
wire        wb_m2s_or1k_d_sdram_dbus_stb;
wire  [2:0] wb_m2s_or1k_d_sdram_dbus_cti;
wire  [1:0] wb_m2s_or1k_d_sdram_dbus_bte;
wire [31:0] wb_s2m_or1k_d_sdram_dbus_dat;
wire        wb_s2m_or1k_d_sdram_dbus_ack;
wire        wb_s2m_or1k_d_sdram_dbus_err;
wire        wb_s2m_or1k_d_sdram_dbus_rty;
wire [31:0] wb_m2s_or1k_d_uart0_adr;
wire [31:0] wb_m2s_or1k_d_uart0_dat;
wire  [3:0] wb_m2s_or1k_d_uart0_sel;
wire        wb_m2s_or1k_d_uart0_we;
wire        wb_m2s_or1k_d_uart0_cyc;
wire        wb_m2s_or1k_d_uart0_stb;
wire  [2:0] wb_m2s_or1k_d_uart0_cti;
wire  [1:0] wb_m2s_or1k_d_uart0_bte;
wire [31:0] wb_s2m_or1k_d_uart0_dat;
wire        wb_s2m_or1k_d_uart0_ack;
wire        wb_s2m_or1k_d_uart0_err;
wire        wb_s2m_or1k_d_uart0_rty;
wire [31:0] wb_m2s_or1k_d_gpio0_adr;
wire [31:0] wb_m2s_or1k_d_gpio0_dat;
wire  [3:0] wb_m2s_or1k_d_gpio0_sel;
wire        wb_m2s_or1k_d_gpio0_we;
wire        wb_m2s_or1k_d_gpio0_cyc;
wire        wb_m2s_or1k_d_gpio0_stb;
wire  [2:0] wb_m2s_or1k_d_gpio0_cti;
wire  [1:0] wb_m2s_or1k_d_gpio0_bte;
wire [31:0] wb_s2m_or1k_d_gpio0_dat;
wire        wb_s2m_or1k_d_gpio0_ack;
wire        wb_s2m_or1k_d_gpio0_err;
wire        wb_s2m_or1k_d_gpio0_rty;
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
wire [31:0] wb_m2s_resize_gpio0_adr;
wire [31:0] wb_m2s_resize_gpio0_dat;
wire  [3:0] wb_m2s_resize_gpio0_sel;
wire        wb_m2s_resize_gpio0_we;
wire        wb_m2s_resize_gpio0_cyc;
wire        wb_m2s_resize_gpio0_stb;
wire  [2:0] wb_m2s_resize_gpio0_cti;
wire  [1:0] wb_m2s_resize_gpio0_bte;
wire [31:0] wb_s2m_resize_gpio0_dat;
wire        wb_s2m_resize_gpio0_ack;
wire        wb_s2m_resize_gpio0_err;
wire        wb_s2m_resize_gpio0_rty;

wb_mux
  #(.num_slaves (3),
    .MATCH_ADDR ({32'h00000000, 32'h90000000, 32'h91000000}),
    .MATCH_MASK ({32'hfe000000, 32'hffffffe0, 32'hfffffffe}))
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
    .wbs_adr_o ({wb_m2s_dbg_sdram_dbus_adr, wb_m2s_dbg_uart0_adr, wb_m2s_dbg_gpio0_adr}),
    .wbs_dat_o ({wb_m2s_dbg_sdram_dbus_dat, wb_m2s_dbg_uart0_dat, wb_m2s_dbg_gpio0_dat}),
    .wbs_sel_o ({wb_m2s_dbg_sdram_dbus_sel, wb_m2s_dbg_uart0_sel, wb_m2s_dbg_gpio0_sel}),
    .wbs_we_o  ({wb_m2s_dbg_sdram_dbus_we, wb_m2s_dbg_uart0_we, wb_m2s_dbg_gpio0_we}),
    .wbs_cyc_o ({wb_m2s_dbg_sdram_dbus_cyc, wb_m2s_dbg_uart0_cyc, wb_m2s_dbg_gpio0_cyc}),
    .wbs_stb_o ({wb_m2s_dbg_sdram_dbus_stb, wb_m2s_dbg_uart0_stb, wb_m2s_dbg_gpio0_stb}),
    .wbs_cti_o ({wb_m2s_dbg_sdram_dbus_cti, wb_m2s_dbg_uart0_cti, wb_m2s_dbg_gpio0_cti}),
    .wbs_bte_o ({wb_m2s_dbg_sdram_dbus_bte, wb_m2s_dbg_uart0_bte, wb_m2s_dbg_gpio0_bte}),
    .wbs_dat_i ({wb_s2m_dbg_sdram_dbus_dat, wb_s2m_dbg_uart0_dat, wb_s2m_dbg_gpio0_dat}),
    .wbs_ack_i ({wb_s2m_dbg_sdram_dbus_ack, wb_s2m_dbg_uart0_ack, wb_s2m_dbg_gpio0_ack}),
    .wbs_err_i ({wb_s2m_dbg_sdram_dbus_err, wb_s2m_dbg_uart0_err, wb_s2m_dbg_gpio0_err}),
    .wbs_rty_i ({wb_s2m_dbg_sdram_dbus_rty, wb_s2m_dbg_uart0_rty, wb_s2m_dbg_gpio0_rty}));

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h00000000, 32'hf0000100}),
    .MATCH_MASK ({32'hfe000000, 32'hffffffc0}))
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
    .wbs_adr_o ({wb_sdram_ibus_adr_o, wb_rom0_adr_o}),
    .wbs_dat_o ({wb_sdram_ibus_dat_o, wb_rom0_dat_o}),
    .wbs_sel_o ({wb_sdram_ibus_sel_o, wb_rom0_sel_o}),
    .wbs_we_o  ({wb_sdram_ibus_we_o, wb_rom0_we_o}),
    .wbs_cyc_o ({wb_sdram_ibus_cyc_o, wb_rom0_cyc_o}),
    .wbs_stb_o ({wb_sdram_ibus_stb_o, wb_rom0_stb_o}),
    .wbs_cti_o ({wb_sdram_ibus_cti_o, wb_rom0_cti_o}),
    .wbs_bte_o ({wb_sdram_ibus_bte_o, wb_rom0_bte_o}),
    .wbs_dat_i ({wb_sdram_ibus_dat_i, wb_rom0_dat_i}),
    .wbs_ack_i ({wb_sdram_ibus_ack_i, wb_rom0_ack_i}),
    .wbs_err_i ({wb_sdram_ibus_err_i, wb_rom0_err_i}),
    .wbs_rty_i ({wb_sdram_ibus_rty_i, wb_rom0_rty_i}));

wb_mux
  #(.num_slaves (3),
    .MATCH_ADDR ({32'h00000000, 32'h90000000, 32'h91000000}),
    .MATCH_MASK ({32'hfe000000, 32'hffffffe0, 32'hfffffffe}))
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
    .wbs_adr_o ({wb_m2s_or1k_d_sdram_dbus_adr, wb_m2s_or1k_d_uart0_adr, wb_m2s_or1k_d_gpio0_adr}),
    .wbs_dat_o ({wb_m2s_or1k_d_sdram_dbus_dat, wb_m2s_or1k_d_uart0_dat, wb_m2s_or1k_d_gpio0_dat}),
    .wbs_sel_o ({wb_m2s_or1k_d_sdram_dbus_sel, wb_m2s_or1k_d_uart0_sel, wb_m2s_or1k_d_gpio0_sel}),
    .wbs_we_o  ({wb_m2s_or1k_d_sdram_dbus_we, wb_m2s_or1k_d_uart0_we, wb_m2s_or1k_d_gpio0_we}),
    .wbs_cyc_o ({wb_m2s_or1k_d_sdram_dbus_cyc, wb_m2s_or1k_d_uart0_cyc, wb_m2s_or1k_d_gpio0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k_d_sdram_dbus_stb, wb_m2s_or1k_d_uart0_stb, wb_m2s_or1k_d_gpio0_stb}),
    .wbs_cti_o ({wb_m2s_or1k_d_sdram_dbus_cti, wb_m2s_or1k_d_uart0_cti, wb_m2s_or1k_d_gpio0_cti}),
    .wbs_bte_o ({wb_m2s_or1k_d_sdram_dbus_bte, wb_m2s_or1k_d_uart0_bte, wb_m2s_or1k_d_gpio0_bte}),
    .wbs_dat_i ({wb_s2m_or1k_d_sdram_dbus_dat, wb_s2m_or1k_d_uart0_dat, wb_s2m_or1k_d_gpio0_dat}),
    .wbs_ack_i ({wb_s2m_or1k_d_sdram_dbus_ack, wb_s2m_or1k_d_uart0_ack, wb_s2m_or1k_d_gpio0_ack}),
    .wbs_err_i ({wb_s2m_or1k_d_sdram_dbus_err, wb_s2m_or1k_d_uart0_err, wb_s2m_or1k_d_gpio0_err}),
    .wbs_rty_i ({wb_s2m_or1k_d_sdram_dbus_rty, wb_s2m_or1k_d_uart0_rty, wb_s2m_or1k_d_gpio0_rty}));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_uart0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_uart0_adr, wb_m2s_dbg_uart0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_uart0_dat, wb_m2s_dbg_uart0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_uart0_sel, wb_m2s_dbg_uart0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_uart0_we, wb_m2s_dbg_uart0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_uart0_cyc, wb_m2s_dbg_uart0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_uart0_stb, wb_m2s_dbg_uart0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_uart0_cti, wb_m2s_dbg_uart0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_uart0_bte, wb_m2s_dbg_uart0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_uart0_dat, wb_s2m_dbg_uart0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_uart0_ack, wb_s2m_dbg_uart0_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_uart0_err, wb_s2m_dbg_uart0_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_uart0_rty, wb_s2m_dbg_uart0_rty}),
    .wbs_adr_o (wb_m2s_resize_uart0_adr),
    .wbs_dat_o (wb_m2s_resize_uart0_dat),
    .wbs_sel_o (wb_m2s_resize_uart0_sel),
    .wbs_we_o  (wb_m2s_resize_uart0_we),
    .wbs_cyc_o (wb_m2s_resize_uart0_cyc),
    .wbs_stb_o (wb_m2s_resize_uart0_stb),
    .wbs_cti_o (wb_m2s_resize_uart0_cti),
    .wbs_bte_o (wb_m2s_resize_uart0_bte),
    .wbs_dat_i (wb_s2m_resize_uart0_dat),
    .wbs_ack_i (wb_s2m_resize_uart0_ack),
    .wbs_err_i (wb_s2m_resize_uart0_err),
    .wbs_rty_i (wb_s2m_resize_uart0_rty));

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

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_sdram_dbus
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_sdram_dbus_adr, wb_m2s_dbg_sdram_dbus_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_sdram_dbus_dat, wb_m2s_dbg_sdram_dbus_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_sdram_dbus_sel, wb_m2s_dbg_sdram_dbus_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_sdram_dbus_we, wb_m2s_dbg_sdram_dbus_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_sdram_dbus_cyc, wb_m2s_dbg_sdram_dbus_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_sdram_dbus_stb, wb_m2s_dbg_sdram_dbus_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_sdram_dbus_cti, wb_m2s_dbg_sdram_dbus_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_sdram_dbus_bte, wb_m2s_dbg_sdram_dbus_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_sdram_dbus_dat, wb_s2m_dbg_sdram_dbus_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_sdram_dbus_ack, wb_s2m_dbg_sdram_dbus_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_sdram_dbus_err, wb_s2m_dbg_sdram_dbus_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_sdram_dbus_rty, wb_s2m_dbg_sdram_dbus_rty}),
    .wbs_adr_o (wb_sdram_dbus_adr_o),
    .wbs_dat_o (wb_sdram_dbus_dat_o),
    .wbs_sel_o (wb_sdram_dbus_sel_o),
    .wbs_we_o  (wb_sdram_dbus_we_o),
    .wbs_cyc_o (wb_sdram_dbus_cyc_o),
    .wbs_stb_o (wb_sdram_dbus_stb_o),
    .wbs_cti_o (wb_sdram_dbus_cti_o),
    .wbs_bte_o (wb_sdram_dbus_bte_o),
    .wbs_dat_i (wb_sdram_dbus_dat_i),
    .wbs_ack_i (wb_sdram_dbus_ack_i),
    .wbs_err_i (wb_sdram_dbus_err_i),
    .wbs_rty_i (wb_sdram_dbus_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_gpio0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k_d_gpio0_adr, wb_m2s_dbg_gpio0_adr}),
    .wbm_dat_i ({wb_m2s_or1k_d_gpio0_dat, wb_m2s_dbg_gpio0_dat}),
    .wbm_sel_i ({wb_m2s_or1k_d_gpio0_sel, wb_m2s_dbg_gpio0_sel}),
    .wbm_we_i  ({wb_m2s_or1k_d_gpio0_we, wb_m2s_dbg_gpio0_we}),
    .wbm_cyc_i ({wb_m2s_or1k_d_gpio0_cyc, wb_m2s_dbg_gpio0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k_d_gpio0_stb, wb_m2s_dbg_gpio0_stb}),
    .wbm_cti_i ({wb_m2s_or1k_d_gpio0_cti, wb_m2s_dbg_gpio0_cti}),
    .wbm_bte_i ({wb_m2s_or1k_d_gpio0_bte, wb_m2s_dbg_gpio0_bte}),
    .wbm_dat_o ({wb_s2m_or1k_d_gpio0_dat, wb_s2m_dbg_gpio0_dat}),
    .wbm_ack_o ({wb_s2m_or1k_d_gpio0_ack, wb_s2m_dbg_gpio0_ack}),
    .wbm_err_o ({wb_s2m_or1k_d_gpio0_err, wb_s2m_dbg_gpio0_err}),
    .wbm_rty_o ({wb_s2m_or1k_d_gpio0_rty, wb_s2m_dbg_gpio0_rty}),
    .wbs_adr_o (wb_m2s_resize_gpio0_adr),
    .wbs_dat_o (wb_m2s_resize_gpio0_dat),
    .wbs_sel_o (wb_m2s_resize_gpio0_sel),
    .wbs_we_o  (wb_m2s_resize_gpio0_we),
    .wbs_cyc_o (wb_m2s_resize_gpio0_cyc),
    .wbs_stb_o (wb_m2s_resize_gpio0_stb),
    .wbs_cti_o (wb_m2s_resize_gpio0_cti),
    .wbs_bte_o (wb_m2s_resize_gpio0_bte),
    .wbs_dat_i (wb_s2m_resize_gpio0_dat),
    .wbs_ack_i (wb_s2m_resize_gpio0_ack),
    .wbs_err_i (wb_s2m_resize_gpio0_err),
    .wbs_rty_i (wb_s2m_resize_gpio0_rty));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_gpio0
   (.wbm_adr_i (wb_m2s_resize_gpio0_adr),
    .wbm_dat_i (wb_m2s_resize_gpio0_dat),
    .wbm_sel_i (wb_m2s_resize_gpio0_sel),
    .wbm_we_i  (wb_m2s_resize_gpio0_we),
    .wbm_cyc_i (wb_m2s_resize_gpio0_cyc),
    .wbm_stb_i (wb_m2s_resize_gpio0_stb),
    .wbm_cti_i (wb_m2s_resize_gpio0_cti),
    .wbm_bte_i (wb_m2s_resize_gpio0_bte),
    .wbm_dat_o (wb_s2m_resize_gpio0_dat),
    .wbm_ack_o (wb_s2m_resize_gpio0_ack),
    .wbm_err_o (wb_s2m_resize_gpio0_err),
    .wbm_rty_o (wb_s2m_resize_gpio0_rty),
    .wbs_adr_o (wb_gpio0_adr_o),
    .wbs_dat_o (wb_gpio0_dat_o),
    .wbs_we_o  (wb_gpio0_we_o),
    .wbs_cyc_o (wb_gpio0_cyc_o),
    .wbs_stb_o (wb_gpio0_stb_o),
    .wbs_cti_o (wb_gpio0_cti_o),
    .wbs_bte_o (wb_gpio0_bte_o),
    .wbs_dat_i (wb_gpio0_dat_i),
    .wbs_ack_i (wb_gpio0_ack_i),
    .wbs_err_i (wb_gpio0_err_i),
    .wbs_rty_i (wb_gpio0_rty_i));

endmodule
