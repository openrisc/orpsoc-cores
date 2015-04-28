/*TODO:
 Test byte masks
 Add timeout
 Add FIFO mode
  */
module wb_bfm_transactor
  #(parameter aw = 32,
    parameter dw = 32,
    parameter VERBOSE = 0,
    parameter MAX_BURST_LEN = 5,
    parameter MEM_LOW = 0,
    parameter MEM_HIGH = 32'hffffffff)
   (input           wb_clk_i,
    input 	    wb_rst_i,
    output [aw-1:0] wb_adr_o,
    output [dw-1:0] wb_dat_o,
    output [3:0]    wb_sel_o,
    output 	    wb_we_o,
    output 	    wb_cyc_o,
    output 	    wb_stb_o,
    output [2:0]    wb_cti_o,
    output [1:0]    wb_bte_o,
    input [dw-1:0]  wb_dat_i,
    input 	    wb_ack_i,
    input 	    wb_err_i,
    input 	    wb_rty_i,
    output reg	    done);

   `include "wb_bfm_params.v"

   integer SEED = 2;
   integer TRANSACTIONS;

   initial
     if(!$value$plusargs("transactions=%d", TRANSACTIONS))
       TRANSACTIONS = 1000;

   wb_bfm_master
     #(.MAX_BURST_LENGTH (MAX_BURST_LEN)) 
   bfm
     (.wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_o (wb_adr_o),
      .wb_dat_o (wb_dat_o),
      .wb_sel_o (wb_sel_o),
      .wb_we_o  (wb_we_o), 
      .wb_cyc_o (wb_cyc_o),
      .wb_stb_o (wb_stb_o),
      .wb_cti_o (wb_cti_o),
      .wb_bte_o (wb_bte_o),
      .wb_dat_i (wb_dat_i),
      .wb_ack_i (wb_ack_i),
      .wb_err_i (wb_err_i),
      .wb_rty_i (wb_rty_i));

   /*Return a 2*aw array with the highest and lowest accessed addresses
    based on starting address and burst type
    TODO: Account for short wrap bursts. Fix for 8-bit mode*/
   function [2*aw-1:0] adr_range;
      input [aw-1:0] adr_i;
      input [$clog2(MAX_BURST_LEN)-1:0] len_i;
      input [2:0]    burst_type_i;
      parameter bpw = 4; //Bytes per word. Hardcoded to 4 (32-bit)
      reg [aw-1:0]   adr;
      reg [aw-1:0]   adr_high;
      reg [aw-1:0]   adr_low;
      begin
	 if(bpw==4)
	   adr = adr_i[aw-1:2];
	 case (burst_type_i)
	   LINEAR_BURST   : begin
	      adr_high = (adr+len_i)*bpw-1;
	      adr_low  = adr*bpw;
	   end
	   WRAP_4_BURST   : begin
	      adr_high = (adr[aw-1:2]*4+4)*bpw-1;
	      adr_low  = adr[aw-1:2]*4*bpw;
	   end
	   WRAP_8_BURST   : begin
	      adr_high = (adr[aw-1:3]*8+8)*bpw-1;
	      adr_low  = adr[aw-1:3]*8*bpw;
	   end
	   WRAP_16_BURST  : begin
	      adr_high = (adr[aw-1:4]*16+16)*bpw-1;
	      adr_low  = adr[aw-1:4]*16*bpw;
	   end
	   CONSTANT_BURST : begin
	      adr_high = (adr+1)*bpw-1;
	      adr_low  = adr*bpw;
	   end
	   default : begin
	      $error("%d : Illegal burst type (%b)", $time, burst_type);
	      adr_range = {2*aw{1'bx}};
	   end
	   endcase // case (burst_type)
	 adr_range = {adr_high, adr_low};
      end
   endfunction
	 
   reg [dw*MAX_BURST_LEN-1:0] write_data;
   reg [dw*MAX_BURST_LEN-1:0] read_data;
   reg [dw*MAX_BURST_LEN-1:0] expected_data;
   
   integer 		      word;
   integer 		      burst_length;
   reg [2:0] 		      burst_type;

   integer 		      transaction;
	
   integer 		      tmp, burst_wrap;
   
   reg 			      err;
	
   reg [aw-1:0] 	      address;

   reg [aw-1:0] 	      adr_high;
   reg [aw-1:0] 	      adr_low;
   
   initial begin
      bfm.reset;
      done = 0;

      $display("%m : Running %0d transactions", TRANSACTIONS);
      $display("Max burst length=%0d", MAX_BURST_LEN);

      for(transaction = 0 ; transaction < TRANSACTIONS; transaction = transaction + 1) begin

	 address = (MEM_LOW + ($random(SEED) % (MEM_HIGH-MEM_LOW))) &  {{aw-2{1'b1}},2'b00};
	 burst_length = ({$random(SEED)} % MAX_BURST_LEN) + 1;
	 burst_type   = ({$random(SEED)} % 4);

	 {adr_high, adr_low} = adr_range(address, burst_length, burst_type);
	 
	 while((adr_high > MEM_HIGH) || (adr_low < MEM_LOW)) begin
	    address = (MEM_LOW + ($random(SEED) % (MEM_HIGH-MEM_LOW))) &  {{aw-2{1'b1}},2'b00};
	    burst_length = ({$random(SEED)} % MAX_BURST_LEN) + 1;
	    burst_type   = ({$random(SEED)} % 4);
	    {adr_high, adr_low} = adr_range(address, burst_length, burst_type);
	 end
	 
	 case (burst_type)
	   LINEAR_BURST   : burst_wrap = burst_length;
	   WRAP_4_BURST   : burst_wrap = 4;
	   WRAP_8_BURST   : burst_wrap = 8;
	   WRAP_16_BURST  : burst_wrap = 16;
	   CONSTANT_BURST : burst_wrap = 1;
	   default : $error("%d : Illegal burst type (%b)", $time, burst_type);
	 endcase
	 
	 for(word = 0; word < burst_length; word = word + 1)
	   write_data[dw*word+:dw] = $random;

	 bfm.write_burst(address, write_data, 4'hf, burst_length, burst_type, err);
	 @(posedge wb_clk_i);
	 bfm.read_burst(address, read_data, 4'hf, burst_length, burst_type, err);
	 @(posedge wb_clk_i);

	 if(VERBOSE>0)
	   if(!(transaction%(TRANSACTIONS/10)))
	     $display("%m : %0d/%0d", transaction, TRANSACTIONS);
	 
	 tmp = burst_length-1;
	 for(word = burst_length-1 ; word >= 0 ; word = word - 1) begin
	    
	    expected_data[dw*word+:dw] = write_data[dw*tmp+:dw];
	    
	    tmp = tmp - 1;
	    if(tmp < burst_length - burst_wrap)
	      tmp = burst_length-1;
	 end
	 for(word = 0 ; word < burst_length ; word = word +1)
	   if(read_data[word*dw+:dw] !== expected_data[word*dw+:dw]) begin
	      $error("%m : Transaction %0d failed!", transaction);
	      $error("Read data mismatch on address %h (burst length=%0d, burst_type=%0d, iteration %0d)", address, burst_length, burst_type, word);
	      $error("Expected %h", expected_data[word*dw+:dw]);
	      $error("Got      %h", read_data[word*dw+:dw]);
	    
	      #3 $finish;
	   end
	 if (VERBOSE>1) $display("Read ok from address %h (burst length=%0d, burst_type=%0d)", address, burst_length, burst_type);
      end
      done = 1;
   end
endmodule
