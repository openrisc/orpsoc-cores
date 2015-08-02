//TODO: Add function to convert between 32 bit words and bytes
module wb_ram_generic
  #(parameter depth=256,
    parameter memfile = "")
  (input clk,
   input [3:0]	 we,
   input [31:0]  din,
   input [$clog2(depth)-1:0] 	 waddr,
   input [$clog2(depth)-1:0] 	 raddr,
   output reg [31:0] dout);

   reg [31:0] 	 mem [0:depth-1];
   
   always @(posedge clk) begin
      if (we[0]) mem[waddr][7:0]   <= din[7:0];
      if (we[1]) mem[waddr][15:8]  <= din[15:8];
      if (we[2]) mem[waddr][23:16] <= din[23:16];
      if (we[3]) mem[waddr][31:24] <= din[31:24];
      dout <= mem[raddr];
   end

   generate
      initial
	if(memfile != "") begin
	   $display("Preloading %m from %s", memfile);
	   $readmemh(memfile, mem);
	end
   endgenerate

endmodule
