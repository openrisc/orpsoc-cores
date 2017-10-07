wire [31:0] wb_m2s_or1k0_i_adr;
wire [31:0] wb_m2s_or1k0_i_dat;
wire  [3:0] wb_m2s_or1k0_i_sel;
wire        wb_m2s_or1k0_i_we;
wire        wb_m2s_or1k0_i_cyc;
wire        wb_m2s_or1k0_i_stb;
wire  [2:0] wb_m2s_or1k0_i_cti;
wire  [1:0] wb_m2s_or1k0_i_bte;
wire [31:0] wb_s2m_or1k0_i_dat;
wire        wb_s2m_or1k0_i_ack;
wire        wb_s2m_or1k0_i_err;
wire        wb_s2m_or1k0_i_rty;
wire [31:0] wb_m2s_or1k0_d_adr;
wire [31:0] wb_m2s_or1k0_d_dat;
wire  [3:0] wb_m2s_or1k0_d_sel;
wire        wb_m2s_or1k0_d_we;
wire        wb_m2s_or1k0_d_cyc;
wire        wb_m2s_or1k0_d_stb;
wire  [2:0] wb_m2s_or1k0_d_cti;
wire  [1:0] wb_m2s_or1k0_d_bte;
wire [31:0] wb_s2m_or1k0_d_dat;
wire        wb_s2m_or1k0_d_ack;
wire        wb_s2m_or1k0_d_err;
wire        wb_s2m_or1k0_d_rty;
wire [31:0] wb_m2s_or1k1_i_adr;
wire [31:0] wb_m2s_or1k1_i_dat;
wire  [3:0] wb_m2s_or1k1_i_sel;
wire        wb_m2s_or1k1_i_we;
wire        wb_m2s_or1k1_i_cyc;
wire        wb_m2s_or1k1_i_stb;
wire  [2:0] wb_m2s_or1k1_i_cti;
wire  [1:0] wb_m2s_or1k1_i_bte;
wire [31:0] wb_s2m_or1k1_i_dat;
wire        wb_s2m_or1k1_i_ack;
wire        wb_s2m_or1k1_i_err;
wire        wb_s2m_or1k1_i_rty;
wire [31:0] wb_m2s_or1k1_d_adr;
wire [31:0] wb_m2s_or1k1_d_dat;
wire  [3:0] wb_m2s_or1k1_d_sel;
wire        wb_m2s_or1k1_d_we;
wire        wb_m2s_or1k1_d_cyc;
wire        wb_m2s_or1k1_d_stb;
wire  [2:0] wb_m2s_or1k1_d_cti;
wire  [1:0] wb_m2s_or1k1_d_bte;
wire [31:0] wb_s2m_or1k1_d_dat;
wire        wb_s2m_or1k1_d_ack;
wire        wb_s2m_or1k1_d_err;
wire        wb_s2m_or1k1_d_rty;
wire [31:0] wb_m2s_mem_adr;
wire [31:0] wb_m2s_mem_dat;
wire  [3:0] wb_m2s_mem_sel;
wire        wb_m2s_mem_we;
wire        wb_m2s_mem_cyc;
wire        wb_m2s_mem_stb;
wire  [2:0] wb_m2s_mem_cti;
wire  [1:0] wb_m2s_mem_bte;
wire [31:0] wb_s2m_mem_dat;
wire        wb_s2m_mem_ack;
wire        wb_s2m_mem_err;
wire        wb_s2m_mem_rty;
wire [31:0] wb_m2s_uart_adr;
wire  [7:0] wb_m2s_uart_dat;
wire  [3:0] wb_m2s_uart_sel;
wire        wb_m2s_uart_we;
wire        wb_m2s_uart_cyc;
wire        wb_m2s_uart_stb;
wire  [2:0] wb_m2s_uart_cti;
wire  [1:0] wb_m2s_uart_bte;
wire  [7:0] wb_s2m_uart_dat;
wire        wb_s2m_uart_ack;
wire        wb_s2m_uart_err;
wire        wb_s2m_uart_rty;
wire [31:0] wb_m2s_ipi_adr;
wire [31:0] wb_m2s_ipi_dat;
wire  [3:0] wb_m2s_ipi_sel;
wire        wb_m2s_ipi_we;
wire        wb_m2s_ipi_cyc;
wire        wb_m2s_ipi_stb;
wire  [2:0] wb_m2s_ipi_cti;
wire  [1:0] wb_m2s_ipi_bte;
wire [31:0] wb_s2m_ipi_dat;
wire        wb_s2m_ipi_ack;
wire        wb_s2m_ipi_err;
wire        wb_s2m_ipi_rty;
wire [31:0] wb_m2s_tc_adr;
wire [31:0] wb_m2s_tc_dat;
wire  [3:0] wb_m2s_tc_sel;
wire        wb_m2s_tc_we;
wire        wb_m2s_tc_cyc;
wire        wb_m2s_tc_stb;
wire  [2:0] wb_m2s_tc_cti;
wire  [1:0] wb_m2s_tc_bte;
wire [31:0] wb_s2m_tc_dat;
wire        wb_s2m_tc_ack;
wire        wb_s2m_tc_err;
wire        wb_s2m_tc_rty;

