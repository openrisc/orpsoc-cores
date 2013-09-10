module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_or1200_d_adr_i,
    input  [31:0] wb_or1200_d_dat_i,
    input   [3:0] wb_or1200_d_sel_i,
    input         wb_or1200_d_we_i,
    input         wb_or1200_d_cyc_i,
    input         wb_or1200_d_stb_i,
    input   [2:0] wb_or1200_d_cti_i,
    input   [1:0] wb_or1200_d_bte_i,
    output [31:0] wb_or1200_d_rdt_o,
    output        wb_or1200_d_ack_o,
    output        wb_or1200_d_err_o,
    output        wb_or1200_d_rty_o,
    input  [31:0] wb_or1200_i_adr_i,
    input  [31:0] wb_or1200_i_dat_i,
    input   [3:0] wb_or1200_i_sel_i,
    input         wb_or1200_i_we_i,
    input         wb_or1200_i_cyc_i,
    input         wb_or1200_i_stb_i,
    input   [2:0] wb_or1200_i_cti_i,
    input   [1:0] wb_or1200_i_bte_i,
    output [31:0] wb_or1200_i_rdt_o,
    output        wb_or1200_i_ack_o,
    output        wb_or1200_i_err_o,
    output        wb_or1200_i_rty_o,
    output [31:0] wb_mem_adr_o,
    output [31:0] wb_mem_dat_o,
    output  [3:0] wb_mem_sel_o,
    output        wb_mem_we_o,
    output        wb_mem_cyc_o,
    output        wb_mem_stb_o,
    output  [2:0] wb_mem_cti_o,
    output  [1:0] wb_mem_bte_o,
    input  [31:0] wb_mem_rdt_i,
    input         wb_mem_ack_i,
    input         wb_mem_err_i,
    input         wb_mem_rty_i,
    output [31:0] wb_uart_adr_o,
    output [31:0] wb_uart_dat_o,
    output  [3:0] wb_uart_sel_o,
    output        wb_uart_we_o,
    output        wb_uart_cyc_o,
    output        wb_uart_stb_o,
    output  [2:0] wb_uart_cti_o,
    output  [1:0] wb_uart_bte_o,
    input  [31:0] wb_uart_rdt_i,
    input         wb_uart_ack_i,
    input         wb_uart_err_i,
    input         wb_uart_rty_i);

wire [31:0] wb_or1200_d_mem_adr;
wire [31:0] wb_or1200_d_mem_dat;
wire  [3:0] wb_or1200_d_mem_sel;
wire        wb_or1200_d_mem_we;
wire        wb_or1200_d_mem_cyc;
wire        wb_or1200_d_mem_stb;
wire  [2:0] wb_or1200_d_mem_cti;
wire  [1:0] wb_or1200_d_mem_bte;
wire [31:0] wb_or1200_d_mem_rdt;
wire        wb_or1200_d_mem_ack;
wire        wb_or1200_d_mem_err;
wire        wb_or1200_d_mem_rty;

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h00000000, 32'h90000000}),
    .MATCH_MASK ({32'hff800000, 32'hfffffff8}))
 wb_mux_or1200_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1200_d_adr_i),
    .wbm_dat_i (wb_or1200_d_dat_i),
    .wbm_sel_i (wb_or1200_d_sel_i),
    .wbm_we_i  (wb_or1200_d_we_i),
    .wbm_cyc_i (wb_or1200_d_cyc_i),
    .wbm_stb_i (wb_or1200_d_stb_i),
    .wbm_cti_i (wb_or1200_d_cti_i),
    .wbm_bte_i (wb_or1200_d_bte_i),
    .wbm_rdt_o (wb_or1200_d_rdt_o),
    .wbm_ack_o (wb_or1200_d_ack_o),
    .wbm_err_o (wb_or1200_d_err_o),
    .wbm_rty_o (wb_or1200_d_rty_o),
    .wbs_adr_o ({wb_or1200_d_mem_adr, wb_uart_adr_o}),
    .wbs_dat_o ({wb_or1200_d_mem_dat, wb_uart_dat_o}),
    .wbs_sel_o ({wb_or1200_d_mem_sel, wb_uart_sel_o}),
    .wbs_we_o  ({wb_or1200_d_mem_we, wb_uart_we_o}),
    .wbs_cyc_o ({wb_or1200_d_mem_cyc, wb_uart_cyc_o}),
    .wbs_stb_o ({wb_or1200_d_mem_stb, wb_uart_stb_o}),
    .wbs_cti_o ({wb_or1200_d_mem_cti, wb_uart_cti_o}),
    .wbs_bte_o ({wb_or1200_d_mem_bte, wb_uart_bte_o}),
    .wbs_rdt_i ({wb_or1200_d_mem_rdt, wb_uart_rdt_i}),
    .wbs_ack_i ({wb_or1200_d_mem_ack, wb_uart_ack_i}),
    .wbs_err_i ({wb_or1200_d_mem_err, wb_uart_err_i}),
    .wbs_rty_i ({wb_or1200_d_mem_rty, wb_uart_rty_i}));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_mem
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_or1200_d_mem_adr, wb_or1200_i_adr_i}),
    .wbm_dat_i ({wb_or1200_d_mem_dat, wb_or1200_i_dat_i}),
    .wbm_sel_i ({wb_or1200_d_mem_sel, wb_or1200_i_sel_i}),
    .wbm_we_i  ({wb_or1200_d_mem_we, wb_or1200_i_we_i}),
    .wbm_cyc_i ({wb_or1200_d_mem_cyc, wb_or1200_i_cyc_i}),
    .wbm_stb_i ({wb_or1200_d_mem_stb, wb_or1200_i_stb_i}),
    .wbm_cti_i ({wb_or1200_d_mem_cti, wb_or1200_i_cti_i}),
    .wbm_bte_i ({wb_or1200_d_mem_bte, wb_or1200_i_bte_i}),
    .wbm_rdt_o ({wb_or1200_d_mem_rdt, wb_or1200_i_rdt_o}),
    .wbm_ack_o ({wb_or1200_d_mem_ack, wb_or1200_i_ack_o}),
    .wbm_err_o ({wb_or1200_d_mem_err, wb_or1200_i_err_o}),
    .wbm_rty_o ({wb_or1200_d_mem_rty, wb_or1200_i_rty_o}),
    .wbs_adr_o (wb_mem_adr_o),
    .wbs_dat_o (wb_mem_dat_o),
    .wbs_sel_o (wb_mem_sel_o),
    .wbs_we_o  (wb_mem_we_o),
    .wbs_cyc_o (wb_mem_cyc_o),
    .wbs_stb_o (wb_mem_stb_o),
    .wbs_cti_o (wb_mem_cti_o),
    .wbs_bte_o (wb_mem_bte_o),
    .wbs_rdt_i (wb_mem_rdt_i),
    .wbs_ack_i (wb_mem_ack_i),
    .wbs_err_i (wb_mem_err_i),
    .wbs_rty_i (wb_mem_rty_i));

endmodule
