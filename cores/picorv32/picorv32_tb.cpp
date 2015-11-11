/*
 * picorv32 system Verilator testbench
 *
 * Based on testbench for mor1kx-generic
 *
 * Author: Olof Kindgren <olof.kindgren@gmail.com>
 * Author: Franck Jullien <franck.jullien@gmail.com>
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 *
 */

#include <stdint.h>
#include <signal.h>
#include <argp.h>
#include <verilator_tb_utils.h>

#include "Vpicorv32_top__Syms.h"

static bool done;

#define RESET_TIME		2

void INThandler(int signal)
{
	printf("\nCaught ctrl-c\n");
	done = true;
}

static int parse_opt(int key, char *arg, struct argp_state *state)
{
	switch (key) {
	case ARGP_KEY_INIT:
		state->child_inputs[0] = state->input;
		break;
	// Add parsing of custom options here
	}

	return 0;
}

static int parse_args(int argc, char **argv, VerilatorTbUtils* tbUtils)
{
	struct argp_option options[] = {
		// Add custom options here
		{ 0 }
	};
	struct argp_child child_parsers[] = {
		{ &verilator_tb_utils_argp, 0, "", 0 },
		{ 0 }
	};
	struct argp argp = { options, parse_opt, 0, 0, child_parsers };

	return argp_parse(&argp, argc, argv, 0, 0, tbUtils);
}

int main(int argc, char **argv, char **env)
{
	Verilated::commandArgs(argc, argv);

	Vpicorv32_top* top = new Vpicorv32_top;
	VerilatorTbUtils* tbUtils =
		new VerilatorTbUtils(top->v->mem->memory);

	parse_args(argc, argv, tbUtils);

	signal(SIGINT, INThandler);

	top->clk = 0;
	top->resetn = 0;

	top->trace(tbUtils->tfp, 99);

	while (tbUtils->doCycle() && !done) {
		if (tbUtils->getTime() > RESET_TIME)
			top->resetn = 1;

		top->eval();

		top->clk = !top->clk;
		done = top->resetn & top->trap;

	}

	printf("Simulation ended at (%lu)\n",
	       tbUtils->getTime());

	delete tbUtils;
	exit(0);
}
