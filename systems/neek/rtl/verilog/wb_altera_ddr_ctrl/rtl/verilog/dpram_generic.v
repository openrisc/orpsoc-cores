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

module dpram_generic #(
	parameter ADDR_WIDTH = 3
)
(
	input			clk_a,
	input  [ADDR_WIDTH-1:0]	addr_a,
	input  [3:0]		we_a,
	input  [31:0]		di_a,
	output reg [31:0]	do_a,

	input			clk_b,
	input  [ADDR_WIDTH-1:0]	addr_b,
	input  [3:0]		we_b,
	input  [31:0]		di_b,
	output reg [31:0]	do_b
);

	reg [7:0]	mem0[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem1[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem2[(1<<ADDR_WIDTH)-1:0];
	reg [7:0]	mem3[(1<<ADDR_WIDTH)-1:0];

	always @(posedge clk_a) begin
		if (we_a[3])
			mem3[addr_a] <= di_a[31:24];
		if (we_a[2])
			mem2[addr_a] <= di_a[23:16];
		if (we_a[1])
			mem1[addr_a] <= di_a[15:8];
		if (we_a[0])
			mem0[addr_a] <= di_a[7:0];
		do_a <= {mem3[addr_a], mem2[addr_a],
			 mem1[addr_a], mem0[addr_a]};
	end

	always @(posedge clk_b) begin
		if (we_b[3])
			mem3[addr_b] <= di_b[31:24];
		if (we_b[2])
			mem2[addr_b] <= di_b[23:16];
		if (we_b[1])
			mem1[addr_b] <= di_b[15:8];
		if (we_b[0])
			mem0[addr_b] <= di_b[7:0];
		do_b <= {mem3[addr_b], mem2[addr_b],
			 mem1[addr_b], mem0[addr_b]};
	end
endmodule
