//////////////////////////////////////////////////////////////////////
////                                                              ////
////  mt48lc16m16a2_loader                                        ////
////                                                              ////
////  Description:                                                ////
////  Testbench component that initializes data in a simulation   ////
////  model of the SDRAM Micron MT48LC16M16A2 (mt48lc16m16a2.v)   ////
////  This can be used to save simlation time, by avoiding having ////
////  to store data in the SDRAM the normal way.                  ////
////                                                              ////
////  The data should be stored in a .vmem file containing        ////
////  32-bit words.                                               ////
////  The filename is set using plusargs "testcase=..."           ////   
////                                                              ////
////  Based on code from Olof Kindgren's ram_wb_loader.v and      ////
////  Julius Baxter's additions to mt48lc16m16a2.v                ////
////                                                              ////
////  To Do:                                                      ////
////      - Clean up                                              ////
////                                                              ////                                                             ////
////  Author(s):                                                  ////
////      - Per Larsson, per.larsson@orsoc.se                     ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2012 Authors and OPENCORES.ORG                 ////
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


// Uncomment the same constant, as is uncommented in mt48lc16m16a2.v
// TODO: Replace this by examining vector length in orpsoc_tb.dut.sdram0, 
//       if possible.
// Uncomment one of the following to have the appropriate size definitions
// for the part.
//`define MT48LC32M16   // 64MB part
`define MT48LC16M16   // 32MB part
//`define MT48LC4M16    //  8MB part

module mt48lc16m16a2_loader;

`ifdef MT48LC32M16
   // Params. for  mt48lc32m16a2 (64MB part)
   parameter mem_sizes = 8388608;
`endif

`ifdef MT48LC16M16
   // Params. for  mt48lc16m16a2 (32MB part)
   parameter mem_sizes = 4194304;
`endif
   
`ifdef MT48LC4M16    
   //Params for mt48lc4m16a2 (8MB part)
   parameter mem_sizes =   1048576;
`endif

  reg [1023 : 0] testcase;
  reg [  31 : 0] Bank0_32bit [0 : (mem_sizes/2)]; // Temporary 32-bit wide array
                                                  // to hold readmemh()'d data before
                                                  // loading into 16-bit wide array
  integer mem_cnt;
   
  //FIXME: Don't hard code sdram location
  initial begin
    if($value$plusargs("testcase=%s",testcase)) begin  //TODO: use parameter for testcase filename instead 
      //$readmemh(testcase, orpsoc_tb.dut.ram_wb0.ram_wb_b3_0.mem);
      $display("* Preloading SDRAM bank 0 from mt48lc16m16a2_loader...");
      $readmemh(testcase, Bank0_32bit);
      for (mem_cnt=0;mem_cnt < (mem_sizes/2); mem_cnt = mem_cnt + 1) begin
        orpsoc_tb.sdram0.Bank0[(mem_cnt*2)+1] = Bank0_32bit[mem_cnt][15: 0];
        orpsoc_tb.sdram0.Bank0[(mem_cnt*2)  ] = Bank0_32bit[mem_cnt][31:16];
      end        
    end else begin
        $display("No testcase specified");
    end
  end
endmodule // mt48lc16m16a2_loader

