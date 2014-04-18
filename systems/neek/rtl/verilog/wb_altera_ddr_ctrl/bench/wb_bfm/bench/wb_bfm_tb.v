module wb_bfm_tb;   

   vlog_tb_utils vlog_tb_utils0();
   
   localparam aw = 32;
   localparam dw = 32;
   
   reg	   wb_clk = 1'b1;
   reg	   wb_rst = 1'b1;
   
   always #5 wb_clk <= ~wb_clk;
   initial  #100 wb_rst <= 0;
   
   wire [aw-1:0] wb_m2s_adr;
   wire [dw-1:0] wb_m2s_dat;
   wire [3:0] 	 wb_m2s_sel;
   wire 	 wb_m2s_we ;
   wire 	 wb_m2s_cyc;
   wire 	 wb_m2s_stb;
   wire [2:0] 	 wb_m2s_cti;
   wire [1:0] 	 wb_m2s_bte;
   wire [dw-1:0] wb_s2m_dat;
   wire 	 wb_s2m_ack;
   wire 	 wb_s2m_err;
   wire 	 wb_s2m_rty;

   wb_master wb_master0
     (.wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_o (wb_m2s_adr),
      .wb_dat_o (wb_m2s_dat),
      .wb_sel_o (wb_m2s_sel),
      .wb_we_o  (wb_m2s_we ),
      .wb_cyc_o (wb_m2s_cyc),
      .wb_stb_o (wb_m2s_stb),
      .wb_cti_o (wb_m2s_cti),
      .wb_bte_o (wb_m2s_bte),
      .wb_dat_i (wb_s2m_dat),
      .wb_ack_i (wb_s2m_ack),
      .wb_err_i (wb_s2m_err),
      .wb_rty_i (wb_s2m_rty));
   
   wb_bfm_memory #(.DEBUG (0))
   wb_mem_model0
     (.wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_i (wb_m2s_adr),
      .wb_dat_i (wb_m2s_dat),
      .wb_sel_i (wb_m2s_sel),
      .wb_we_i  (wb_m2s_we ),
      .wb_cyc_i (wb_m2s_cyc),
      .wb_stb_i (wb_m2s_stb),
      .wb_cti_i (wb_m2s_cti),
      .wb_bte_i (wb_m2s_bte),
      .wb_dat_o (wb_s2m_dat),
      .wb_ack_o (wb_s2m_ack),
      .wb_err_o (wb_s2m_err),
      .wb_rty_o (wb_s2m_rty));
endmodule
