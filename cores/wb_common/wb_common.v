`include "wb_common_params.v"
function get_cycle_type;
   input [2:0] cti;
   begin
      get_cycle_type = (cti === CTI_CLASSIC) ? CLASSIC_CYCLE : BURST_CYCLE;
   end
endfunction

function wb_is_last;
   input [2:0] cti;
   begin
      case (cti)
	CTI_CLASSIC      : wb_is_last = 1'b1;
	CTI_CONST_BURST  : wb_is_last = 1'b0;
	CTI_INC_BURST    : wb_is_last = 1'b0;
	CTI_END_OF_BURST : wb_is_last = 1'b1;
	default : $display("%d : Illegal Wishbone B3 cycle type (%b)", $time, cti);
      endcase
   end
endfunction

function [31:0] wb_next_adr;
   input [31:0] adr_i;
   input [2:0] 	cti_i;
   input [2:0] 	bte_i;
   input integer dw;

   reg [31:0] 	 adr;
   integer 	 shift;
   begin
      shift = $clog2(dw/8);
      adr = adr_i >> shift;
      if (cti_i == CTI_INC_BURST)
	case (bte_i)
	  BTE_LINEAR   : adr = adr + 1;
	  BTE_WRAP_4   : adr = {adr[31:2], adr[1:0]+2'd1};
	  BTE_WRAP_8   : adr = {adr[31:3], adr[2:0]+3'd1};
	  BTE_WRAP_16  : adr = {adr[31:4], adr[3:0]+4'd1};
	endcase // case (burst_type_i)
      wb_next_adr = adr << shift;
   end
endfunction

