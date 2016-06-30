module mt48lc16m16a2_wrapper
  #(parameter TPROP_PCB = 2.0,
    parameter ADDR_BITS = 12,
    parameter MEM_SIZES = 4194303,
    parameter COL_BITS  = 9)
   (input 		  clk_i,
    input 		  rst_n_i,
    inout [15:0] 	  dq_io,
    input [ADDR_BITS-1:0] addr_i,
    input [1:0] 	  ba_i,
    input 		  cas_i,
    input 		  cke_i,
    input 		  cs_n_i,
    input [1:0] 	  dqm_i,
    input 		  ras_i,
    input 		  we_i);

   reg [ADDR_BITS-1:0] addr;
   reg [1:0] 	       ba;
   reg 		       cas;
   reg 		       cke;
   reg 		       cs_n;
   wire [15:0] 	       dq;
   reg [1:0] 	       dqm;
   reg 		       ras;
   reg 		       we;

   integer 	mem_words;
   integer 	i;
   reg [31:0] 	mem_word;
   reg [1023:0] elf_file;
   reg [31:0] 	temp;

   initial begin
      if($value$plusargs("elf_load=%s", elf_file)) begin
	 $elf_load_file(elf_file);

	 mem_words = $elf_get_size / 4;
	 //$display("Loading %d words", mem_words);
	 for(i = 0; i < mem_words; i = i + 1) begin
	    mem_word = $elf_read_32(i * 4);
	    sdram0.Bank0[(i * 2)]     = mem_word[31:16];
	    sdram0.Bank0[(i * 2) + 1] = mem_word[15:0];
	 end
      end else
	$display("No ELF file specified");
   end

   always @( * ) begin
      addr <= #(TPROP_PCB) addr_i;
      ba   <= #(TPROP_PCB) ba_i;
      cas  <= #(TPROP_PCB) cas_i;
      cke  <= #(TPROP_PCB) cke_i;
      cs_n <= #(TPROP_PCB) cs_n_i;
      dqm  <= #(TPROP_PCB) dqm_i;
      ras  <= #(TPROP_PCB) ras_i;
      we   <= #(TPROP_PCB) we_i;
   end

   genvar dqwd;
   generate
      for (dqwd = 0; dqwd < 16; dqwd = dqwd + 1) begin : dq_delay
	 wiredelay
		  #(.Delay_g	(TPROP_PCB),
		    .Delay_rd	(TPROP_PCB))
	 u_delay_dq
		  (.A	  (dq_io[dqwd]),
		   .B	  (dq[dqwd]),
		   .reset (rst_n_i));
      end
   endgenerate

   mt48lc16m16a2
     #(.addr_bits	(ADDR_BITS),
       .col_bits	(COL_BITS),
       .mem_sizes	(MEM_SIZES))
   sdram0
     (.Dq		(dq),
      .Addr		(addr),
      .Ba		(ba),
      .Clk		(clk_i),
      .Cke		(cke),
      .Cs_n		(cs_n),
      .Ras_n		(ras),
      .Cas_n		(cas),
      .We_n		(we),
      .Dqm		(dqm));
endmodule
