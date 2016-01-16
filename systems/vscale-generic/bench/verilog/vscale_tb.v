module vscale_tb;

   vlog_tb_utils vtu();

   ////////////////////////////////////////////////////////////////////////
   //
   // ELF program loading
   //
   ////////////////////////////////////////////////////////////////////////
   integer mem_words;
   integer i;
   reg [31:0] mem_word;
   reg [1023:0] elf_file;

   initial begin
      if($value$plusargs("elf_load=%s", elf_file)) begin
	 $elf_load_file(elf_file);

	 mem_words = $elf_get_size/4;
	 $display("Loading %d words", mem_words);
	 for(i=0; i < mem_words; i = i+1)
	   vscale_tb.dut.mem.ram0.mem[i] = $elf_read_32(i*4);
      end else
	$display("No ELF file specified");

   end

   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   //
   ////////////////////////////////////////////////////////////////////////
   reg syst_clk = 1;
   reg syst_rst = 1;

   always #5 syst_clk <= ~syst_clk;
   initial #100 syst_rst <= 0;

   ////////////////////////////////////////////////////////////////////////
   //
   // DUT
   //
   ////////////////////////////////////////////////////////////////////////
   vscale_top
   dut
     (.wb_clk_i (syst_clk),
      .wb_rst_i (syst_rst)
     );

endmodule
