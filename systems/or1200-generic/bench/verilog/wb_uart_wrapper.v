module wb_uart_wrapper
  #(parameter DEBUG = 0)
  (// Clock, reset
   input 	wb_clk_i,
   input 	wb_rst_i,
   // Inputs
   input [31:0]	wb_adr_i,
   input [7:0] 	wb_dat_i,
   input 	wb_we_i,
   input 	wb_cyc_i,
   input 	wb_stb_i,
   input [2:0] 	wb_cti_i,
   input [1:0] 	wb_bte_i,
   // Outputs
   output [7:0] wb_dat_o,
   output 	wb_ack_o,
   output 	wb_err_o,
   output 	wb_rty_o);

wb_uart16550_model #(.DEBUG (0))
   wb_uart16550_model0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i	(wb_adr_i[2:0]),
      .wb_dat_i	(wb_dat_i),
      .wb_we_i	(wb_we_i),
      .wb_cyc_i	(wb_cyc_i),
      .wb_stb_i	(wb_stb_i),
      .wb_cti_i	(wb_cti_i),
      .wb_bte_i	(wb_bte_i),
      .wb_dat_o	(wb_dat_o),
      .wb_ack_o	(wb_ack_o),
      .wb_err_o (wb_err_o),
      .wb_rty_o (wb_rty_o));
endmodule
