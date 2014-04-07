/*
 * Copyright (c) 2011, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * All rights reserved.
 *
 * Redistribution and use in source and non-source forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in non-source form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *
 * THIS WORK IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * WORK, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

module bufram #(
	parameter TECHNOLOGY = "GENERIC",
	parameter ADDR_WIDTH = 3
)
(
	input			clk_a,
	input  [ADDR_WIDTH-1:0]	addr_a,
	input  [3:0]		we_a,
	input  [31:0]		di_a,
	output [31:0]		do_a,

	input			clk_b,
	input  [ADDR_WIDTH-1:0]	addr_b,
	input  [3:0]		we_b,
	input  [31:0]		di_b,
	output [31:0]		do_b
);
generate
if (TECHNOLOGY == "GENERIC") begin : dpram_generic
dpram_generic #(
	.ADDR_WIDTH(ADDR_WIDTH)
) dpram_generic (
	.clk_a		(clk_a),
	.addr_a		(addr_a),
	.we_a		(we_a),
	.di_a		(di_a),
	.do_a		(do_a),

	.clk_b		(clk_b),
	.addr_b		(addr_b),
	.we_b		(we_b),
	.di_b		(di_b),
	.do_b		(do_b)
);
end else if (TECHNOLOGY == "ALTERA") begin : dpram_altera
dpram_altera #(
	.ADDR_WIDTH(ADDR_WIDTH)
) dpram_altera (
	.clk_a		(clk_a),
	.addr_a		(addr_a),
	.we_a		(we_a),
	.di_a		(di_a),
	.do_a		(do_a),

	.clk_b		(clk_b),
	.addr_b		(addr_b),
	.we_b		(we_b),
	.di_b		(di_b),
	.do_b		(do_b)
);
end
endgenerate
endmodule
