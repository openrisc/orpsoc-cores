//////////////////////////////////////////////////////////////////////
////                                                              ////
////  or1200_monitor.v                                            ////
////                                                              ////
////  OR1200 processor monitor module                             ////
////                                                              ////
////  Author(s):                                                  ////
////      - Damjan Lampret, lampret@opencores.org                 ////
////      - Julius Baxter, julius@opencores.org                   ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

`include "timescale.v"
`include "or1200_defines.v"
`include "or1200_monitor_defines.v"


module or1200_monitor;

   parameter TEST_NAME_STRING = "unnamed";
   parameter LOG_DIR          = ".";

   integer fexe;
   integer finsn;

   reg [23:0] ref;
`ifdef OR1200_MONITOR_SPRS
   integer    fspr;
`endif
   integer    fgeneral;
`ifdef OR1200_MONITOR_LOOKUP
   integer    flookup;
`endif
   integer    r3;
   integer    insns;


   //
   // Initialization
   //
   initial begin
      ref = 0;
`ifdef OR1200_MONITOR_EXEC_STATE
      fexe = $fopen({LOG_DIR, "/", TEST_NAME_STRING,"-executed.log"});
`endif
`ifdef OR1200_MONITOR_EXEC_LOG_DISASSEMBLY
      finsn = fexe;
`endif
      $timeformat (-9, 2, " ns", 12);
`ifdef OR1200_MONITOR_SPRS
      fspr = $fopen({LOG_DIR, "/", TEST_NAME_STRING,"-sprs.log"});
`endif
      fgeneral = $fopen({LOG_DIR, "/", TEST_NAME_STRING,"-general.log"});
`ifdef OR1200_MONITOR_LOOKUP
      flookup = $fopen({LOG_DIR, "/", TEST_NAME_STRING,"-lookup.log"});
`endif
      insns = 0;

   end

   //
   // Get GPR
   //
   task get_gpr;
      input	[4:0]	gpr_no;
      output [31:0] 	gpr;
      integer 		j;
      begin

`ifdef OR1200_RFRAM_GENERIC
	 for(j = 0; j < 32; j = j + 1) begin
	    gpr[j] = `OR1200_TOP.`CPU_cpu.`CPU_rf.rf_a.mem[gpr_no*32+j];
	 end

`else
	 //gpr = `OR1200_TOP.`CPU_cpu.`CPU_rf.rf_a.mem[gpr_no];
	 gpr = `OR1200_TOP.`CPU_cpu.`CPU_rf.rf_a.get_gpr(gpr_no);

`endif


      end
   endtask

   //
   // Write state of the OR1200 registers into a file
   //
   // Limitation: only a small subset of register file RAMs
   // are supported
   //
   task display_arch_state;
      input exception;

      reg [5:0] i;
      reg [31:0] r;
      integer 	 j;
      begin
