/* Copyright (c) 2013 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 *
 * This is a generic wishbone bus (B3). The number of masters and
 * slaves are configurable. Ten slaves can be connected with a
 * configurable memory map.
 *
 * Instantiation example:
 *  wb_bus_b3
 *   #(.DATA_WIDTH(32), .ADDR_WIDTH(32),
 *     .MASTERS(4), .SLAVES(2),
 *     .S0_RANGE_WIDTH(1), .S0_RANGE_MATCH(1'b0),
 *     .S1_RANGE_WIDTH(4), .S1_RANGE_MATCH(4'he))
 *  bus(.clk_i(clk), rst_i(rst),
 *      .m_adr_i({m_adr_i[3],..,m_adr_i[0]},
 *      ...
 *      );
 *
 * DATA_WIDTH and ADDR_WIDTH are defined in bits. DATA_WIDTH must be
 * full bytes (i.e., multiple of 8)!
 *
 * The ports are flattened. That means, that all masters share the bus
 * signal ports. With four masters and a data width of 32 bit the
 * m_cyc_i port is 4 bit wide and the m_dat_i is 128 (=4*32) bit wide.
 * The signals are arranged from right to left, meaning the m_dat_i is
 * defined as [DATA_WIDTH*MASTERS-1:0] and each port m is assigned to
 * [(m+1)*DATA_WIDTH-1:m*DATA_WIDTH].
 *
 * The memory map is defined with the S?_RANGE_WIDTH and
 * S?_RANGE_MATCH parameters. The WIDTH sets the number of most
 * significant bits (i.e., those from the left) that are relevant to
 * define the memory range. The MATCH accordingly sets the value of
 * those bits of the address that define the memory range.
 *
 * Example (32 bit addresses):
 *  Slave 0: 0x00000000-0x7fffffff
 *  Slave 1: 0x80000000-0xbfffffff
 *  Slave 2: 0xe0000000-0xe0ffffff
 *
 * Slave 0 is defined by the uppermost bit, which is 0 for this
 * address range. Slave 1 is defined by the uppermost two bit, that
 * are 10 for the memory range. Slave 2 is defined by 8 bit which are
 * e0 for the memory range.
 *
 * This results in:
 *  S0_RANGE_WIDTH(1), S0_RANGE_MATCH(1'b1)
 *  S1_RANGE_WIDTH(2), S1_RANGE_MATCH(2'b10)
 *  S2_RANGE_WIDTH(8), S2_RANGE_MATCH(8'he0)
 *
 * Author(s):
 *   Stefan Wallentowitz <stefan.wallentowitz@tum.de>
 */

// TODO: * check bus hold signal correctness

