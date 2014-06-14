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
 * This is a round-robin arbiter for N participants, which is a
 * parameter. The arbiter itself contains no register but is purely
 * combinational which allows for various use cases. It simply
 * calculates the next grant (nxt_gnt) based on the current grant
 * (gnt) and the requests (req).
 *
 * That means, the gnt should in general be a register and especially
 * there must be no combinational path from nxt_gnt to gnt!
 *
 * The normal usage is something like registering the gnt from
 * nxt_gnt. Furthermore it is important that the gnt has an initial
 * value which also must be one hot!
 *
 * Author(s):
 *   Stefan Wallentowitz <stefan.wallentowitz@tum.de>
 */

module wb_interconnect_arb_rr(/*AUTOARG*/
   // Outputs
   nxt_gnt,
   // Inputs
   req, gnt
   );

   /* User parameters */
   // Number of participants
   parameter N = 2;

   /* Ports */
   // Request
   input [N-1:0] req;
   // Current grant
   input [N-1:0] gnt;
   // Next grant
   output [N-1:0] nxt_gnt;

   // Sanity check
   // synthesis translate_off
   //always @(*)
   //  if (~^gnt)
   //    $fatal("signal <gnt> must always be one hot!");
   // synthesis translate_on
     
   
   // At a first glance, the computation of the nxt_gnt signal looks
   // strange, but the principle is easy:
   //
   //  * For each participant we compute a mask of width N. Based on
   //    the current gnt signal the mask contains a 1 at the position
   //    of other participants that will be served in round robin
   //    before the participant in case they request it.
   //
   //  * The mask is 0 on all positions for the participant "left" of
   //    the currently granted participant as no other has precedence
   //    over this one. The mask has all one except the participant
   //    itself for the currently arbitrated participant.
   //
   //  * From the mask and the request the nxt_gnt is calculated,
   //    roughly said as: if there is no other participant which has a
   //    higher precedence that also requests, the participant gets
   //    granted.
   //
   // Example 1:
   //  req     = 1010
   //  gnt     = 1000
   //  nxt_gnt = 0010
   //
   //  mask[0] = 0000
   //  mask[1] = 0001
   //  mask[2] = 0011
   //  mask[3] = 0111
   //   
   // Example 2:
   //  req     = 1010
   //  gnt     = 0100
   //  nxt_gnt = 1000
   //
   //  mask[0] = 1000
   //  mask[1] = 1001
   //  mask[2] = 1011
   //  mask[3] = 0000

   // Mask net
   reg [N-1:0]      mask [0:N-1];
   
   // Calculate the mask
   always @(*) begin : calc_mask
      integer            i,j;
      for (i=0;i<N;i=i+1) begin
         // Initialize mask as 0
         mask[i] = {N{1'b0}};

         // All participants to the "right" up to the current grant
         // holder have precendence and therefore a 1 in the mask.
         // First check if the next right from us has the grant.
         // Afterwards the mask is calculated iteratively based on
         // this.
         if(i>0)
           // For i=N:1 the next right is i-1
           mask[i][i-1] = ~gnt[i-1];
         else
           // For i=0 the next right is N-1
           mask[i][N-1] = ~gnt[N-1];

         // Now the mask contains a 1 when the next right to us is not
         // the grant holder. If it is the grant holder that means,
         // that we are the next served (if necessary) as no other has
         // higher precendence, which is then calculated in the
         // following by filling up 1s up to the grant holder. To stop
         // filling up there and not fill up any after this is
         // iterative by always checking if the one before was not
         // before the grant holder.
         for (j=2;j<N;j=j+1) begin
            if (i-j>=0)
              mask[i][i-j] = mask[i][i-j+1] & ~gnt[i-j];
            else if(i-j+1>=0)
              mask[i][i-j+N] = mask[i][i-j+1] & ~gnt[i-j+N];
            else
              mask[i][i-j+N] = mask[i][i-j+N+1] & ~gnt[i-j+N];
         end
      end
   end // always @ (*)

   // Calculate the nxt_gnt
   genvar k;
   generate
      for (k=0;k<N;k=k+1) begin : gen_nxt_gnt
         // (mask[k] & req) masks all requests with higher precendence
         // Example 1: 0: 0000  1: 0000  2: 0010  3: 0010
         // Example 2: 0: 1000  1: 1000  2: 1010  3: 0000
         //
         // ~|(mask[k] & req) is there is none of them
         // Example 1: 0: 1  1: 1  2: 0  3: 0
         // Example 2: 1: 0  1: 0  2: 0  3: 1
         //
         // One might expect at this point that there was only one of
         // them that matches, but this is guaranteed by the last part
         // that is checking if this one has a request itself. In
         // example 1, k=0 does not have a request, if it had, the
         // result of the previous calculation would be 0 for k=1.
         // Therefore: (~|(mask[k] & req) & req[k]) selects the next one.
         // Example 1: 0: 0  1: 1  2: 0  3: 0
         // Example 2: 0: 0  1: 0  2: 0  3: 1
         //
         // This is already the result. (0010 and 1000). Nevertheless,
         // it is necessary to capture the case of no request at all
         // (~|req). In that case, nxt_gnt would be 0, what iself
         // leads to a problem in the next cycle (always grants).
         // Therefore the current gnt is hold in case of no request by
         // (~|req & gnt[k]).
         
         assign nxt_gnt[k] = (~|(mask[k] & req) & req[k]) | (~|req & gnt[k]);
      end
   endgenerate
endmodule // wb_interconnect_arb_rr
