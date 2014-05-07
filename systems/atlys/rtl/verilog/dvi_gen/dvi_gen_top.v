//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////
//   ____  ____
//  /   /\/   /
// /___/  \  /   Vendor:        Xilinx
// \   \   \/    Version:       1.0.0
//  \   \        Filename:      vtc_demo.v
//  /   /        Date Created:  April 8, 2009
// /___/   /\    Author:        Bob Feng   
// \   \  /  \
//  \___\/\___\
//
// Devices:   Spartan-6 Generation FPGA
// Purpose:   SP601 board demo top level
// Contact:   
// Reference: None
//
// Revision History:
// 
//
//////////////////////////////////////////////////////////////////////////////
//
// LIMITED WARRANTY AND DISCLAIMER. These designs are provided to you "as is".
// Xilinx and its licensors make and you receive no warranties or conditions,
// express, implied, statutory or otherwise, and Xilinx specifically disclaims
// any implied warranties of merchantability, non-infringement, or fitness for
// a particular purpose. Xilinx does not warrant that the functions contained
// in these designs will meet your requirements, or that the operation of
// these designs will be uninterrupted or error free, or that defects in the
// designs will be corrected. Furthermore, Xilinx does not warrant or make any
// representations regarding use or the results of the use of the designs in
// terms of correctness, accuracy, reliability, or otherwise.
//
// LIMITATION OF LIABILITY. In no event will Xilinx or its licensors be liable
// for any loss of data, lost profits, cost or procurement of substitute goods
// or services, or for any special, incidental, consequential, or indirect
// damages arising from the use or operation of the designs or accompanying
// documentation, however caused and on any theory of liability. This
// limitation will apply even if Xilinx has been advised of the possibility
// of such damage. This limitation shall apply not-withstanding the failure
// of the essential purpose of any limited remedies herein.
//
//////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2009 Xilinx, Inc.
// This design is confidential and proprietary of Xilinx, All Rights Reserved.
//////////////////////////////////////////////////////////////////////////////

