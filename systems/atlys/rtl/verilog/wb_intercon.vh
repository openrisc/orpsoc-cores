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
wire [31:0] wb_m2s_vga0_master_adr;
wire [31:0] wb_m2s_vga0_master_dat;
wire  [3:0] wb_m2s_vga0_master_sel;
wire        wb_m2s_vga0_master_we;
wire        wb_m2s_vga0_master_cyc;
wire        wb_m2s_vga0_master_stb;
wire  [2:0] wb_m2s_vga0_master_cti;
wire  [1:0] wb_m2s_vga0_master_bte;
wire [31:0] wb_s2m_vga0_master_dat;
wire        wb_s2m_vga0_master_ack;
wire        wb_s2m_vga0_master_err;
wire        wb_s2m_vga0_master_rty;
wire [31:0] wb_m2s_eth0_master_adr;
wire [31:0] wb_m2s_eth0_master_dat;
wire  [3:0] wb_m2s_eth0_master_sel;
wire        wb_m2s_eth0_master_we;
wire        wb_m2s_eth0_master_cyc;
wire        wb_m2s_eth0_master_stb;
wire  [2:0] wb_m2s_eth0_master_cti;
wire  [1:0] wb_m2s_eth0_master_bte;
wire [31:0] wb_s2m_eth0_master_dat;
wire        wb_s2m_eth0_master_ack;
wire        wb_s2m_eth0_master_err;
wire        wb_s2m_eth0_master_rty;
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
wire [31:0] wb_m2s_ddr2_dbus_adr;
wire [31:0] wb_m2s_ddr2_dbus_dat;
wire  [3:0] wb_m2s_ddr2_dbus_sel;
wire        wb_m2s_ddr2_dbus_we;
wire        wb_m2s_ddr2_dbus_cyc;
wire        wb_m2s_ddr2_dbus_stb;
wire  [2:0] wb_m2s_ddr2_dbus_cti;
wire  [1:0] wb_m2s_ddr2_dbus_bte;
wire [31:0] wb_s2m_ddr2_dbus_dat;
wire        wb_s2m_ddr2_dbus_ack;
wire        wb_s2m_ddr2_dbus_err;
wire        wb_s2m_ddr2_dbus_rty;
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
wire [31:0] wb_m2s_diila_adr;
wire [31:0] wb_m2s_diila_dat;
wire  [3:0] wb_m2s_diila_sel;
wire        wb_m2s_diila_we;
wire        wb_m2s_diila_cyc;
wire        wb_m2s_diila_stb;
wire  [2:0] wb_m2s_diila_cti;
wire  [1:0] wb_m2s_diila_bte;
wire [31:0] wb_s2m_diila_dat;
wire        wb_s2m_diila_ack;
wire        wb_s2m_diila_err;
wire        wb_s2m_diila_rty;
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
wire [31:0] wb_m2s_ps2_0_adr;
wire [31:0] wb_m2s_ps2_0_dat;
wire  [3:0] wb_m2s_ps2_0_sel;
wire        wb_m2s_ps2_0_we;
wire        wb_m2s_ps2_0_cyc;
wire        wb_m2s_ps2_0_stb;
wire  [2:0] wb_m2s_ps2_0_cti;
wire  [1:0] wb_m2s_ps2_0_bte;
wire [31:0] wb_s2m_ps2_0_dat;
wire        wb_s2m_ps2_0_ack;
wire        wb_s2m_ps2_0_err;
wire        wb_s2m_ps2_0_rty;
wire [31:0] wb_m2s_vga0_adr;
wire [31:0] wb_m2s_vga0_dat;
wire  [3:0] wb_m2s_vga0_sel;
wire        wb_m2s_vga0_we;
wire        wb_m2s_vga0_cyc;
wire        wb_m2s_vga0_stb;
wire  [2:0] wb_m2s_vga0_cti;
wire  [1:0] wb_m2s_vga0_bte;
wire [31:0] wb_s2m_vga0_dat;
wire        wb_s2m_vga0_ack;
wire        wb_s2m_vga0_err;
wire        wb_s2m_vga0_rty;
wire [31:0] wb_m2s_ddr2_eth0_adr;
wire [31:0] wb_m2s_ddr2_eth0_dat;
wire  [3:0] wb_m2s_ddr2_eth0_sel;
wire        wb_m2s_ddr2_eth0_we;
wire        wb_m2s_ddr2_eth0_cyc;
wire        wb_m2s_ddr2_eth0_stb;
wire  [2:0] wb_m2s_ddr2_eth0_cti;
wire  [1:0] wb_m2s_ddr2_eth0_bte;
wire [31:0] wb_s2m_ddr2_eth0_dat;
wire        wb_s2m_ddr2_eth0_ack;
wire        wb_s2m_ddr2_eth0_err;
wire        wb_s2m_ddr2_eth0_rty;
wire [31:0] wb_m2s_ac97_adr;
wire [31:0] wb_m2s_ac97_dat;
wire  [3:0] wb_m2s_ac97_sel;
wire        wb_m2s_ac97_we;
wire        wb_m2s_ac97_cyc;
wire        wb_m2s_ac97_stb;
wire  [2:0] wb_m2s_ac97_cti;
wire  [1:0] wb_m2s_ac97_bte;
wire [31:0] wb_s2m_ac97_dat;
wire        wb_s2m_ac97_ack;
wire        wb_s2m_ac97_err;
wire        wb_s2m_ac97_rty;
wire [31:0] wb_m2s_ddr2_ibus_adr;
wire [31:0] wb_m2s_ddr2_ibus_dat;
wire  [3:0] wb_m2s_ddr2_ibus_sel;
wire        wb_m2s_ddr2_ibus_we;
wire        wb_m2s_ddr2_ibus_cyc;
wire        wb_m2s_ddr2_ibus_stb;
wire  [2:0] wb_m2s_ddr2_ibus_cti;
wire  [1:0] wb_m2s_ddr2_ibus_bte;
wire [31:0] wb_s2m_ddr2_ibus_dat;
wire        wb_s2m_ddr2_ibus_ack;
wire        wb_s2m_ddr2_ibus_err;
wire        wb_s2m_ddr2_ibus_rty;
wire [31:0] wb_m2s_ddr2_vga0_adr;
wire [31:0] wb_m2s_ddr2_vga0_dat;
wire  [3:0] wb_m2s_ddr2_vga0_sel;
wire        wb_m2s_ddr2_vga0_we;
wire        wb_m2s_ddr2_vga0_cyc;
wire        wb_m2s_ddr2_vga0_stb;
wire  [2:0] wb_m2s_ddr2_vga0_cti;
wire  [1:0] wb_m2s_ddr2_vga0_bte;
wire [31:0] wb_s2m_ddr2_vga0_dat;
wire        wb_s2m_ddr2_vga0_ack;
wire        wb_s2m_ddr2_vga0_err;
wire        wb_s2m_ddr2_vga0_rty;
wire [31:0] wb_m2s_ps2_2_adr;
wire [31:0] wb_m2s_ps2_2_dat;
wire  [3:0] wb_m2s_ps2_2_sel;
wire        wb_m2s_ps2_2_we;
wire        wb_m2s_ps2_2_cyc;
wire        wb_m2s_ps2_2_stb;
wire  [2:0] wb_m2s_ps2_2_cti;
wire  [1:0] wb_m2s_ps2_2_bte;
wire [31:0] wb_s2m_ps2_2_dat;
wire        wb_s2m_ps2_2_ack;
wire        wb_s2m_ps2_2_err;
wire        wb_s2m_ps2_2_rty;
wire [31:0] wb_m2s_ps2_1_adr;
wire [31:0] wb_m2s_ps2_1_dat;
wire  [3:0] wb_m2s_ps2_1_sel;
wire        wb_m2s_ps2_1_we;
wire        wb_m2s_ps2_1_cyc;
wire        wb_m2s_ps2_1_stb;
wire  [2:0] wb_m2s_ps2_1_cti;
wire  [1:0] wb_m2s_ps2_1_bte;
wire [31:0] wb_s2m_ps2_1_dat;
wire        wb_s2m_ps2_1_ack;
wire        wb_s2m_ps2_1_err;
wire        wb_s2m_ps2_1_rty;
wire [31:0] wb_m2s_eth0_adr;
wire [31:0] wb_m2s_eth0_dat;
wire  [3:0] wb_m2s_eth0_sel;
wire        wb_m2s_eth0_we;
wire        wb_m2s_eth0_cyc;
wire        wb_m2s_eth0_stb;
wire  [2:0] wb_m2s_eth0_cti;
wire  [1:0] wb_m2s_eth0_bte;
wire [31:0] wb_s2m_eth0_dat;
wire        wb_s2m_eth0_ack;
wire        wb_s2m_eth0_err;
wire        wb_s2m_eth0_rty;

