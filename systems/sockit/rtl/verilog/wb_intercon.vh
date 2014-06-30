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
wire [31:0] wb_m2s_h2f_lw_adr;
wire [31:0] wb_m2s_h2f_lw_dat;
wire  [3:0] wb_m2s_h2f_lw_sel;
wire        wb_m2s_h2f_lw_we;
wire        wb_m2s_h2f_lw_cyc;
wire        wb_m2s_h2f_lw_stb;
wire  [2:0] wb_m2s_h2f_lw_cti;
wire  [1:0] wb_m2s_h2f_lw_bte;
wire [31:0] wb_s2m_h2f_lw_dat;
wire        wb_s2m_h2f_lw_ack;
wire        wb_s2m_h2f_lw_err;
wire        wb_s2m_h2f_lw_rty;
wire [31:0] wb_m2s_fpga_ddr3_adr;
wire [31:0] wb_m2s_fpga_ddr3_dat;
wire  [3:0] wb_m2s_fpga_ddr3_sel;
wire        wb_m2s_fpga_ddr3_we;
wire        wb_m2s_fpga_ddr3_cyc;
wire        wb_m2s_fpga_ddr3_stb;
wire  [2:0] wb_m2s_fpga_ddr3_cti;
wire  [1:0] wb_m2s_fpga_ddr3_bte;
wire [31:0] wb_s2m_fpga_ddr3_dat;
wire        wb_s2m_fpga_ddr3_ack;
wire        wb_s2m_fpga_ddr3_err;
wire        wb_s2m_fpga_ddr3_rty;
wire [31:0] wb_m2s_gpio0_adr;
wire  [7:0] wb_m2s_gpio0_dat;
wire  [3:0] wb_m2s_gpio0_sel;
wire        wb_m2s_gpio0_we;
wire        wb_m2s_gpio0_cyc;
wire        wb_m2s_gpio0_stb;
wire  [2:0] wb_m2s_gpio0_cti;
wire  [1:0] wb_m2s_gpio0_bte;
wire  [7:0] wb_s2m_gpio0_dat;
wire        wb_s2m_gpio0_ack;
wire        wb_s2m_gpio0_err;
wire        wb_s2m_gpio0_rty;
wire [31:0] wb_m2s_hps_ddr3_adr;
wire [31:0] wb_m2s_hps_ddr3_dat;
wire  [3:0] wb_m2s_hps_ddr3_sel;
wire        wb_m2s_hps_ddr3_we;
wire        wb_m2s_hps_ddr3_cyc;
wire        wb_m2s_hps_ddr3_stb;
wire  [2:0] wb_m2s_hps_ddr3_cti;
wire  [1:0] wb_m2s_hps_ddr3_bte;
wire [31:0] wb_s2m_hps_ddr3_dat;
wire        wb_s2m_hps_ddr3_ack;
wire        wb_s2m_hps_ddr3_err;
wire        wb_s2m_hps_ddr3_rty;
wire [31:0] wb_m2s_clkgen_adr;
wire [31:0] wb_m2s_clkgen_dat;
wire  [3:0] wb_m2s_clkgen_sel;
wire        wb_m2s_clkgen_we;
wire        wb_m2s_clkgen_cyc;
wire        wb_m2s_clkgen_stb;
wire  [2:0] wb_m2s_clkgen_cti;
wire  [1:0] wb_m2s_clkgen_bte;
wire [31:0] wb_s2m_clkgen_dat;
wire        wb_s2m_clkgen_ack;
wire        wb_s2m_clkgen_err;
wire        wb_s2m_clkgen_rty;
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
wire [31:0] wb_m2s_vga0_ddr3_adr;
wire [31:0] wb_m2s_vga0_ddr3_dat;
wire  [3:0] wb_m2s_vga0_ddr3_sel;
wire        wb_m2s_vga0_ddr3_we;
wire        wb_m2s_vga0_ddr3_cyc;
wire        wb_m2s_vga0_ddr3_stb;
wire  [2:0] wb_m2s_vga0_ddr3_cti;
wire  [1:0] wb_m2s_vga0_ddr3_bte;
wire [31:0] wb_s2m_vga0_ddr3_dat;
wire        wb_s2m_vga0_ddr3_ack;
wire        wb_s2m_vga0_ddr3_err;
wire        wb_s2m_vga0_ddr3_rty;
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
wire [31:0] wb_m2s_sram0_adr;
wire [31:0] wb_m2s_sram0_dat;
wire  [3:0] wb_m2s_sram0_sel;
wire        wb_m2s_sram0_we;
wire        wb_m2s_sram0_cyc;
wire        wb_m2s_sram0_stb;
wire  [2:0] wb_m2s_sram0_cti;
wire  [1:0] wb_m2s_sram0_bte;
wire [31:0] wb_s2m_sram0_dat;
wire        wb_s2m_sram0_ack;
wire        wb_s2m_sram0_err;
wire        wb_s2m_sram0_rty;
wire [31:0] wb_m2s_vga0_slave_adr;
wire [31:0] wb_m2s_vga0_slave_dat;
wire  [3:0] wb_m2s_vga0_slave_sel;
wire        wb_m2s_vga0_slave_we;
wire        wb_m2s_vga0_slave_cyc;
wire        wb_m2s_vga0_slave_stb;
wire  [2:0] wb_m2s_vga0_slave_cti;
wire  [1:0] wb_m2s_vga0_slave_bte;
wire [31:0] wb_s2m_vga0_slave_dat;
wire        wb_s2m_vga0_slave_ack;
wire        wb_s2m_vga0_slave_err;
wire        wb_s2m_vga0_slave_rty;
wire [31:0] wb_m2s_i2c0_adr;
wire  [7:0] wb_m2s_i2c0_dat;
wire  [3:0] wb_m2s_i2c0_sel;
wire        wb_m2s_i2c0_we;
wire        wb_m2s_i2c0_cyc;
wire        wb_m2s_i2c0_stb;
wire  [2:0] wb_m2s_i2c0_cti;
wire  [1:0] wb_m2s_i2c0_bte;
wire  [7:0] wb_s2m_i2c0_dat;
wire        wb_s2m_i2c0_ack;
wire        wb_s2m_i2c0_err;
wire        wb_s2m_i2c0_rty;

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
    .wb_h2f_lw_adr_i      (wb_m2s_h2f_lw_adr),
    .wb_h2f_lw_dat_i      (wb_m2s_h2f_lw_dat),
    .wb_h2f_lw_sel_i      (wb_m2s_h2f_lw_sel),
    .wb_h2f_lw_we_i       (wb_m2s_h2f_lw_we),
    .wb_h2f_lw_cyc_i      (wb_m2s_h2f_lw_cyc),
    .wb_h2f_lw_stb_i      (wb_m2s_h2f_lw_stb),
    .wb_h2f_lw_cti_i      (wb_m2s_h2f_lw_cti),
    .wb_h2f_lw_bte_i      (wb_m2s_h2f_lw_bte),
    .wb_h2f_lw_dat_o      (wb_s2m_h2f_lw_dat),
    .wb_h2f_lw_ack_o      (wb_s2m_h2f_lw_ack),
    .wb_h2f_lw_err_o      (wb_s2m_h2f_lw_err),
    .wb_h2f_lw_rty_o      (wb_s2m_h2f_lw_rty),
    .wb_fpga_ddr3_adr_o   (wb_m2s_fpga_ddr3_adr),
    .wb_fpga_ddr3_dat_o   (wb_m2s_fpga_ddr3_dat),
    .wb_fpga_ddr3_sel_o   (wb_m2s_fpga_ddr3_sel),
    .wb_fpga_ddr3_we_o    (wb_m2s_fpga_ddr3_we),
    .wb_fpga_ddr3_cyc_o   (wb_m2s_fpga_ddr3_cyc),
    .wb_fpga_ddr3_stb_o   (wb_m2s_fpga_ddr3_stb),
    .wb_fpga_ddr3_cti_o   (wb_m2s_fpga_ddr3_cti),
    .wb_fpga_ddr3_bte_o   (wb_m2s_fpga_ddr3_bte),
    .wb_fpga_ddr3_dat_i   (wb_s2m_fpga_ddr3_dat),
    .wb_fpga_ddr3_ack_i   (wb_s2m_fpga_ddr3_ack),
    .wb_fpga_ddr3_err_i   (wb_s2m_fpga_ddr3_err),
    .wb_fpga_ddr3_rty_i   (wb_s2m_fpga_ddr3_rty),
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
    .wb_hps_ddr3_adr_o    (wb_m2s_hps_ddr3_adr),
    .wb_hps_ddr3_dat_o    (wb_m2s_hps_ddr3_dat),
    .wb_hps_ddr3_sel_o    (wb_m2s_hps_ddr3_sel),
    .wb_hps_ddr3_we_o     (wb_m2s_hps_ddr3_we),
    .wb_hps_ddr3_cyc_o    (wb_m2s_hps_ddr3_cyc),
    .wb_hps_ddr3_stb_o    (wb_m2s_hps_ddr3_stb),
    .wb_hps_ddr3_cti_o    (wb_m2s_hps_ddr3_cti),
    .wb_hps_ddr3_bte_o    (wb_m2s_hps_ddr3_bte),
    .wb_hps_ddr3_dat_i    (wb_s2m_hps_ddr3_dat),
    .wb_hps_ddr3_ack_i    (wb_s2m_hps_ddr3_ack),
    .wb_hps_ddr3_err_i    (wb_s2m_hps_ddr3_err),
    .wb_hps_ddr3_rty_i    (wb_s2m_hps_ddr3_rty),
    .wb_clkgen_adr_o      (wb_m2s_clkgen_adr),
    .wb_clkgen_dat_o      (wb_m2s_clkgen_dat),
    .wb_clkgen_sel_o      (wb_m2s_clkgen_sel),
    .wb_clkgen_we_o       (wb_m2s_clkgen_we),
    .wb_clkgen_cyc_o      (wb_m2s_clkgen_cyc),
    .wb_clkgen_stb_o      (wb_m2s_clkgen_stb),
    .wb_clkgen_cti_o      (wb_m2s_clkgen_cti),
    .wb_clkgen_bte_o      (wb_m2s_clkgen_bte),
    .wb_clkgen_dat_i      (wb_s2m_clkgen_dat),
    .wb_clkgen_ack_i      (wb_s2m_clkgen_ack),
    .wb_clkgen_err_i      (wb_s2m_clkgen_err),
    .wb_clkgen_rty_i      (wb_s2m_clkgen_rty),
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
    .wb_vga0_ddr3_adr_o   (wb_m2s_vga0_ddr3_adr),
    .wb_vga0_ddr3_dat_o   (wb_m2s_vga0_ddr3_dat),
    .wb_vga0_ddr3_sel_o   (wb_m2s_vga0_ddr3_sel),
    .wb_vga0_ddr3_we_o    (wb_m2s_vga0_ddr3_we),
    .wb_vga0_ddr3_cyc_o   (wb_m2s_vga0_ddr3_cyc),
    .wb_vga0_ddr3_stb_o   (wb_m2s_vga0_ddr3_stb),
    .wb_vga0_ddr3_cti_o   (wb_m2s_vga0_ddr3_cti),
    .wb_vga0_ddr3_bte_o   (wb_m2s_vga0_ddr3_bte),
    .wb_vga0_ddr3_dat_i   (wb_s2m_vga0_ddr3_dat),
    .wb_vga0_ddr3_ack_i   (wb_s2m_vga0_ddr3_ack),
    .wb_vga0_ddr3_err_i   (wb_s2m_vga0_ddr3_err),
    .wb_vga0_ddr3_rty_i   (wb_s2m_vga0_ddr3_rty),
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
    .wb_sram0_adr_o       (wb_m2s_sram0_adr),
    .wb_sram0_dat_o       (wb_m2s_sram0_dat),
    .wb_sram0_sel_o       (wb_m2s_sram0_sel),
    .wb_sram0_we_o        (wb_m2s_sram0_we),
    .wb_sram0_cyc_o       (wb_m2s_sram0_cyc),
    .wb_sram0_stb_o       (wb_m2s_sram0_stb),
    .wb_sram0_cti_o       (wb_m2s_sram0_cti),
    .wb_sram0_bte_o       (wb_m2s_sram0_bte),
    .wb_sram0_dat_i       (wb_s2m_sram0_dat),
    .wb_sram0_ack_i       (wb_s2m_sram0_ack),
    .wb_sram0_err_i       (wb_s2m_sram0_err),
    .wb_sram0_rty_i       (wb_s2m_sram0_rty),
    .wb_vga0_slave_adr_o  (wb_m2s_vga0_slave_adr),
    .wb_vga0_slave_dat_o  (wb_m2s_vga0_slave_dat),
    .wb_vga0_slave_sel_o  (wb_m2s_vga0_slave_sel),
    .wb_vga0_slave_we_o   (wb_m2s_vga0_slave_we),
    .wb_vga0_slave_cyc_o  (wb_m2s_vga0_slave_cyc),
    .wb_vga0_slave_stb_o  (wb_m2s_vga0_slave_stb),
    .wb_vga0_slave_cti_o  (wb_m2s_vga0_slave_cti),
    .wb_vga0_slave_bte_o  (wb_m2s_vga0_slave_bte),
    .wb_vga0_slave_dat_i  (wb_s2m_vga0_slave_dat),
    .wb_vga0_slave_ack_i  (wb_s2m_vga0_slave_ack),
    .wb_vga0_slave_err_i  (wb_s2m_vga0_slave_err),
    .wb_vga0_slave_rty_i  (wb_s2m_vga0_slave_rty),
    .wb_i2c0_adr_o        (wb_m2s_i2c0_adr),
    .wb_i2c0_dat_o        (wb_m2s_i2c0_dat),
    .wb_i2c0_sel_o        (wb_m2s_i2c0_sel),
    .wb_i2c0_we_o         (wb_m2s_i2c0_we),
    .wb_i2c0_cyc_o        (wb_m2s_i2c0_cyc),
    .wb_i2c0_stb_o        (wb_m2s_i2c0_stb),
    .wb_i2c0_cti_o        (wb_m2s_i2c0_cti),
    .wb_i2c0_bte_o        (wb_m2s_i2c0_bte),
    .wb_i2c0_dat_i        (wb_s2m_i2c0_dat),
    .wb_i2c0_ack_i        (wb_s2m_i2c0_ack),
    .wb_i2c0_err_i        (wb_s2m_i2c0_err),
    .wb_i2c0_rty_i        (wb_s2m_i2c0_rty));