wb_intercon wb_intercon0
   (.wb_clk_i         (wb_clk),
    .wb_rst_i         (wb_rst),
    .wb_or1k0_i_adr_i (wb_m2s_or1k0_i_adr),
    .wb_or1k0_i_dat_i (wb_m2s_or1k0_i_dat),
    .wb_or1k0_i_sel_i (wb_m2s_or1k0_i_sel),
    .wb_or1k0_i_we_i  (wb_m2s_or1k0_i_we),
    .wb_or1k0_i_cyc_i (wb_m2s_or1k0_i_cyc),
    .wb_or1k0_i_stb_i (wb_m2s_or1k0_i_stb),
    .wb_or1k0_i_cti_i (wb_m2s_or1k0_i_cti),
    .wb_or1k0_i_bte_i (wb_m2s_or1k0_i_bte),
    .wb_or1k0_i_dat_o (wb_s2m_or1k0_i_dat),
    .wb_or1k0_i_ack_o (wb_s2m_or1k0_i_ack),
    .wb_or1k0_i_err_o (wb_s2m_or1k0_i_err),
    .wb_or1k0_i_rty_o (wb_s2m_or1k0_i_rty),
    .wb_or1k0_d_adr_i (wb_m2s_or1k0_d_adr),
    .wb_or1k0_d_dat_i (wb_m2s_or1k0_d_dat),
    .wb_or1k0_d_sel_i (wb_m2s_or1k0_d_sel),
    .wb_or1k0_d_we_i  (wb_m2s_or1k0_d_we),
    .wb_or1k0_d_cyc_i (wb_m2s_or1k0_d_cyc),
    .wb_or1k0_d_stb_i (wb_m2s_or1k0_d_stb),
    .wb_or1k0_d_cti_i (wb_m2s_or1k0_d_cti),
    .wb_or1k0_d_bte_i (wb_m2s_or1k0_d_bte),
    .wb_or1k0_d_dat_o (wb_s2m_or1k0_d_dat),
    .wb_or1k0_d_ack_o (wb_s2m_or1k0_d_ack),
    .wb_or1k0_d_err_o (wb_s2m_or1k0_d_err),
    .wb_or1k0_d_rty_o (wb_s2m_or1k0_d_rty),
    .wb_or1k1_i_adr_i (wb_m2s_or1k1_i_adr),
    .wb_or1k1_i_dat_i (wb_m2s_or1k1_i_dat),
    .wb_or1k1_i_sel_i (wb_m2s_or1k1_i_sel),
    .wb_or1k1_i_we_i  (wb_m2s_or1k1_i_we),
    .wb_or1k1_i_cyc_i (wb_m2s_or1k1_i_cyc),
    .wb_or1k1_i_stb_i (wb_m2s_or1k1_i_stb),
    .wb_or1k1_i_cti_i (wb_m2s_or1k1_i_cti),
    .wb_or1k1_i_bte_i (wb_m2s_or1k1_i_bte),
    .wb_or1k1_i_dat_o (wb_s2m_or1k1_i_dat),
    .wb_or1k1_i_ack_o (wb_s2m_or1k1_i_ack),
    .wb_or1k1_i_err_o (wb_s2m_or1k1_i_err),
    .wb_or1k1_i_rty_o (wb_s2m_or1k1_i_rty),
    .wb_or1k1_d_adr_i (wb_m2s_or1k1_d_adr),
    .wb_or1k1_d_dat_i (wb_m2s_or1k1_d_dat),
    .wb_or1k1_d_sel_i (wb_m2s_or1k1_d_sel),
    .wb_or1k1_d_we_i  (wb_m2s_or1k1_d_we),
    .wb_or1k1_d_cyc_i (wb_m2s_or1k1_d_cyc),
    .wb_or1k1_d_stb_i (wb_m2s_or1k1_d_stb),
    .wb_or1k1_d_cti_i (wb_m2s_or1k1_d_cti),
    .wb_or1k1_d_bte_i (wb_m2s_or1k1_d_bte),
    .wb_or1k1_d_dat_o (wb_s2m_or1k1_d_dat),
    .wb_or1k1_d_ack_o (wb_s2m_or1k1_d_ack),
    .wb_or1k1_d_err_o (wb_s2m_or1k1_d_err),
    .wb_or1k1_d_rty_o (wb_s2m_or1k1_d_rty),
    .wb_mem_adr_o     (wb_m2s_mem_adr),
    .wb_mem_dat_o     (wb_m2s_mem_dat),
    .wb_mem_sel_o     (wb_m2s_mem_sel),
    .wb_mem_we_o      (wb_m2s_mem_we),
    .wb_mem_cyc_o     (wb_m2s_mem_cyc),
    .wb_mem_stb_o     (wb_m2s_mem_stb),
    .wb_mem_cti_o     (wb_m2s_mem_cti),
    .wb_mem_bte_o     (wb_m2s_mem_bte),
    .wb_mem_dat_i     (wb_s2m_mem_dat),
    .wb_mem_ack_i     (wb_s2m_mem_ack),
    .wb_mem_err_i     (wb_s2m_mem_err),
    .wb_mem_rty_i     (wb_s2m_mem_rty),
    .wb_uart_adr_o    (wb_m2s_uart_adr),
    .wb_uart_dat_o    (wb_m2s_uart_dat),
    .wb_uart_sel_o    (wb_m2s_uart_sel),
    .wb_uart_we_o     (wb_m2s_uart_we),
    .wb_uart_cyc_o    (wb_m2s_uart_cyc),
    .wb_uart_stb_o    (wb_m2s_uart_stb),
    .wb_uart_cti_o    (wb_m2s_uart_cti),
    .wb_uart_bte_o    (wb_m2s_uart_bte),
    .wb_uart_dat_i    (wb_s2m_uart_dat),
    .wb_uart_ack_i    (wb_s2m_uart_ack),
    .wb_uart_err_i    (wb_s2m_uart_err),
    .wb_uart_rty_i    (wb_s2m_uart_rty),
    .wb_ipi_adr_o     (wb_m2s_ipi_adr),
    .wb_ipi_dat_o     (wb_m2s_ipi_dat),
    .wb_ipi_sel_o     (wb_m2s_ipi_sel),
    .wb_ipi_we_o      (wb_m2s_ipi_we),
    .wb_ipi_cyc_o     (wb_m2s_ipi_cyc),
    .wb_ipi_stb_o     (wb_m2s_ipi_stb),
    .wb_ipi_cti_o     (wb_m2s_ipi_cti),
    .wb_ipi_bte_o     (wb_m2s_ipi_bte),
    .wb_ipi_dat_i     (wb_s2m_ipi_dat),
    .wb_ipi_ack_i     (wb_s2m_ipi_ack),
    .wb_ipi_err_i     (wb_s2m_ipi_err),
    .wb_ipi_rty_i     (wb_s2m_ipi_rty),
    .wb_tc_adr_o      (wb_m2s_tc_adr),
    .wb_tc_dat_o      (wb_m2s_tc_dat),
    .wb_tc_sel_o      (wb_m2s_tc_sel),
    .wb_tc_we_o       (wb_m2s_tc_we),
    .wb_tc_cyc_o      (wb_m2s_tc_cyc),
    .wb_tc_stb_o      (wb_m2s_tc_stb),
    .wb_tc_cti_o      (wb_m2s_tc_cti),
    .wb_tc_bte_o      (wb_m2s_tc_bte),
    .wb_tc_dat_i      (wb_s2m_tc_dat),
    .wb_tc_ack_i      (wb_s2m_tc_ack),
    .wb_tc_err_i      (wb_s2m_tc_err),
    .wb_tc_rty_i      (wb_s2m_tc_rty));

