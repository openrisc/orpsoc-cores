module wb_uart_wrapper
  #(parameter DEBUG = 0,
    parameter SIM   = 0)
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
   output 	wb_rty_o,
   output 	int_o,
   input        rx,
   output       tx);

   generate
      if(SIM) begin : uart_model
	 wb_uart16550_model #(.DEBUG (DEBUG))
	 uart
	   (//Wishbone Master interface
	    .wb_clk_i (wb_clk_i),
	    .wb_rst_i (wb_rst_i),
	    .wb_adr_i (wb_adr_i[2:0]),
	    .wb_dat_i (wb_dat_i),
	    .wb_we_i  (wb_we_i),
	    .wb_cyc_i (wb_cyc_i),
	    .wb_stb_i (wb_stb_i),
	    .wb_cti_i (wb_cti_i),
	    .wb_bte_i (wb_bte_i),
	    .wb_dat_o (wb_dat_o),
	    .wb_ack_o (wb_ack_o),
	    .wb_err_o (wb_err_o),
	    .wb_rty_o (wb_rty_o));

	 assign tx = 1'b0;
         assign int_o = 1'b0;
      end else begin : uart16550
	 uart_top
	   #(.uart_data_width (8),
	     .uart_addr_width (3),
	     .debug           (DEBUG))
	 uart
	   (.wb_clk_i  (wb_clk_i),
	    .wb_rst_i  (wb_rst_i),
	    .wb_adr_i  (wb_adr_i[2:0]),
	    .wb_dat_i  (wb_dat_i),
	    .wb_sel_i  (4'b0),
	    .wb_we_i   (wb_we_i),
	    .wb_cyc_i  (wb_cyc_i),
	    .wb_stb_i  (wb_stb_i),
	    .wb_dat_o  (wb_dat_o),
	    .wb_ack_o  (wb_ack_o),
	    .int_o     (int_o),
	    .srx_pad_i (rx),
	    .stx_pad_o (tx),
	    .rts_pad_o (),
	    .cts_pad_i (1'b0),
	    .dtr_pad_o (),
	    .dsr_pad_i (1'b0),
	    .ri_pad_i  (1'b0),
	    .dcd_pad_i (1'b0));
	 assign wb_err_o = 1'b0;
	 assign wb_rty_o = 1'b0;
      end
   endgenerate

endmodule
