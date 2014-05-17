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

module wb_port_arbiter #(
	parameter WB_PORTS	= 3,
	parameter BUF_WIDTH	= {3'd3, 3'd3, 3'd3}
)
(
	// Wishbone
	input  				wb_clk,
	input  				wb_rst,
	input  [WB_PORTS*32-1:0]	wb_adr_i,
	input  [WB_PORTS-1:0]		wb_stb_i,
	input  [WB_PORTS-1:0]		wb_cyc_i,
	input  [WB_PORTS*3-1:0]		wb_cti_i,
	input  [WB_PORTS*2-1:0]		wb_bte_i,
	input  [WB_PORTS-1:0]		wb_we_i,
	input  [WB_PORTS*4-1:0]		wb_sel_i,
	input  [WB_PORTS*32-1:0]	wb_dat_i,
	output [WB_PORTS*32-1:0]	wb_dat_o,
	output [WB_PORTS-1:0]		wb_ack_o,

	// Internal interface
	input				sdram_rst,
	input				sdram_clk,
	input				sdram_idle_i,
	input  [31:0]			adr_i,
	output [31:0]			adr_o,
	input  [31:0]			dat_i,
	output [31:0]			dat_o,
	output [3:0]			sel_o,
	output				acc_o,
	input				ack_i,
	output				we_o,
	output [3:0]			buf_width_o
);

	wire [31:0]			wbp_adr_i[WB_PORTS-1:0];
	wire				wbp_stb_i[WB_PORTS-1:0];
	wire				wbp_cyc_i[WB_PORTS-1:0];
	wire [2:0]			wbp_cti_i[WB_PORTS-1:0];
	wire [1:0]			wbp_bte_i[WB_PORTS-1:0];
	wire				wbp_we_i[WB_PORTS-1:0];
	wire [3:0]			wbp_sel_i[WB_PORTS-1:0];
	wire [31:0]			wbp_dat_i[WB_PORTS-1:0];
	wire [31:0]			wbp_dat_o[WB_PORTS-1:0];
	wire				wbp_ack_o[WB_PORTS-1:0];

	wire				wb_cycle[WB_PORTS-1:0];

	wire [31:0]			p_adr_i[WB_PORTS-1:0];
	wire [31:0]			p_adr_o[WB_PORTS-1:0];
	wire [31:0]			p_dat_i[WB_PORTS-1:0];
	wire [31:0]			p_dat_o[WB_PORTS-1:0];
	wire [3:0]			p_sel_o[WB_PORTS-1:0];
	wire [WB_PORTS-1:0]		p_acc_o;
	wire				p_ack_i[WB_PORTS-1:0];
	wire				p_we_o[WB_PORTS-1:0];
	wire [3:0]			p_buf_width_o[WB_PORTS-1:0];

	wire [3:0]			buf_width_p[WB_PORTS-1:0];

	reg [31:0]			p_bufw_adr[WB_PORTS-1:0];
	reg [31:0]			p_bufw_dat[WB_PORTS-1:0];
	reg [3:0]			p_bufw_sel[WB_PORTS-1:0];
	reg				p_bufw_we[WB_PORTS-1:0];

	reg [WB_PORTS-1:0]		port_sel;
	reg [WB_PORTS-1:0]		port_enc;

	wire				safe_to_switch;

	genvar				i;
	generate
	for (i = 0; i < WB_PORTS; i=i+1) begin : wbports
		assign wbp_adr_i[i] = wb_adr_i[31+i*32:i*32];
		assign wbp_stb_i[i] = wb_stb_i[i];
		assign wbp_cyc_i[i] = wb_cyc_i[i];
		assign wbp_cti_i[i] = wb_cti_i[2+i*3:i*3];
		assign wbp_bte_i[i] = wb_bte_i[1+i*2:i*2];
		assign wbp_we_i[i]  = wb_we_i[i];
		assign wbp_sel_i[i] = wb_sel_i[3+i*4:i*4];
		assign wbp_dat_i[i] = wb_dat_i[31+i*32:i*32];
		assign wb_dat_o[31+i*32:i*32] = wbp_dat_o[i];
		assign wb_ack_o[i] = wbp_ack_o[i];
		assign wb_cycle[i] = wb_cyc_i[i] & wb_stb_i[i];
		assign p_adr_i[i] = adr_i;
		assign p_dat_i[i] = dat_i;
		assign p_ack_i[i] = ack_i & port_sel[i];

		wb_port #(
			.BUF_WIDTH	(BUF_WIDTH[i*3+2:i*3])
		)
		wb_port (
			// Wishbone
			.wb_clk		(wb_clk),
			.wb_rst		(wb_rst),
			.wb_adr_i	(wbp_adr_i[i]),
			.wb_stb_i	(wbp_stb_i[i]),
			.wb_cyc_i	(wbp_cyc_i[i]),
			.wb_cti_i	(wbp_cti_i[i]),
			.wb_bte_i	(wbp_bte_i[i]),
			.wb_we_i	(wbp_we_i[i]),
			.wb_sel_i	(wbp_sel_i[i]),
			.wb_dat_i	(wbp_dat_i[i]),
			.wb_dat_o	(wbp_dat_o[i]),
			.wb_ack_o	(wbp_ack_o[i]),

			// Internal interface
			.sdram_rst	(sdram_rst),
			.sdram_clk	(sdram_clk),
			.adr_i		(p_adr_i[i]),
			.adr_o		(p_adr_o[i]),
			.dat_i		(p_dat_i[i]),
			.dat_o		(p_dat_o[i]),
			.sel_o		(p_sel_o[i]),
			.acc_o		(p_acc_o[i]),
			.ack_i		(p_ack_i[i]),
			.we_o		(p_we_o[i]),
			.buf_width_o	(p_buf_width_o[i]),

			// Buffer write
			.bufw_adr_i	(p_bufw_adr[i]),
			.bufw_dat_i	(p_bufw_dat[i]),
			.bufw_sel_i	(p_bufw_sel[i]),
			.bufw_we_i	(p_bufw_we[i])
		);

	end
	endgenerate

	assign adr_o = p_adr_o[port_enc];
	assign dat_o = p_dat_o[port_enc];
	assign acc_o = p_acc_o[port_enc];
	assign sel_o = p_sel_o[port_enc];
	assign we_o  = p_we_o[port_enc];
	assign buf_width_o = p_buf_width_o[port_enc];

	assign safe_to_switch = sdram_idle_i & !p_acc_o[port_enc];

	// simple round robin arbitration between ports
	function [WB_PORTS-1:0] round_robin;
		input [WB_PORTS-1:0] current;
		input [WB_PORTS-1:0] req;
		reg   [WB_PORTS-1:0] grant;
		reg   [WB_PORTS-1:0] temp;
		integer		     i;
		begin
			grant = 0;
			temp = current;
			for (i = 0; i < WB_PORTS; i=i+1) begin
				temp[WB_PORTS-1:0] = {temp[0],temp[WB_PORTS-1:1]};
				if (|(temp & req) & !(|grant))
					grant = temp;
			end

			if (|grant)
				round_robin = grant;
			else
				round_robin = current;
		end
	endfunction

	function [WB_PORTS-1:0] ff1;
		input [WB_PORTS-1:0] in;
		integer i;
		begin
			ff1 = 0;
			for (i = WB_PORTS-1; i >= 0; i=i-1)
				if (in[i]) ff1 = i;
		end
	endfunction

	always @(posedge sdram_clk)
		if (sdram_rst) begin
			// default to first port after reset
			port_sel[WB_PORTS-1:1] <= {(WB_PORTS-1){1'b0}};
			port_sel[0] <= 1'b1;
			port_enc <= 0;
		end else if (safe_to_switch) begin
			port_sel <= round_robin(port_sel, p_acc_o);
			port_enc <= ff1(round_robin(port_sel, p_acc_o));
		end

	// Signal when a write have happened to all ports, so they can write
	// the data into their buffer in case of a hit
	integer j,k;
	always @(posedge wb_clk) begin
		for (k = 0; k < WB_PORTS; k=k+1) begin
			p_bufw_we[k] <= 1'b0;
			p_bufw_adr[k] <= 0;
			p_bufw_dat[k] <= 0;
			p_bufw_sel[k] <= 0;
			for (j = 0; j < WB_PORTS; j=j+1) begin
				if (j!=k & wb_cycle[j] & wb_we_i[j]) begin
					p_bufw_we[k]  <= wbp_ack_o[j];
					p_bufw_adr[k] <= wbp_adr_i[j];
					p_bufw_dat[k] <= wbp_dat_i[j];
					p_bufw_sel[k] <= wbp_sel_i[j];
				end
			end

		end
	end
endmodule
