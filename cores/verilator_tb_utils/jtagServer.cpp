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

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <argp.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <fcntl.h>
#include "jtagServer.h"

int VerilatorJtagServer::check_for_command(struct jtag_cmd *packet)
{
	int nb;

	nb = read(connfd, packet, sizeof(struct jtag_cmd));

	if (((nb < 0) && (errno == EAGAIN)) || (nb == 0)) {
		packet->cmd = -1;
		return -1;
	} else {
		if (nb < 0) {
			packet->cmd = -1;
			return -1;
		}
	}

	return nb;
}

int VerilatorJtagServer::send_result_to_server(struct jtag_cmd *packet)
{
	write(connfd, packet, sizeof(struct jtag_cmd));
	return 0;
}

int VerilatorJtagServer::gen_clk(uint64_t t, int nb_period, uint8_t *tck, uint8_t tdo,
				 uint8_t *captured_tdo, int restart, int get_tdo)
{
	static bool gen_clk_begin = 1;
	static bool tck_low = 1;
	static uint64_t time;
	static int cur_period = 0;
	static int capture_done = 0;

	if (restart) {
		cur_period = 0;
		gen_clk_begin = 1;
		tck_low = 1;
		return DONE;
	}

	if (gen_clk_begin) {
		gen_clk_begin = 0;
		time = t;
	}

	if (cur_period < (nb_period * tck_period)) {
		if (tck_low) {
			capture_done = 0;
			*tck = 0;
			if ((t - time) > tck_period) {
				time = t;
				tck_low = 0;
			}
			return IN_PROGRESS;
		} else {
			*tck = 1;
			if (get_tdo && !capture_done) {
				capture_done = 1;
				*captured_tdo = tdo;
			}
			if ((t - time) > tck_period) {
				time = t;
				tck_low = 1;
			}
			cur_period++;
			return IN_PROGRESS;
		}
	}

	capture_done = 0;
	gen_clk_begin = 1;
	return DONE;
}

void VerilatorJtagServer::gen_clk_restart()
{
	gen_clk(0, 0, NULL, 0, NULL, 1, 0);
}

int VerilatorJtagServer::reset_tap(uint64_t t, uint8_t *tms, uint8_t *tck)
{
	*tms = 1;
	if (gen_clk(t, 5, tck, -1, NULL, 0, 0) == DONE) {
		gen_clk_restart();
		*tms = 0;
		return DONE;
	}

	return IN_PROGRESS;
}

int VerilatorJtagServer::goto_run_test_idle(uint64_t t, uint8_t *tms, uint8_t *tck)
{
	*tms = 0;
	if (gen_clk(t, 1, tck, -1, NULL, 0, 0) == DONE) {
		gen_clk_restart();
		return DONE;
	}

	return IN_PROGRESS;
}

int VerilatorJtagServer::do_tms_seq(uint64_t t, int length, int nb_bits,
				    uint8_t *buffer, uint8_t *tms, uint8_t *tck)
{
	static int i = 0;
	static int j = 0;
	static unsigned char data;
	static int start = 1;
	int nb_bits_rem;
	int nb_bits_in_this_byte;

	// Number of bits to send in the last byte
	nb_bits_rem = nb_bits % 8;

	while (i < length) {
		// If we are in the last byte, we have to send only
		// nb_bits_rem bits. If not, we send the whole byte.
		nb_bits_in_this_byte = (i == (length - 1)) ? nb_bits_rem : 8;

		if (start) {
			data = buffer[i];
			start = 0;
		}

		while (j < nb_bits_in_this_byte) {
			*tms = 0;
			if ((data & 1) == 1)
				*tms = 1;
			if (gen_clk(t, 1, tck, 0, NULL, 0, 0) == DONE) {
				j++;
				data = data >> 1;
				gen_clk_restart();
			}
			return IN_PROGRESS;
		}

		j = 0;
		i++;
		start = 1;
		return IN_PROGRESS;
	}

	*tms = 0;
	i = 0;
	j = 0;
	start = 1;

	return DONE;
}

