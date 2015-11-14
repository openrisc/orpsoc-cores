/*TODO:
 Test byte masks
 Add timeout
 Test linear burst from 0xffffffff
 Add support for settings address ranges
 */
module wb_master
  #(parameter aw = 32,
    parameter dw = 32,
    parameter VERBOSE = 0,
    parameter MAX_BURST_LEN = 500)
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
    input 	    wb_rty_i);

   `include "wb_bfm_params.v"

   vlog_functions utils();

   integer SEED = 2;
   integer TRANSACTIONS;
   
   initial
     if(!$value$plusargs("transaction=%d", TRANSACTIONS))
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

   
   reg [dw*MAX_BURST_LEN-1:0] write_data;
   reg [dw*MAX_BURST_LEN-1:0] read_data;
   reg [dw*MAX_BURST_LEN-1:0] expected_data;
   
   integer 		      word;
   integer 		      burst_length;
   reg [2:0] 		      burst_type;
   
   integer 		      transaction;
	
   integer 		      tmp, burst_wrap, word_size;
   
   reg 			      err;
	
   reg [aw-1:0] 	      address;
	
   initial begin
      
      for(transaction = 0 ; transaction < TRANSACTIONS; transaction = transaction + 1) begin
	 tmp = $random;
	 address = {20'h0000,tmp[11:0]};//FIXME Check address range against memory model
			
	 burst_length = ({$random(SEED)} % MAX_BURST_LEN) + 1;
	 burst_type = ({$random(SEED)} % 4);

	 word_size = ({$random(SEED)} % 3) + 1;
	 //word_size = 3;
         if (word_size == 3) begin
            word_size = 4;
         end else begin
            burst_length = 1;
            burst_type = LINEAR_BURST;
         end

         if (burst_length == 1) begin
            case (word_size)
              1:
                begin
                   write_data = 0;
	           write_data[7:0] = $random;
	           bfm.write_byte(address, write_data[7:0], err);
	           @(posedge wb_clk_i);
                   read_data = 0;
	           //bfm.read(address, read_data, 4'hf, err);
	           bfm.read_byte(address, read_data[7:0], err);
	           @(posedge wb_clk_i);
                end // case: 1
              2:
                begin
                   write_data = 0;
	           write_data[15:0] = $random;
	           bfm.write_half_word(address, write_data[15:0], err);
	           @(posedge wb_clk_i);
                   read_data = 0;
	           //bfm.read(address, read_data, 4'hf, err);
	           bfm.read_half_word(address, read_data[15:0], err);
	           @(posedge wb_clk_i);
                end // case: 2
              4:
                begin
	           write_data[dw-1:0] = $random;
	           bfm.write(address, write_data, 4'hf, err);
	           @(posedge wb_clk_i);
	           bfm.read(address, read_data, 4'hf, err);
	           @(posedge wb_clk_i);
                end // case: 4
            endcase // case (word_size)
         end else begin // if (burst_length == 1)
	    for(word = 0; word < burst_length; word = word + 1)
	      write_data[dw*word+:dw] = $random;
	    bfm.write_burst(address, write_data, 4'hf, burst_length, burst_type, err);
	    @(posedge wb_clk_i);
	    bfm.read_burst(address, read_data, 4'hf, burst_length, burst_type, err);
	    @(posedge wb_clk_i);
         end // else: !if(burst_length == 1)

	 case (burst_type)
	   LINEAR_BURST   : burst_wrap = burst_length;
	   WRAP_4_BURST   : burst_wrap = 4;
	   WRAP_8_BURST   : burst_wrap = 8;
	   WRAP_16_BURST  : burst_wrap = 16;
	   CONSTANT_BURST : burst_wrap = 1;
	   default : $error("%d : Illegal burst type (%b)", $time, burst_type);
	 endcase
	 
	 tmp = burst_length-1;
	 for(word = burst_length-1 ; word >= 0 ; word = word - 1) begin
	    
	    expected_data[dw*word+:dw] = write_data[dw*tmp+:dw];
	    
	    tmp = tmp - 1;
	    if(tmp < burst_length - burst_wrap)
	      tmp = burst_length-1;
	 end
	 for(word = 0 ; word < burst_length ; word = word +1)
	   if(read_data[word*dw+:dw] !== expected_data[word*dw+:dw]) begin
	      $error("Read data mismatch on address %h (burst length=%0d, burst_type=%0d, word_size=%0d, iteration %0d)", address, burst_length, burst_type, word_size, word);
	      $error("Expected %h", expected_data[word*dw+:dw]);
	      $error("Got      %h", read_data[word*dw+:dw]);
	      
	      $finish;
	   end
	 if (VERBOSE) $display("Read ok from address %h (burst length=%0d, burst_type=%0d)", address, burst_length, burst_type);
	 utils.progress_bar("Completed transaction", transaction, TRANSACTIONS);
      end // for (i = 1 ; i < 10; i = i + 1)
      $display("%0d : All tests passed!", $time);
      #3 $finish;
   end
   
endmodule   
	    
