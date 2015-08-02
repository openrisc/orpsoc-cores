/*
 * Copyright (c) 2011, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
 * Copyright (c) 2014, Franck Jullien <franck.jullien@gmail.com>
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

module wb_ddr_ctrl #(
	parameter ADDR_WIDTH	= 25,	// Memory size = 2^ADDR_WIDTH = 32MB
	parameter WB_PORTS	= 3,	// Number of wishbone ports
	parameter BUF_WIDTH	= {3'd3, 3'd3, 3'd3}	// Buffer size = 2^BUF_WIDTH
)
(
	// Wishbone interface
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

	// DDR controller local interface
	output	[ADDR_WIDTH-3:0]	local_address_o,
	output				local_write_req_o,
	output				local_read_req_o,
	output				local_burstbegin_o,
	output	[31:0]			local_wdata_o,
	output	[3:0]			local_be_o,
	output	[6:0]			local_size_o,
	input	[31:0]			local_rdata_i,
	input				local_rdata_valid_i,
	input				local_reset_n_i,
	input				local_clk_i,
	input				local_ready_i
);

	wire			sdram_if_idle;
	wire [31:0]		sdram_if_adr_i;
	wire [31:0]		sdram_if_adr_o;
	wire [31:0]		sdram_if_dat_i;
	wire [31:0]		sdram_if_dat_o;
	wire [3:0]		sdram_if_sel_i;
	wire			sdram_if_acc;
	wire			sdram_if_we;
	wire			sdram_if_ack;
	wire [3:0]		sdram_if_buf_width;

	ddr_ctrl_wrapper #(
		.ADDR_WIDTH	(ADDR_WIDTH)
	)
	ddr_ctrl_wrapper (
		// Internal interface
		.rdy_o			(),
		.idle_o			(sdram_if_idle),
		.adr_i			(sdram_if_adr_i),
		.adr_o			(sdram_if_adr_o),
		.dat_i			(sdram_if_dat_i),
		.dat_o			(sdram_if_dat_o),
		.sel_i			(sdram_if_sel_i),
		.acc_i			(sdram_if_acc),
		.ack_o			(sdram_if_ack),
		.we_i			(sdram_if_we),
		.buf_width_i		(sdram_if_buf_width),

		.local_address_o	(local_address_o),
		.local_write_req_o	(local_write_req_o),
		.local_read_req_o	(local_read_req_o),
		.local_burstbegin_o	(local_burstbegin_o),
		.local_wdata_o		(local_wdata_o),
		.local_be_o		(local_be_o),
		.local_size_o		(local_size_o),
		.local_rdata_i		(local_rdata_i),
		.local_rdata_valid_i	(local_rdata_valid_i),
		.local_reset_n_i	(local_reset_n_i),
		.local_clk_i		(local_clk_i),
		.local_ready_i		(local_ready_i)
	);

	wb_port_arbiter #(
		.WB_PORTS	(WB_PORTS),
		.BUF_WIDTH	(BUF_WIDTH)
	)
	wb_port_arbiter (
		.wb_clk		(wb_clk),
		.wb_rst		(wb_rst),

		.wb_adr_i	(wb_adr_i),
		.wb_stb_i	(wb_stb_i),
		.wb_cyc_i	(wb_cyc_i),
		.wb_cti_i	(wb_cti_i),
		.wb_bte_i	(wb_bte_i),
		.wb_we_i	(wb_we_i),
		.wb_sel_i	(wb_sel_i),
		.wb_dat_i	(wb_dat_i),
		.wb_dat_o	(wb_dat_o),
		.wb_ack_o	(wb_ack_o),

		// Internal interface
		.sdram_rst	(~local_reset_n_i),
		.sdram_clk	(local_clk_i),
		.sdram_idle_i	(sdram_if_idle),
		.adr_i		(sdram_if_adr_o),
		.adr_o		(sdram_if_adr_i),
		.dat_i		(sdram_if_dat_o),
		.dat_o		(sdram_if_dat_i),
		.sel_o		(sdram_if_sel_i),
		.acc_o		(sdram_if_acc),
		.ack_i		(sdram_if_ack),
		.we_o		(sdram_if_we),
		.buf_width_o	(sdram_if_buf_width)
	);
endmodule
