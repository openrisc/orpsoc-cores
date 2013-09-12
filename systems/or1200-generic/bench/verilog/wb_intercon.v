module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_m2s_or1200_d_adr,
    input  [31:0] wb_m2s_or1200_d_dat,
    input   [3:0] wb_m2s_or1200_d_sel,
    input         wb_m2s_or1200_d_we,
    input         wb_m2s_or1200_d_cyc,
    input         wb_m2s_or1200_d_stb,
    input   [2:0] wb_m2s_or1200_d_cti,
    input   [1:0] wb_m2s_or1200_d_bte,
    output [31:0] wb_s2m_or1200_d_dat,
    output        wb_s2m_or1200_d_ack,
    output        wb_s2m_or1200_d_err,
    output        wb_s2m_or1200_d_rty,
    input  [31:0] wb_m2s_or1200_i_adr,
    input  [31:0] wb_m2s_or1200_i_dat,
    input   [3:0] wb_m2s_or1200_i_sel,
    input         wb_m2s_or1200_i_we,
    input         wb_m2s_or1200_i_cyc,
    input         wb_m2s_or1200_i_stb,
    input   [2:0] wb_m2s_or1200_i_cti,
    input   [1:0] wb_m2s_or1200_i_bte,
    output [31:0] wb_s2m_or1200_i_dat,
    output        wb_s2m_or1200_i_ack,
    output        wb_s2m_or1200_i_err,
    output        wb_s2m_or1200_i_rty,
    output [31:0] wb_m2s_uart_adr,
    output [31:0] wb_m2s_uart_dat,
    output  [3:0] wb_m2s_uart_sel,
    output        wb_m2s_uart_we,
    output        wb_m2s_uart_cyc,
    output        wb_m2s_uart_stb,
    output  [2:0] wb_m2s_uart_cti,
    output  [1:0] wb_m2s_uart_bte,
    input  [31:0] wb_s2m_uart_dat,
    input         wb_s2m_uart_ack,
    input         wb_s2m_uart_err,
    input         wb_s2m_uart_rty,
    output [31:0] wb_m2s_mem_adr,
    output [31:0] wb_m2s_mem_dat,
    output  [3:0] wb_m2s_mem_sel,
    output        wb_m2s_mem_we,
    output        wb_m2s_mem_cyc,
    output        wb_m2s_mem_stb,
    output  [2:0] wb_m2s_mem_cti,
    output  [1:0] wb_m2s_mem_bte,
    input  [31:0] wb_s2m_mem_dat,
    input         wb_s2m_mem_ack,
    input         wb_s2m_mem_err,
    input         wb_s2m_mem_rty);

