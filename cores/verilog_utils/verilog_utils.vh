/*
 * Copyright (c) 2014, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
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

`ifndef _VERILOG_UTILS_VH_
`define _VERILOG_UTILS_VH_ 1
//
// clog2 - replacement for $clog for tools that doesn't support verilog 2005.
// However, icarus doesn't support constant user functions, so it has to be
// implemened with a bit of `define trickery.
//
`ifdef __ICARUS__
`define clog2 $clog2
`else
`define clog2 clog2
`endif

`endif // _VERILOG_UTILS_VH_

function integer clog2;
input integer in;
begin
	in = in - 1;
	for (clog2 = 0; in > 0; clog2=clog2+1)
		in = in >> 1;
end
endfunction

//
// Find First 1 - Start from MSB and count downwards, returns 0 when no bit set
//
function integer ff1;
input integer in;
input integer width;
integer i;
begin
	ff1 = 0;
	for (i = width-1; i >= 0; i=i-1) begin
		if (in[i])
			ff1 = i;
	end
end
endfunction

//
// Find Last 1 -  Start from LSB and count upwards, returns 0 when no bit set
//
function integer fl1;
input integer in;
input integer width;
integer i;
begin
	fl1 = 0;
	for (i = 0; i < width; i=i+1) begin
		if (in[i])
			fl1 = i;
	end
end
endfunction

//
// Reverse bits in a vector
//
function integer reverse_bits;
input integer in;
input integer width;
integer i;
begin
	for (i = 0; i < width; i=i+1) begin
		reverse_bits[width-i] = in[i];
	end
end
endfunction

//
// Reverse bytes in a vector
//
function integer reverse_bytes;
input integer in;
input integer width;
integer i;
begin
	for (i = 0; i < width; i=i+8) begin
		reverse_bytes[(width-1)-i-:8] = in[i+:8];
	end
end
endfunction
