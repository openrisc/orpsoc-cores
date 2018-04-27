module vlog_functions;
   
   task progress_bar;
      input [8*32:1] msg;
      input integer  current;
      input integer  total;
      begin
	 if(!(current%(total/10)))
	   $display("%0s %0d/%0d", msg, current, total);
      end
   endtask

endmodule

