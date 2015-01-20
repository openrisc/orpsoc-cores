localparam CLASSIC_CYCLE = 1'b0;
localparam BURST_CYCLE   = 1'b1;

localparam READ  = 1'b0;
localparam WRITE = 1'b1;

localparam [2:0]
  CTI_CLASSIC      = 3'b000,
  CTI_CONST_BURST  = 3'b001,
  CTI_INC_BURST    = 3'b010,
  CTI_END_OF_BURST = 3'b111;

localparam [1:0]
  BTE_LINEAR  = 2'd0,
  BTE_WRAP_4  = 2'd1,
  BTE_WRAP_8  = 2'd2,
  BTE_WRAP_16 = 2'd3;
