/*
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

`timescale 1ns / 1ps

module wb_ddr_ctrl_tb;

	localparam MEMORY_SIZE_WORDS = 1048576;
	localparam WB_PORTS = 3;
	localparam BA_WIDTH = 2;

	initial begin
		if($test$plusargs("vcd")) begin
			$dumpfile("ddr_ctrl.vcd");
			$dumpvars(0);
		end
	end

	wire init_done;
	wire wbm_rst;

	reg wb_clk = 1'b1;
	reg wb_rst = 1'b1;

	assign wbm_rst = ~init_done;

	always @(posedge init_done)
	begin
		if (init_done)
			$display("DDR initialization done\n");
	end

	initial #200 wb_rst <= 1'b0;
	always #10 wb_clk <= !wb_clk;

	wire	[1:0]			ba;
	wire	[12:0]			a;
	wire				cs_n;
	wire				ras;
	wire				cas;
	wire				we;
	wire	[1:0]			dqm;
	wire				cke;
	tri	[15:0]			dq;
	wire	[1:0]			dqs;
	wire				ddr_clk;
	wire				ddr_clk_n;

	wire	[WB_PORTS*32-1:0]	wb_adr;
	wire	[WB_PORTS-1:0]		wb_stb;
	wire	[WB_PORTS-1:0]		wb_cyc;
	wire	[WB_PORTS*3-1:0]	wb_cti;
	wire	[WB_PORTS*2-1:0]	wb_bte;
	wire	[WB_PORTS-1:0]		wb_we;
	wire	[WB_PORTS*4-1:0]	wb_sel;
	wire	[WB_PORTS*32-1:0]	wb_m2s_dat;
	wire	[WB_PORTS*32-1:0]	wb_s2m_dat;
	wire	[WB_PORTS-1:0] 		wb_ack;

	wire	[31:0]			slave_writes;
	wire	[31:0]			slave_reads;
	wire	[WB_PORTS-1:0]		done_int;

	genvar	i;

	generate
		for(i = 0; i < WB_PORTS; i = i + 1) begin : masters
		wb_bfm_transactor
			#(.MEM_HIGH (MEMORY_SIZE_WORDS*(i+1)-1),
			.MEM_LOW  (MEMORY_SIZE_WORDS*i),
			.VERBOSE  (1))
		wb_bfm_transactor0 (
			.wb_clk_i (wb_clk),
			.wb_rst_i (wbm_rst),
			.wb_adr_o (wb_adr[i*32+:32]),
			.wb_dat_o (wb_m2s_dat[i*32+:32]),
			.wb_sel_o (wb_sel[i*4+:4]),
			.wb_we_o  (wb_we[i] ),
			.wb_cyc_o (wb_cyc[i]),
			.wb_stb_o (wb_stb[i]),
			.wb_cti_o (wb_cti[i*3+:3]),
			.wb_bte_o (wb_bte[i*2+:2]),
			.wb_dat_i (wb_s2m_dat[i*32+:32]),
			.wb_ack_i (wb_ack[i]),
			.wb_err_i (1'b0),
			.wb_rty_i (1'b0),
			//Test Control
			.done(done_int[i]));
		end // block: slaves
	endgenerate

	integer	idx;
	time	start_time[WB_PORTS-1:0];
	time	ack_delay[WB_PORTS-1:0];
	integer	num_transactions[WB_PORTS-1:0];

	assign done = &done_int;

	always @(done) begin
		if(done === 1) begin
			$display("Average wait times");
			for(idx=0;idx<WB_PORTS;idx=idx+1)
				$display("Master %0d : %f",idx, ack_delay[idx]/num_transactions[idx]);
			$display("All tests passed!");
			$finish;
		end
	end

	generate
		for(i=0;i<WB_PORTS;i=i+1) begin : wait_time
			initial begin
				wait (init_done);
				ack_delay[i] = 0;
				num_transactions[i] = 0;
				while(1) begin
					@(posedge wb_cyc[i]);
					start_time[i] = $time;
					@(posedge wb_ack[i]);
					ack_delay[i] = ack_delay[i] + $time-start_time[i];
					num_transactions[i] = num_transactions[i]+1;
				end
			end
		end
	endgenerate

	wire [22:0]	local_address;
	wire		local_write_req;
	wire		local_read_req;
	wire		local_burstbegin;
	wire [31:0]	local_wdata;
	wire [3:0]	local_be;
	wire [6:0]	local_size;
	wire [31:0]	local_rdata;
	wire		local_rdata_valid;
	wire		local_reset_n;
	wire		local_clk;
	wire		local_ready;

wb_ddr_ctrl
#(
	.ADDR_WIDTH	(25),			// Memory size = 2^ADDR_WIDTH = 32MB
	.WB_PORTS	(3),			// Number of wishbone ports
	.BUF_WIDTH	({3'd3, 3'd3, 3'd5})	// Buffer size = 2^BUF_WIDTH
)
wb_ddr_ctrl0
(
	// Wishbone interface
	.wb_clk			(wb_clk),
	.wb_rst			(wb_rst),

	.wb_adr_i		(wb_adr),
	.wb_stb_i		(wb_stb),
	.wb_cyc_i		(wb_cyc),
	.wb_cti_i		(wb_cti),
	.wb_bte_i		(wb_bte),
	.wb_we_i		(wb_we),
	.wb_sel_i		(wb_sel),
	.wb_dat_i		(wb_m2s_dat),
	.wb_dat_o		(wb_s2m_dat),
	.wb_ack_o		(wb_ack),

	// DDR controller local interface
	.local_address_o	(local_address),
	.local_write_req_o	(local_write_req),
	.local_read_req_o	(local_read_req),
	.local_burstbegin_o	(local_burstbegin),
	.local_wdata_o		(local_wdata),
	.local_be_o		(local_be),
	.local_size_o		(local_size),
	.local_rdata_i		(local_rdata),
	.local_rdata_valid_i	(local_rdata_valid),
	.local_reset_n_i	(local_reset_n),
	.local_clk_i		(local_clk),
	.local_ready_i		(local_ready)
);

ddr_ctrl_ip ddr_ctrl_ip
(
	.local_address		(local_address),
	.local_write_req	(local_write_req),
	.local_read_req		(local_read_req),
	.local_burstbegin	(local_burstbegin),
	.local_wdata		(local_wdata),
	.local_be		(local_be),
	.local_size		(local_size),

	.global_reset_n		(~wb_rst),
	.pll_ref_clk		(wb_clk),
	.soft_reset_n		(1'b1),

	.local_ready		(local_ready),
	.local_rdata		(local_rdata),
	.local_rdata_valid	(local_rdata_valid),
	.local_refresh_ack	(),
	.local_init_done	(init_done),

	.reset_phy_clk_n	(local_reset_n),

	.mem_cs_n		(cs_n),
	.mem_cke		(cke),
	.mem_addr		(a),
	.mem_ba			(ba),
	.mem_ras_n		(ras),
	.mem_cas_n		(cas),
	.mem_we_n		(we),
	.mem_dm			(dqm),

	.phy_clk		(local_clk),
	.aux_full_rate_clk	(),
	.aux_half_rate_clk	(),
	.reset_request_n	(),

	.mem_clk		(ddr_clk),
	.mem_clk_n		(ddr_clk_n),
	.mem_dq			(dq),
	.mem_dqs		(dqs)
);

ddr
#(
	.DEBUG		(0)
)
ddr0
(
	.Clk		(ddr_clk),
	.Clk_n		(ddr_clk_n),
	.Cke		(cke),
	.Cs_n		(cs_n),
	.Ras_n		(ras),
	.Cas_n		(cas),
	.We_n		(we),
	.Ba		(ba),
	.Addr		(a),
	.Dm		(dqm),
	.Dq		(dq),
	.Dqs		(dqs)
);

endmodule