`ifdef OR1200_MONITOR_EXEC_STATE
	 ref = ref + 1;
 `ifdef OR1200_MONITOR_LOOKUP
	 $fdisplay(flookup, "Instruction %d: %t", insns, $time);
 `endif
	 if(exception)
	   $fwrite(fexe, "\nEXECUTED(%d): %h:  %h  (exception)", insns,
		   `OR1200_TOP.`CPU_cpu.`CPU_except.ex_pc,
		   `OR1200_TOP.`CPU_cpu.`CPU_ctrl.ex_insn);
	 else
	   $fwrite(fexe, "\nEXECUTED(%d): %h:  %h", insns,
		   `OR1200_TOP.`CPU_cpu.`CPU_except.wb_pc,
		   `OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn);
 `ifdef OR1200_MONITOR_EXEC_LOG_DISASSEMBLY
	 if(!exception) begin
	    $fwrite(fexe,"\t");
	    // Decode the instruction, print it out
	    or1200_print_op(`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn);
	 end
 `endif
	 for(i = 0; i < 32; i = i + 1) begin
	    if (i % 4 == 0)
	      $fdisplay(fexe);
	    get_gpr(i, r);
	    $fwrite(fexe, "GPR%d: %h  ", i, r);
	 end
	 $fdisplay(fexe);
	 r = `OR1200_TOP.`CPU_cpu.`CPU_sprs.sr;
	 $fwrite(fexe, "SR   : %h  ", r);
	 r = `OR1200_TOP.`CPU_cpu.`CPU_sprs.epcr;
	 $fwrite(fexe, "EPCR0: %h  ", r);
	 r = `OR1200_TOP.`CPU_cpu.`CPU_sprs.eear;
	 $fwrite(fexe, "EEAR0: %h  ", r);
	 r = `OR1200_TOP.`CPU_cpu.`CPU_sprs.esr;
	 $fdisplay(fexe, "ESR0 : %h", r);
`endif //  `ifdef OR1200_MONITOR_EXEC_STATE
	 insns = insns + 1;
      end
   endtask // display_arch_state

   /* Keep a trace buffer of the last lot of instructions and addresses
    * "executed",as read from the writeback stage, and cause a $finish if we hit
    * an instruction that is invalid, such as all zeros.
    * Currently, only breaks on an all zero instruction, but should probably be
    * made to break for anything with an X in it too. And of course ideally this
    * shouldn't be needed - but is handy if someone changes something and stops
    * the test continuing forever.
    */
   integer num_nul_inst;
   initial num_nul_inst = 0;

   task monitor_for_crash;
`define OR1200_MONITOR_CRASH_TRACE_SIZE 32
      //Trace buffer of 32 instructions
      reg [31:0] insn_trace [0:`OR1200_MONITOR_CRASH_TRACE_SIZE-1];
      //Trace buffer of the addresses of those instructions
      reg [31:0] addr_trace [0:`OR1200_MONITOR_CRASH_TRACE_SIZE-1];
      integer 	 i;

      begin
	 if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h00000000)
	   num_nul_inst = num_nul_inst + 1;
	 else
	   num_nul_inst = 0; // Reset it

	 if (num_nul_inst == 1000) // Sat a loop a bit too long...
	   begin
	      $fdisplay(fgeneral, "ERROR - no instruction at PC %h",
			`OR1200_TOP.`CPU_cpu.`CPU_except.wb_pc);
	      $fdisplay(fgeneral, "Crash trace: Last %d instructions: ",
			`OR1200_MONITOR_CRASH_TRACE_SIZE);

	      $fdisplay(fgeneral, "PC\t\tINSTR");
	      for(i=`OR1200_MONITOR_CRASH_TRACE_SIZE-1;i>=0;i=i-1) begin
		 $fdisplay(fgeneral, "%h\t%h",addr_trace[i], insn_trace[i]);
	      end
	      $display("*");
	      $display("* or1200_monitor : OR1200 crash detected (suspected CPU PC corruption)");
	      $display("*");

	      #100 $finish;
	   end
	 else
	   begin
	      for(i=`OR1200_MONITOR_CRASH_TRACE_SIZE-1;i>0;i=i-1) begin
		 insn_trace[i] = insn_trace[i-1];
		 addr_trace[i] = addr_trace[i-1];
	      end
	      insn_trace[0] = `OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn;
	      addr_trace[0] = `OR1200_TOP.`CPU_cpu.`CPU_except.wb_pc;
	   end

      end
   endtask // monitor_for_crash

   integer iwb_progress;
   reg [31:0] iwb_progress_addr;
   //
   // WISHBONE bus checker
   //
   always @(posedge `OR1200_TOP.iwb_clk_i)
     if (`OR1200_TOP.iwb_rst_i) begin
	iwb_progress = 0;
	iwb_progress_addr = `OR1200_TOP.iwb_adr_o;
     end
     else begin
	if (`OR1200_TOP.iwb_cyc_o && (iwb_progress != 2)) begin
	   iwb_progress = 1;
	end
	if (`OR1200_TOP.iwb_stb_o) begin
	   if (iwb_progress >= 1) begin
	      if (iwb_progress == 1)
		iwb_progress_addr = `OR1200_TOP.iwb_adr_o;
	      iwb_progress = 2;
	   end
	   else begin
	      $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.iwb_stb_o raised without `OR1200_TOP.iwb_cyc_o, at %t\n", $time);
	      #100 $finish;
	   end
	end
	if (`OR1200_TOP.iwb_ack_i & `OR1200_TOP.iwb_err_i) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.iwb_ack_i and `OR1200_TOP.iwb_err_i raised at the same time, at %t\n", $time);
	end
	if ((iwb_progress == 2) && (iwb_progress_addr != `OR1200_TOP.iwb_adr_o)) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.iwb_adr_o changed while waiting for `OR1200_TOP.iwb_err_i/`OR1200_TOP.iwb_ack_i, at %t\n", $time);
	   #100 $finish;
	end
	if (`OR1200_TOP.iwb_ack_i | `OR1200_TOP.iwb_err_i)
	  if (iwb_progress == 2) begin
	     iwb_progress = 0;
	     iwb_progress_addr = `OR1200_TOP.iwb_adr_o;
	  end
	  else begin
	     $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.iwb_ack_i/`OR1200_TOP.iwb_err_i raised without `OR1200_TOP.iwb_cyc_i/`OR1200_TOP.iwb_stb_i, at %t\n", $time);
	     #100 $finish;
	  end
	if ((iwb_progress == 2) && !`OR1200_TOP.iwb_stb_o) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.iwb_stb_o lowered without `OR1200_TOP.iwb_err_i/`OR1200_TOP.iwb_ack_i, at %t\n", $time);
	   #100 $finish;
	end
     end

   integer dwb_progress;
   reg [31:0] dwb_progress_addr;
   //
   // WISHBONE bus checker
   //
   always @(posedge `OR1200_TOP.dwb_clk_i)
     if (`OR1200_TOP.dwb_rst_i)
       dwb_progress = 0;
     else begin
	if (`OR1200_TOP.dwb_cyc_o && (dwb_progress != 2))
	  dwb_progress = 1;
	if (`OR1200_TOP.dwb_stb_o)
	  if (dwb_progress >= 1) begin
	     if (dwb_progress == 1)
	       dwb_progress_addr = `OR1200_TOP.dwb_adr_o;
	     dwb_progress = 2;
	  end
	  else begin
	     $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.dwb_stb_o raised without `OR1200_TOP.dwb_cyc_o, at %t\n", $time);
	     #100 $finish;
	  end
	if (`OR1200_TOP.dwb_ack_i & `OR1200_TOP.dwb_err_i) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.dwb_ack_i and `OR1200_TOP.dwb_err_i raised at the same time, at %t\n", $time);
	end
	if ((dwb_progress == 2) && (dwb_progress_addr != `OR1200_TOP.dwb_adr_o)) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.dwb_adr_o changed while waiting for `OR1200_TOP.dwb_err_i/`OR1200_TOP.dwb_ack_i, at %t\n", $time);
	   #100 $finish;
	end
	if (`OR1200_TOP.dwb_ack_i | `OR1200_TOP.dwb_err_i)
	  if (dwb_progress == 2) begin
	     dwb_progress = 0;
	     dwb_progress_addr = `OR1200_TOP.dwb_adr_o;
	  end
	  else begin
	     $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.dwb_ack_i/`OR1200_TOP.dwb_err_i raised without `OR1200_TOP.dwb_cyc_i/`OR1200_TOP.dwb_stb_i, at %t\n", $time);
	     #100 $finish;
	  end
	if ((dwb_progress == 2) && !`OR1200_TOP.dwb_stb_o) begin
	   $fdisplay(fgeneral, "WISHBONE protocol violation: `OR1200_TOP.dwb_stb_o lowered without `OR1200_TOP.dwb_err_i/`OR1200_TOP.dwb_ack_i, at %t\n", $time);
	   #100 $finish;
	end
     end

   //
   // Hooks for:
   // - displaying registers
   // - end of simulation
   // - access to SPRs
   //
   always @(posedge `CPU_CORE_CLK)
     if (!`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_freeze) begin
	//	#2;
	if (((`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn[31:26] != `OR1200_OR32_NOP)
	     | !`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn[16])
	    & !(`OR1200_TOP.`CPU_cpu.`CPU_except.except_flushpipe &
		`OR1200_TOP.`CPU_cpu.`CPU_except.ex_dslot))
	  begin
	     display_arch_state(0);
	     monitor_for_crash;
	  end
	else
	  if (`OR1200_TOP.`CPU_cpu.`CPU_except.except_flushpipe)
	    display_arch_state(1);
	// small hack to stop simulation (l.nop 1):
	if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h1500_0001) begin
	   get_gpr(3, r3);
	   $fdisplay(fgeneral, "%t: l.nop exit (%h)", $time, r3);
`ifdef OR1200_MONITOR_VERBOSE_NOPS
       // Note that the 'expect' scripts in or1ksim's test suite look for strings
       // like "exit(1)", therefore something like "exit(  1)" would fail.
       $display("exit(%0d)",r3);
`endif
	   $finish;
	end
	// debug if test (l.nop 10)
	if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h1500_000a) begin
	   $fdisplay(fgeneral, "%t: l.nop dbg_if_test", $time);
	end
	// simulation reports (l.nop 2)
	if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h1500_0002) begin
	   get_gpr(3, r3);
	   $fdisplay(fgeneral, "%t: l.nop report (0x%h)", $time, r3);
