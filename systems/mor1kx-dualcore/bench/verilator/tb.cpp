/*
 * mor1kx-generic system Verilator testbench
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

#include "Vorpsoc_top__Syms.h"

static int done;

#define NOP_NOP			0x0000      /* Normal nop instruction */
#define NOP_EXIT		0x0001      /* End of simulation */
#define NOP_REPORT		0x0002      /* Simple report */
#define NOP_PUTC		0x0004      /* Simputc instruction */
#define NOP_CNT_RESET		0x0005      /* Reset statistics counters */
#define NOP_GET_TICKS		0x0006      /* Get # ticks running */
#define NOP_GET_PS		0x0007      /* Get picosecs/cycle */
#define NOP_TRACE_ON		0x0008      /* Turn on tracing */
#define NOP_TRACE_OFF		0x0009      /* Turn off tracing */
#define NOP_RANDOM		0x000a      /* Return 4 random bytes */
#define NOP_OR1KSIM		0x000b      /* Return non-zero if this is Or1ksim */
#define NOP_EXIT_SILENT		0x000c      /* End of simulation, quiet version */

#define RESET_TIME		2

#define SR_ICE	(1 << 4)
#define SR_DCE	(1 << 3)

void INThandler(int signal)
{
	printf("\nCaught ctrl-c\n");
	done = 2;
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

class TraceExecMonitor {
public:
  unsigned int id;
  bool self_done;
  VerilatorTbUtils* tbUtils;
  uint32_t *insn;
  uint32_t *pc;
  unsigned char *valid;

  Vorpsoc_top_mor1kx_cpu_cappuccino__pi5 *cpu;
//  Vorpsoc_top_mor1kx_cpu_cappuccino__pi6 *cpu;
  char printstring[256];
  int printstringpos;

  TraceExecMonitor() : printstringpos(0), self_done(false) {}

  void eval() {
    if (!*valid)
      return;

    if (!self_done) {
      if (*insn == (0x15000000 | NOP_EXIT)) {
	printf("[%lu] Success! Got NOP_EXIT (%lu)\n", id,
	       tbUtils->getTime());
	done++; self_done = true;
      } else if (*insn == (0x15000000 | NOP_EXIT_SILENT)) {
	printf("[%lu] Success! Got NOP_EXIT_SILENT (%lu)\n", id,
	       tbUtils->getTime());
	done++; self_done = true;
      } else if (*insn == (0x15000000 | NOP_PUTC)) {
	char c = cpu->get_gpr(3) & 0xff;
	printstring[printstringpos++] = c;
	if (c == '\n') {
	  printstring[printstringpos] = 0;
	  printf("%s", printstring);
	  printstringpos = 0;
	}
      } else if (*insn == (0x15000000 | NOP_GET_TICKS)) {
	printf("((%lu) PC = %08x (%lu))\n", id, *pc, tbUtils->getTime());
#if 0
      } else if (*insn == (0x15000000 | NOP_REPORT)) {
/*
        if (id != 1)
          return;
*/
	printf("report(0x%08x) ((%lu) PC = %08x (%lu))\n",
	       cpu->get_gpr(3), id, cpu->get_gpr(9), tbUtils->getTime());
#endif
      }
    }
  }

};


int main(int argc, char **argv, char **env)
{
	Verilated::commandArgs(argc, argv);

	Vorpsoc_top* top = new Vorpsoc_top;
	VerilatorTbUtils* tbUtils =
		new VerilatorTbUtils(top->v->wb_bfm_memory0->mem);

	parse_args(argc, argv, tbUtils);

	signal(SIGINT, INThandler);

	top->wb_clk_i = 0;
	top->wb_rst_i = 1;

	top->trace(tbUtils->tfp, 99);

	TraceExecMonitor trace0;
	trace0.id = 0;
	trace0.tbUtils = tbUtils;
	trace0.pc = &top->v->traceport_exec_pc[0];
	trace0.insn = &top->v->traceport_exec_insn[0];
	trace0.cpu = top->v->mor1kx0->mor1kx_cpu->cappuccino__DOT__mor1kx_cpu;
	trace0.valid = &top->v->traceport_exec_valid[0];
	TraceExecMonitor trace1;
	trace1.id = 1;
	trace1.tbUtils = tbUtils;
	trace1.pc = &top->v->traceport_exec_pc[1];
	trace1.insn = &top->v->traceport_exec_insn[1];
	trace1.cpu = top->v->mor1kx1->mor1kx_cpu->cappuccino__DOT__mor1kx_cpu;
	trace1.valid = &top->v->traceport_exec_valid[1];

	done = 0;

	uint32_t cpu0_sr, cpu1_sr, cpu0_sr_last, cpu1_sr_last;

	while (tbUtils->doCycle() && !(done==2)) {
		if (tbUtils->getTime() > RESET_TIME)
			top->wb_rst_i = 0;

		top->eval();
		top->wb_clk_i = !top->wb_clk_i;

		top->eval();
		trace0.eval();
		trace1.eval();

#if 0
		cpu0_sr = trace0.cpu->mor1kx_ctrl_cappuccino->spr_sr;
		cpu1_sr = trace1.cpu->mor1kx_ctrl_cappuccino->spr_sr;

		if ((cpu0_sr & SR_ICE) && !(cpu0_sr_last & SR_ICE))
			printf("ICACHE enabled on cpu0 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);

		if (!(cpu0_sr & SR_ICE) && (cpu0_sr_last & SR_ICE))
			printf("ICACHE disabled on cpu0 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);

		if ((cpu0_sr & SR_DCE) && !(cpu0_sr_last & SR_DCE))
			printf("DCACHE enabled on cpu0 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);

		if (!(cpu0_sr & SR_DCE) && (cpu0_sr_last & SR_DCE))
			printf("DCACHE disabled on cpu0 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);

		if ((cpu1_sr & SR_ICE) && !(cpu1_sr_last & SR_ICE))
			printf("ICACHE enabled on cpu1 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);

		if (!(cpu1_sr & SR_ICE) && (cpu1_sr_last & SR_ICE))
			printf("ICACHE disabled on cpu1 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);

		if ((cpu1_sr & SR_DCE) && !(cpu1_sr_last & SR_DCE))
			printf("DCACHE enabled on cpu1 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);

		if (!(cpu1_sr & SR_DCE) && (cpu1_sr_last & SR_DCE))
			printf("DCACHE disabled on cpu1 (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);

		cpu0_sr_last = cpu0_sr;
		cpu1_sr_last = cpu1_sr;
#endif

		top->wb_clk_i = !top->wb_clk_i;

#if 0
		if (*trace0.pc == 0xc0007cc8) {
			printf("SJK DEBUG: 0) (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);
		}

		if (*trace1.pc == 0x04) {
			printf("SJK DEBUG: 1) (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);
			done=2;
		}
#endif
#if 0
		if (*trace1.pc == 0xc01fe360) {
			printf("SJK DEBUG: 1) (%lu)\n", tbUtils->getTime());
		}
#endif

#if 0
		if (*trace0.pc == 0x200) {
			printf("SJK DEBUG: 0) (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace0.pc);
		}

#endif
#if 0
		if (*trace1.pc == 0x200) {
			printf("SJK DEBUG: 1) (%lu), PC=%08x\n",
			       tbUtils->getTime(), *trace1.pc);
		}
#endif

#if 0
		if (*trace0.pc == 0x200 ||
		    *trace1.pc == 0x200) {
			printf("SJK DEBUG: 0) (%lu)\n", tbUtils->getTime());
			//done = 2;
		}
#endif
	}

	printf("Simulation ended at PC[0] = %08x, PC[1] = %08x (%lu)\n",
	       *trace0.pc, *trace1.pc, tbUtils->getTime());

	delete tbUtils;
	exit(0);
}
