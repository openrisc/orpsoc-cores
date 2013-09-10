module wb_mux_tb
  (input wb_clk_i,
   input wb_rst_i,
   output done);

   localparam NUM_SLAVES = 4;
   
   localparam aw = 32;
   localparam dw = 32;

   localparam MEMORY_SIZE_WORDS = 32'h100;
   localparam MEMORY_SIZE_BITS  = 8;

   /*TODO: Find a way to generate MATCH_ADDR and MATCH_MASK based on memory
           size and number of slaves. Missing support for constant
           user functions in Icarus Verilog is the blocker for this*/
   localparam [dw*NUM_SLAVES-1:0] MATCH_ADDR = {32'h00000300,
						32'h00000200,
						32'h00000100,
						32'h00000000};
   localparam [dw*NUM_SLAVES-1:0] MATCH_MASK = {NUM_SLAVES{32'hffffff00}};
   
   wire [NUM_SLAVES*aw-1:0] wbs_adr;
   wire [NUM_SLAVES*dw-1:0] wbs_dat;
   wire [NUM_SLAVES*4-1:0]  wbs_sel;
   wire [NUM_SLAVES-1:0]    wbs_we ;
   wire [NUM_SLAVES-1:0]    wbs_cyc;
   wire [NUM_SLAVES-1:0]    wbs_stb;
   wire [NUM_SLAVES*3-1:0]  wbs_cti;
   wire [NUM_SLAVES*2-1:0]  wbs_bte;
   wire [NUM_SLAVES*dw-1:0] wbs_rdt;
   wire [NUM_SLAVES-1:0]    wbs_ack;
   wire [NUM_SLAVES-1:0]    wbs_err;
   wire [NUM_SLAVES-1:0]    wbs_rty;

   wire [aw-1:0] wb_adr;
   wire [dw-1:0] wb_dat;
   wire [3:0] 	 wb_sel;
   wire 	 wb_we ;
   wire 	 wb_cyc;
   wire 	 wb_stb;
   wire [2:0] 	 wb_cti;
   wire [1:0] 	 wb_bte;
   wire [dw-1:0] wb_rdt;
   wire 	 wb_ack;
   wire 	 wb_err;
   wire 	 wb_rty;

   wire [31:0] 	 slave_writes [0:NUM_SLAVES-1];
   wire [31:0] 	 slave_reads  [0:NUM_SLAVES-1];
   
   genvar 	 i;

   wb_master
     #(.MEMORY_SIZE_BITS(MEMORY_SIZE_BITS+$clog2(NUM_SLAVES)))
   wb_master0
     (.wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_o (wb_adr),
      .wb_dat_o (wb_dat),
      .wb_sel_o (wb_sel),
      .wb_we_o  (wb_we ), 
      .wb_cyc_o (wb_cyc),
      .wb_stb_o (wb_stb),
      .wb_cti_o (wb_cti),
      .wb_bte_o (wb_bte),
      .wb_sdt_i (wb_rdt),
      .wb_ack_i (wb_ack),
      .wb_err_i (wb_err),
      .wb_rty_i (wb_rty),
      //Test Control
      .done(done));
   
   integer 	 idx;
   
   always @(done) begin
      if(done === 1'b1) begin
	 for(idx=0;idx<NUM_SLAVES;idx=idx+1) begin
	    $display("%0d writes to slave %0d", slave_writes[idx], idx);
	 end
	 $display("All tests passed!");
      end
   end

   wb_mux
     #(.num_slaves(NUM_SLAVES),
       .MATCH_ADDR (MATCH_ADDR),
       .MATCH_MASK (MATCH_MASK))
   wb_mux0
   (.wb_clk_i    (wb_clk_i),
    .wb_rst_i     (wb_rst_i),

    // Master Interface
    .wbm_adr_i (wb_adr),
    .wbm_dat_i (wb_dat),
    .wbm_sel_i (wb_sel),
    .wbm_we_i  (wb_we ),
    .wbm_cyc_i (wb_cyc),
    .wbm_stb_i (wb_stb),
    .wbm_cti_i (wb_cti),
    .wbm_bte_i (wb_bte),
    .wbm_rdt_o (wb_rdt),
    .wbm_ack_o (wb_ack),
    .wbm_err_o (wb_err),
    .wbm_rty_o (wb_rty), 
    // Wishbone Slave interface
    .wbs_adr_o (wbs_adr),
    .wbs_dat_o (wbs_dat),
    .wbs_sel_o (wbs_sel), 
    .wbs_we_o  (wbs_we),
    .wbs_cyc_o (wbs_cyc),
    .wbs_stb_o (wbs_stb),
    .wbs_cti_o (wbs_cti),
    .wbs_bte_o (wbs_bte),
    .wbs_rdt_i (wbs_rdt),
    .wbs_ack_i (wbs_ack),
    .wbs_err_i (wbs_err),
    .wbs_rty_i (wbs_rty));
   
   generate
      for(i=0;i<NUM_SLAVES;i=i+1) begin : slaves
	 assign slave_writes[i] = wb_mem_model0.writes;
	 assign slave_reads[i]  = wb_mem_model0.reads;
	 
	 wb_bfm_memory #(.DEBUG (0),
			 .mem_size_bytes(MEMORY_SIZE_WORDS*(dw/8)))
	 wb_mem_model0
	    (.wb_clk_i (wb_clk_i),
	     .wb_rst_i (wb_rst_i),
	     .wb_adr_i (wbs_adr[i*aw+:aw] & (2**MEMORY_SIZE_BITS-1)),
	     .wb_dat_i (wbs_dat[i*dw+:dw]),
	     .wb_sel_i (wbs_sel[i*4+:4]),
	     .wb_we_i  (wbs_we[i]),
	     .wb_cyc_i (wbs_cyc[i]),
	     .wb_stb_i (wbs_stb[i]),
	     .wb_cti_i (wbs_cti[i*3+:3]),
	     .wb_bte_i (wbs_bte[i*2+:2]),
	     .wb_sdt_o (wbs_rdt[i*dw+:dw]),
	     .wb_ack_o (wbs_ack[i]),
	     .wb_err_o (wbs_err[i]),
	     .wb_rty_o (wbs_rty[i]));
      end // block: slaves
   endgenerate
   
endmodule // orpsoc_tb
