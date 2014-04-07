module wb_next_adr
    #(parameter aw = 32)
     (input [aw-1:0] addr_i,
      input [2:0] cti_i,
      input [1:0] bte_i,
      output [aw-1:0] addr_o);

   `include "wb_bfm_params.v"

   assign addr_o = next_adr(addr_i, cti_i, bte_i);
   
   function [aw-1:0] next_adr;

      input [aw-1:0] addr_i;

      input [2:0]    cti_i;

      input [1:0]    bte_i;

      begin
	  if(cti_i == 3'b010)
	       case (bte_i)
		 LINEAR_BURST  : next_adr = addr_i + 4;

		 WRAP_4_BURST  : next_adr = {addr_i[aw-1:4], addr_i[3:0]+4'd4};

		 WRAP_8_BURST  : next_adr = {addr_i[aw-1:5], addr_i[4:0]+5'd4};

		 WRAP_16_BURST : next_adr = {addr_i[aw-1:6], addr_i[5:0]+6'd4};

	       endcase // case (bte_i)
	  else
	    next_adr = addr_i;

	  //default :("%d :b)", $time, burst_type_i);
      end
   endfunction // if
   endmodule