module wb_bus_b3(/*AUTOARG*/
   // Outputs
   m_dat_o, m_ack_o, m_err_o, m_rty_o, s_adr_o, s_dat_o, s_cyc_o,
   s_stb_o, s_sel_o, s_we_o, s_cti_o, s_bte_o, snoop_adr_o,
   snoop_en_o, bus_hold_ack,
   // Inputs
   clk_i, rst_i, m_adr_i, m_dat_i, m_cyc_i, m_stb_i, m_sel_i, m_we_i,
   m_cti_i, m_bte_i, s_dat_i, s_ack_i, s_err_i, s_rty_i, bus_hold
   );

   /* User parameters */
   // Set the number of masters and slaves
   parameter MASTERS = 2;
   parameter SLAVES = 1;

   // Set bus address and data width in bits
   // DATA_WIDTH must be a multiple of 8 (full bytes)!
   parameter DATA_WIDTH = 32;
   parameter ADDR_WIDTH = 32;

   // Memory range definitions, see above
   // The number of parameters actually limits the number of slaves as
   // there is no generic way that is handled by all tools to define
   // variable width parameter arrays.
   parameter S0_RANGE_WIDTH = 1;
   parameter S0_RANGE_MATCH = 1'b0;
   parameter S1_RANGE_WIDTH = 1;
   parameter S1_RANGE_MATCH = 1'b0;
   parameter S2_RANGE_WIDTH = 1;
   parameter S2_RANGE_MATCH = 1'b0;
   parameter S3_RANGE_WIDTH = 1;
   parameter S3_RANGE_MATCH = 1'b0;
   parameter S4_RANGE_WIDTH = 1;
   parameter S4_RANGE_MATCH = 1'b0;
   parameter S5_RANGE_WIDTH = 1;
   parameter S5_RANGE_MATCH = 1'b0;
   parameter S6_RANGE_WIDTH = 1;
   parameter S6_RANGE_MATCH = 1'b0;
   parameter S7_RANGE_WIDTH = 1;
   parameter S7_RANGE_MATCH = 1'b0;
   parameter S8_RANGE_WIDTH = 1;
   parameter S8_RANGE_MATCH = 1'b0;
   parameter S9_RANGE_WIDTH = 1;
   parameter S9_RANGE_MATCH = 1'b0;
   
   /* Derived local parameters */
   // Width of byte select registers
   localparam SEL_WIDTH = DATA_WIDTH >> 3;   

   /* Ports */
   input clk_i;
   input rst_i;
   
   input [ADDR_WIDTH*MASTERS-1:0] m_adr_i;
   input [DATA_WIDTH*MASTERS-1:0] m_dat_i;
   input [MASTERS-1:0]            m_cyc_i;
   input [MASTERS-1:0]            m_stb_i;
   input [SEL_WIDTH*MASTERS-1:0]  m_sel_i;
   input [MASTERS-1:0]            m_we_i;
   input [MASTERS*3-1:0]          m_cti_i;
   input [MASTERS*2-1:0]          m_bte_i;

   output [DATA_WIDTH*MASTERS-1:0] m_dat_o;
   output [MASTERS-1:0]            m_ack_o;
   output [MASTERS-1:0]            m_err_o;
   output [MASTERS-1:0]            m_rty_o;

   output [ADDR_WIDTH*SLAVES-1:0] s_adr_o;
   output [DATA_WIDTH*SLAVES-1:0] s_dat_o;
   output [SLAVES-1:0]            s_cyc_o;
   output [SLAVES-1:0]            s_stb_o;
   output [SEL_WIDTH*SLAVES-1:0]  s_sel_o;
   output [SLAVES-1:0]            s_we_o;
   output [SLAVES*3-1:0]          s_cti_o;
   output [SLAVES*2-1:0]          s_bte_o;

   input [DATA_WIDTH*SLAVES-1:0]  s_dat_i;
   input [SLAVES-1:0]             s_ack_i;
   input [SLAVES-1:0]             s_err_i;
   input [SLAVES-1:0]             s_rty_i;

   // The snoop port forwards all write accesses on their success for
   // one cycle.
   output [DATA_WIDTH-1:0]        snoop_adr_o;
   output                         snoop_en_o;

   input                          bus_hold;
   output reg                     bus_hold_ack;

   // Internally all master and slave ports have a bus signal where
   // all wishbone signals are packed. There are master generated and
   // slave generated signals. Each master and each slave therefore
   // generates and receives a bus of packed wishbone signals.

   // The master signals are of width M_WIDTH and the packing is
   // defined below.
   localparam M_WIDTH = ADDR_WIDTH + DATA_WIDTH + SEL_WIDTH + 8;

   localparam M_ADDR_LSB = 0;
   localparam M_ADDR_MSB = ADDR_WIDTH - 1;
   localparam M_DATA_LSB = M_ADDR_MSB + 1;
   localparam M_DATA_MSB = M_DATA_LSB + DATA_WIDTH - 1;
   localparam M_CYC      = M_DATA_MSB + 1;
   localparam M_STB      = M_CYC + 1;
   localparam M_SEL_LSB  = M_STB + 1;
   localparam M_SEL_MSB  = M_SEL_LSB + SEL_WIDTH - 1;
   localparam M_WE       = M_SEL_MSB + 1;
   localparam M_CTI_LSB  = M_WE + 1;
   localparam M_CTI_MSB  = M_CTI_LSB + 2;
   localparam M_BTE_LSB  = M_CTI_MSB + 1;
   localparam M_BTE_MSB  = M_BTE_LSB + 1;
 
   // The slave signals are of width S_WIDTH and the packing is
   // defined accordingly.
   localparam S_WIDTH = DATA_WIDTH + 3; // data + ack + err + rty

   localparam S_DATA_LSB = 0;
   localparam S_DATA_MSB = DATA_WIDTH - 1;
   localparam S_ACK = S_DATA_MSB + 1;
   localparam S_ERR = S_ACK + 1;
   localparam S_RTY = S_ERR + 1;
   
   // The masters have master signals input and slave signal outputs
   wire [M_WIDTH-1:0]      m_i [0:MASTERS-1];
   wire [S_WIDTH-1:0]      m_o [0:MASTERS-1];

   // The slaves have master signals output and slave signal inputs
   wire [M_WIDTH-1:0]      s_o [0:SLAVES-1];
   wire [S_WIDTH-1:0]      s_i [0:SLAVES-1];

   // After arbitration an internal bus contains the master signals
   // which are then forwarded to the selected slave
   reg [M_WIDTH-1:0]      m_bus;
   
   // The slave is selected based on the address of the arbitrated
   // bus. The selected slave signals are then put on this bus and
   // forwarded to the arbitrated master
   reg [S_WIDTH-1:0]      s_bus;

   // The granted master is one hot encoded
   wire [MASTERS-1:0]     grant;
   // The granted master from previous cycle (register)
   reg [MASTERS-1:0]      prev_grant;

   // The selected slave is also one hot encoded
   wire [SLAVES-1:0]      s_select; 

   // If either memory maps overlap or an address is not matched, the
   // bus generates an error itself.
   wire                   bus_error;
   
   // Generate variables for all the wiring
   genvar m, s;

   // Generate all the wiring. Of course this could be shortened, but
   // we like it explicit and it comes free of cost..
   generate
      for (m = 0; m < MASTERS; m = m + 1) begin : gen_m_bus
         // Connect master inputs to packed signal array
         assign m_i[m][M_ADDR_MSB:M_ADDR_LSB] = m_adr_i[(m+1)*ADDR_WIDTH-1:m*ADDR_WIDTH];
         assign m_i[m][M_DATA_MSB:M_DATA_LSB] = m_dat_i[(m+1)*DATA_WIDTH-1:m*DATA_WIDTH];
         assign m_i[m][M_CYC]                 = m_cyc_i[m];
         assign m_i[m][M_STB]                 = m_stb_i[m];
         assign m_i[m][M_SEL_MSB:M_SEL_LSB]   = m_sel_i[(m+1)*SEL_WIDTH-1:m*SEL_WIDTH];
         assign m_i[m][M_WE]                  = m_we_i[m];
         assign m_i[m][M_CTI_MSB:M_CTI_LSB]   = m_cti_i[(m+1)*3-1:m*3];
         assign m_i[m][M_BTE_MSB:M_BTE_LSB]   = m_bte_i[(m+1)*2-1:m*2];

         // Connect packed output signals to master output ports
         assign m_dat_o[(m+1)*DATA_WIDTH-1:m*DATA_WIDTH] = m_o[m][S_DATA_MSB:S_DATA_LSB];
         assign m_ack_o[m]                               = m_o[m][S_ACK];
         assign m_err_o[m]                               = m_o[m][S_ERR];
         assign m_rty_o[m]                               = m_o[m][S_RTY];         

         // Connect the slave bus signals to the master. The data is
         // just output to all masters..
         assign m_o[m][S_DATA_MSB:S_DATA_LSB] = s_bus[S_DATA_MSB:S_DATA_LSB];
         // .. while the status signals are only forwarded to
         // arbitrated master. The signals are masked with the strobe
         // to make it more clear and not have for example permanent
         // ack'ing slaves forwarded to a master without request
         // (should not have any effect, but more clear).
         // Error can also be a bus error.
         assign m_o[m][S_ACK] = grant[m] & (s_bus[S_ACK] & !bus_error) & m_bus[M_STB];
         assign m_o[m][S_ERR] = grant[m] & (s_bus[S_ERR] | bus_error) & m_bus[M_STB];
         assign m_o[m][S_RTY] = grant[m] & (s_bus[S_RTY] & !bus_error) & m_bus[M_STB];    
      end // block: gen_m_bus
      
      for (s = 0; s < SLAVES; s = s + 1) begin : gen_s_bus
         // Connect slave input ports to the packed bus
         assign s_i[s][S_DATA_MSB:S_DATA_LSB] = s_dat_i[(s+1)*DATA_WIDTH-1:s*DATA_WIDTH];
         assign s_i[s][S_ACK]                 = s_ack_i[s];
         assign s_i[s][S_ERR]                 = s_err_i[s];
         assign s_i[s][S_RTY]                 = s_rty_i[s];

         // Connect packed bus to slave output ports
         assign s_adr_o[(s+1)*ADDR_WIDTH-1:s*ADDR_WIDTH] = s_o[s][M_ADDR_MSB:M_ADDR_LSB];
         assign s_dat_o[(s+1)*DATA_WIDTH-1:s*DATA_WIDTH] = s_o[s][M_DATA_MSB:M_DATA_LSB];
         assign s_cyc_o[s]                               = s_o[s][M_CYC];
         assign s_stb_o[s]                               = s_o[s][M_STB];
         assign s_sel_o[(s+1)*SEL_WIDTH-1:s*SEL_WIDTH]   = s_o[s][M_SEL_MSB:M_SEL_LSB];
         assign s_we_o[s]                                = s_o[s][M_WE];
         assign s_cti_o[(s+1)*3-1:s*3]                   = s_o[s][M_CTI_MSB:M_CTI_LSB];
         assign s_bte_o[(s+1)*2-1:s*2]                   = s_o[s][M_BTE_MSB:M_BTE_LSB];

         // Forward the (arbitrated) master bus signals to the slaves.
         // All slaves get the data and similar signals...
         assign s_o[s][M_ADDR_MSB:M_ADDR_LSB] = m_bus[M_ADDR_MSB:M_ADDR_LSB];
         assign s_o[s][M_DATA_MSB:M_DATA_LSB] = m_bus[M_DATA_MSB:M_DATA_LSB];
         assign s_o[s][M_SEL_MSB:M_SEL_LSB]   = m_bus[M_SEL_MSB:M_SEL_LSB];
         assign s_o[s][M_WE]                  = m_bus[M_WE];
         assign s_o[s][M_CTI_MSB:M_CTI_LSB]   = m_bus[M_CTI_MSB:M_CTI_LSB];
         assign s_o[s][M_BTE_MSB:M_BTE_LSB]   = m_bus[M_BTE_MSB:M_BTE_LSB];
         // .. but only the selected gets the control signals.
         assign s_o[s][M_CYC]                 = s_select[s] & m_bus[M_CYC];
         assign s_o[s][M_STB]                 = s_select[s] & m_bus[M_STB];

      end // block: gen_s_bus
   endgenerate

   // This is a net that masks the actual requests. The arbiter
   // selects a different master each cycle. Therefore we need to
   // actively control the return of the bus arbitration. That means
   // as long as the granted master still holds is cycle signal, we
   // mask out all other requests (be setting the requests to grant).
   // When the cycle signal is released, we set the request to all
   // masters cycle signals.
   reg [MASTERS-1:0] m_req;

   // This is the arbitration net from round robin
   wire [MASTERS-1:0] arb_grant;
   reg [MASTERS-1:0] prev_arb_grant;
   
   // It is masked with the bus_hold_ack to hold back the arbitration
   // as long as the bus is held
   assign grant = arb_grant & {MASTERS{!bus_hold_ack}};
   
   always @(*) begin
      if (m_cyc_i & prev_grant) begin
         // The bus is not released this cycle
         m_req = prev_grant;
         bus_hold_ack = 1'b0;
      end else begin
         m_req = m_cyc_i;
         bus_hold_ack = bus_hold;
      end
   end

   // We register the grant signal. This is needed nevertheless for
   // fair arbitration (round robin)
   always @(posedge clk_i) begin
      if (rst_i) begin
         prev_arb_grant <= {{MASTERS-1{1'b0}},1'b1};
         prev_grant <= {{MASTERS-1{1'b0}},1'b1};
      end else begin   
         prev_arb_grant <= arb_grant;
         prev_grant <= grant;
      end
   end

   /* wb_interconnect_arb_rr AUTO_TEMPLATE(
    .gnt     (prev_arb_grant),
    .nxt_gnt (arb_grant),
    .req     (m_req),
    ); */
   wb_interconnect_arb_rr
     #(.N(MASTERS))
     u_arbiter(/*AUTOINST*/
               // Outputs
               .nxt_gnt                 (arb_grant),             // Templated
               // Inputs
               .req                     (m_req),                 // Templated
               .gnt                     (prev_arb_grant));       // Templated

   // Mux the bus based on the grant signal which must be one hot!
   always @(*) begin : bus_m_mux
      integer i;
      m_bus = {M_WIDTH{1'b0}};
      for (i = 0; i < MASTERS; i = i + 1) begin
         if (grant[i])
           m_bus = m_bus | m_i[i];
      end
      
   end

   // Generate the slave select signals based on the master bus
   // address and the memory range parameters
   generate
      if (SLAVES > 0)
        assign s_select[0] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S0_RANGE_WIDTH+1] == S0_RANGE_MATCH);
      if (SLAVES > 1)
        assign s_select[1] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S1_RANGE_WIDTH+1] == S1_RANGE_MATCH);
      if (SLAVES > 2)
        assign s_select[2] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S2_RANGE_WIDTH+1] == S2_RANGE_MATCH);
      if (SLAVES > 3)
        assign s_select[3] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S3_RANGE_WIDTH+1] == S3_RANGE_MATCH);
      if (SLAVES > 4)
        assign s_select[4] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S4_RANGE_WIDTH+1] == S4_RANGE_MATCH);
      if (SLAVES > 5)
        assign s_select[5] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S5_RANGE_WIDTH+1] == S5_RANGE_MATCH);
      if (SLAVES > 6)
        assign s_select[6] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S6_RANGE_WIDTH+1] == S6_RANGE_MATCH);
      if (SLAVES > 7)
        assign s_select[7] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S7_RANGE_WIDTH+1] == S7_RANGE_MATCH);
      if (SLAVES > 8)
        assign s_select[8] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S8_RANGE_WIDTH+1] == S8_RANGE_MATCH);
      if (SLAVES > 9)
        assign s_select[9] = (m_bus[M_ADDR_MSB:M_ADDR_MSB-S9_RANGE_WIDTH+1] == S9_RANGE_MATCH);      
   endgenerate

   // If two s_select are high or none, we might have an bus error
   assign bus_error = ~^s_select;
   
   // Mux the slave bus based on the slave select signal (one hot!)
   always @(*) begin : bus_s_mux
      integer i;
      s_bus = {S_WIDTH{1'b0}};
      for (i = 0; i < SLAVES; i = i + 1) begin
         if (s_select[i]) begin
            s_bus = s_bus | s_i[i];
         end
      end
   end

   // Snoop address comes direct from master bus
   assign snoop_adr_o = m_bus[M_ADDR_MSB:M_ADDR_LSB];
   // Snoop on acknowledge and write. Mask with strobe to be sure
   // there actually is a something happing and no dangling signals
   // and always ack'ing slaves.
   assign snoop_en_o = s_bus[S_ACK] & m_bus[M_STB] & m_bus[M_WE];

endmodule // wb_bus_b3
