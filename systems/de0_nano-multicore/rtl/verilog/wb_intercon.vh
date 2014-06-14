wire [31:0] wb_m2s_or1k_i_adr;
wire [31:0] wb_m2s_or1k_i_dat;
wire  [3:0] wb_m2s_or1k_i_sel;
wire        wb_m2s_or1k_i_we;
wire        wb_m2s_or1k_i_cyc;
wire        wb_m2s_or1k_i_stb;
wire  [2:0] wb_m2s_or1k_i_cti;
wire  [1:0] wb_m2s_or1k_i_bte;
wire [31:0] wb_s2m_or1k_i_dat;
wire        wb_s2m_or1k_i_ack;
wire        wb_s2m_or1k_i_err;
wire        wb_s2m_or1k_i_rty;
wire [31:0] wb_m2s_or1k_d_adr;
wire [31:0] wb_m2s_or1k_d_dat;
wire  [3:0] wb_m2s_or1k_d_sel;
wire        wb_m2s_or1k_d_we;
wire        wb_m2s_or1k_d_cyc;
wire        wb_m2s_or1k_d_stb;
wire  [2:0] wb_m2s_or1k_d_cti;
wire  [1:0] wb_m2s_or1k_d_bte;
wire [31:0] wb_s2m_or1k_d_dat;
wire        wb_s2m_or1k_d_ack;
wire        wb_s2m_or1k_d_err;
wire        wb_s2m_or1k_d_rty;
wire [31:0] wb_m2s_dbg_adr;
wire [31:0] wb_m2s_dbg_dat;
wire  [3:0] wb_m2s_dbg_sel;
wire        wb_m2s_dbg_we;
wire        wb_m2s_dbg_cyc;
wire        wb_m2s_dbg_stb;
wire  [2:0] wb_m2s_dbg_cti;
wire  [1:0] wb_m2s_dbg_bte;
wire [31:0] wb_s2m_dbg_dat;
wire        wb_s2m_dbg_ack;
wire        wb_s2m_dbg_err;
wire        wb_s2m_dbg_rty;
wire [31:0] wb_m2s_spi2_adr;
wire [31:0] wb_m2s_spi2_dat;
wire  [3:0] wb_m2s_spi2_sel;
wire        wb_m2s_spi2_we;
wire        wb_m2s_spi2_cyc;
wire        wb_m2s_spi2_stb;
wire  [2:0] wb_m2s_spi2_cti;
wire  [1:0] wb_m2s_spi2_bte;
wire [31:0] wb_s2m_spi2_dat;
wire        wb_s2m_spi2_ack;
wire        wb_s2m_spi2_err;
wire        wb_s2m_spi2_rty;
wire [31:0] wb_m2s_gpio0_adr;
wire [31:0] wb_m2s_gpio0_dat;
wire  [3:0] wb_m2s_gpio0_sel;
wire        wb_m2s_gpio0_we;
wire        wb_m2s_gpio0_cyc;
wire        wb_m2s_gpio0_stb;
wire  [2:0] wb_m2s_gpio0_cti;
wire  [1:0] wb_m2s_gpio0_bte;
wire [31:0] wb_s2m_gpio0_dat;
wire        wb_s2m_gpio0_ack;
wire        wb_s2m_gpio0_err;
wire        wb_s2m_gpio0_rty;
wire [31:0] wb_m2s_spi1_adr;
wire [31:0] wb_m2s_spi1_dat;
wire  [3:0] wb_m2s_spi1_sel;
wire        wb_m2s_spi1_we;
wire        wb_m2s_spi1_cyc;
wire        wb_m2s_spi1_stb;
wire  [2:0] wb_m2s_spi1_cti;
wire  [1:0] wb_m2s_spi1_bte;
wire [31:0] wb_s2m_spi1_dat;
wire        wb_s2m_spi1_ack;
wire        wb_s2m_spi1_err;
wire        wb_s2m_spi1_rty;
wire [31:0] wb_m2s_rom0_adr;
wire [31:0] wb_m2s_rom0_dat;
wire  [3:0] wb_m2s_rom0_sel;
wire        wb_m2s_rom0_we;
wire        wb_m2s_rom0_cyc;
wire        wb_m2s_rom0_stb;
wire  [2:0] wb_m2s_rom0_cti;
wire  [1:0] wb_m2s_rom0_bte;
wire [31:0] wb_s2m_rom0_dat;
wire        wb_s2m_rom0_ack;
wire        wb_s2m_rom0_err;
wire        wb_s2m_rom0_rty;
wire [31:0] wb_m2s_sdram_dbus_adr;
wire [31:0] wb_m2s_sdram_dbus_dat;
wire  [3:0] wb_m2s_sdram_dbus_sel;
wire        wb_m2s_sdram_dbus_we;
wire        wb_m2s_sdram_dbus_cyc;
wire        wb_m2s_sdram_dbus_stb;
wire  [2:0] wb_m2s_sdram_dbus_cti;
wire  [1:0] wb_m2s_sdram_dbus_bte;
wire [31:0] wb_s2m_sdram_dbus_dat;
wire        wb_s2m_sdram_dbus_ack;
wire        wb_s2m_sdram_dbus_err;
wire        wb_s2m_sdram_dbus_rty;
wire [31:0] wb_m2s_spi0_adr;
wire [31:0] wb_m2s_spi0_dat;
wire  [3:0] wb_m2s_spi0_sel;
wire        wb_m2s_spi0_we;
wire        wb_m2s_spi0_cyc;
wire        wb_m2s_spi0_stb;
wire  [2:0] wb_m2s_spi0_cti;
wire  [1:0] wb_m2s_spi0_bte;
wire [31:0] wb_s2m_spi0_dat;
wire        wb_s2m_spi0_ack;
wire        wb_s2m_spi0_err;
wire        wb_s2m_spi0_rty;
wire [31:0] wb_m2s_uart0_adr;
wire [31:0] wb_m2s_uart0_dat;
wire  [3:0] wb_m2s_uart0_sel;
wire        wb_m2s_uart0_we;
wire        wb_m2s_uart0_cyc;
wire        wb_m2s_uart0_stb;
wire  [2:0] wb_m2s_uart0_cti;
wire  [1:0] wb_m2s_uart0_bte;
wire [31:0] wb_s2m_uart0_dat;
wire        wb_s2m_uart0_ack;
wire        wb_s2m_uart0_err;
wire        wb_s2m_uart0_rty;
wire [31:0] wb_m2s_sdram_ibus_adr;
wire [31:0] wb_m2s_sdram_ibus_dat;
wire  [3:0] wb_m2s_sdram_ibus_sel;
wire        wb_m2s_sdram_ibus_we;
wire        wb_m2s_sdram_ibus_cyc;
wire        wb_m2s_sdram_ibus_stb;
wire  [2:0] wb_m2s_sdram_ibus_cti;
wire  [1:0] wb_m2s_sdram_ibus_bte;
wire [31:0] wb_s2m_sdram_ibus_dat;
wire        wb_s2m_sdram_ibus_ack;
wire        wb_s2m_sdram_ibus_err;
wire        wb_s2m_sdram_ibus_rty;
wire [31:0] wb_m2s_i2c0_adr;
wire [31:0] wb_m2s_i2c0_dat;
wire  [3:0] wb_m2s_i2c0_sel;
wire        wb_m2s_i2c0_we;
wire        wb_m2s_i2c0_cyc;
wire        wb_m2s_i2c0_stb;
wire  [2:0] wb_m2s_i2c0_cti;
wire  [1:0] wb_m2s_i2c0_bte;
wire [31:0] wb_s2m_i2c0_dat;
wire        wb_s2m_i2c0_ack;
wire        wb_s2m_i2c0_err;
wire        wb_s2m_i2c0_rty;
wire [31:0] wb_m2s_i2c1_adr;
wire [31:0] wb_m2s_i2c1_dat;
wire  [3:0] wb_m2s_i2c1_sel;
wire        wb_m2s_i2c1_we;
wire        wb_m2s_i2c1_cyc;
wire        wb_m2s_i2c1_stb;
wire  [2:0] wb_m2s_i2c1_cti;
wire  [1:0] wb_m2s_i2c1_bte;
wire [31:0] wb_s2m_i2c1_dat;
wire        wb_s2m_i2c1_ack;
wire        wb_s2m_i2c1_err;
wire        wb_s2m_i2c1_rty;