`timescale 1 ps / 1 ps

module dvi_gen_top (
  input  wire        rst_n_pad_i,
  input  wire        dvi_clk_i,
  input  wire [15:0] hlen,
  input  wire [15:0] vlen,
  output wire [3:0]  TMDS,
  output wire [3:0]  TMDSB,
  output wire        pclk_o,
  input  wire        hsync_i, 
  input  wire        vsync_i, 
  input  wire        blank_i, 
  input  wire [7:0]  red_data_i,
  input  wire [7:0]  green_data_i,
  input  wire [7:0]  blue_data_i
);

  //******************************************************************//
  // Create global clock and synchronous system reset.                //
  //******************************************************************//
  wire          locked;
  wire          reset;

  wire          clk50m, clk50m_bufg;

  wire          pwrup;

  assign clk50m = dvi_clk_i;
  BUFG clk50m_bufgbufg (.I(clk50m), .O(clk50m_bufg));

  wire pclk_lckd;
  wire RSTBTN;
  // transform rst button into active high
  assign RSTBTN = ~rst_n_pad_i; 
//`ifdef SIMULATION
//  assign pwrup = 1'b0;
//`else
  SRL16E #(.INIT(16'h1)) pwrup_0 (
    .Q(pwrup),
    .A0(1'b1),
    .A1(1'b1),
    .A2(1'b1),
    .A3(1'b1),
    .CE(pclk_lckd),
    .CLK(clk50m_bufg),
    .D(1'b0)
  );
//`endif

  //////////////////////////////////////
  /// Switching screen formats
  //////////////////////////////////////
  wire busy;
  reg switch = 1'b0;
  reg [15:0] hlen_q, vlen_q;

  always @ (posedge clk50m_bufg)
  begin
    switch <= pwrup | ({hlen_q,vlen_q} != {hlen,vlen});
  end

  wire gopclk;
  SRL16E SRL16E_0 (
    .Q(gopclk),
    .A0(1'b1),
    .A1(1'b1),
    .A2(1'b1),
    .A3(1'b1),
    .CE(1'b1),
    .CLK(clk50m_bufg),
    .D(switch)
  );
  // The following defparam declaration 
  defparam SRL16E_0.INIT = 16'h0;

  reg [7:0] pclk_M, pclk_D;

  always @(posedge clk50m_bufg)
  begin
    hlen_q <= hlen;
    vlen_q <= vlen;
    if (switch) begin
      case ({hlen,vlen})
        32'h031f01c1:  // 640x400@70, pclk = 21.600000MHz
        begin
          pclk_M <= 8'd54 - 8'd1;
          pclk_D <= 8'd125 - 8'd1;
        end
        32'h031f020c:  // 640x480@60, pclk = 25.200000MHz
        begin
          pclk_M <= 8'd63 - 8'd1;
          pclk_D <= 8'd125 - 8'd1;
        end
        32'h03ff0270:  // 800x600@56, pclk = 38.400000MHz
        begin
          pclk_M <= 8'd96 - 8'd1;
          pclk_D <= 8'd125 - 8'd1;
        end
        32'h04ef0330:  // 1024x768@87, pclk = 61.961280MHz
        begin
          pclk_M <= 8'd202 - 8'd1;
          pclk_D <= 8'd163 - 8'd1;
        end
        32'h033f01bc:  // 640x400@85, pclk = 22.214400MHz
        begin
          pclk_M <= 8'd4 - 8'd1;
          pclk_D <= 8'd9 - 8'd1;
        end
        32'h035f0208:  // 640x480@72, pclk = 27.008640MHz
        begin
          pclk_M <= 8'd121 - 8'd1;
          pclk_D <= 8'd224 - 8'd1;
        end
        32'h041f0273:  // 800x600@60, pclk = 39.790080MHz
        begin
          pclk_M <= 8'd152 - 8'd1;
          pclk_D <= 8'd191 - 8'd1;
        end
        32'h033f01fc:  // 640x480@85, pclk = 25.409280MHz
        begin
          pclk_M <= 8'd31 - 8'd1;
          pclk_D <= 8'd61 - 8'd1;
        end
        32'h05c703d8:  // 1152x864@89, pclk = 87.468000MHz
        begin
          pclk_M <= 8'd7 - 8'd1;
          pclk_D <= 8'd4 - 8'd1;
        end
        32'h040f0299:  // 800x600@72, pclk = 41.558400MHz
        begin
          pclk_M <= 8'd64 - 8'd1;
          pclk_D <= 8'd77 - 8'd1;
        end
        32'h053f0325:  // 1024x768@60, pclk = 64.995840MHz
        begin
          pclk_M <= 8'd13 - 8'd1;
          pclk_D <= 8'd10 - 8'd1;
        end
        32'h035f0211:  // 640x480@100, pclk = 27.475200MHz
        begin
          pclk_M <= 8'd111 - 8'd1;
          pclk_D <= 8'd202 - 8'd1;
        end
        32'h068f037b:  // 1152x864@60, pclk = 89.913600MHz
        begin
          pclk_M <= 8'd205 - 8'd1;
          pclk_D <= 8'd114 - 8'd1;
        end
        32'h043f0290:  // 800x600@85, pclk = 42.888960MHz
        begin
          pclk_M <= 8'd193 - 8'd1;
          pclk_D <= 8'd225 - 8'd1;
        end
        32'h052f0325:  // 1024x768@70, pclk = 64.222080MHz
        begin
          pclk_M <= 8'd140 - 8'd1;
          pclk_D <= 8'd109 - 8'd1;
        end
        32'h061f048c:  // 1280x1024@87, pclk = 109.603200MHz
        begin
          pclk_M <= 8'd217 - 8'd1;
          pclk_D <= 8'd99 - 8'd1;
        end
        32'h043f027f:  // 800x600@100, pclk = 41.779200MHz
        begin
          pclk_M <= 8'd188 - 8'd1;
          pclk_D <= 8'd225 - 8'd1;
        end
        32'h054f0336:  // 1024x768@76, pclk = 67.156800MHz
        begin
          pclk_M <= 8'd137 - 8'd1;
          pclk_D <= 8'd102 - 8'd1;
        end
        32'h05c1037e:  // 1152x864@70, pclk = 79.153800MHz
        begin
          pclk_M <= 8'd19 - 8'd1;
          pclk_D <= 8'd12 - 8'd1;
        end
        32'h06af041d:  // 1280x1024@61, pclk = 108.266880MHz
        begin
          pclk_M <= 8'd249 - 8'd1;
          pclk_D <= 8'd115 - 8'd1;
        end
        32'h0697042a:  // 1400x1050@60, pclk = 108.065760MHz
        begin
          pclk_M <= 8'd67 - 8'd1;
          pclk_D <= 8'd31 - 8'd1;
        end
        32'h06970447:  // 1400x1050@75, pclk = 111.002880MHz
        begin
          pclk_M <= 8'd111 - 8'd1;
          pclk_D <= 8'd50 - 8'd1;
        end
        32'h068f0428:  // 1400x1050@60, pclk = 107.352000MHz
        begin
          pclk_M <= 8'd73 - 8'd1;
          pclk_D <= 8'd34 - 8'd1;
        end
        32'h057f0335:  // 1024x768@85, pclk = 69.442560MHz
        begin
          pclk_M <= 8'd25 - 8'd1;
          pclk_D <= 8'd18 - 8'd1;
        end
        32'h060f038b:  // 1152x864@78, pclk = 84.552960MHz
        begin
          pclk_M <= 8'd208 - 8'd1;
          pclk_D <= 8'd123 - 8'd1;
        end
        32'h069f042b:  // 1280x1024@70, pclk = 108.679680MHz
        begin
          pclk_M <= 8'd213 - 8'd1;
          pclk_D <= 8'd98 - 8'd1;
        end
        32'h086f04e1:  // 1600x1200@60, pclk = 162.000000MHz
        begin
          pclk_M <= 8'd81 - 8'd1;
          pclk_D <= 8'd25 - 8'd1;
        end
        32'h06ef038b:  // 1152x864@84, pclk = 96.756480MHz
        begin
          pclk_M <= 8'd209 - 8'd1;
          pclk_D <= 8'd108 - 8'd1;
        end
        32'h06af0427:  // 1280x1024@74, pclk = 109.294080MHz
        begin
          pclk_M <= 8'd247 - 8'd1;
          pclk_D <= 8'd113 - 8'd1;
        end
        32'h059f0321:  // 1024x768@100, pclk = 69.292800MHz
        begin
          pclk_M <= 8'd255 - 8'd1;
          pclk_D <= 8'd184 - 8'd1;
        end
        32'h067f0427:  // 1280x1024@76, pclk = 106.229760MHz
        begin
          pclk_M <= 8'd17 - 8'd1;
          pclk_D <= 8'd8 - 8'd1;
        end
        32'h05ff0385:  // 1152x864@100, pclk = 83.128320MHz
        begin
          pclk_M <= 8'd133 - 8'd1;
          pclk_D <= 8'd80 - 8'd1;
        end
        32'h06bf042f:  // 1280x1024@85, pclk = 111.144960MHz
        begin
          pclk_M <= 8'd249 - 8'd1;
          pclk_D <= 8'd112 - 8'd1;
        end
        32'h08bf0440:  // 1680x1050@60, pclk = 146.361600MHz
        begin
          pclk_M <= 8'd161 - 8'd1;
          pclk_D <= 8'd55 - 8'd1;
        end
        32'h081f04db:  // 1600x1200@85, pclk = 155.251200MHz
        begin
          pclk_M <= 8'd59 - 8'd1;
          pclk_D <= 8'd19 - 8'd1;
        end
        32'h069f042f:  // 1280x1024@100, pclk = 109.086720MHz
        begin
          pclk_M <= 8'd24 - 8'd1;
          pclk_D <= 8'd11 - 8'd1;
        end
        32'h095705d1:  // 1800x1440@64, pclk = 213.844800MHz
        begin
          pclk_M <= 8'd201 - 8'd1;
          pclk_D <= 8'd47 - 8'd1;
        end
        32'h027f0193:  // 512x384@78, pclk = 15.513600MHz
        begin
          pclk_M <= 8'd76 - 8'd1;
          pclk_D <= 8'd245 - 8'd1;
        end
        32'h018f00e0:  // 320x200@70, pclk = 5.400000MHz
        begin
          pclk_M <= 8'd27 - 8'd1;
          pclk_D <= 8'd250 - 8'd1;
        end
        32'h018f0105:  // 320x240@60, pclk = 6.288000MHz
        begin
          pclk_M <= 8'd21 - 8'd1;
          pclk_D <= 8'd167 - 8'd1;
        end
        32'h01ff0137:  // 400x300@56, pclk = 9.584640MHz
        begin
          pclk_M <= 8'd37 - 8'd1;
          pclk_D <= 8'd193 - 8'd1;
        end
        32'h020f0139:  // 400x300@60, pclk = 9.947520MHz
        begin
          pclk_M <= 8'd38 - 8'd1;
          pclk_D <= 8'd191 - 8'd1;
        end
        32'h0207014c:  // 400x300@72, pclk = 10.389600MHz
        begin
          pclk_M <= 8'd16 - 8'd1;
          pclk_D <= 8'd77 - 8'd1;
        end
        32'h02670137:  // 480x300@56, pclk = 11.531520MHz
        begin
          pclk_M <= 8'd3 - 8'd1;
          pclk_D <= 8'd13 - 8'd1;
        end
        32'h02770139:  // 480x300@60, pclk = 11.906880MHz
        begin
          pclk_M <= 8'd5 - 8'd1;
          pclk_D <= 8'd21 - 8'd1;
        end
        32'h026f014c:  // 480x300@72, pclk = 12.467520MHz
        begin
          pclk_M <= 8'd63 - 8'd1;
          pclk_D <= 8'd253 - 8'd1;
        end
        32'h0a1f04d9:  // 1920x1200@60, pclk = 193.155840MHz
        begin
          pclk_M <= 8'd197 - 8'd1;
          pclk_D <= 8'd51 - 8'd1;
        end
        32'h05bf0325:  // 1152x768@60, pclk = 71.185920MHz
        begin
          pclk_M <= 8'd84 - 8'd1;
          pclk_D <= 8'd59 - 8'd1;
        end
        32'h05f70315:  // 1366x768@60, pclk = 72.427200MHz
        begin
          pclk_M <= 8'd197 - 8'd1;
          pclk_D <= 8'd136 - 8'd1;
        end
        32'h068f033b:  // 1280x800@60, pclk = 83.462400MHz
        begin
          pclk_M <= 8'd217 - 8'd1;
          pclk_D <= 8'd130 - 8'd1;
        end
        32'h035f0270:  // 720x576@50, pclk = 32.400000MHz
        begin
          pclk_M <= 8'd81 - 8'd1;
          pclk_D <= 8'd125 - 8'd1;
        end
        32'h043f0270:  // 800x520@50, pclk = 40.800000MHz
        begin
          pclk_M <= 8'd102 - 8'd1;
          pclk_D <= 8'd125 - 8'd1;
        end
        default:
        begin
          pclk_M <= 8'd2 - 8'd1;
          pclk_D <= 8'd4 - 8'd1;
        end
      endcase
    end
  end

  //
  // DCM_CLKGEN SPI controller
  //
  wire progdone, progen, progdata;
  dcmspi dcmspi_0 (
    .RST(switch),          //Synchronous Reset
    .PROGCLK(clk50m_bufg), //SPI clock
    .PROGDONE(progdone),   //DCM is ready to take next command
    .DFSLCKD(pclk_lckd),
    .M(pclk_M),            //DCM M value
    .D(pclk_D),            //DCM D value
    .GO(gopclk),           //Go programme the M and D value into DCM(1 cycle pulse)
    .BUSY(busy),
    .PROGEN(progen),       //SlaveSelect,
    .PROGDATA(progdata)    //CommandData
  );

  //
  // DCM_CLKGEN to generate a pixel clock with a variable frequency
  //
  wire          clkfx, pclk;
  DCM_CLKGEN #(
    .CLKFX_DIVIDE (21),
    .CLKFX_MULTIPLY (31),
    .CLKIN_PERIOD(20.000)
  )
  PCLK_GEN_INST (
    .CLKFX(clkfx),
    .CLKFX180(),
    .CLKFXDV(),
    .LOCKED(pclk_lckd),
    .PROGDONE(progdone),
    .STATUS(),
    .CLKIN(clk50m),
    .FREEZEDCM(1'b0),
    .PROGCLK(clk50m_bufg),
    .PROGDATA(progdata),
    .PROGEN(progen),
    .RST(1'b0)
  );


  wire pllclk0, pllclk1, pllclk2;
  wire pclkx2, pclkx10, pll_lckd;
  wire clkfbout;

  //
  // Pixel Rate clock buffer
  //
  BUFG pclkbufg (.I(pllclk1), .O(pclk));
  assign pclk_o = pclk;
  //////////////////////////////////////////////////////////////////
  // 2x pclk is going to be used to drive OSERDES2
  // on the GCLK side
  //////////////////////////////////////////////////////////////////
  BUFG pclkx2bufg (.I(pllclk2), .O(pclkx2));

  //////////////////////////////////////////////////////////////////
  // 10x pclk is used to drive IOCLK network so a bit rate reference
  // can be used by OSERDES2
  //////////////////////////////////////////////////////////////////
  PLL_BASE # (
    .CLKIN_PERIOD(13),
    .CLKFBOUT_MULT(10), //set VCO to 10x of CLKIN
    .CLKOUT0_DIVIDE(1),
    .CLKOUT1_DIVIDE(10),
    .CLKOUT2_DIVIDE(5),
    .COMPENSATION("INTERNAL")
  ) PLL_OSERDES (
    .CLKFBOUT(clkfbout),
    .CLKOUT0(pllclk0),
    .CLKOUT1(pllclk1),
    .CLKOUT2(pllclk2),
    .CLKOUT3(),
    .CLKOUT4(),
    .CLKOUT5(),
    .LOCKED(pll_lckd),
    .CLKFBIN(clkfbout),
    .CLKIN(clkfx),
    .RST(~pclk_lckd)
  );

  wire serdesstrobe;
  wire bufpll_lock;
  BUFPLL #(.DIVIDE(5)) ioclk_buf (.PLLIN(pllclk0), .GCLK(pclkx2), .LOCKED(pll_lckd),
           .IOCLK(pclkx10), .SERDESSTROBE(serdesstrobe), .LOCK(bufpll_lock));

  synchro #(.INITIALIZE("LOGIC1"))
  synchro_reset (.async(!pll_lckd),.sync(reset),.clk(pclk));

  ////////////////////////////////////////////////////////////////
  // DVI Encoder
  ////////////////////////////////////////////////////////////////
  wire [4:0] tmds_data0, tmds_data1, tmds_data2;
  wire not_blank = !blank_i;
  dvi_encoder enc0 (
    .clkin      (pclk),
    .clkx2in    (pclkx2),
    .rstin      (reset),
    .blue_din   (blue_data_i),
    .green_din  (green_data_i),
    .red_din    (red_data_i),
    .hsync      (hsync_i),
    .vsync      (vsync_i),
    .de         (not_blank),
    .tmds_data0 (tmds_data0),
    .tmds_data1 (tmds_data1),
    .tmds_data2 (tmds_data2));

  wire [2:0] tmdsint;

  wire serdes_rst = RSTBTN | ~bufpll_lock;

  serdes_n_to_1 #(.SF(5)) oserdes0 (
             .ioclk(pclkx10),
             .serdesstrobe(serdesstrobe),
             .reset(serdes_rst),
             .gclk(pclkx2),
             .datain(tmds_data0),
             .iob_data_out(tmdsint[0])) ;

  serdes_n_to_1 #(.SF(5)) oserdes1 (
             .ioclk(pclkx10),
             .serdesstrobe(serdesstrobe),
             .reset(serdes_rst),
             .gclk(pclkx2),
             .datain(tmds_data1),
             .iob_data_out(tmdsint[1])) ;

  serdes_n_to_1 #(.SF(5)) oserdes2 (
             .ioclk(pclkx10),
             .serdesstrobe(serdesstrobe),
             .reset(serdes_rst),
             .gclk(pclkx2),
             .datain(tmds_data2),
             .iob_data_out(tmdsint[2])) ;

  OBUFDS TMDS0 (.I(tmdsint[0]), .O(TMDS[0]), .OB(TMDSB[0])) ;
  OBUFDS TMDS1 (.I(tmdsint[1]), .O(TMDS[1]), .OB(TMDSB[1])) ;
  OBUFDS TMDS2 (.I(tmdsint[2]), .O(TMDS[2]), .OB(TMDSB[2])) ;

  reg [4:0] tmdsclkint = 5'b00000;
  reg toggle = 1'b0;

  always @ (posedge pclkx2 or posedge serdes_rst) begin
    if (serdes_rst)
      toggle <= 1'b0;
    else
      toggle <= ~toggle;
  end

  always @ (posedge pclkx2) begin
    if (toggle)
      tmdsclkint <= 5'b11111;
    else
      tmdsclkint <= 5'b00000;
  end

  wire tmdsclk;

  serdes_n_to_1 #(
    .SF           (5))
  clkout (
    .iob_data_out (tmdsclk),
    .ioclk        (pclkx10),
    .serdesstrobe (serdesstrobe),
    .gclk         (pclkx2),
    .reset        (serdes_rst),
    .datain       (tmdsclkint));

  OBUFDS TMDS3 (.I(tmdsclk), .O(TMDS[3]), .OB(TMDSB[3])) ;// clock

endmodule
