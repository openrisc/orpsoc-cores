`include "timescale.v"

module orpsoc_tb;

   vlog_tb_utils vlog_tb_utils0();

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
           orpsoc_tb.dut.wb_bfm_memory0.mem[i] = $elf_read_32(i*4);
      end else
        $display("No ELF file specified");

   end

   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   //
   ////////////////////////////////////////////////////////////////////////
   reg wb_clk = 1;
   reg wb_rst = 1;

   always #5 wb_clk <= ~wb_clk;
   initial #100 wb_rst <= 0;

   ////////////////////////////////////////////////////////////////////////
   //
   // mor1kx monitor
   //
   ////////////////////////////////////////////////////////////////////////
   wire [1:0] finish;

   mor1kx_traceport_monitor #(.LOG_DIR("."),.COREID(0),.NUMCORES(2))
   i_monitor0(.clk(wb_clk),
              .rst(wb_rst),
              .traceport_exec_valid(dut.traceport_exec_valid[0]),
              .traceport_exec_pc(dut.traceport_exec_pc[0]),
              .traceport_exec_insn(dut.traceport_exec_insn[0]),
              .traceport_exec_wbdata(dut.traceport_exec_wbdata[0]),
              .traceport_exec_wbreg(dut.traceport_exec_wbreg[0]),
              .traceport_exec_wben(dut.traceport_exec_wben[0]),
              .finish_cross(finish),
              .finish(finish[0]));
   
   mor1kx_traceport_monitor #(.LOG_DIR("."),.COREID(1),.NUMCORES(2))
   i_monitor1(.clk(wb_clk),
              .rst(wb_rst),
              .traceport_exec_valid(dut.traceport_exec_valid[1]),
              .traceport_exec_pc(dut.traceport_exec_pc[1]),
              .traceport_exec_insn(dut.traceport_exec_insn[1]),
              .traceport_exec_wbdata(dut.traceport_exec_wbdata[1]),
              .traceport_exec_wbreg(dut.traceport_exec_wbreg[1]),
              .traceport_exec_wben(dut.traceport_exec_wben[1]),
              .finish_cross(finish),
              .finish(finish[1]));

   ////////////////////////////////////////////////////////////////////////
   //
   // DUT
   //
   ////////////////////////////////////////////////////////////////////////
   orpsoc_top
     #(.UART_SIM (1))
   dut
     (.wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst)
      );

endmodule
