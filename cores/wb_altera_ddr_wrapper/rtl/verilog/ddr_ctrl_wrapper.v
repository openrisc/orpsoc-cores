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

module ddr_ctrl_wrapper #(
	parameter ADDR_WIDTH	= 25	// Memory size = 2^ADDR_WIDTH = 32MB
)
(
	// Internal interface
	output			rdy_o,
	output			idle_o,
	input  [31:0]		adr_i,
	output [31:0]		adr_o,
	input  [31:0]		dat_i,
	output [31:0]		dat_o,
	input  [3:0]		sel_i,
	input			acc_i,
	output			ack_o,
	input			we_i,
	input  [3:0]		buf_width_i,

	output [ADDR_WIDTH-3:0]	local_address_o,
	output			local_write_req_o,
	output			local_read_req_o,
	output			local_burstbegin_o,
	output [31:0]		local_wdata_o,
	output [3:0]		local_be_o,
	output [6:0]		local_size_o,
	input  [31:0]		local_rdata_i,
	input			local_rdata_valid_i,
	input			local_reset_n_i,
	input			local_clk_i,
	input			local_ready_i
);

	localparam LOCAL_ADR_WIDTH = ADDR_WIDTH-2;

	function [31:0] get_mask;
	input [3:0] width;
		begin
			get_mask = ((1 << (width)) - 1);
		end
	endfunction

	assign local_be_o	= sel_i;
	assign dat_o		= local_rdata_i;
	assign local_address_o	= we_i ? adr_i[LOCAL_ADR_WIDTH+1:2] : adr_i[LOCAL_ADR_WIDTH+1:2] & ~get_mask(buf_width_i);
	assign local_wdata_o	= dat_i;

	reg		local_write_req;
	reg		local_read_req;
	reg		local_burstbegin;
	reg [31:0]	local_wdata;
	reg [6:0]	local_size;

	assign local_write_req_o	= local_write_req;
	assign local_read_req_o		= local_read_req;
	assign local_burstbegin_o	= local_burstbegin;
	assign local_size_o		= local_size;

	reg [3:0]	state;
	reg [31:0]	count;
	reg		ack_w;
	reg [31:0]	adr;

	wire		ack_w_rdy;

	// FSM states
	localparam [3:0]
		WAIT_READY    = 4'h0,
		IDLE          = 4'h1,
		WRITE         = 4'h2,
		READ          = 4'h3;

	assign rdy_o = local_ready_i;
	assign idle_o = (state == IDLE);
	assign adr_o = adr;
	assign ack_w_rdy = local_ready_i & ack_w;

	assign ack_o = acc_i ? (we_i ? ack_w_rdy : local_rdata_valid_i) : 1'b0;

	always @(posedge local_clk_i) begin
		if (local_reset_n_i == 1'b0) begin
			local_write_req		<= 1'b0;
			local_read_req		<= 1'b0;
			local_burstbegin	<= 1'b0;
			local_size		<= 6'b1;
			count			<= 0;
			adr			<= 32'b0;
			state			<= WAIT_READY;
		end else begin

			ack_w			<= 1'b0;
			local_burstbegin	<= 1'b0;
			local_write_req		<= 1'b0;
			local_burstbegin	<= 1'b0;
			local_read_req		<= 1'b0;

			case (state)

			WAIT_READY: begin
				if (local_ready_i)
					state <= IDLE;
			end

			IDLE: begin
				if (acc_i) begin
					if (we_i & local_ready_i) begin
						ack_w			<= 1'b1;
						local_burstbegin	<= 1'b1;
						local_write_req		<= 1'b1;
						local_size		<= 1;
						state			<= WRITE;
					end
					if (!we_i & local_ready_i) begin
						local_burstbegin	<= 1'b1;
						local_read_req		<= 1'b1;
						state			<= READ;
						local_size		<= (1<<buf_width_i);
						adr			<= adr_i & ~get_mask(buf_width_i+2);
						count			<= 0;
					end
				end
			end

			WRITE : begin
				if (local_ready_i)
					state <= IDLE;
			end

			READ : begin
				if (local_rdata_valid_i) begin
					count <= count + 1'b1;
					adr <= (adr & ~get_mask(buf_width_i+2)) | ((((adr >> 2) + 1) & get_mask(buf_width_i)) << 2);
				end

				if (count == (1<<buf_width_i)) begin
					count <= 0;
					state <= IDLE;
				end
			end


			endcase
		end
	end

endmodule
