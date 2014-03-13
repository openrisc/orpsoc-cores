/*
 * or1200-generic system Verilator testbench
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
#include <elf-loader.h>

#include "Vorpsoc_top__Syms.h"
#include "verilated_vcd_c.h"

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

#define VCD_DEFAULT_NAME	"../sim.vcd"

void parseArgs(int argc, char **argv);

int timeout;
char *elf_file_name;
bool vcd_enabled;
char *vcd_name;

bool dump_all;
unsigned long dump_start, dump_end;

int main(int argc, char **argv, char **env)
{
	int i;
	int t = 0;
	int size;
	uint8_t *bin_file;
	bool dump = false;
	VerilatedVcdC* tfp;
	uint32_t insn = 0;

	Verilated::commandArgs(argc, argv);

	Vorpsoc_top* top = new Vorpsoc_top;

	parseArgs(argc, argv);

	if (elf_file_name) {
		printf("Loading %s\n",elf_file_name);
		bin_file = load_elf_file(elf_file_name, &size);
		if (bin_file == NULL) {
			printf("Error loading elf file\n");
			exit(1);
		}
		for (int i = 0; i < size; i += 4)
			top->v->wb_bfm_memory0->mem[i / 4] = read_32(bin_file, i);
	}

	top->wb_clk_i = 0;
	top->wb_rst_i = 1;

	if (vcd_enabled) {
		Verilated::traceEverOn(true);
		tfp = new VerilatedVcdC;
		top->trace (tfp, 99);
		tfp->open(vcd_name);
	}

	if (dump_all)
		printf("VCD dump started (%u)\n", t);

	while (1) {

		if (vcd_enabled) {
			if (dump_start &&  t >= dump_start) {
				if (t == dump_start)
					printf("VCD dump started (%u)\n", t);
				dump = true;
			}
			if (dump_all)
				dump = true;
			if (!dump_all && !dump_start && dump_end)
				dump = true;
			if (dump_end && t >= dump_end) {
				if (t == dump_end)
					printf("VCD dump stopped (%u)\n", t);
				dump = false;
			}
			if (dump)
				tfp->dump(t);
		}

		top->eval();

		if (t > RESET_TIME)
			top->wb_rst_i = 0;

		top->wb_clk_i = !top->wb_clk_i;

		insn = top->v->or1200_top0->or1200_cpu->or1200_ctrl->wb_insn;

		if (insn == (0x15000000 | NOP_EXIT)) {
			printf("Success! Got NOP_EXIT. Exiting (%u)\n", t);
			break;
		}

		if (timeout && t > timeout) {
			printf("Timeout reached (%u)\n", t);
			break;
		}
		t++;
	}

	tfp->close();
	free(vcd_name);
	exit(0);
}

void parseArgs(int argc, char **argv)
{
	int i = 1;
	while (i < argc) {

		if (strcmp(argv[i], "--timeout") == 0) {
			timeout = strtod(argv[i], NULL);
			i++;
			continue;
		}
/*
		if ((strcmp(argv[i], "-q") == 0) || (strcmp(argv[i], "--quiet") == 0)) {
			quiet = true;
			i++;
			continue
		}
*/
		if (strcmp(argv[i], "--or1k-elf-load") == 0) {
			i++;
			elf_file_name = argv[i++];
			continue;
		}

		if ((strcmp(argv[i], "-d") == 0) || (strcmp(argv[i], "--vcdfile") == 0) ||
		    (strcmp(argv[i], "-v") == 0) || (strcmp(argv[i], "--vcd") == 0)) {
			vcd_enabled = true;
			dump_all = true;
			if ((i + 1 < argc) && (argv[i + 1][0] != '-')) {
					vcd_name = strdup(argv[i + 1]);
					i++;
			} else
				vcd_name = strdup(VCD_DEFAULT_NAME);
			i++;
			continue;
		}

		if ((strcmp(argv[i], "-s") == 0) || (strcmp(argv[i], "--vcdstart") == 0)) {
			dump_start = strtod(argv[i + 1], NULL);
			dump_all = false;
			i++;
			continue;
		}


		if ((strcmp(argv[i], "-t") == 0) || (strcmp(argv[i], "--vcdstop") == 0)) {
			dump_end = strtod(argv[i + 1], NULL);
			dump_all = false;
			i++;
			continue;
		}

#ifdef JTAG_DEBUG
		if ((strcmp(argv[i], "-r") == 0) || (strcmp(argv[i], "--rsp") == 0)) {
			rsp_server_enabled = true;
			if (i + 1 < argc)
				if (argv[i + 1][0] != '-') {
				rsp_server_port = atoi(argv[i + 1]);
				i++;
			}
			i++;
			continue;
		}
#endif

		if ((strcmp(argv[i], "-h") == 0) || (strcmp(argv[i], "--help") == 0)) {
			printf("Usage: %s [options]\n", argv[0]);
			printf("\n  ORPSoCv3 cycle accurate model\n");
			printf("  For details visit http://opencores.org/openrisc,orpsocv2\n");
			printf("\n");
			printf("Options:\n");
			printf("  -h, --help\t\tPrint this help message\n");
			printf("  -q, --quiet\t\tDisable all except UART print out\n");
			printf("\nSimulation control:\n");
			printf("  -f, --program <file> \tLoad program from OR32 ELF <file>\n");
			printf("  --timeout <val> \tStop the sim at <val> ns\n");
			printf("\nVCD generation:\n");
			printf("  -v, --vcdon\t\tEnable VCD generation\n");
			printf("  -d, --vcdfile <file>\tEnable and save VCD to <file>\n");
			printf("  -s, --vcdstart <val>\tEnable and delay VCD generation until <val> ns\n");
			printf("  -t, --vcdstop <val> \tEnable and terminate VCD generation at <val> ns\n");
#ifdef JTAG_DEBUG
			printf("\nRemote debugging:\n");
			printf("  -r, --rsp [<port>]\tEnable RSP debugging server, opt. specify <port>\n");
#endif
			printf("\n");
			exit(0);
		}

		i++;
	}
}
