module wb_arbiter_tb
  #(parameter NUM_MASTERS = 5)
  (input wb_clk_i,
   input wb_rst_i,
   output done);

   localparam aw = 32;
   localparam dw = 32;

   localparam MEMORY_SIZE_BITS  = 8;
   localparam MEMORY_SIZE_WORDS = 2**MEMORY_SIZE_BITS;
   
   wire [aw-1:0] wbs_m2s_adr;
   wire [dw-1:0] wbs_m2s_dat;
   wire [3:0] 	 wbs_m2s_sel;
   wire 	 wbs_m2s_we ;
   wire 	 wbs_m2s_cyc;
   wire 	 wbs_m2s_stb;
   wire [2:0] 	 wbs_m2s_cti;
   wire [1:0] 	 wbs_m2s_bte;
   wire [dw-1:0] wbs_s2m_dat;
   wire 	 wbs_s2m_ack;
   wire 	 wbs_s2m_err;
   wire 	 wbs_s2m_rty;

   wire [NUM_MASTERS*aw-1:0] 	 wbm_m2s_adr;
   wire [NUM_MASTERS*dw-1:0] 	 wbm_m2s_dat;
   wire [NUM_MASTERS*4-1:0] 	 wbm_m2s_sel;
   wire [NUM_MASTERS-1:0] 	 wbm_m2s_we ;
   wire [NUM_MASTERS-1:0]	 wbm_m2s_cyc;
   wire [NUM_MASTERS-1:0]	 wbm_m2s_stb;
   wire [NUM_MASTERS*3-1:0] 	 wbm_m2s_cti;
   wire [NUM_MASTERS*2-1:0] 	 wbm_m2s_bte;
   wire [NUM_MASTERS*dw-1:0] 	 wbm_s2m_dat;
   wire [NUM_MASTERS-1:0]	 wbm_s2m_ack;
   wire [NUM_MASTERS-1:0] 	 wbm_s2m_err;
   wire [NUM_MASTERS-1:0] 	 wbm_s2m_rty;

   wire [31:0] 	 slave_writes;
   wire [31:0] 	 slave_reads;
   wire [NUM_MASTERS-1:0] done_int;

   genvar 	 i;
   
   generate
      for(i=0;i<NUM_MASTERS;i=i+1) begin : masters
	 wb_bfm_transactor
	    #(.MEM_HIGH((i+1)*MEMORY_SIZE_WORDS-1),
	      .MEM_LOW (i*MEMORY_SIZE_WORDS))
	 wb_bfm_transactor0
	    (.wb_clk_i (wb_clk_i),
	     .wb_rst_i (wb_rst_i),
	     .wb_adr_o (wbm_m2s_adr[i*aw+:aw]),
	     .wb_dat_o (wbm_m2s_dat[i*dw+:dw]),
	     .wb_sel_o (wbm_m2s_sel[i*4+:4]),
	     .wb_we_o  (wbm_m2s_we[i] ),
	     .wb_cyc_o (wbm_m2s_cyc[i]),
	     .wb_stb_o (wbm_m2s_stb[i]),
	     .wb_cti_o (wbm_m2s_cti[i*3+:3]),
	     .wb_bte_o (wbm_m2s_bte[i*2+:2]),
	     .wb_dat_i (wbm_s2m_dat[i*dw+:dw]),
	     .wb_ack_i (wbm_s2m_ack[i]),
	     .wb_err_i (wbm_s2m_err[i]),
	     .wb_rty_i (wbm_s2m_rty[i]),
	     //Test Control
	     .done(done_int[i]));
      end // block: slaves
   endgenerate
   
   integer 	 idx;

   assign done = &done_int;
   
   always @(done) begin
      if(done === 1) begin
	 $display("Average wait times");
	 for(idx=0;idx<NUM_MASTERS;idx=idx+1)
	   $display("Master %0d : %f",idx, ack_delay[idx]/num_transactions[idx]);
	 $display("All tests passed!");
      end
   end

   wb_arbiter
     #(.num_masters(NUM_MASTERS))
   wb_arbiter0
     (.wb_clk_i    (wb_clk_i),
      .wb_rst_i     (wb_rst_i),
      
      // Master Interface
      .wbm_adr_i (wbm_m2s_adr),
      .wbm_dat_i (wbm_m2s_dat),
      .wbm_sel_i (wbm_m2s_sel),
      .wbm_we_i  (wbm_m2s_we ),
      .wbm_cyc_i (wbm_m2s_cyc),
      .wbm_stb_i (wbm_m2s_stb),
      .wbm_cti_i (wbm_m2s_cti),
      .wbm_bte_i (wbm_m2s_bte),
      .wbm_dat_o (wbm_s2m_dat),
      .wbm_ack_o (wbm_s2m_ack),
      .wbm_err_o (wbm_s2m_err),
      .wbm_rty_o (wbm_s2m_rty),
      // Wishbone Slave interface
      .wbs_adr_o (wbs_m2s_adr),
      .wbs_dat_o (wbs_m2s_dat),
      .wbs_sel_o (wbs_m2s_sel),
      .wbs_we_o  (wbs_m2s_we),
      .wbs_cyc_o (wbs_m2s_cyc),
      .wbs_stb_o (wbs_m2s_stb),
      .wbs_cti_o (wbs_m2s_cti),
      .wbs_bte_o (wbs_m2s_bte),
      .wbs_dat_i (wbs_s2m_dat),
      .wbs_ack_i (wbs_s2m_ack),
      .wbs_err_i (wbs_s2m_err),
      .wbs_rty_i (wbs_s2m_rty));
   
   assign slave_writes = wb_mem_model0.writes;
   assign slave_reads  = wb_mem_model0.reads;

   time start_time[NUM_MASTERS-1:0];
   time ack_delay[NUM_MASTERS-1:0];
   integer num_transactions[NUM_MASTERS-1:0];

   generate
      for(i=0;i<NUM_MASTERS;i=i+1) begin : wait_time
	 initial begin
	    ack_delay[i] = 0;
	    num_transactions[i] = 0;
	    while(1) begin
	       @(posedge wbm_m2s_cyc[i]);
	       start_time[i] = $time;
	       @(posedge wbm_s2m_ack[i]);
	       ack_delay[i] = ack_delay[i] + $time-start_time[i];
	       num_transactions[i] = num_transactions[i]+1;
	    end
	 end
      end
   endgenerate
      
   wb_bfm_memory #(.DEBUG (0),
		   .mem_size_bytes(MEMORY_SIZE_WORDS*(dw/8)*NUM_MASTERS))
   wb_mem_model0
     (.wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i (wbs_m2s_adr),
      .wb_dat_i (wbs_m2s_dat),
      .wb_sel_i (wbs_m2s_sel),
      .wb_we_i  (wbs_m2s_we),
      .wb_cyc_i (wbs_m2s_cyc),
      .wb_stb_i (wbs_m2s_stb),
      .wb_cti_i (wbs_m2s_cti),
      .wb_bte_i (wbs_m2s_bte),
      .wb_dat_o (wbs_s2m_dat),
      .wb_ack_o (wbs_s2m_ack),
      .wb_err_o (wbs_s2m_err),
      .wb_rty_o (wbs_s2m_rty));
endmodule