wb_intercon wb_intercon0
   (.wb_clk_i            (wb_clk),
    .wb_rst_i            (wb_rst),
    .wb_or1k_i_adr_i     (wb_m2s_or1k_i_adr),
    .wb_or1k_i_dat_i     (wb_m2s_or1k_i_dat),
    .wb_or1k_i_sel_i     (wb_m2s_or1k_i_sel),
    .wb_or1k_i_we_i      (wb_m2s_or1k_i_we),
    .wb_or1k_i_cyc_i     (wb_m2s_or1k_i_cyc),
    .wb_or1k_i_stb_i     (wb_m2s_or1k_i_stb),
    .wb_or1k_i_cti_i     (wb_m2s_or1k_i_cti),
    .wb_or1k_i_bte_i     (wb_m2s_or1k_i_bte),
    .wb_or1k_i_dat_o     (wb_s2m_or1k_i_dat),
    .wb_or1k_i_ack_o     (wb_s2m_or1k_i_ack),
    .wb_or1k_i_err_o     (wb_s2m_or1k_i_err),
    .wb_or1k_i_rty_o     (wb_s2m_or1k_i_rty),
    .wb_or1k_d_adr_i     (wb_m2s_or1k_d_adr),
    .wb_or1k_d_dat_i     (wb_m2s_or1k_d_dat),
    .wb_or1k_d_sel_i     (wb_m2s_or1k_d_sel),
    .wb_or1k_d_we_i      (wb_m2s_or1k_d_we),
    .wb_or1k_d_cyc_i     (wb_m2s_or1k_d_cyc),
    .wb_or1k_d_stb_i     (wb_m2s_or1k_d_stb),
    .wb_or1k_d_cti_i     (wb_m2s_or1k_d_cti),
    .wb_or1k_d_bte_i     (wb_m2s_or1k_d_bte),
    .wb_or1k_d_dat_o     (wb_s2m_or1k_d_dat),
    .wb_or1k_d_ack_o     (wb_s2m_or1k_d_ack),
    .wb_or1k_d_err_o     (wb_s2m_or1k_d_err),
    .wb_or1k_d_rty_o     (wb_s2m_or1k_d_rty),
    .wb_dbg_adr_i        (wb_m2s_dbg_adr),
    .wb_dbg_dat_i        (wb_m2s_dbg_dat),
    .wb_dbg_sel_i        (wb_m2s_dbg_sel),
    .wb_dbg_we_i         (wb_m2s_dbg_we),
    .wb_dbg_cyc_i        (wb_m2s_dbg_cyc),
    .wb_dbg_stb_i        (wb_m2s_dbg_stb),
    .wb_dbg_cti_i        (wb_m2s_dbg_cti),
    .wb_dbg_bte_i        (wb_m2s_dbg_bte),
    .wb_dbg_dat_o        (wb_s2m_dbg_dat),
    .wb_dbg_ack_o        (wb_s2m_dbg_ack),
    .wb_dbg_err_o        (wb_s2m_dbg_err),
    .wb_dbg_rty_o        (wb_s2m_dbg_rty),
    .wb_spi2_adr_o       (wb_m2s_spi2_adr),
    .wb_spi2_dat_o       (wb_m2s_spi2_dat),
    .wb_spi2_sel_o       (wb_m2s_spi2_sel),
    .wb_spi2_we_o        (wb_m2s_spi2_we),
    .wb_spi2_cyc_o       (wb_m2s_spi2_cyc),
    .wb_spi2_stb_o       (wb_m2s_spi2_stb),
    .wb_spi2_cti_o       (wb_m2s_spi2_cti),
    .wb_spi2_bte_o       (wb_m2s_spi2_bte),
    .wb_spi2_dat_i       (wb_s2m_spi2_dat),
    .wb_spi2_ack_i       (wb_s2m_spi2_ack),
    .wb_spi2_err_i       (wb_s2m_spi2_err),
    .wb_spi2_rty_i       (wb_s2m_spi2_rty),
    .wb_gpio0_adr_o      (wb_m2s_gpio0_adr),
    .wb_gpio0_dat_o      (wb_m2s_gpio0_dat),
    .wb_gpio0_sel_o      (wb_m2s_gpio0_sel),
    .wb_gpio0_we_o       (wb_m2s_gpio0_we),
    .wb_gpio0_cyc_o      (wb_m2s_gpio0_cyc),
    .wb_gpio0_stb_o      (wb_m2s_gpio0_stb),
    .wb_gpio0_cti_o      (wb_m2s_gpio0_cti),
    .wb_gpio0_bte_o      (wb_m2s_gpio0_bte),
    .wb_gpio0_dat_i      (wb_s2m_gpio0_dat),
    .wb_gpio0_ack_i      (wb_s2m_gpio0_ack),
    .wb_gpio0_err_i      (wb_s2m_gpio0_err),
    .wb_gpio0_rty_i      (wb_s2m_gpio0_rty),
    .wb_spi1_adr_o       (wb_m2s_spi1_adr),
    .wb_spi1_dat_o       (wb_m2s_spi1_dat),
    .wb_spi1_sel_o       (wb_m2s_spi1_sel),
    .wb_spi1_we_o        (wb_m2s_spi1_we),
    .wb_spi1_cyc_o       (wb_m2s_spi1_cyc),
    .wb_spi1_stb_o       (wb_m2s_spi1_stb),
    .wb_spi1_cti_o       (wb_m2s_spi1_cti),
    .wb_spi1_bte_o       (wb_m2s_spi1_bte),
    .wb_spi1_dat_i       (wb_s2m_spi1_dat),
    .wb_spi1_ack_i       (wb_s2m_spi1_ack),
    .wb_spi1_err_i       (wb_s2m_spi1_err),
    .wb_spi1_rty_i       (wb_s2m_spi1_rty),
    .wb_rom0_adr_o       (wb_m2s_rom0_adr),
    .wb_rom0_dat_o       (wb_m2s_rom0_dat),
    .wb_rom0_sel_o       (wb_m2s_rom0_sel),
    .wb_rom0_we_o        (wb_m2s_rom0_we),
    .wb_rom0_cyc_o       (wb_m2s_rom0_cyc),
    .wb_rom0_stb_o       (wb_m2s_rom0_stb),
    .wb_rom0_cti_o       (wb_m2s_rom0_cti),
    .wb_rom0_bte_o       (wb_m2s_rom0_bte),
    .wb_rom0_dat_i       (wb_s2m_rom0_dat),
    .wb_rom0_ack_i       (wb_s2m_rom0_ack),
    .wb_rom0_err_i       (wb_s2m_rom0_err),
    .wb_rom0_rty_i       (wb_s2m_rom0_rty),
    .wb_sdram_dbus_adr_o (wb_m2s_sdram_dbus_adr),
    .wb_sdram_dbus_dat_o (wb_m2s_sdram_dbus_dat),
    .wb_sdram_dbus_sel_o (wb_m2s_sdram_dbus_sel),
    .wb_sdram_dbus_we_o  (wb_m2s_sdram_dbus_we),
    .wb_sdram_dbus_cyc_o (wb_m2s_sdram_dbus_cyc),
    .wb_sdram_dbus_stb_o (wb_m2s_sdram_dbus_stb),
    .wb_sdram_dbus_cti_o (wb_m2s_sdram_dbus_cti),
    .wb_sdram_dbus_bte_o (wb_m2s_sdram_dbus_bte),
    .wb_sdram_dbus_dat_i (wb_s2m_sdram_dbus_dat),
    .wb_sdram_dbus_ack_i (wb_s2m_sdram_dbus_ack),
    .wb_sdram_dbus_err_i (wb_s2m_sdram_dbus_err),
    .wb_sdram_dbus_rty_i (wb_s2m_sdram_dbus_rty),
    .wb_spi0_adr_o       (wb_m2s_spi0_adr),
    .wb_spi0_dat_o       (wb_m2s_spi0_dat),
    .wb_spi0_sel_o       (wb_m2s_spi0_sel),
    .wb_spi0_we_o        (wb_m2s_spi0_we),
    .wb_spi0_cyc_o       (wb_m2s_spi0_cyc),
    .wb_spi0_stb_o       (wb_m2s_spi0_stb),
    .wb_spi0_cti_o       (wb_m2s_spi0_cti),
    .wb_spi0_bte_o       (wb_m2s_spi0_bte),
    .wb_spi0_dat_i       (wb_s2m_spi0_dat),
    .wb_spi0_ack_i       (wb_s2m_spi0_ack),
    .wb_spi0_err_i       (wb_s2m_spi0_err),
    .wb_spi0_rty_i       (wb_s2m_spi0_rty),
    .wb_uart0_adr_o      (wb_m2s_uart0_adr),
    .wb_uart0_dat_o      (wb_m2s_uart0_dat),
    .wb_uart0_sel_o      (wb_m2s_uart0_sel),
    .wb_uart0_we_o       (wb_m2s_uart0_we),
    .wb_uart0_cyc_o      (wb_m2s_uart0_cyc),
    .wb_uart0_stb_o      (wb_m2s_uart0_stb),
    .wb_uart0_cti_o      (wb_m2s_uart0_cti),
    .wb_uart0_bte_o      (wb_m2s_uart0_bte),
    .wb_uart0_dat_i      (wb_s2m_uart0_dat),
    .wb_uart0_ack_i      (wb_s2m_uart0_ack),
    .wb_uart0_err_i      (wb_s2m_uart0_err),
    .wb_uart0_rty_i      (wb_s2m_uart0_rty),
    .wb_sdram_ibus_adr_o (wb_m2s_sdram_ibus_adr),
    .wb_sdram_ibus_dat_o (wb_m2s_sdram_ibus_dat),
    .wb_sdram_ibus_sel_o (wb_m2s_sdram_ibus_sel),
    .wb_sdram_ibus_we_o  (wb_m2s_sdram_ibus_we),
    .wb_sdram_ibus_cyc_o (wb_m2s_sdram_ibus_cyc),
    .wb_sdram_ibus_stb_o (wb_m2s_sdram_ibus_stb),
    .wb_sdram_ibus_cti_o (wb_m2s_sdram_ibus_cti),
    .wb_sdram_ibus_bte_o (wb_m2s_sdram_ibus_bte),
    .wb_sdram_ibus_dat_i (wb_s2m_sdram_ibus_dat),
    .wb_sdram_ibus_ack_i (wb_s2m_sdram_ibus_ack),
    .wb_sdram_ibus_err_i (wb_s2m_sdram_ibus_err),
    .wb_sdram_ibus_rty_i (wb_s2m_sdram_ibus_rty),
    .wb_i2c0_adr_o       (wb_m2s_i2c0_adr),
    .wb_i2c0_dat_o       (wb_m2s_i2c0_dat),
    .wb_i2c0_sel_o       (wb_m2s_i2c0_sel),
    .wb_i2c0_we_o        (wb_m2s_i2c0_we),
    .wb_i2c0_cyc_o       (wb_m2s_i2c0_cyc),
    .wb_i2c0_stb_o       (wb_m2s_i2c0_stb),
    .wb_i2c0_cti_o       (wb_m2s_i2c0_cti),
    .wb_i2c0_bte_o       (wb_m2s_i2c0_bte),
    .wb_i2c0_dat_i       (wb_s2m_i2c0_dat),
    .wb_i2c0_ack_i       (wb_s2m_i2c0_ack),
    .wb_i2c0_err_i       (wb_s2m_i2c0_err),
    .wb_i2c0_rty_i       (wb_s2m_i2c0_rty),
    .wb_i2c1_adr_o       (wb_m2s_i2c1_adr),
    .wb_i2c1_dat_o       (wb_m2s_i2c1_dat),
    .wb_i2c1_sel_o       (wb_m2s_i2c1_sel),
    .wb_i2c1_we_o        (wb_m2s_i2c1_we),
    .wb_i2c1_cyc_o       (wb_m2s_i2c1_cyc),
    .wb_i2c1_stb_o       (wb_m2s_i2c1_stb),
    .wb_i2c1_cti_o       (wb_m2s_i2c1_cti),
    .wb_i2c1_bte_o       (wb_m2s_i2c1_bte),
    .wb_i2c1_dat_i       (wb_s2m_i2c1_dat),
    .wb_i2c1_ack_i       (wb_s2m_i2c1_ack),
    .wb_i2c1_err_i       (wb_s2m_i2c1_err),
    .wb_i2c1_rty_i       (wb_s2m_i2c1_rty));