`ifdef OR1200_MONITOR_VERBOSE_NOPS
	   // Note that the 'expect' scripts in or1ksim's test suite look for strings
	   // like "report(0x7ffffffe);", therefore something like "report (0x7ffffffe);"
	   // (note the extra space character) would fail.
	   $display("report(0x%h);", r3);
`endif
	end
	// simulation printfs (l.nop 3)
	if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h1500_0003) begin
	   get_gpr(3, r3);
	   $fdisplay(fgeneral, "%t: l.nop printf (%h)", $time, r3);
	end
	if (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn == 32'h1500_0004) begin
	   // simulation putc (l.nop 4)
	   get_gpr(3, r3);
	   $write("%c", r3);
	   $fdisplay(fgeneral, "%t: l.nop putc (%c)", $time, r3);
	end
`ifdef OR1200_MONITOR_SPRS
	if (`OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_we)
	  $fdisplay(fspr, "%t: Write to SPR : [%h] <- %h", $time,
		    `OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_addr,
		    `OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_dat_o);
	if ((|`OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_cs) &
	    !`OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_we)
	  $fdisplay(fspr, "%t: Read from SPR: [%h] -> %h", $time,
		    `OR1200_TOP.`CPU_cpu.`CPU_sprs.spr_addr,
		    `OR1200_TOP.`CPU_cpu.`CPU_sprs.to_wbmux);
`endif
     end


`ifdef RAM_WB
 `define RAM_WB_TOP `DUT_TOP.ram_wb0.ram_wb_b3_0
   task get_insn_from_wb_ram;
      input [31:0] addr;
      output [31:0] insn;
      begin
	 insn = `RAM_WB_TOP.get_mem32(addr[31:2]);
      end
   endtask // get_insn_from_wb_ram
`endif

`ifdef VERSATILE_SDRAM
 `define SDRAM_TOP `TB_TOP.sdram0
   // Bit selects to define the bank
   // 32 MB part with 4 banks
 `define SDRAM_BANK_SEL_BITS 24:23
 `define SDRAM_WORD_SEL_TOP_BIT 22
   // Gets instruction word from correct bank
   task get_insn_from_sdram;
      input [31:0] addr;
      output [31:0] insn;
      reg [`SDRAM_WORD_SEL_TOP_BIT-1:0] word_addr;

      begin
	 word_addr = addr[`SDRAM_WORD_SEL_TOP_BIT:2];
	 if (addr[`SDRAM_BANK_SEL_BITS] == 2'b00)
	   begin

	      //$display("%t: get_insn_from_sdram bank0, word 0x%h, (%h and %h in SDRAM)", $time, word_addr, `SDRAM_TOP.Bank0[{word_addr,1'b0}], `SDRAM_TOP.Bank0[{word_addr,1'b1}]);
	      insn[15:0] = `SDRAM_TOP.Bank0[{word_addr,1'b1}];
	      insn[31:16] = `SDRAM_TOP.Bank0[{word_addr,1'b0}];
	   end
      end

   endtask // get_insn_from_sdram
`endif //  `ifdef VERSATILE_SDRAM

`ifdef XILINX_DDR2
 `define DDR2_TOP `TB_TOP.gen_cs[0]
   // Gets instruction word from correct bank
   task get_insn_from_xilinx_ddr2;
      input [31:0] addr;
      output [31:0] insn;
      reg [16*8-1:0] ddr2_array_line0,ddr2_array_line1,ddr2_array_line2,
		     ddr2_array_line3;
      integer 	     word_in_line_num;
      begin
	 // Get our 4 128-bit chunks (8 half-words in each!! Confused yet?),
	 // 16 words total
	 `DDR2_TOP.gen[0].u_mem0.memory_read(addr[28:27],addr[26:13],{addr[12:6],3'd0},ddr2_array_line0);
	 `DDR2_TOP.gen[1].u_mem0.memory_read(addr[28:27],addr[26:13],{addr[12:6],3'd0},ddr2_array_line1);
	 `DDR2_TOP.gen[2].u_mem0.memory_read(addr[28:27],addr[26:13],{addr[12:6],3'd0},ddr2_array_line2);
	 `DDR2_TOP.gen[3].u_mem0.memory_read(addr[28:27],addr[26:13],{addr[12:6],3'd0},ddr2_array_line3);
	 case (addr[5:2])
	   4'h0:
	     begin
		insn[15:0] = ddr2_array_line0[15:0];
		insn[31:16] = ddr2_array_line1[15:0];
	     end
	   4'h1:
	     begin
		insn[15:0] = ddr2_array_line2[15:0];
		insn[31:16] = ddr2_array_line3[15:0];
	     end
	   4'h2:
	     begin
		insn[15:0] = ddr2_array_line0[31:16];
		insn[31:16] = ddr2_array_line1[31:16];
	     end
	   4'h3:
	     begin
		insn[15:0] = ddr2_array_line2[31:16];
		insn[31:16] = ddr2_array_line3[31:16];
	     end
	   4'h4:
	     begin
		insn[15:0] = ddr2_array_line0[47:32];
		insn[31:16] = ddr2_array_line1[47:32];
	     end
	   4'h5:
	     begin
		insn[15:0] = ddr2_array_line2[47:32];
		insn[31:16] = ddr2_array_line3[47:32];
	     end
	   4'h6:
	     begin
		insn[15:0] = ddr2_array_line0[63:48];
		insn[31:16] = ddr2_array_line1[63:48];
	     end
	   4'h7:
	     begin
		insn[15:0] = ddr2_array_line2[63:48];
		insn[31:16] = ddr2_array_line3[63:48];
	     end
	   4'h8:
	     begin
		insn[15:0] = ddr2_array_line0[79:64];
		insn[31:16] = ddr2_array_line1[79:64];
	     end
	   4'h9:
	     begin
		insn[15:0] = ddr2_array_line2[79:64];
		insn[31:16] = ddr2_array_line3[79:64];
	     end
	   4'ha:
	     begin
		insn[15:0] = ddr2_array_line0[95:80];
		insn[31:16] = ddr2_array_line1[95:80];
	     end
	   4'hb:
	     begin
		insn[15:0] = ddr2_array_line2[95:80];
		insn[31:16] = ddr2_array_line3[95:80];
	     end
	   4'hc:
	     begin
		insn[15:0] = ddr2_array_line0[111:96];
		insn[31:16] = ddr2_array_line1[111:96];
	     end
	   4'hd:
	     begin
		insn[15:0] = ddr2_array_line2[111:96];
		insn[31:16] = ddr2_array_line3[111:96];
	     end
	   4'he:
	     begin
		insn[15:0] = ddr2_array_line0[127:112];
		insn[31:16] = ddr2_array_line1[127:112];
	     end
	   4'hf:
	     begin
		insn[15:0] = ddr2_array_line2[127:112];
		insn[31:16] = ddr2_array_line3[127:112];
	     end
	 endcase // case (addr[5:2])
      end
   endtask // get_insn_from_xilinx_ddr2
`endif


   task get_insn_from_memory;
      input [31:0] id_pc;
      output [31:0] insn;
      begin
	 // do a decode of which server we should look in
	 case (id_pc[31:28])
`ifdef VERSATILE_SDRAM
	   4'h0:
	     get_insn_from_sdram(id_pc, insn);
`endif
`ifdef XILINX_DDR2
	   4'h0:
	     get_insn_from_xilinx_ddr2(id_pc, insn);
`endif
`ifdef RAM_WB
	   4'h0:
	     get_insn_from_wb_ram(id_pc, insn);
`endif
	   4'hf:
	     // Flash isn't stored in a memory, it's an FSM so just skip/ignore
	     insn = `OR1200_TOP.`CPU_cpu.`CPU_ctrl.id_insn;
	   default:
	     begin
		$fdisplay(fgeneral, "%t: Unknown memory server for address 0x%h", $time,id_pc);
		insn = 32'hxxxxxxxx; // Unknown server
	     end
	 endcase // case (id_pc[31:28])
      end
   endtask // get_insn_from_memory


   //
   // Look in the iMMU TLB MR for this address' page, if MMUs are on and enabled
   //
   task check_for_immu_entry;
      input [31:0] pc;
      output [31:0] physical_pc;
      output 	    mmu_tlb_miss;
      integer 	    w,x;

      reg [31:`OR1200_IMMU_PS] pc_vpn;

      reg [`OR1200_ITLBTRW-1:0] itlb_tr;
      reg [`OR1200_ITLBMRW-1:0] itlb_mr;

      integer 			tlb_index;
      reg 			mmu_en;


      begin
	 mmu_tlb_miss = 0;

`ifdef OR1200_NO_IMMU
	 physical_pc = pc;
`else
 	 mmu_en = `OR1200_TOP.`CPU_immu_top.immu_en;
	 // If MMU is enabled
	 if (mmu_en)
	   begin

	      // Look in the iTLB for mapping - get virtual page number
	      pc_vpn = pc[31:`OR1200_IMMU_PS];

	      tlb_index = pc[`OR1200_ITLB_INDX];

	      // Look at the ITLB match register
	      itlb_mr = `OR1200_TOP.`CPU_immu_top.`CPU_immu_tlb.itlb_mr_ram.mem[tlb_index];

	      // Get the translate register here too, in case there's an error, we print it
	      itlb_tr = `OR1200_TOP.`CPU_immu_top.`CPU_immu_tlb.itlb_tr_ram.mem[tlb_index];

	      if ((itlb_mr[`OR1200_ITLBMR_V_BITS] === 1'b1) & (itlb_mr[`OR1200_ITLBMRW-1:1] === pc[`OR1200_ITLB_TAG]))
		begin
		   // Page number in match register matches page number of virtual PC, so get the physical
		   // address from the translate memory
		   // Now pull the physical page number out of the tranlsate register (it's after bottom 3 bits)
		   physical_pc = {itlb_tr[`OR1200_ITLBTRW-1:`OR1200_ITLBTRW-(32-`OR1200_IMMU_PS)],pc[`OR1200_IMMU_PS-1:0]};
		   //$display("check_for_immu_entry: found match for virtual PC 0x%h in entry %d of iMMU, mr = 0x%x tr = 0x%x, phys. PC = 0x%h", pc, pc[`OR1200_ITLB_INDX], itlb_mr, itlb_tr, physical_pc);
		end // if ((itlb_mr[`OR1200_ITLBMR_V_BITS]) & (itlb_mr[`OR1200_ITLBMRW-1:1] == pc[`OR1200_ITLB_TAG]))
	      else
		begin

		   // Wait a couple of clocks, see if we're doing a miss
		   @(posedge `CPU_CORE_CLK);
		   @(posedge `CPU_CORE_CLK);
		   if (!(`OR1200_TOP.`CPU_immu_top.miss)) // MMU should indicate miss
		     begin
			$display("%t: check_for_immu_entry - ERROR - no match found for virtual PC 0x%h in entry %d of iMMU, mr = 0x%x tr = 0x%x, and no miss generated",
				 $time, pc, pc[`OR1200_ITLB_INDX], itlb_mr, itlb_tr);
			#100;
			$finish;
		     end
		   else
		     begin
			mmu_tlb_miss = 1; // Started a miss, so ignore this instruction
		     end
		end // else: !if((itlb_mr[`OR1200_ITLBMR_V_BITS]) & (itlb_mr[`OR1200_ITLBMRW-1:1] == pc[`OR1200_ITLB_TAG]))

	   end // if (`OR1200_TOP.`CPU_immu_top.immu_en === 1'b1)
	 else
 	   physical_pc = pc;
`endif // !`ifdef OR1200_NO_IMMU
      end
   endtask // check_for_immu_entry


   /*
    Instruction memory coherence checking.

    For new instruction executed in the pipeline - ensure it matches
    what is in the main program memory. Perform MMU translations if
    it is enabled.
    */

   reg [31:0] mem_word;
   reg [31:0] last_addr = 0;
   reg [31:0] last_mem_word;
   reg [31:0] physical_pc;
   reg 	      tlb_miss;


`ifdef MEM_COHERENCE_CHECK
 `define MEM_COHERENCE_TRIGGER (`OR1200_TOP.`CPU_cpu.`CPU_ctrl.id_void === 1'b0)

 `define INSN_TO_CHECK `OR1200_TOP.`CPU_cpu.`CPU_ctrl.id_insn
 `define PC_TO_CHECK `OR1200_TOP.`CPU_cpu.`CPU_except.id_pc

   // Check instruction in decode stage is what is in the RAM
   always @(posedge `CPU_CORE_CLK)
     begin
	if (`MEM_COHERENCE_TRIGGER)
	  begin

	     check_for_immu_entry(`PC_TO_CHECK, physical_pc, tlb_miss);

	     // Check if it's a new PC - will also get triggered if the
	     // instruction has changed since we last checked it
	     if (((physical_pc !== last_addr) ||
		  (last_mem_word != `INSN_TO_CHECK)) & !tlb_miss)
	       begin
		  // Decode stage not void, check instruction
		  // get PC
		  get_insn_from_memory(physical_pc, mem_word);

		  if (mem_word !== `INSN_TO_CHECK)
		    begin
		       $fdisplay(fgeneral, "%t: Instruction mismatch for PC 0x%h (phys. 0x%h) - memory had 0x%h, CPU had 0x%h",
				 $time, `PC_TO_CHECK, physical_pc, mem_word,
				 `INSN_TO_CHECK);
		       $display("%t: Instruction mismatch for PC 0x%h (phys. 0x%h) - memory had 0x%h, CPU had 0x%h",
				$time, `PC_TO_CHECK, physical_pc, mem_word,
				`INSN_TO_CHECK);
		       #200;
		       $finish;
		    end
		  last_addr = physical_pc;
		  last_mem_word = mem_word;

	       end // if (((physical_pc !== last_addr) || (last_mem_word != `INSN_TO_CHECK))...
	  end // if (`MEM_COHERENCE_TRIGGER)
     end // always @ (posedge `CPU_CORE_CLK)

`endif //  `ifdef MEM_COHERENCE_CHECK

   // Trigger on each instruction that gets into writeback stage properly
   reg exception_coming1, exception_coming2, exception_here;
   reg will_jump, jumping, jump_dslot, jumped;
   reg rfe, except_during_rfe;
   reg dslot_expt;


   // Maintain a copy of GPRS for previous instruction
   reg [31:0] current_gprs [0:31];
   reg [31:0] current_epcr, current_eear, current_esr, current_sr;
   reg [31:0] previous_gprs [0:31];
   reg [31:0] previous_epcr;
   reg [31:0] previous_eear;
   reg [31:0] previous_esr;
   reg [31:0] previous_sr;

   task update_current_gprs;
      integer j;
      begin
	 for(j=0;j<32;j=j+1)
	   begin
	      get_gpr(j,current_gprs[j]);
	   end
	 current_sr = `OR1200_TOP.`CPU_cpu.`CPU_sprs.sr ;
    	 current_esr = `OR1200_TOP.`CPU_cpu.`CPU_sprs.epcr ;
	 current_epcr = `OR1200_TOP.`CPU_cpu.`CPU_sprs.epcr ;
	 current_eear = `OR1200_TOP.`CPU_cpu.`CPU_sprs.eear ;
      end
   endtask

   task update_previous_gprs;
      integer j;
      begin
	 for(j=0;j<32;j=j+1)
	   begin
	      previous_gprs[j] = current_gprs[j];
	   end
	 previous_sr = current_sr;
    	 previous_esr = current_esr;
	 previous_epcr = current_epcr;
	 previous_eear = current_eear;
      end
   endtask // update_previous_gprs

   // Maintain a list of addresses we expect the processor to execute
   // Whenever we hit a branch or jump or rfe we add to this list - when we
   // execute it then we remove it from the list.
   reg [31:0] expected_addresses [0:31];
   reg        expected_addresses_waiting [0:31]; // List indicating if address is waiting
   reg        duplicate_expected_addresses_waiting [0:31]; // List indicating if a waiting address will be cleared by the single return
   integer    expected_address_num;
   // Initialise things on reset
   always @(`OR1200_TOP.iwb_rst_i)
     begin
	for (expected_address_num=0;expected_address_num<32;expected_address_num=expected_address_num+1)
	  begin
	     expected_addresses_waiting[expected_address_num] = 0;
	     duplicate_expected_addresses_waiting[expected_address_num] = 0;
	  end
	expected_address_num = 0;
     end

   task add_expected_address;
      input [31:0] expected_pc;
      begin
	 if (expected_address_num == 31)
	   begin
	      $display("%t: Too many branches not reached",$time);
	      #100;
	      $finish;
	   end
	 if (expected_addresses_waiting[expected_address_num])
	   begin
	      $display("%t: expected_addresses tracker bugged out. expected_address_num = %0d",$time,expected_address_num);
	      #100;
	      $finish;
	   end
	 else
	   begin
`ifdef OR1200_MONITOR_JUMPTRACK_DEBUG_OUTPUT
	      // Debugging output...
	      $display("%t: Adding address 0x%h to expected list index %0d",$time, expected_pc,expected_address_num);
`endif
	      // Put the expected PC in the list, increase the index
	      expected_addresses[expected_address_num] = expected_pc;
	      expected_addresses_waiting[expected_address_num] = 1;
	      expected_address_num = expected_address_num + 1;
	   end // else: !if(expected_addresses_waiting[expected_address_num])
      end
   endtask // add_address_to_expect

   // Use this in the case that there's an execption after a jump, in which
   // case we'll have two entries when we finally jump back (the one the
   // original jump put in, and the one put in by the l.rfe or l.jr/ when
   // returning outside of exception handler), so mark this one as OK for
   // removing the duplicate of
   task mark_duplicate_expected_address;
      begin
	 // This will always be done on the first instruction of an exception
	 // that has occured after a delay slot instruction, so
	 // expected_address_num will be one past the entry for the one we will
	 // get a duplicate return call for
	 duplicate_expected_addresses_waiting[expected_address_num-1] = 1;
      end
   endtask // mark_duplicate_expected_address


   task check_expected_address;
      input [31:0] pc;
      input 	   expecting_hit;
      integer 	   i,j;
      reg 	   hit;
      reg 	   duplicates;

      begin
	 hit = 0;
	 //$display("%t: check_expected_addr 0x%h, index %0d",
	 // $time,pc, expected_address_num);
	 if (expected_address_num > 0)
	   begin
	      // First check the last jump we did
	      if (expected_addresses[expected_address_num-1] == pc)
		begin
		   // Jump address hit
		   // Debugging printout:
`ifdef OR1200_MONITOR_JUMPTRACK_DEBUG_OUTPUT
		   $display("%t: PC address 0x%h was in expected list, index %0d",$time, pc,expected_address_num-1);
`endif
		   expected_address_num = expected_address_num-1;
		   expected_addresses_waiting[expected_address_num] = 0;
		   hit = 1;
		end
	      else
		begin
		   // Check through the list
		   for(i=0;i<expected_address_num;i=i+1)
		     begin
			if (expected_addresses[i] == pc)
			  begin
			     // Jump address hit
			     // Debugging printout:
`ifdef OR1200_MONITOR_JUMPTRACK_DEBUG_OUTPUT
			     $display("%t: PC address 0x%h was in expected list, index %0d",$time, pc,i);
`endif
			     for(j=i;j<expected_address_num;j=j+1)
			       begin
				  // Pull all of the ones above us down one
				  expected_addresses_waiting[j]
				    = expected_addresses_waiting[j+1];
				  expected_addresses[j]
				    = expected_addresses[j+1];
				  duplicate_expected_addresses_waiting[j]
				    = duplicate_expected_addresses_waiting[j+1];
			       end
			     expected_address_num = expected_address_num-1;
			     hit = 1;
			     // quit out. only allow 1 hit
			     i = expected_address_num;
			  end
		     end
		end // else: !if(expected_addresses[expected_ad...
	   end // if (expected_address_num > 0)

	 // Check for duplicates this way because of the way we've declared
	 // the array...
	 duplicates=0;
	 for(i=0;i<32;i=i+1)
	   duplicates = duplicates | duplicate_expected_addresses_waiting[i];

	 if (hit & duplicates)
	   begin
	      // If we got a hit, check for duplicates we're also meant to clear
`ifdef OR1200_MONITOR_JUMPTRACK_DEBUG_OUTPUT
	      $display;
`endif
	      for(i=0;i<expected_address_num;i=i+1)
		begin
		   if(duplicate_expected_addresses_waiting[i] &
		      expected_addresses_waiting[i] &
		      expected_addresses[i] == pc)
		     begin
			// Found a duplicate call address, clear it
			duplicate_expected_addresses_waiting[i] = 0;
			expected_addresses_waiting[i] = 0;

			// Now reorder the list - pull all the ones above us
			// down by one
			for(j=i;j<expected_address_num;j=j+1)
			  begin
			     expected_addresses_waiting[j] = expected_addresses_waiting[j+1];
			     expected_addresses[j] = expected_addresses[j+1];
			     duplicate_expected_addresses_waiting[j] = duplicate_expected_addresses_waiting[j+1];
			  end
			expected_address_num = expected_address_num - 1;
		     end
		end // for (i=0;i<expected_address_num;i=i+1)
	   end // if (hit & duplicates)

	 if (expecting_hit & !hit)
	   begin
	      // Expected this address to be one we're supposed to jump to, but it wasn't!
	      $display("%t: Failed to find current PC, 0x%h, in expected PCs for branches/jumps",$time,pc);
	      #100;
	      $finish;
	   end

      end
   endtask // check_expected_address

   // Task to assert value of GPR
   task assert_gpr_val;
      input [5:0] regnum;
      input [31:0] assert_value;
      input [31:0] pc;
      reg [31:0]   reg_val;

      begin
	 get_gpr(regnum, reg_val);
	 if (reg_val !== assert_value)
	   begin
	      $display("%t: Assert r%0d value (0x%h) = 0x%h failed. pc=0x%h",
		       $time, regnum, reg_val, assert_value,pc);
	      #100;
	      $finish;
	   end
      end
   endtask // assert_gpr_val

   // Task to assert something is true
   task assert_this;
      input assert_result;
      input [31:0] pc;
      begin
	 if (!assert_result)
	   begin
	      $display("%t: Assert failed for instruction at pc=0x%h",
		       $time , pc);
	      #100;
	      $finish;
	   end
      end
   endtask // assert_gpr_val

   // The jumping variable doesn't get updated until we do the proper check of
   // the current instruction reaching the writeback stage. We need to know
   // earlier, eg. in the exception checking part, if this instruction will
   // jump. We do that with this task.
   task check_for_jump;
      input [31:0] insn;
      reg [5:0]    opcode;
      reg 	   flag;
      begin
	 opcode = insn[`OR1K_OPCODE_POS];
	 // Use the flag from the previous instruction, as the decision
	 // is made in the execute stage not in te writeback stage,
	 // which is where we're getting our instructions.
	 flag = previous_sr[`OR1200_SR_F];

	 case (opcode)
	   `OR1200_OR32_J,
	     `OR1200_OR32_JR,
	     `OR1200_OR32_JAL,
	     `OR1200_OR32_JALR:
	       will_jump = 1;
	   `OR1200_OR32_BNF:
	     will_jump = !flag;
	   `OR1200_OR32_BF:
	     will_jump = flag;
	   default:
	     will_jump = 0;
	 endcase // case (opcode)
      end
   endtask // check_for_jump



   // Detect exceptions from the processor here
   reg [13:0] except_trig_r;
   reg        exception_coming;

   always @(posedge `CPU_CORE_CLK)
     if (`OR1200_TOP.iwb_rst_i)
       begin
	  except_trig_r = 0;
	  exception_coming = 0;
	  except_during_rfe = 0;
       end
     else if ((|`OR1200_TOP.`CPU_cpu.`CPU_except.except_trig) && !exception_coming)
       begin
	  exception_coming  = 1;
	  except_trig_r = `OR1200_TOP.`CPU_cpu.`CPU_except.except_trig;
	  except_during_rfe = rfe;
       end

   task check_incoming_exceptions;
      begin

	 // Exception timing  - depends on the trigger.
	 // Appears to be:
	 // tick timer - dslot - 1 instruction delay, else 2
	 // tlb lookasides - 1 instruction for both

	 casex (except_trig_r)
	   13'b1_xxxx_xxxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_TICK;
	      exception_here = exception_coming2;
	      exception_coming2 = jump_dslot ? exception_coming: exception_coming1 ;
	      exception_coming1 = jump_dslot ? 0 : exception_coming;
	   end
	   13'b0_1xxx_xxxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_INT;
	      #1;
	   end
	   13'b0_01xx_xxxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_ITLBMISS;
	      exception_here = exception_coming2;
	      exception_coming2 = jump_dslot ? exception_coming : exception_coming1 ;
	      exception_coming1 = jump_dslot ? 0 : exception_coming;
	   end
	   13'b0_001x_xxxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_IPF;
	      exception_here = exception_coming2;
	      exception_coming2 = jump_dslot ? exception_coming : exception_coming1 ;
	      exception_coming1 = jump_dslot ? 0 : exception_coming;
	   end
	   13'b0_0001_xxxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_BUSERR;
	      exception_here = exception_coming;
	      exception_coming2 = 0;
	      exception_coming1 = 0;
	   end
	   13'b0_0000_1xxx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_ILLEGAL;
	      if (will_jump)
		begin
		   // Writeback stage instruction will jump, and we have an
		   // illegal instruction in the decode/execute stage, which is
		   // the delay slot, so indicate the exception is coming...
		   exception_here = exception_coming2;
		   exception_coming2 = exception_coming;
		   exception_coming1 = 0;
		end
	      else
		begin
		   exception_here = jump_dslot ?
				    exception_coming2 : exception_coming;
		   exception_coming2 = jump_dslot ? exception_coming : 0;
		   exception_coming1 = 0;
		end
	   end
	   13'b0_0000_01xx_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_ALIGN;
	      if(will_jump)
		begin
		   exception_here = exception_coming2;
		   exception_coming2 = exception_coming;
		   exception_coming1 = 0;
		end
	      else
		begin
		   exception_here =  (rfe) ? exception_coming : exception_coming2;
		   exception_coming2 = (rfe) ? 0 : exception_coming;
		   exception_coming1 = 0;
		end
	   end
	   13'b0_0000_001x_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_DTLBMISS;
	      // Looks like except_trig goes high here after we check the
	      // instruction before the itlb miss after a delay slot, so we
	      // miss the dslot variable (it gets propegated before we call
	      // this task) so we use the jumped variable here to see if we
	      // are an exception after a delay slot
	      //exception_here = (jumped | rfe) ? exception_coming : exception_coming2 ;
	      //exception_coming2 = (jumped | rfe) ? 0 : exception_coming;

	      exception_here = (jumped | rfe) ? exception_coming : exception_coming2 ;
	      exception_coming2 = (jumped | rfe) ? 0 : exception_coming;

	      exception_coming1 = 0;
	   end
	   13'b0_0000_0001_xxxx: begin
	      //except_type <= #1 `OR1200_EXCEPT_DPF;
	      if (jumped) begin // Jumped onto illegal instruction
		 exception_here = exception_coming ;
		 exception_coming2 = 0;
		 exception_coming1 = 0;
	      end
	      else begin
		 exception_here =  exception_coming2;
		 exception_coming2 = exception_coming;
		 exception_coming1 = 0;
	      end
	   end
	   13'b0_0000_0000_1xxx: begin	// Data Bus Error
	      //except_type <= #1 `OR1200_EXCEPT_BUSERR;
	      exception_here = exception_coming2 ;
	      exception_coming2 = exception_coming;
	      exception_coming1 = 0;
	   end
	   13'b0_0000_0000_01xx: begin
	      //except_type <= #1 `OR1200_EXCEPT_RANGE;
	      #1;
	   end
	   13'b0_0000_0000_001x: begin
	      // trap
	      #1;
	   end
	   13'b0_0000_0000_0001: begin
	      //except_type <= #1 `OR1200_EXCEPT_SYSCALL;
	      exception_here = exception_coming2;
	      exception_coming2 = jumped ? exception_coming: exception_coming1 ;
	      exception_coming1 = jumped ? 0 : exception_coming;
	   end
	 endcase // casex (except_trig_r)

	 exception_coming = 0;
	 except_during_rfe = 0;

      end
   endtask // check_incoming_exceptions




   /////////////////////////////////////////////////////////////////////////
   // Execution tracking task
   /////////////////////////////////////////////////////////////////////////


`ifdef OR1200_SYSTEM_CHECKER
   always @(posedge `CPU_CORE_CLK)
     begin
	if (`OR1200_TOP.iwb_rst_i)
	  begin
	     exception_coming1 = 0;exception_coming2 = 0;exception_here= 0;
	     jumping = 0; jump_dslot = 0; jumped = 0;
	     rfe = 0;
	  end
	if (!`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_freeze) begin
	   //#2 ;
	   // If instruction isn't a l.nop with bit 16 set (implementation's
	   // filler instruction in pipeline), and do not have an exception
	   // signaled with a dslot instruction in the execute stage
	   if (((`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn[`OR1K_OPCODE_POS] !=
		 `OR1200_OR32_NOP) || !`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn[16])
	       && !(`OR1200_TOP.`CPU_cpu.`CPU_except.except_flushpipe &&
		    `OR1200_TOP.`CPU_cpu.`CPU_except.ex_dslot)) // and not except start
	     begin

		// Propegate jump-tracking variables
		// If was exception in delay slot, we didn't actually jump
		// so don't set jumped in this case.
		jumped = exception_here ? 0 : jump_dslot;
		jump_dslot = jumping;
		jumping = 0;
		rfe = 0;

		// Now, check if current instruction will jump/branch, this is
		// needed by the exception checking code, sets will_jump=1
		check_for_jump(`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn);

		// Now check if it's an exception this instruction
		check_incoming_exceptions;

		// Case where we just went to an exception after a jump, so we
		// mark the address we were meant to jump to as a place which will
		// have duplicate return entries in the expected address list
		if (exception_here & (jumped | jump_dslot))
		  begin
		     $display("%t: marked as jump address with exception (dup)"
			      ,$time);
		     mark_duplicate_expected_address;
		  end

		or1200_check_execution(`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn,
				       `OR1200_TOP.`CPU_cpu.`CPU_except.wb_pc,
				       exception_here);
		//$write("%t: pc:0x%h\t",$time,
		//       `OR1200_TOP.`CPU_cpu.`CPU_except.wb_pc);
		// Decode the instruction, print it out
		//or1200_print_op(`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_insn);
		//$write("\t exc:%0h dsl:%0h\n",exception_here,jump_dslot);



	     end
	end // if (!`OR1200_TOP.`CPU_cpu.`CPU_ctrl.wb_freeze)
     end // always @ (posedge `CPU_CORE_CLK)
`endif


   task or1200_check_execution;
      input [31:0] insn;
      input [31:0] pc;
      input 	   exception;

      reg [5:0]    opcode;

      reg [25:0]   j_imm;
      reg [25:0]   br_imm;

      reg [4:0]    rD_num, rA_num, rB_num;
      reg [31:0]   rD_val, rA_val, rB_val;
      reg [15:0]   imm_16bit;

      reg [15:0]   mtspr_imm;

      reg [3:0]    alu_op;
      reg [1:0]    shrot_op;

      reg [5:0]    shroti_imm;

      reg [5:0]    sf_op;

      reg [5:0]    xsync_op;

      reg 	   flag;

      reg [31:0]   br_j_ea; // Branch/jump effective address


      begin

	 // Instruction opcode
	 opcode = insn[`OR1K_OPCODE_POS];
	 // Immediates for jump or branch instructions
	 j_imm = insn[`OR1K_J_BR_IMM_POS];
	 br_imm = insn[`OR1K_J_BR_IMM_POS];
	 // Register numbers (D, A and B)
	 rD_num = insn[`OR1K_RD_POS];
	 rA_num = insn[`OR1K_RA_POS];
	 rB_num = insn[`OR1K_RB_POS];
	 // Bottom 16 bits when used as immediates in various instructions
	 imm_16bit = insn[15:0];
	 // 16-bit immediate for mtspr instructions
	 mtspr_imm = {insn[25:21],insn[10:0]};
	 // ALU op for ALU instructions
	 alu_op = insn[`OR1K_ALU_OP_POS];
	 // Shift-rotate op for SHROT ALU instructions
	 shrot_op = insn[`OR1K_SHROT_OP_POS];
	 shroti_imm = insn[`OR1K_SHROTI_IMM_POS];

	 // Set flag op
	 sf_op = insn[`OR1K_SF_OP];

	 // Xsync/syscall/trap opcode
	 xsync_op = insn[`OR1K_XSYNC_OP_POS];

	 // Use the flag from the previous instruction, as the decision
	 // is made in the execute stage not in te writeback stage,
	 // which is where we're getting our instructions.
	 flag = previous_sr[`OR1200_SR_F];

	 update_current_gprs;

	 // Check MSbit of the immediate, sign extend if set
	 br_j_ea = j_imm[25] ? pc + {4'hf,j_imm,2'b00} :
		   pc + {4'h0,j_imm,2'b00};

	 if (exception)
	   begin
	      $display("%t: exception - at 0x%x",$time, pc);
	      // get epcr, put it in the addresses we expect to jump
	      // back to
	      // Maybe DON'T do this. Because maybe in linux things we
	      // interrupt out of, we don't want to execute them again?
	      //add_expected_address(current_epcr);
	   end


	 check_expected_address(pc, (jumped & !exception));

	 rfe = 0;

	 case (opcode)
	   `OR1200_OR32_J:
	     begin
		//
		// PC < - exts(Immediate < < 2) + JumpInsnAddr
		//
		//The immediate value is shifted left two bits, sign-extended
		// to program counter width, and then added to the address of
		// the jump instruction. The result is the effective address
		// of the jump. The program unconditionally jumps to EA with
		// a delay of one instruction.

		add_expected_address(br_j_ea);

		jumping = 1;
	     end
	   `OR1200_OR32_JAL:
	     begin
		//
		//PC < - exts(Immediate < < 2) + JumpInsnAddr
		//LR < - DelayInsnAddr + 4
		//
		// Link reg is r9, check it is PC+8
		//
		add_expected_address(br_j_ea);
		assert_gpr_val(9, pc+8, pc);
		jumping = 1;	//
	     end
	   `OR1200_OR32_BNF:
	     begin
		//EA < - exts(Immediate < < 2) + BranchInsnAddr
		//PC < - EA if SR[F] cleared
		if (!flag)
		  begin
		     add_expected_address(br_j_ea);
		     jumping = 1;
		  end
	     end
	   `OR1200_OR32_BF:
	     begin
		//EA < - exts(Immediate < < 2) + BranchInsnAddr
		//PC < - EA if SR[F] set
		if (flag)
		  begin
		     add_expected_address(br_j_ea);
		     jumping = 1;
		  end
	     end
	   `OR1200_OR32_RFE:
	     begin
		add_expected_address(current_epcr);
		// jumping variable keeps track of jumps/branches with delay
		// slot - there is none for l.rfe
		rfe = 1;
	     end
	   `OR1200_OR32_JR:
	     begin
		//PC < - rB
		get_gpr(rB_num, rB_val);
		add_expected_address(rB_val);
		jumping = 1;
	     end
	   `OR1200_OR32_JALR:
	     begin
		//PC < - rB
		//LR < - DelayInsnAddr + 4
		get_gpr(rB_num, rB_val);
		add_expected_address(rB_val);
		assert_gpr_val(9, pc+8, pc);
		jumping = 1;
	     end
	   /*
	    `OR1200_OR32_LWZ,
	    `OR1200_OR32_LBZ,
	    `OR1200_OR32_LBS,
	    `OR1200_OR32_LHZ,
	    `OR1200_OR32_LHS,
	    `OR1200_OR32_SW,
	    `OR1200_OR32_SB,
	    `OR1200_OR32_SH:
	    begin
	    // Should result in databus access if data cache disabled
	    $display("%t: lsu instruction",$time);
end

	    `OR1200_OR32_MFSPR,
	    `OR1200_OR32_MTSPR:
	    begin
	    // Confirm RF values end up in the correct SPR
	    $display("%t: mxspr",$time);
end

	    `OR1200_OR32_MOVHI,
	    `OR1200_OR32_ADDI,
	    `OR1200_OR32_ADDIC,
	    `OR1200_OR32_ANDI,
	    `OR1200_OR32_ORI,
	    `OR1200_OR32_XORI,
	    `OR1200_OR32_MULI,
	    `OR1200_OR32_ALU:
	    begin
	    // Double check operations done on RF and immediate values
	    $display("%t: ALU op",$time);
end

	    `OR1200_OR32_SH_ROTI:
	    begin
	    // Rotate according to immediate - maybe should be in ALU ops
	    $display("%t: rotate op",$time);
end

	    `OR1200_OR32_SFXXI,
	    `OR1200_OR32_SFXX:
	    begin
	    // Set flag - do the check oursevles, check flag
	    $display("%t: set flag op",$time);
end

	    `OR1200_OR32_MACI,
	    `OR1200_OR32_MACMSB:
	    begin
	    // Either, multiply signed and accumulate, l.mac
	    // or multiply signed and subtract, l.msb
	    $display("%t: MAC op",$time);
end
	    */

	   /*default:
	    begin
	    $display("%t: Unknown opcode 0x%h at pc 0x%x\n",
	    $time,opcode, pc);
end
	    */
	 endcase // case (opcode)

	 update_previous_gprs;

      end
   endtask // or1200_check_execution


   /////////////////////////////////////////////////////////////////////////
   // Instruction decode task
   /////////////////////////////////////////////////////////////////////////

   task or1200_print_op;
      input [31:0] insn;

      reg [5:0]    opcode;

      reg [25:0]   j_imm;
      reg [25:0]   br_imm;

      reg [4:0]    rD_num, rA_num, rB_num;
      reg [31:0]   rA_val, rB_val;
      reg [15:0]   imm_16bit;
      reg [10:0]   imm_split16bit;

      reg [3:0]    alu_op;
      reg [1:0]    shrot_op;

      reg [5:0]    shroti_imm;

      reg [5:0]    sf_op;

      reg [5:0]    xsync_op;

      begin
	 // Instruction opcode
	 opcode = insn[`OR1K_OPCODE_POS];
	 // Immediates for jump or branch instructions
	 j_imm = insn[`OR1K_J_BR_IMM_POS];
	 br_imm = insn[`OR1K_J_BR_IMM_POS];
	 // Register numbers (D, A and B)
	 rD_num = insn[`OR1K_RD_POS];
	 rA_num = insn[`OR1K_RA_POS];
	 rB_num = insn[`OR1K_RB_POS];
	 // Bottom 16 bits when used as immediates in various instructions
	 imm_16bit = insn[15:0];
	 // Bottom 11 bits used as immediates for l.sX instructions

	 // Split 16-bit immediate for l.mtspr/l.sX instructions
	 imm_split16bit = {insn[25:21],insn[10:0]};
	 // ALU op for ALU instructions
	 alu_op = insn[`OR1K_ALU_OP_POS];
	 // Shift-rotate op for SHROT ALU instructions
	 shrot_op = insn[`OR1K_SHROT_OP_POS];
	 shroti_imm = insn[`OR1K_SHROTI_IMM_POS];

	 // Set flag op
	 sf_op = insn[`OR1K_SF_OP];

	 // Xsync/syscall/trap opcode
	 xsync_op = insn[`OR1K_XSYNC_OP_POS];

	 case (opcode)
	   `OR1200_OR32_J:
	     begin
		$fwrite(finsn,"l.j 0x%h", {j_imm,2'b00});
	     end

	   `OR1200_OR32_JAL:
	     begin
		$fwrite(finsn,"l.jal 0x%h", {j_imm,2'b00});
	     end

	   `OR1200_OR32_BNF:
	     begin
		$fwrite(finsn,"l.bnf 0x%h", {br_imm,2'b00});
	     end

	   `OR1200_OR32_BF:
	     begin
		$fwrite(finsn,"l.bf 0x%h", {br_imm,2'b00});
	     end

	   `OR1200_OR32_RFE:
	     begin
		$fwrite(finsn,"l.rfe");
	     end

	   `OR1200_OR32_JR:
	     begin
		$fwrite(finsn,"l.jr r%0d",rB_num);
	     end

	   `OR1200_OR32_JALR:
	     begin
		$fwrite(finsn,"l.jalr r%0d",rB_num);
	     end

	   `OR1200_OR32_LWZ:
	     begin
		$fwrite(finsn,"l.lwz r%0d,0x%0h(r%0d)",rD_num,imm_16bit,rA_num);
	     end

	   `OR1200_OR32_LBZ:
	     begin
		$fwrite(finsn,"l.lbz r%0d,0x%0h(r%0d)",rD_num,imm_16bit,rA_num);
	     end

	   `OR1200_OR32_LBS:
	     begin
		$fwrite(finsn,"l.lbs r%0d,0x%0h(r%0d)",rD_num,imm_16bit,rA_num);
	     end

	   `OR1200_OR32_LHZ:
	     begin
		$fwrite(finsn,"l.lhz r%0d,0x%0h(r%0d)",rD_num,imm_16bit,rA_num);
	     end

	   `OR1200_OR32_LHS:
	     begin
		$fwrite(finsn,"l.lhs r%0d,0x%0h(r%0d)",rD_num,imm_16bit,rA_num);
	     end

	   `OR1200_OR32_SW:
	     begin
		$fwrite(finsn,"l.sw 0x%0h(r%0d),r%0d",imm_split16bit,rA_num,rB_num);
	     end

	   `OR1200_OR32_SB:
	     begin
		$fwrite(finsn,"l.sb 0x%0h(r%0d),r%0d",imm_split16bit,rA_num,rB_num);
	     end

	   `OR1200_OR32_SH:
	     begin
		$fwrite(finsn,"l.sh 0x%0h(r%0d),r%0d",imm_split16bit,rA_num,rB_num);
	     end

	   `OR1200_OR32_MFSPR:
	     begin
		$fwrite(finsn,"l.mfspr r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit,);
	     end

	   `OR1200_OR32_MTSPR:
	     begin
		$fwrite(finsn,"l.mtspr r%0d,r%0d,0x%h",rA_num,rB_num,imm_split16bit);
	     end

	   `OR1200_OR32_MOVHI:
	     begin
		if (!insn[16])
		  $fwrite(finsn,"l.movhi r%0d,0x%h",rD_num,imm_16bit);
		else
		  $fwrite(finsn,"l.macrc r%0d",rD_num);
	     end

	   `OR1200_OR32_ADDI:
	     begin
		$fwrite(finsn,"l.addi r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_ADDIC:
	     begin
		$fwrite(finsn,"l.addic r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_ANDI:
	     begin
		$fwrite(finsn,"l.andi r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_ORI:
	     begin
		$fwrite(finsn,"l.ori r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_XORI:
	     begin
		$fwrite(finsn,"l.xori r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_MULI:
	     begin
		$fwrite(finsn,"l.muli r%0d,r%0d,0x%h",rD_num,rA_num,imm_16bit);
	     end

	   `OR1200_OR32_ALU:
	     begin
		case(alu_op)
		  `OR1200_ALUOP_ADD:
		    $fwrite(finsn,"l.add ");
		  `OR1200_ALUOP_ADDC:
		    $fwrite(finsn,"l.addc ");
		  `OR1200_ALUOP_SUB:
		    $fwrite(finsn,"l.sub ");
		  `OR1200_ALUOP_AND:
		    $fwrite(finsn,"l.and ");
		  `OR1200_ALUOP_OR:
		    $fwrite(finsn,"l.or ");
		  `OR1200_ALUOP_XOR:
		    $fwrite(finsn,"l.xor ");
		  `OR1200_ALUOP_MUL:
		    $fwrite(finsn,"l.mul ");
		  `OR1200_ALUOP_SHROT:
		    begin
		       case(shrot_op)
			 `OR1200_SHROTOP_SLL:
			   $fwrite(finsn,"l.sll ");
			 `OR1200_SHROTOP_SRL:
			   $fwrite(finsn,"l.srl ");
			 `OR1200_SHROTOP_SRA:
			   $fwrite(finsn,"l.sra ");
			 `OR1200_SHROTOP_ROR:
			   $fwrite(finsn,"l.ror ");
		       endcase // case (shrot_op)
		    end
		  `OR1200_ALUOP_DIV:
		    $fwrite(finsn,"l.div ");
		  `OR1200_ALUOP_DIVU:
		    $fwrite(finsn,"l.divu ");
		  `OR1200_ALUOP_CMOV:
		    $fwrite(finsn,"l.cmov ");
		endcase // case (alu_op)
		$fwrite(finsn,"r%0d,r%0d,r%0d",rD_num,rA_num,rB_num);
	     end

	   `OR1200_OR32_SH_ROTI:
	     begin
		case(shrot_op)
		  `OR1200_SHROTOP_SLL:
		    $fwrite(finsn,"l.slli ");
		  `OR1200_SHROTOP_SRL:
		    $fwrite(finsn,"l.srli ");
		  `OR1200_SHROTOP_SRA:
		    $fwrite(finsn,"l.srai ");
		  `OR1200_SHROTOP_ROR:
		    $fwrite(finsn,"l.rori ");
		endcase // case (shrot_op)
		$fwrite(finsn,"r%0d,r%0d,0x%h",rD_num,rA_num,shroti_imm);
	     end

	   `OR1200_OR32_SFXXI:
	     begin
		case(sf_op[2:0])
		  `OR1200_COP_SFEQ:
		    $fwrite(finsn,"l.sfeqi ");
		  `OR1200_COP_SFNE:
		    $fwrite(finsn,"l.sfnei ");
		  `OR1200_COP_SFGT:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfgtsi ");
		       else
			 $fwrite(finsn,"l.sfgtui ");
		    end
		  `OR1200_COP_SFGE:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfgesi ");
		       else
			 $fwrite(finsn,"l.sfgeui ");
		    end
		  `OR1200_COP_SFLT:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfltsi ");
		       else
			 $fwrite(finsn,"l.sfltui ");
		    end
		  `OR1200_COP_SFLE:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sflesi ");
		       else
			 $fwrite(finsn,"l.sfleui ");
		    end
		endcase // case (sf_op[2:0])

		$fwrite(finsn,"r%0d,0x%h",rA_num, imm_16bit);

	     end // case: `OR1200_OR32_SFXXI

	   `OR1200_OR32_SFXX:
	     begin
		case(sf_op[2:0])
		  `OR1200_COP_SFEQ:
		    $fwrite(finsn,"l.sfeq ");
		  `OR1200_COP_SFNE:
		    $fwrite(finsn,"l.sfne ");
		  `OR1200_COP_SFGT:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfgts ");
		       else
			 $fwrite(finsn,"l.sfgtu ");
		    end
		  `OR1200_COP_SFGE:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfges ");
		       else
			 $fwrite(finsn,"l.sfgeu ");
		    end
		  `OR1200_COP_SFLT:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sflts ");
		       else
			 $fwrite(finsn,"l.sfltu ");
		    end
		  `OR1200_COP_SFLE:
		    begin
		       if (sf_op[`OR1200_SIGNED_COMPARE])
			 $fwrite(finsn,"l.sfles ");
		       else
			 $fwrite(finsn,"l.sfleu ");
		    end

		endcase // case (sf_op[2:0])

		$fwrite(finsn,"r%0d,r%0d",rA_num, rB_num);

	     end

	   `OR1200_OR32_MACI:
	     begin
		$fwrite(finsn,"l.maci r%0d,0x%h",rA_num,imm_16bit);
	     end

	   `OR1200_OR32_MACMSB:
	     begin
		if(insn[3:0] == 4'h1)
		  $fwrite(finsn,"l.mac ");
		else if(insn[3:0] == 4'h2)
		  $fwrite(finsn,"l.msb ");

		$fwrite(finsn,"r%0d,r%0d",rA_num,rB_num);
	     end

	   `OR1200_OR32_NOP:
	     begin
		$fwrite(finsn,"l.nop 0x%0h",imm_16bit);
	     end

	   `OR1200_OR32_XSYNC:
	     begin
		case (xsync_op)
		  5'd0:
		    $fwrite(finsn,"l.sys 0x%h",imm_16bit);
		  5'd8:
		    $fwrite(finsn,"l.trap 0x%h",imm_16bit);
		  5'd16:
		    $fwrite(finsn,"l.msync");
		  5'd20:
		    $fwrite(finsn,"l.psync");
		  5'd24:
		    $fwrite(finsn,"l.csync");
		  default:
		    begin
		       $display("%t: Instruction with opcode 0x%h has bad specific type information: 0x%h",$time,opcode,insn);
		       $fwrite(finsn,"%t: Instruction with opcode 0x%h has has bad specific type information: 0x%h",$time,opcode,insn);
		    end
		endcase // case (xsync_op)
	     end

	   default:
	     begin
		$display("%t: Unknown opcode 0x%h",$time,opcode);
		$fwrite(finsn,"%t: Unknown opcode 0x%h",$time,opcode);
	     end

	 endcase // case (opcode)

      end
   endtask // or1200_print_op



endmodule
