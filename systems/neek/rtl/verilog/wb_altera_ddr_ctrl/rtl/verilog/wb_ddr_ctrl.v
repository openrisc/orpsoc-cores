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
	parameter TECHNOLOGY	= "GENERIC",
	parameter WB_PORTS	= 3,	// Number of wishbone ports
	parameter BUF_WIDTH	= 3	// Buffer size = 2^BUF_WIDTH
)
(
	// DDR Interface
	output	[1:0]			dm_pad_o,
	inout	[15:0]			dq_pad_io,
	inout	[1:0]			dqs_pad_io,
	output	[12:0]			a_pad_o,
	output	[1:0]			ba_pad_o,
	output				cas_n_pad_o,
	output				cke_pad_o,
	inout				clk_pad_io,
	inout				clk_n_pad_io,
	output				cs_n_pad_o,
	output				ras_n_pad_o,
	output				we_n_pad_o,

	output				init_done_o,

	// Wishbone interface
	input				wb_clk,
	input				wb_rst,
	input  [WB_PORTS*32-1:0]	wb_adr_i,
	input  [WB_PORTS-1:0]		wb_stb_i,
	input  [WB_PORTS-1:0]		wb_cyc_i,
	input  [WB_PORTS*3-1:0]		wb_cti_i,
	input  [WB_PORTS*2-1:0]		wb_bte_i,
	input  [WB_PORTS-1:0]		wb_we_i,
	input  [WB_PORTS*4-1:0]		wb_sel_i,
	input  [WB_PORTS*32-1:0]	wb_dat_i,
	output [WB_PORTS*32-1:0]	wb_dat_o,
	output [WB_PORTS-1:0]		wb_ack_o
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
	wire			ctrl_clock;
	wire			ctrl_reset;

	ddr_ctrl_wrapper ddr_ctrl_wrapper
	(
		.ctrl_clk_i		(wb_clk),
		.ctrl_rst_i		(wb_rst),

		.local_clk_o		(ctrl_clock),
		.local_rst_o		(ctrl_reset),

		.local_init_done_o	(init_done_o),

		.ddr_dm			(dm_pad_o),
		.ddr_dq			(dq_pad_io),
		.ddr_dqs		(dqs_pad_io),
		.ddr_a			(a_pad_o),
		.ddr_ba			(ba_pad_o),
		.ddr_cas_n		(cas_n_pad_o),
		.ddr_cke		(cke_pad_o),
		.ddr_clk		(clk_pad_io),
		.ddr_clk_n		(clk_n_pad_io),
		.ddr_cs_n		(cs_n_pad_o),
		.ddr_ras_n		(ras_n_pad_o),
		.ddr_we_n		(we_n_pad_o),

		// Internal interface
		.rdy_o			(sdram_if_rdy),
		.idle_o			(sdram_if_idle),
		.adr_i			(sdram_if_adr_i),
		.adr_o			(sdram_if_adr_o),
		.dat_i			(sdram_if_dat_i),
		.dat_o			(sdram_if_dat_o),
		.sel_i			(sdram_if_sel_i),
		.acc_i			(sdram_if_acc),
		.ack_o			(sdram_if_ack),
		.we_i			(sdram_if_we),
		.buf_width_i		(sdram_if_buf_width)
);

	wb_port_arbiter #(
		.TECHNOLOGY	(TECHNOLOGY),
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
		.sdram_rst	(ctrl_reset),
		.sdram_clk	(ctrl_clock),
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
