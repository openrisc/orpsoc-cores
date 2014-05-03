/*
 * Copyright (c) 2014, Olof Kindgren <olof.kindgren@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module wb_ram_tb;

   localparam MEMORY_SIZE_WORDS = 128;
   
   localparam WB_PORTS = 1;

   vlog_tb_utils vlog_tb_utils0();

   reg wbm_rst = 1'b1;
   
   reg wb_clk = 1'b1;
   reg wb_rst = 1'b1;
   
   initial #1800 wbm_rst <= 1'b0;

   initial #200 wb_rst <= 1'b0;
   always #100 wb_clk <= !wb_clk;

   wire [WB_PORTS*32-1:0] wb_adr;
   wire [WB_PORTS-1:0] 	  wb_stb;
   wire [WB_PORTS-1:0] 	  wb_cyc;
   wire [WB_PORTS*3-1:0]  wb_cti;
   wire [WB_PORTS*2-1:0]  wb_bte;
   wire [WB_PORTS-1:0] 	  wb_we;
   wire [WB_PORTS*4-1:0]  wb_sel;
   wire [WB_PORTS*32-1:0] wb_dat;
   wire [WB_PORTS*32-1:0] wb_rdt;
   wire [WB_PORTS-1:0] 	  wb_ack;
   
   wire [31:0] 	 slave_writes;
   wire [31:0] 	 slave_reads;
   wire [WB_PORTS-1:0] done_int;

   genvar 	 i;
   
   generate
      for(i=0;i<WB_PORTS;i=i+1) begin : masters
	 wb_bfm_transactor
	    #(.MEM_HIGH (MEMORY_SIZE_WORDS*(i+1)-1),
	      .MEM_LOW  (MEMORY_SIZE_WORDS*i),
	      .VERBOSE  (1))
	 wb_bfm_transactor0
	    (.wb_clk_i (wb_clk),
	     .wb_rst_i (wbm_rst),
	     .wb_adr_o (wb_adr[i*32+:32]),
	     .wb_dat_o (wb_dat[i*32+:32]),
	     .wb_sel_o (wb_sel[i*4+:4]),
	     .wb_we_o  (wb_we[i] ), 
	     .wb_cyc_o (wb_cyc[i]),
	     .wb_stb_o (wb_stb[i]),
	     .wb_cti_o (wb_cti[i*3+:3]),
	     .wb_bte_o (wb_bte[i*2+:2]),
	     .wb_dat_i (wb_rdt[i*32+:32]),
	     .wb_ack_i (wb_ack[i]),
	     .wb_err_i (1'b0),
	     .wb_rty_i (1'b0),
	     //Test Control
	     .done(done_int[i]));
      end // block: slaves
   endgenerate
   
   integer 	 idx;

   time start_time[WB_PORTS-1:0];
   time ack_delay[WB_PORTS-1:0];
   integer num_transactions[WB_PORTS-1:0];
   
   assign done = &done_int;
   
   always @(done) begin
      if(done === 1) begin
	 $display("Average wait times");
	 for(idx=0;idx<WB_PORTS;idx=idx+1)
	   $display("Master %0d : %f",idx, ack_delay[idx]/num_transactions[idx]);
	 $display("All tests passed!");
	 $finish;
	 
      end
   end

   generate
      for(i=0;i<WB_PORTS;i=i+1) begin : wait_time
	 initial begin
	    ack_delay[i] = 0;
	    num_transactions[i] = 0;
	    while(1) begin
	       @(posedge wb_cyc[i]);
	       start_time[i] = $time;
	       @(posedge wb_ack[i]);
	       ack_delay[i] = ack_delay[i] + $time-start_time[i];
	       num_transactions[i] = num_transactions[i]+1;
	    end
	 end
      end
   endgenerate
   
   wb_ram
     #(.depth (MEMORY_SIZE_WORDS))
   wb_ram0
     (// Wishbone interface
      .wb_clk_i   (wb_clk),
      .wb_rst_i   (wb_rst),
      .wb_adr_i (wb_adr[$clog2(MEMORY_SIZE_WORDS)-1:0]),
      .wb_stb_i (wb_stb),
      .wb_cyc_i (wb_cyc),
      .wb_cti_i (wb_cti),
      .wb_bte_i (wb_bte),
      .wb_we_i  (wb_we) ,
      .wb_sel_i (wb_sel),
      .wb_dat_i (wb_dat),
      .wb_dat_o (wb_rdt),
      .wb_ack_o (wb_ack),
      .wb_err_o ());
   
endmodule
