//////////////////////////////////////////////////////////////////////
////                                                              ////
////  ORPSoC SystemC Testbench header                             ////
////                                                              ////
////  Description                                                 ////
////  ORPSoC Testbench header file                                ////
////                                                              ////
////  To Do:                                                      ////
////                                                              ////
////                                                              ////
////  Author(s):                                                  ////
////      - Jeremy Bennett jeremy.bennett@embecosm.com            ////
////      - Julius Baxter jb@orsoc.se                             ////
////      - Jose T. de Sousa jb@inesc-id.pt                       ////
////                                                              ////
////                                                              ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009 Authors and OPENCORES.ORG                 ////
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

// SystemC declarations that should be visible anywhere. These should be
// consistent with the values used in the Verilog

#ifndef ORPSOC_MAIN__H
#define ORPSOC_MAIN__H

/* Globals used by other C modules */
extern bool gQuiet;
extern int gSimRunning;

//! The Verilog timescale unit (as SystemC timescale unit)
#define TIMESCALE_UNIT        SC_NS

//! The number of cycles of reset required
#define BENCH_RESET_TIME      10

//! CPU clock Half period in timescale units 
#define BENCH_CLK_HALFPERIOD  5 //10 -->50MHz 5 --> 100MHZ 

//! Ratio of JTAG clock period to CPU clock period
#define CLOCK_RATIO  10

//! JTAG clock half period in timescale units
#define JTAG_CLK_HALFPERIOD (CLOCK_RATIO * BENCH_CLK_HALFPERIOD)

//! Start of 2MB Flash memory
#define FLASH_START 0xf0000000

//! End of 2MB Flash memory
#define FLASH_END   0xf01fffff

//! Default port for RSP to listen on
#define DEFAULT_JTAG_PORT  50003

//! FIFO size for talking to the RSP connection
#define RSP_FIFO_SIZE  8

//! Maximum size of a RSP packet is used to return the value of all the
//! registers, each of which takes 8 chars. There are a total of 32 GPRs plus
//! PPC, SR and NPC. Plus one byte for end of string marker.
#define RSP_MAX_PKT_SIZE ((32 + 3) * 8 + 1)

#endif // ORPSOC_MAIN__H
