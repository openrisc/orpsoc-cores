/*
 *  TAP (Test Anything Protocol) generator for verilog testbenches
 *
 *  Copyright (C) 2016  Olof Kindgren <olof.kindgren@gmail.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

module vlog_tap_generator
  #(parameter TAPFILE          = "",
    parameter MAX_STRING_LEN   = 80,
    parameter MAX_FILENAME_LEN = 1024);

   integer f; //File handle
   integer cur_tc = 0; //Current testcase index

   reg [MAX_FILENAME_LEN*8-1:0] tapfile; //TAP file to write

   initial begin
      //Grab CLI parameters and use parameters for default values
      if(!$value$plusargs("tapfile=%s", tapfile))
	tapfile = TAPFILE;
   end

   task set_file;
      input [MAX_FILENAME_LEN*8-1:0] f;
      begin
	 if (cur_tc)
	   $display("Error: Can't change file. Already started writing to %0s", tapfile);
	 else
	   tapfile = f;
      end
   endtask

   task write_tc;
      input [MAX_STRING_LEN*8-1:0] description;
      input 			   ok_i;
      begin
	 if (!f) begin
	    if(tapfile == 0)
	      $display("No TAP file specified");
	    else
	      f = $fopen(tapfile,"w");
	 end

	 if (f) begin
	    cur_tc=cur_tc+1;

	    if (!ok_i)
	      $fwrite(f, "not ");
	    $fwrite(f, "ok %0d %0s\n", cur_tc, description);
	 end
      end
   endtask

   task ok;
      input [MAX_STRING_LEN*8-1:0] description;
      begin
	 write_tc(description, 1);
      end
   endtask

   task nok;
      input [MAX_STRING_LEN*8-1:0] description;
      begin
	 write_tc(description, 0);
      end
   endtask

endmodule
