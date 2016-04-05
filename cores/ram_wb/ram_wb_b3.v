module ram_wb_b3
 #(//Wishbone parameters
   parameter dw = 32,
   parameter aw = 32,
   // Memory parameters
   parameter memory_file = "",
   parameter mem_size_bytes = 32'h0000_5000, // 20KBytes
   parameter mem_adr_width = 15) //(log2(mem_size_bytes));
  (input 	   wb_clk_i,
   input 	   wb_rst_i,
   
   input [aw-1:0]  wb_adr_i,
   input [dw-1:0]  wb_dat_i,
   input [3:0] 	   wb_sel_i,
   input 	   wb_we_i,
   input [1:0] 	   wb_bte_i,
   input [2:0] 	   wb_cti_i,
   input 	   wb_cyc_i,
   input 	   wb_stb_i,
   
   output 	   wb_ack_o,
   output 	   wb_err_o,
   output 	   wb_rty_o,
   output [dw-1:0] wb_dat_o);


   
   localparam bytes_per_dw = (dw/8);
   localparam adr_width_for_num_word_bytes = 2; //(log2(bytes_per_dw))
   localparam mem_words = (mem_size_bytes/bytes_per_dw);   

   // synthesis attribute ram_style of mem is block
   reg [dw-1:0] 	mem [ 0 : mem_words-1 ]   /* verilator public */ /* synthesis ram_style = no_rw_check */;

   // Register to address internal memory array
   reg [(mem_adr_width-adr_width_for_num_word_bytes)-1:0] addr_reg;
   

   // Register to indicate if the cycle is a Wishbone B3-registered feedback 
   // type access
   reg 				   wb_b3_trans;
   
   // Register to use for counting the addresses when doing burst accesses
   reg [(mem_adr_width-adr_width_for_num_word_bytes)-1:0] burst_adr_r;

   // Combinatorial next address calculation for bust accesses
   reg [(mem_adr_width-adr_width_for_num_word_bytes)-1:0] adr;

   // Logic to detect if there's a burst access going on
   wire wb_b3_trans_start = ((wb_cti_i == 3'b001)|(wb_cti_i == 3'b010)) & 
	wb_stb_i & !wb_b3_trans & wb_cyc_i;
   
   wire wb_b3_trans_stop = ((wb_cti_i == 3'b111) & 
			    wb_stb_i & wb_b3_trans & wb_ack_o) | wb_err_o;
   
   always @(posedge wb_clk_i)
     if (wb_rst_i)
       wb_b3_trans <= 0;
     else if (wb_b3_trans_start)
       wb_b3_trans <= 1;
     else if (wb_b3_trans_stop)
       wb_b3_trans <= 0;

   // Register it locally
   reg [1:0] wb_bte_i_r;
   reg [2:0] wb_cti_i_r;

   always @(posedge wb_clk_i) begin
      wb_bte_i_r <= wb_bte_i;
      wb_cti_i_r <= wb_cti_i;
   end

   // Burst address generation logic
   always @(wb_ack_o or wb_b3_trans or wb_b3_trans_start
	    or wb_bte_i_r or wb_cti_i_r or wb_adr_i or burst_adr_r)
     if (wb_b3_trans_start)
       // Kick off adr, this assumes 4-byte words when getting
       // address off incoming Wishbone bus address! 
       // So if dw is no longer 4 bytes, change this!
       adr = wb_adr_i[mem_adr_width-1:2];
     else if ((wb_cti_i_r == 3'b010) & wb_ack_o & wb_b3_trans) // Incrementing burst
       case(wb_bte_i_r)
	 2'b00 : adr  = burst_adr_r + 1; // Linear burst
	 2'b01 : begin
	       adr[1:0] = burst_adr_r[1:0] + 1; // 4-beat wrap burst
	       adr[(mem_adr_width-adr_width_for_num_word_bytes)-1:2] = burst_adr_r[(mem_adr_width-adr_width_for_num_word_bytes)-1:2];
	    end
	 2'b10 : begin
	       // 8-beat wrap burst
	       adr[2:0] = burst_adr_r[2:0] + 1;
	       adr[(mem_adr_width-adr_width_for_num_word_bytes)-1:3] = burst_adr_r[(mem_adr_width-adr_width_for_num_word_bytes)-1:3];
	    end
	 2'b11 : begin
	       // 16-beat wrap burst
	       adr[3:0] = burst_adr_r[3:0] + 1;
	       adr[(mem_adr_width-adr_width_for_num_word_bytes)-1:4] = burst_adr_r[(mem_adr_width-adr_width_for_num_word_bytes)-1:4];
	    end
	 default: adr  = wb_adr_i[mem_adr_width-1:2];
       endcase
     else
       adr = wb_adr_i[mem_adr_width-1:2];

   wire using_burst_adr = wb_b3_trans;
   
   wire burst_access_wrong_wb_adr = (using_burst_adr & 
				     (burst_adr_r != wb_adr_i[mem_adr_width-1:2]));

   // Address registering logic only for read
   always@(posedge wb_clk_i)
     if(wb_rst_i)
       burst_adr_r <= 0;
     else if (using_burst_adr)
        burst_adr_r <= adr;
     else if (wb_cyc_i & wb_stb_i)
       burst_adr_r <= wb_adr_i[mem_adr_width-1:2];

   assign wb_rty_o = 0;

   // mux for data to ram, RMW on part sel != 4'hf
   wire [31:0] wr_data;
   assign wr_data[31:24] = wb_sel_i[3] ? wb_dat_i[31:24] : wb_dat_o[31:24];
   assign wr_data[23:16] = wb_sel_i[2] ? wb_dat_i[23:16] : wb_dat_o[23:16];
   assign wr_data[15: 8] = wb_sel_i[1] ? wb_dat_i[15: 8] : wb_dat_o[15: 8];
   assign wr_data[ 7: 0] = wb_sel_i[0] ? wb_dat_i[ 7: 0] : wb_dat_o[ 7: 0];
   
   wire ram_we = wb_we_i & wb_ack_o;

   assign wb_dat_o = mem[addr_reg];
    
   // Write logic
   always @ (posedge wb_clk_i)
     if (ram_we)
	  mem[adr] <= wr_data;

   // Read logic
   always @ (posedge wb_clk_i)
      addr_reg <= adr;

   // Ack Logic
   reg wb_ack_o_r;

   assign wb_ack_o = wb_ack_o_r & wb_stb_i & !burst_access_wrong_wb_adr;
   
   //Handle wb_ack
   always @ (posedge wb_clk_i)
     if (wb_rst_i)
       wb_ack_o_r <= 1'b0;
     else if (wb_cyc_i) begin // We have bus
	if (wb_cti_i == 3'b000) // Classic cycle acks
	  wb_ack_o_r <= wb_stb_i ^ wb_ack_o_r;
	else if ((wb_cti_i == 3'b001) | (wb_cti_i == 3'b010)) // Increment/constant address bursts
	  wb_ack_o_r <= wb_stb_i;
	else if (wb_cti_i == 3'b111) // End of cycle
	  wb_ack_o_r <= wb_stb_i & !wb_ack_o_r;
     end // if (wb_cyc_i)
     else
       wb_ack_o_r <= 0;

   //
   // Error signal generation
   //
   
   // OR in other errors here...
   assign wb_err_o =  wb_ack_o_r & wb_stb_i & 
		      (burst_access_wrong_wb_adr);

   //
   // Access functions
   //
   
   /* Memory initialisation.
    If not Verilator model, always do load, otherwise only load when called
    from SystemC testbench.
    */
// synthesis translate_off

`ifdef verilator
   
   task do_readmemh;
      // verilator public
      $readmemh(memory_file, mem);
   endtask // do_readmemh

   // Function to access RAM (for use by Verilator).
   function [31:0] get_mem32;
      // verilator public
      input [aw-1:0] 		addr;
      get_mem32 = mem[addr];
   endfunction // get_mem32   

   // Function to access RAM (for use by Verilator).
   function [7:0] get_mem8;
      // verilator public
      input [aw-1:0] 		addr;
            reg [31:0] 		temp_word;
      begin
	 temp_word = mem[{addr[aw-1:2],2'd0}];
	 // Big endian mapping.
	 get_mem8 = (addr[1:0]==2'b00) ? temp_word[31:24] :
		    (addr[1:0]==2'b01) ? temp_word[23:16] :
		    (addr[1:0]==2'b10) ? temp_word[15:8] : temp_word[7:0];
	 end
   endfunction // get_mem8   

   // Function to write RAM (for use by Verilator).
   function set_mem32;
      // verilator public
      input [aw-1:0] 		addr;
      input [dw-1:0] 		data;
      begin
         mem[addr] = data;
         set_mem32 = data; // For avoiding ModelSim warning
      end
   endfunction // set_mem32   
   
`endif // !`ifdef verilator
   
//synthesis translate_on

endmodule // ram_wb_b3