wb_intercon wb_intercon0
   (.wb_clk_i             (wb_clk),
    .wb_rst_i             (wb_rst),
    .wb_or1k_i_adr_i      (wb_m2s_or1k_i_adr),
    .wb_or1k_i_dat_i      (wb_m2s_or1k_i_dat),
    .wb_or1k_i_sel_i      (wb_m2s_or1k_i_sel),
    .wb_or1k_i_we_i       (wb_m2s_or1k_i_we),
    .wb_or1k_i_cyc_i      (wb_m2s_or1k_i_cyc),
    .wb_or1k_i_stb_i      (wb_m2s_or1k_i_stb),
    .wb_or1k_i_cti_i      (wb_m2s_or1k_i_cti),
    .wb_or1k_i_bte_i      (wb_m2s_or1k_i_bte),
    .wb_or1k_i_dat_o      (wb_s2m_or1k_i_dat),
    .wb_or1k_i_ack_o      (wb_s2m_or1k_i_ack),
    .wb_or1k_i_err_o      (wb_s2m_or1k_i_err),
    .wb_or1k_i_rty_o      (wb_s2m_or1k_i_rty),
    .wb_or1k_d_adr_i      (wb_m2s_or1k_d_adr),
    .wb_or1k_d_dat_i      (wb_m2s_or1k_d_dat),
    .wb_or1k_d_sel_i      (wb_m2s_or1k_d_sel),
    .wb_or1k_d_we_i       (wb_m2s_or1k_d_we),
    .wb_or1k_d_cyc_i      (wb_m2s_or1k_d_cyc),
    .wb_or1k_d_stb_i      (wb_m2s_or1k_d_stb),
    .wb_or1k_d_cti_i      (wb_m2s_or1k_d_cti),
    .wb_or1k_d_bte_i      (wb_m2s_or1k_d_bte),
    .wb_or1k_d_dat_o      (wb_s2m_or1k_d_dat),
    .wb_or1k_d_ack_o      (wb_s2m_or1k_d_ack),
    .wb_or1k_d_err_o      (wb_s2m_or1k_d_err),
    .wb_or1k_d_rty_o      (wb_s2m_or1k_d_rty),
    .wb_dbg_adr_i         (wb_m2s_dbg_adr),
    .wb_dbg_dat_i         (wb_m2s_dbg_dat),
    .wb_dbg_sel_i         (wb_m2s_dbg_sel),
    .wb_dbg_we_i          (wb_m2s_dbg_we),
    .wb_dbg_cyc_i         (wb_m2s_dbg_cyc),
    .wb_dbg_stb_i         (wb_m2s_dbg_stb),
    .wb_dbg_cti_i         (wb_m2s_dbg_cti),
    .wb_dbg_bte_i         (wb_m2s_dbg_bte),
    .wb_dbg_dat_o         (wb_s2m_dbg_dat),
    .wb_dbg_ack_o         (wb_s2m_dbg_ack),
    .wb_dbg_err_o         (wb_s2m_dbg_err),
    .wb_dbg_rty_o         (wb_s2m_dbg_rty),
    .wb_vga0_master_adr_i (wb_m2s_vga0_master_adr),
    .wb_vga0_master_dat_i (wb_m2s_vga0_master_dat),
    .wb_vga0_master_sel_i (wb_m2s_vga0_master_sel),
    .wb_vga0_master_we_i  (wb_m2s_vga0_master_we),
    .wb_vga0_master_cyc_i (wb_m2s_vga0_master_cyc),
    .wb_vga0_master_stb_i (wb_m2s_vga0_master_stb),
    .wb_vga0_master_cti_i (wb_m2s_vga0_master_cti),
    .wb_vga0_master_bte_i (wb_m2s_vga0_master_bte),
    .wb_vga0_master_dat_o (wb_s2m_vga0_master_dat),
    .wb_vga0_master_ack_o (wb_s2m_vga0_master_ack),
    .wb_vga0_master_err_o (wb_s2m_vga0_master_err),
    .wb_vga0_master_rty_o (wb_s2m_vga0_master_rty),
    .wb_eth0_master_adr_i (wb_m2s_eth0_master_adr),
    .wb_eth0_master_dat_i (wb_m2s_eth0_master_dat),
    .wb_eth0_master_sel_i (wb_m2s_eth0_master_sel),
    .wb_eth0_master_we_i  (wb_m2s_eth0_master_we),
    .wb_eth0_master_cyc_i (wb_m2s_eth0_master_cyc),
    .wb_eth0_master_stb_i (wb_m2s_eth0_master_stb),
    .wb_eth0_master_cti_i (wb_m2s_eth0_master_cti),
    .wb_eth0_master_bte_i (wb_m2s_eth0_master_bte),
    .wb_eth0_master_dat_o (wb_s2m_eth0_master_dat),
    .wb_eth0_master_ack_o (wb_s2m_eth0_master_ack),
    .wb_eth0_master_err_o (wb_s2m_eth0_master_err),
    .wb_eth0_master_rty_o (wb_s2m_eth0_master_rty),
    .wb_gpio0_adr_o       (wb_m2s_gpio0_adr),
    .wb_gpio0_dat_o       (wb_m2s_gpio0_dat),
    .wb_gpio0_sel_o       (wb_m2s_gpio0_sel),
    .wb_gpio0_we_o        (wb_m2s_gpio0_we),
    .wb_gpio0_cyc_o       (wb_m2s_gpio0_cyc),
    .wb_gpio0_stb_o       (wb_m2s_gpio0_stb),
    .wb_gpio0_cti_o       (wb_m2s_gpio0_cti),
    .wb_gpio0_bte_o       (wb_m2s_gpio0_bte),
    .wb_gpio0_dat_i       (wb_s2m_gpio0_dat),
    .wb_gpio0_ack_i       (wb_s2m_gpio0_ack),
    .wb_gpio0_err_i       (wb_s2m_gpio0_err),
    .wb_gpio0_rty_i       (wb_s2m_gpio0_rty),
    .wb_rom0_adr_o        (wb_m2s_rom0_adr),
    .wb_rom0_dat_o        (wb_m2s_rom0_dat),
    .wb_rom0_sel_o        (wb_m2s_rom0_sel),
    .wb_rom0_we_o         (wb_m2s_rom0_we),
    .wb_rom0_cyc_o        (wb_m2s_rom0_cyc),
    .wb_rom0_stb_o        (wb_m2s_rom0_stb),
    .wb_rom0_cti_o        (wb_m2s_rom0_cti),
    .wb_rom0_bte_o        (wb_m2s_rom0_bte),
    .wb_rom0_dat_i        (wb_s2m_rom0_dat),
    .wb_rom0_ack_i        (wb_s2m_rom0_ack),
    .wb_rom0_err_i        (wb_s2m_rom0_err),
    .wb_rom0_rty_i        (wb_s2m_rom0_rty),
    .wb_ddr2_dbus_adr_o   (wb_m2s_ddr2_dbus_adr),
    .wb_ddr2_dbus_dat_o   (wb_m2s_ddr2_dbus_dat),
    .wb_ddr2_dbus_sel_o   (wb_m2s_ddr2_dbus_sel),
    .wb_ddr2_dbus_we_o    (wb_m2s_ddr2_dbus_we),
    .wb_ddr2_dbus_cyc_o   (wb_m2s_ddr2_dbus_cyc),
    .wb_ddr2_dbus_stb_o   (wb_m2s_ddr2_dbus_stb),
    .wb_ddr2_dbus_cti_o   (wb_m2s_ddr2_dbus_cti),
    .wb_ddr2_dbus_bte_o   (wb_m2s_ddr2_dbus_bte),
    .wb_ddr2_dbus_dat_i   (wb_s2m_ddr2_dbus_dat),
    .wb_ddr2_dbus_ack_i   (wb_s2m_ddr2_dbus_ack),
    .wb_ddr2_dbus_err_i   (wb_s2m_ddr2_dbus_err),
    .wb_ddr2_dbus_rty_i   (wb_s2m_ddr2_dbus_rty),
    .wb_spi0_adr_o        (wb_m2s_spi0_adr),
    .wb_spi0_dat_o        (wb_m2s_spi0_dat),
    .wb_spi0_sel_o        (wb_m2s_spi0_sel),
    .wb_spi0_we_o         (wb_m2s_spi0_we),
    .wb_spi0_cyc_o        (wb_m2s_spi0_cyc),
    .wb_spi0_stb_o        (wb_m2s_spi0_stb),
    .wb_spi0_cti_o        (wb_m2s_spi0_cti),
    .wb_spi0_bte_o        (wb_m2s_spi0_bte),
    .wb_spi0_dat_i        (wb_s2m_spi0_dat),
    .wb_spi0_ack_i        (wb_s2m_spi0_ack),
    .wb_spi0_err_i        (wb_s2m_spi0_err),
    .wb_spi0_rty_i        (wb_s2m_spi0_rty),
    .wb_diila_adr_o       (wb_m2s_diila_adr),
    .wb_diila_dat_o       (wb_m2s_diila_dat),
    .wb_diila_sel_o       (wb_m2s_diila_sel),
    .wb_diila_we_o        (wb_m2s_diila_we),
    .wb_diila_cyc_o       (wb_m2s_diila_cyc),
    .wb_diila_stb_o       (wb_m2s_diila_stb),
    .wb_diila_cti_o       (wb_m2s_diila_cti),
    .wb_diila_bte_o       (wb_m2s_diila_bte),
    .wb_diila_dat_i       (wb_s2m_diila_dat),
    .wb_diila_ack_i       (wb_s2m_diila_ack),
    .wb_diila_err_i       (wb_s2m_diila_err),
    .wb_diila_rty_i       (wb_s2m_diila_rty),
    .wb_uart0_adr_o       (wb_m2s_uart0_adr),
    .wb_uart0_dat_o       (wb_m2s_uart0_dat),
    .wb_uart0_sel_o       (wb_m2s_uart0_sel),
    .wb_uart0_we_o        (wb_m2s_uart0_we),
    .wb_uart0_cyc_o       (wb_m2s_uart0_cyc),
    .wb_uart0_stb_o       (wb_m2s_uart0_stb),
    .wb_uart0_cti_o       (wb_m2s_uart0_cti),
    .wb_uart0_bte_o       (wb_m2s_uart0_bte),
    .wb_uart0_dat_i       (wb_s2m_uart0_dat),
    .wb_uart0_ack_i       (wb_s2m_uart0_ack),
    .wb_uart0_err_i       (wb_s2m_uart0_err),
    .wb_uart0_rty_i       (wb_s2m_uart0_rty),
    .wb_ps2_0_adr_o       (wb_m2s_ps2_0_adr),
    .wb_ps2_0_dat_o       (wb_m2s_ps2_0_dat),
    .wb_ps2_0_sel_o       (wb_m2s_ps2_0_sel),
    .wb_ps2_0_we_o        (wb_m2s_ps2_0_we),
    .wb_ps2_0_cyc_o       (wb_m2s_ps2_0_cyc),
    .wb_ps2_0_stb_o       (wb_m2s_ps2_0_stb),
    .wb_ps2_0_cti_o       (wb_m2s_ps2_0_cti),
    .wb_ps2_0_bte_o       (wb_m2s_ps2_0_bte),
    .wb_ps2_0_dat_i       (wb_s2m_ps2_0_dat),
    .wb_ps2_0_ack_i       (wb_s2m_ps2_0_ack),
    .wb_ps2_0_err_i       (wb_s2m_ps2_0_err),
    .wb_ps2_0_rty_i       (wb_s2m_ps2_0_rty),
    .wb_vga0_adr_o        (wb_m2s_vga0_adr),
    .wb_vga0_dat_o        (wb_m2s_vga0_dat),
    .wb_vga0_sel_o        (wb_m2s_vga0_sel),
    .wb_vga0_we_o         (wb_m2s_vga0_we),
    .wb_vga0_cyc_o        (wb_m2s_vga0_cyc),
    .wb_vga0_stb_o        (wb_m2s_vga0_stb),
    .wb_vga0_cti_o        (wb_m2s_vga0_cti),
    .wb_vga0_bte_o        (wb_m2s_vga0_bte),
    .wb_vga0_dat_i        (wb_s2m_vga0_dat),
    .wb_vga0_ack_i        (wb_s2m_vga0_ack),
    .wb_vga0_err_i        (wb_s2m_vga0_err),
    .wb_vga0_rty_i        (wb_s2m_vga0_rty),
    .wb_ddr2_eth0_adr_o   (wb_m2s_ddr2_eth0_adr),
    .wb_ddr2_eth0_dat_o   (wb_m2s_ddr2_eth0_dat),
    .wb_ddr2_eth0_sel_o   (wb_m2s_ddr2_eth0_sel),
    .wb_ddr2_eth0_we_o    (wb_m2s_ddr2_eth0_we),
    .wb_ddr2_eth0_cyc_o   (wb_m2s_ddr2_eth0_cyc),
    .wb_ddr2_eth0_stb_o   (wb_m2s_ddr2_eth0_stb),
    .wb_ddr2_eth0_cti_o   (wb_m2s_ddr2_eth0_cti),
    .wb_ddr2_eth0_bte_o   (wb_m2s_ddr2_eth0_bte),
    .wb_ddr2_eth0_dat_i   (wb_s2m_ddr2_eth0_dat),
    .wb_ddr2_eth0_ack_i   (wb_s2m_ddr2_eth0_ack),
    .wb_ddr2_eth0_err_i   (wb_s2m_ddr2_eth0_err),
    .wb_ddr2_eth0_rty_i   (wb_s2m_ddr2_eth0_rty),
    .wb_ac97_adr_o        (wb_m2s_ac97_adr),
    .wb_ac97_dat_o        (wb_m2s_ac97_dat),
    .wb_ac97_sel_o        (wb_m2s_ac97_sel),
    .wb_ac97_we_o         (wb_m2s_ac97_we),
    .wb_ac97_cyc_o        (wb_m2s_ac97_cyc),
    .wb_ac97_stb_o        (wb_m2s_ac97_stb),
    .wb_ac97_cti_o        (wb_m2s_ac97_cti),
    .wb_ac97_bte_o        (wb_m2s_ac97_bte),
    .wb_ac97_dat_i        (wb_s2m_ac97_dat),
    .wb_ac97_ack_i        (wb_s2m_ac97_ack),
    .wb_ac97_err_i        (wb_s2m_ac97_err),
    .wb_ac97_rty_i        (wb_s2m_ac97_rty),
    .wb_ddr2_ibus_adr_o   (wb_m2s_ddr2_ibus_adr),
    .wb_ddr2_ibus_dat_o   (wb_m2s_ddr2_ibus_dat),
    .wb_ddr2_ibus_sel_o   (wb_m2s_ddr2_ibus_sel),
    .wb_ddr2_ibus_we_o    (wb_m2s_ddr2_ibus_we),
    .wb_ddr2_ibus_cyc_o   (wb_m2s_ddr2_ibus_cyc),
    .wb_ddr2_ibus_stb_o   (wb_m2s_ddr2_ibus_stb),
    .wb_ddr2_ibus_cti_o   (wb_m2s_ddr2_ibus_cti),
    .wb_ddr2_ibus_bte_o   (wb_m2s_ddr2_ibus_bte),
    .wb_ddr2_ibus_dat_i   (wb_s2m_ddr2_ibus_dat),
    .wb_ddr2_ibus_ack_i   (wb_s2m_ddr2_ibus_ack),
    .wb_ddr2_ibus_err_i   (wb_s2m_ddr2_ibus_err),
    .wb_ddr2_ibus_rty_i   (wb_s2m_ddr2_ibus_rty),
    .wb_ddr2_vga0_adr_o   (wb_m2s_ddr2_vga0_adr),
    .wb_ddr2_vga0_dat_o   (wb_m2s_ddr2_vga0_dat),
    .wb_ddr2_vga0_sel_o   (wb_m2s_ddr2_vga0_sel),
    .wb_ddr2_vga0_we_o    (wb_m2s_ddr2_vga0_we),
    .wb_ddr2_vga0_cyc_o   (wb_m2s_ddr2_vga0_cyc),
    .wb_ddr2_vga0_stb_o   (wb_m2s_ddr2_vga0_stb),
    .wb_ddr2_vga0_cti_o   (wb_m2s_ddr2_vga0_cti),
    .wb_ddr2_vga0_bte_o   (wb_m2s_ddr2_vga0_bte),
    .wb_ddr2_vga0_dat_i   (wb_s2m_ddr2_vga0_dat),
    .wb_ddr2_vga0_ack_i   (wb_s2m_ddr2_vga0_ack),
    .wb_ddr2_vga0_err_i   (wb_s2m_ddr2_vga0_err),
    .wb_ddr2_vga0_rty_i   (wb_s2m_ddr2_vga0_rty),
    .wb_ps2_2_adr_o       (wb_m2s_ps2_2_adr),
    .wb_ps2_2_dat_o       (wb_m2s_ps2_2_dat),
    .wb_ps2_2_sel_o       (wb_m2s_ps2_2_sel),
    .wb_ps2_2_we_o        (wb_m2s_ps2_2_we),
    .wb_ps2_2_cyc_o       (wb_m2s_ps2_2_cyc),
    .wb_ps2_2_stb_o       (wb_m2s_ps2_2_stb),
    .wb_ps2_2_cti_o       (wb_m2s_ps2_2_cti),
    .wb_ps2_2_bte_o       (wb_m2s_ps2_2_bte),
    .wb_ps2_2_dat_i       (wb_s2m_ps2_2_dat),
    .wb_ps2_2_ack_i       (wb_s2m_ps2_2_ack),
    .wb_ps2_2_err_i       (wb_s2m_ps2_2_err),
    .wb_ps2_2_rty_i       (wb_s2m_ps2_2_rty),
    .wb_ps2_1_adr_o       (wb_m2s_ps2_1_adr),
    .wb_ps2_1_dat_o       (wb_m2s_ps2_1_dat),
    .wb_ps2_1_sel_o       (wb_m2s_ps2_1_sel),
    .wb_ps2_1_we_o        (wb_m2s_ps2_1_we),
    .wb_ps2_1_cyc_o       (wb_m2s_ps2_1_cyc),
    .wb_ps2_1_stb_o       (wb_m2s_ps2_1_stb),
    .wb_ps2_1_cti_o       (wb_m2s_ps2_1_cti),
    .wb_ps2_1_bte_o       (wb_m2s_ps2_1_bte),
    .wb_ps2_1_dat_i       (wb_s2m_ps2_1_dat),
    .wb_ps2_1_ack_i       (wb_s2m_ps2_1_ack),
    .wb_ps2_1_err_i       (wb_s2m_ps2_1_err),
    .wb_ps2_1_rty_i       (wb_s2m_ps2_1_rty),
    .wb_eth0_adr_o        (wb_m2s_eth0_adr),
    .wb_eth0_dat_o        (wb_m2s_eth0_dat),
    .wb_eth0_sel_o        (wb_m2s_eth0_sel),
    .wb_eth0_we_o         (wb_m2s_eth0_we),
    .wb_eth0_cyc_o        (wb_m2s_eth0_cyc),
    .wb_eth0_stb_o        (wb_m2s_eth0_stb),
    .wb_eth0_cti_o        (wb_m2s_eth0_cti),
    .wb_eth0_bte_o        (wb_m2s_eth0_bte),
    .wb_eth0_dat_i        (wb_s2m_eth0_dat),
    .wb_eth0_ack_i        (wb_s2m_eth0_ack),
    .wb_eth0_err_i        (wb_s2m_eth0_err),
    .wb_eth0_rty_i        (wb_s2m_eth0_rty));