int VerilatorJtagServer::do_scan_chain(uint64_t t, int length, int nb_bits,
	unsigned char *buffer_out, unsigned char *buffer_in, uint8_t *tms,
	uint8_t *tck, uint8_t *tdi, uint8_t tdo, int flip_tms)
{
	static int i = 0;
	static int j = 0;
	static int index = 0;
	static int start = 1;
	static unsigned char data;
	static uint8_t captured_tdo;
	int nb_bits_rem;
	int nb_bits_in_this_byte;

	// Number of bits to send in the last byte
	nb_bits_rem = nb_bits % 8;

	while (i < length) {
		// If we are in the last byte, we have to send only
		// nb_bits_rem bits if it's not zero.
		// If not, we send the whole byte.
		nb_bits_in_this_byte = (i == (length - 1)) ? ((nb_bits_rem == 0) ? 8 : nb_bits_rem) : 8;

		if (start) {
			buffer_in[i] = 0;
			if (buffer_out)
				data = buffer_out[i];
			else
				data = 0;
			start = 0;
		}

		while (j < nb_bits_in_this_byte) {
			*tdi = 0;
			if ((data & 1) == 1)
				*tdi = 1;

			// On the last bit, set TMS to '1'
			if (((j == (nb_bits_in_this_byte - 1)) && (i == (length - 1))) && (flip_tms == 1))
				*tms = 1;

			if (gen_clk(t, 1, tck, tdo, &captured_tdo, 0, 1) == DONE) {
				if (captured_tdo)
					buffer_in[i] |= (1 << j);
				else
					buffer_in[i] &= ~(1 << j);
				j++;
				data = data >> 1;
				gen_clk_restart();
			}
			return IN_PROGRESS;
		}

		j = 0;
		i++;
		start = 1;
		return IN_PROGRESS;
	}

	*tdi = 0;
	*tms = 0;
	i = 0;
	j = 0;
	start = 1;

	return DONE;
}

int VerilatorJtagServer::init_jtag_server(int port)
{
	struct sockaddr_in serv_addr;
	int flags;

	printf("JTAG server is listening on port %d\n", port);

	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	memset(&serv_addr, '0', sizeof(serv_addr));

	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port = htons(port);

	bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr));

	listen(listenfd, 10);

	printf("Waiting for client connection...");
	connfd = accept(listenfd, (struct sockaddr*)NULL, NULL);
	printf("ok\n");

	flags = fcntl(listenfd, F_GETFL, 0);
	fcntl(listenfd, F_SETFL, flags | O_NONBLOCK);

	return 0;
}


int VerilatorJtagServer::doJTAG(uint64_t t, uint8_t *tms, uint8_t *tdi, uint8_t *tck, uint8_t tdo)
{
	if (!cmd_in_progress)
		check_for_command(&packet);

	switch (jtag_state) {

	case CHECK_CMD:
		switch (packet.cmd) {
		case CMD_RESET:
			cmd_in_progress = 1;
			jtag_state = TAP_RESET;
			break;
		case CMD_TMS_SEQ:
			cmd_in_progress = 1;
			jtag_state = DO_TMS_SEQ;
			break;
		case CMD_SCAN_CHAIN:
			cmd_in_progress = 1;
			tms_flip = 0;
			jtag_state = SCAN_CHAIN;
			break;
		case CMD_SCAN_CHAIN_FLIP_TMS:
			cmd_in_progress = 1;
			tms_flip = 1;
			jtag_state = SCAN_CHAIN;
			break;
		default:
			break;
		}

	case TAP_RESET:
		if (reset_tap(t, tms, tck) == DONE) {
			jtag_state = GOTO_IDLE;
		}
		break;

	case GOTO_IDLE:
		if (goto_run_test_idle(t, tms, tck) == DONE) {
			cmd_in_progress = 0;
			jtag_state = CHECK_CMD;
		}
		break;

	case DO_TMS_SEQ:
		if (do_tms_seq(t, packet.length, packet.nb_bits, packet.buffer_out, tms, tck) == DONE) {
			cmd_in_progress = 0;
			jtag_state = CHECK_CMD;
		}
		break;

	case SCAN_CHAIN:
		*tms = 0;
		if (do_scan_chain(t, packet.length, packet.nb_bits, packet.buffer_out,
				  packet.buffer_in, tms, tck, tdi, tdo, tms_flip) == DONE) {
			cmd_in_progress = 0;
			send_result_to_server(&packet);
			jtag_state = CHECK_CMD;
		}
		break;

	case FINISHED:
		break;
	}

	return 0;
}

VerilatorJtagServer::VerilatorJtagServer(uint64_t period) {
	tck_period = period;
	jtag_state = CHECK_CMD;
	cmd_in_progress = 0;
}

VerilatorJtagServer::~VerilatorJtagServer() {
}
