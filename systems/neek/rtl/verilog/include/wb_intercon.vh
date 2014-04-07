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
wire [31:0] wb_m2s_spi0_adr;
wire  [7:0] wb_m2s_spi0_dat;
wire  [3:0] wb_m2s_spi0_sel;
wire        wb_m2s_spi0_we;
wire        wb_m2s_spi0_cyc;
wire        wb_m2s_spi0_stb;
wire  [2:0] wb_m2s_spi0_cti;
wire  [1:0] wb_m2s_spi0_bte;
wire  [7:0] wb_s2m_spi0_dat;
wire        wb_s2m_spi0_ack;
wire        wb_s2m_spi0_err;
wire        wb_s2m_spi0_rty;
wire [31:0] wb_m2s_ddr_dbus_adr;
wire [31:0] wb_m2s_ddr_dbus_dat;
wire  [3:0] wb_m2s_ddr_dbus_sel;
wire        wb_m2s_ddr_dbus_we;
wire        wb_m2s_ddr_dbus_cyc;
wire        wb_m2s_ddr_dbus_stb;
wire  [2:0] wb_m2s_ddr_dbus_cti;
wire  [1:0] wb_m2s_ddr_dbus_bte;
wire [31:0] wb_s2m_ddr_dbus_dat;
wire        wb_s2m_ddr_dbus_ack;
wire        wb_s2m_ddr_dbus_err;
wire        wb_s2m_ddr_dbus_rty;
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
wire [31:0] wb_m2s_cfi0_adr;
wire [31:0] wb_m2s_cfi0_dat;
wire  [3:0] wb_m2s_cfi0_sel;
wire        wb_m2s_cfi0_we;
wire        wb_m2s_cfi0_cyc;
wire        wb_m2s_cfi0_stb;
wire  [2:0] wb_m2s_cfi0_cti;
wire  [1:0] wb_m2s_cfi0_bte;
wire [31:0] wb_s2m_cfi0_dat;
wire        wb_s2m_cfi0_ack;
wire        wb_s2m_cfi0_err;
wire        wb_s2m_cfi0_rty;
wire [31:0] wb_m2s_ddr_vga_adr;
wire [31:0] wb_m2s_ddr_vga_dat;
wire  [3:0] wb_m2s_ddr_vga_sel;
wire        wb_m2s_ddr_vga_we;
wire        wb_m2s_ddr_vga_cyc;
wire        wb_m2s_ddr_vga_stb;
wire  [2:0] wb_m2s_ddr_vga_cti;
wire  [1:0] wb_m2s_ddr_vga_bte;
wire [31:0] wb_s2m_ddr_vga_dat;
wire        wb_s2m_ddr_vga_ack;
wire        wb_s2m_ddr_vga_err;
wire        wb_s2m_ddr_vga_rty;
wire [31:0] wb_m2s_uart0_adr;
wire  [7:0] wb_m2s_uart0_dat;
wire  [3:0] wb_m2s_uart0_sel;
wire        wb_m2s_uart0_we;
wire        wb_m2s_uart0_cyc;
wire        wb_m2s_uart0_stb;
wire  [2:0] wb_m2s_uart0_cti;
wire  [1:0] wb_m2s_uart0_bte;
wire  [7:0] wb_s2m_uart0_dat;
wire        wb_s2m_uart0_ack;
wire        wb_s2m_uart0_err;
wire        wb_s2m_uart0_rty;
wire [31:0] wb_m2s_ddr_ibus_adr;
wire [31:0] wb_m2s_ddr_ibus_dat;
wire  [3:0] wb_m2s_ddr_ibus_sel;
wire        wb_m2s_ddr_ibus_we;
wire        wb_m2s_ddr_ibus_cyc;
wire        wb_m2s_ddr_ibus_stb;
wire  [2:0] wb_m2s_ddr_ibus_cti;
wire  [1:0] wb_m2s_ddr_ibus_bte;
wire [31:0] wb_s2m_ddr_ibus_dat;
wire        wb_s2m_ddr_ibus_ack;
wire        wb_s2m_ddr_ibus_err;
wire        wb_s2m_ddr_ibus_rty;
wire [31:0] wb_m2s_ddr_eth_adr;
wire [31:0] wb_m2s_ddr_eth_dat;
wire  [3:0] wb_m2s_ddr_eth_sel;
wire        wb_m2s_ddr_eth_we;
wire        wb_m2s_ddr_eth_cyc;
wire        wb_m2s_ddr_eth_stb;
wire  [2:0] wb_m2s_ddr_eth_cti;
wire  [1:0] wb_m2s_ddr_eth_bte;
wire [31:0] wb_s2m_ddr_eth_dat;
wire        wb_s2m_ddr_eth_ack;
wire        wb_s2m_ddr_eth_err;
wire        wb_s2m_ddr_eth_rty;
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
    .wb_ddr_dbus_adr_o    (wb_m2s_ddr_dbus_adr),
    .wb_ddr_dbus_dat_o    (wb_m2s_ddr_dbus_dat),
    .wb_ddr_dbus_sel_o    (wb_m2s_ddr_dbus_sel),
    .wb_ddr_dbus_we_o     (wb_m2s_ddr_dbus_we),
    .wb_ddr_dbus_cyc_o    (wb_m2s_ddr_dbus_cyc),
    .wb_ddr_dbus_stb_o    (wb_m2s_ddr_dbus_stb),
    .wb_ddr_dbus_cti_o    (wb_m2s_ddr_dbus_cti),
    .wb_ddr_dbus_bte_o    (wb_m2s_ddr_dbus_bte),
    .wb_ddr_dbus_dat_i    (wb_s2m_ddr_dbus_dat),
    .wb_ddr_dbus_ack_i    (wb_s2m_ddr_dbus_ack),
    .wb_ddr_dbus_err_i    (wb_s2m_ddr_dbus_err),
    .wb_ddr_dbus_rty_i    (wb_s2m_ddr_dbus_rty),
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
    .wb_cfi0_adr_o        (wb_m2s_cfi0_adr),
    .wb_cfi0_dat_o        (wb_m2s_cfi0_dat),
    .wb_cfi0_sel_o        (wb_m2s_cfi0_sel),
    .wb_cfi0_we_o         (wb_m2s_cfi0_we),
    .wb_cfi0_cyc_o        (wb_m2s_cfi0_cyc),
    .wb_cfi0_stb_o        (wb_m2s_cfi0_stb),
    .wb_cfi0_cti_o        (wb_m2s_cfi0_cti),
    .wb_cfi0_bte_o        (wb_m2s_cfi0_bte),
    .wb_cfi0_dat_i        (wb_s2m_cfi0_dat),
    .wb_cfi0_ack_i        (wb_s2m_cfi0_ack),
    .wb_cfi0_err_i        (wb_s2m_cfi0_err),
    .wb_cfi0_rty_i        (wb_s2m_cfi0_rty),
    .wb_ddr_vga_adr_o     (wb_m2s_ddr_vga_adr),
    .wb_ddr_vga_dat_o     (wb_m2s_ddr_vga_dat),
    .wb_ddr_vga_sel_o     (wb_m2s_ddr_vga_sel),
    .wb_ddr_vga_we_o      (wb_m2s_ddr_vga_we),
    .wb_ddr_vga_cyc_o     (wb_m2s_ddr_vga_cyc),
    .wb_ddr_vga_stb_o     (wb_m2s_ddr_vga_stb),
    .wb_ddr_vga_cti_o     (wb_m2s_ddr_vga_cti),
    .wb_ddr_vga_bte_o     (wb_m2s_ddr_vga_bte),
    .wb_ddr_vga_dat_i     (wb_s2m_ddr_vga_dat),
    .wb_ddr_vga_ack_i     (wb_s2m_ddr_vga_ack),
    .wb_ddr_vga_err_i     (wb_s2m_ddr_vga_err),
    .wb_ddr_vga_rty_i     (wb_s2m_ddr_vga_rty),
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
    .wb_ddr_ibus_adr_o    (wb_m2s_ddr_ibus_adr),
    .wb_ddr_ibus_dat_o    (wb_m2s_ddr_ibus_dat),
    .wb_ddr_ibus_sel_o    (wb_m2s_ddr_ibus_sel),
    .wb_ddr_ibus_we_o     (wb_m2s_ddr_ibus_we),
    .wb_ddr_ibus_cyc_o    (wb_m2s_ddr_ibus_cyc),
    .wb_ddr_ibus_stb_o    (wb_m2s_ddr_ibus_stb),
    .wb_ddr_ibus_cti_o    (wb_m2s_ddr_ibus_cti),
    .wb_ddr_ibus_bte_o    (wb_m2s_ddr_ibus_bte),
    .wb_ddr_ibus_dat_i    (wb_s2m_ddr_ibus_dat),
    .wb_ddr_ibus_ack_i    (wb_s2m_ddr_ibus_ack),
    .wb_ddr_ibus_err_i    (wb_s2m_ddr_ibus_err),
    .wb_ddr_ibus_rty_i    (wb_s2m_ddr_ibus_rty),
    .wb_ddr_eth_adr_o     (wb_m2s_ddr_eth_adr),
    .wb_ddr_eth_dat_o     (wb_m2s_ddr_eth_dat),
    .wb_ddr_eth_sel_o     (wb_m2s_ddr_eth_sel),
    .wb_ddr_eth_we_o      (wb_m2s_ddr_eth_we),
    .wb_ddr_eth_cyc_o     (wb_m2s_ddr_eth_cyc),
    .wb_ddr_eth_stb_o     (wb_m2s_ddr_eth_stb),
    .wb_ddr_eth_cti_o     (wb_m2s_ddr_eth_cti),
    .wb_ddr_eth_bte_o     (wb_m2s_ddr_eth_bte),
    .wb_ddr_eth_dat_i     (wb_s2m_ddr_eth_dat),
    .wb_ddr_eth_ack_i     (wb_s2m_ddr_eth_ack),
    .wb_ddr_eth_err_i     (wb_s2m_ddr_eth_err),
    .wb_ddr_eth_rty_i     (wb_s2m_ddr_eth_rty),
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

