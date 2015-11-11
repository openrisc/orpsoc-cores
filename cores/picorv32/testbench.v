// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

`timescale 1 ns / 1 ps
// `define VERBOSE
// `define AXI_TEST

module testbench;

   vlog_tb_utils vtu();
   
   reg clk = 1;
   reg resetn = 0;

   always #5 clk = ~clk;

   initial begin
      repeat (100) @(posedge clk);
      resetn <= 1;
   end

   integer      mem_words;
   integer      i;
   reg [31:0] 	mem_word;
   reg [1023:0]      elf_file;

   initial begin
      if($value$plusargs("elf_load=%s", elf_file)) begin
	 $elf_load_file(elf_file);

	 mem_words = $elf_get_size/4;
	 $display("Loading %d words", mem_words);
	 for(i=0; i < mem_words; i = i+1) begin
	    top.mem.memory[i] = $elf_read_32(i*4);
	 end
      end else
	$display("No ELF file specified");
   end

   integer cycle_counter;
   always @(posedge clk) begin
      cycle_counter <= resetn ? cycle_counter + 1 : 0;
      if (resetn && trap) begin
	 repeat (10) @(posedge clk);
	 $display("TRAP after %1d clock cycles", cycle_counter);
	 $finish;
      end
   end

   picorv32_top top
     (.clk    (clk),
      .resetn (resetn),
      .trap   (trap));

endmodule