wire [31:0] wb_m2s_or1200_d_mem_adr;
wire [31:0] wb_m2s_or1200_d_mem_dat;
wire  [3:0] wb_m2s_or1200_d_mem_sel;
wire        wb_m2s_or1200_d_mem_we;
wire        wb_m2s_or1200_d_mem_cyc;
wire        wb_m2s_or1200_d_mem_stb;
wire  [2:0] wb_m2s_or1200_d_mem_cti;
wire  [1:0] wb_m2s_or1200_d_mem_bte;
wire [31:0] wb_s2m_or1200_d_mem_dat;
wire        wb_s2m_or1200_d_mem_ack;
wire        wb_s2m_or1200_d_mem_err;
wire        wb_s2m_or1200_d_mem_rty;

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h00000000, 32'h90000000}),
    .MATCH_MASK ({32'hff800000, 32'hfffffff8}))
 wb_mux_or1200_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_m2s_or1200_d_adr),
    .wbm_dat_i (wb_m2s_or1200_d_dat),
    .wbm_sel_i (wb_m2s_or1200_d_sel),
    .wbm_we_i  (wb_m2s_or1200_d_we),
    .wbm_cyc_i (wb_m2s_or1200_d_cyc),
    .wbm_stb_i (wb_m2s_or1200_d_stb),
    .wbm_cti_i (wb_m2s_or1200_d_cti),
    .wbm_bte_i (wb_m2s_or1200_d_bte),
    .wbm_dat_o (wb_s2m_or1200_d_dat),
    .wbm_ack_o (wb_s2m_or1200_d_ack),
    .wbm_err_o (wb_s2m_or1200_d_err),
    .wbm_rty_o (wb_s2m_or1200_d_rty),
    .wbs_adr_o ({wb_m2s_or1200_d_mem_adr, wb_m2s_uart_adr}),
    .wbs_dat_o ({wb_m2s_or1200_d_mem_dat, wb_m2s_uart_dat}),
    .wbs_sel_o ({wb_m2s_or1200_d_mem_sel, wb_m2s_uart_sel}),
    .wbs_we_o  ({wb_m2s_or1200_d_mem_we, wb_m2s_uart_we}),
    .wbs_cyc_o ({wb_m2s_or1200_d_mem_cyc, wb_m2s_uart_cyc}),
    .wbs_stb_o ({wb_m2s_or1200_d_mem_stb, wb_m2s_uart_stb}),
    .wbs_cti_o ({wb_m2s_or1200_d_mem_cti, wb_m2s_uart_cti}),
    .wbs_bte_o ({wb_m2s_or1200_d_mem_bte, wb_m2s_uart_bte}),
    .wbs_dat_i ({wb_s2m_or1200_d_mem_dat, wb_s2m_uart_dat}),
    .wbs_ack_i ({wb_s2m_or1200_d_mem_ack, wb_s2m_uart_ack}),
    .wbs_err_i ({wb_s2m_or1200_d_mem_err, wb_s2m_uart_err}),
    .wbs_rty_i ({wb_s2m_or1200_d_mem_rty, wb_s2m_uart_rty}));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_mem
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1200_d_mem_adr, wb_m2s_or1200_i_adr}),
    .wbm_dat_i ({wb_m2s_or1200_d_mem_dat, wb_m2s_or1200_i_dat}),
    .wbm_sel_i ({wb_m2s_or1200_d_mem_sel, wb_m2s_or1200_i_sel}),
    .wbm_we_i  ({wb_m2s_or1200_d_mem_we, wb_m2s_or1200_i_we}),
    .wbm_cyc_i ({wb_m2s_or1200_d_mem_cyc, wb_m2s_or1200_i_cyc}),
    .wbm_stb_i ({wb_m2s_or1200_d_mem_stb, wb_m2s_or1200_i_stb}),
    .wbm_cti_i ({wb_m2s_or1200_d_mem_cti, wb_m2s_or1200_i_cti}),
    .wbm_bte_i ({wb_m2s_or1200_d_mem_bte, wb_m2s_or1200_i_bte}),
    .wbm_dat_o ({wb_s2m_or1200_d_mem_dat, wb_s2m_or1200_i_dat}),
    .wbm_ack_o ({wb_s2m_or1200_d_mem_ack, wb_s2m_or1200_i_ack}),
    .wbm_err_o ({wb_s2m_or1200_d_mem_err, wb_s2m_or1200_i_err}),
    .wbm_rty_o ({wb_s2m_or1200_d_mem_rty, wb_s2m_or1200_i_rty}),
    .wbs_adr_o (wb_m2s_mem_adr),
    .wbs_dat_o (wb_m2s_mem_dat),
    .wbs_sel_o (wb_m2s_mem_sel),
    .wbs_we_o  (wb_m2s_mem_we),
    .wbs_cyc_o (wb_m2s_mem_cyc),
    .wbs_stb_o (wb_m2s_mem_stb),
    .wbs_cti_o (wb_m2s_mem_cti),
    .wbs_bte_o (wb_m2s_mem_bte),
    .wbs_dat_i (wb_s2m_mem_dat),
    .wbs_ack_i (wb_s2m_mem_ack),
    .wbs_err_i (wb_s2m_mem_err),
    .wbs_rty_i (wb_s2m_mem_rty));

endmodule
