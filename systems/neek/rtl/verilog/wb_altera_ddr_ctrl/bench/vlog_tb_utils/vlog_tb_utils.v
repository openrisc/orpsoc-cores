module vlog_tb_utils;

   //Force simulation stop after timeout cycles
   reg [63:0] timeout;
   initial
     if($value$plusargs("timeout=%d", timeout)) begin
	#timeout $display("Timeout: Forcing end of simulation");
	$finish;
     end

   //FIXME: Add more options for VCD logging
   initial begin
      if($test$plusargs("vcd")) begin
	 $dumpfile("testlog.vcd");
	 $dumpvars(0);
      end
   end

endmodule // vlog_tb_utils
