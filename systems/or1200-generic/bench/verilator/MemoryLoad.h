/* MemoryLoad.h -- Header file for parse.c

   Copyright (C) 1999 Damjan Lampret, lampret@opencores.org
   Copyright (C) 2008 Embecosm Limited
   Copyright (C) 2009 Julius Baxter, julius@orsoc.se

   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>

   This file is part of Or1ksim, the OpenRISC 1000 Architectural Simulator.

   This program is free software; you can redistribute it and/or modify it
   under the terms of the GNU General Public License as published by the Free
   Software Foundation; either version 3 of the License, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful, but WITHOUT
   ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
   more details.

   You should have received a copy of the GNU General Public License along
   with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* Here we define some often used caharcters in assembly files.  This wil
   probably go into architecture dependent directory. */

#ifndef MEMORYLOAD__H
#define MEMORYLOAD__H

/* Package includes */
//#include "sim-config.h"
#include <stdint.h>

#include "coff.h"
#include "elf.h"

#include "OrpsocAccess.h"

//#define PRINTF(x...) fprintf(stdout,x)
#define PRINTF(x...)

/* Basic types for openrisc */
typedef uint32_t oraddr_t;	/*!< Address as addressed by openrisc */
typedef uint32_t uorreg_t;	/*!< An unsigned register of openrisc */
typedef int32_t orreg_t;	/*!< A signed register of openrisc */

/* From abstract.h */
#define DEFAULT_MEMORY_START         0
//#define DEFAULT_MEMORY_LEN    0x800000
#define STACK_SIZE                  20
#define LABELNAME_LEN               50
#define INSNAME_LEN                 15
#define OPERANDNAME_LEN             50
#define MAX_OPERANDS                 5

#define OP_MEM_ACCESS       0x80000000

/* Cache tag types.  */
#define CT_NONE                      0
#define CT_VIRTUAL                   1
#define CT_PHYSICAL                  2

/* History of execution */
#define HISTEXEC_LEN               200

/* Added by MM */
#ifndef LONGEST
#define LONGEST long long
#endif /* LONGEST */

#ifndef ULONGEST
#define ULONGEST unsigned long long
#endif /* ULONGEST */

#define PRIx32 "x"
#define PRIx16 "hx"
#define PRIx8 "hhx"
#define PRId32 "d"

/* Strings for printing OpenRISC types */
#define PRIxADDR  "08" PRIx32	/*!< print an openrisc address in hex */
#define PRIxREG   "08" PRIx32	/*!< print an openrisc register in hex */
#define PRIdREG   PRId32	/*!< print an openrisc register in decimals */

/* Endianness convenience macros */
#define LE16(x) bswap_16(x)

/*! Instruction queue */
struct iqueue_entry {
	int insn_index;
	uint32_t insn;
	oraddr_t insn_addr;
};

/*! Structure for holding one label per particular memory location */
struct label_entry {
	char *name;
	oraddr_t addr;
	struct label_entry *next;
};

/* from arch sim cpu/or1k/opcode/or32.h */
#define MAX_GPRS 32
#define PAGE_SIZE 8192

class MemoryLoad {
public:

	// Constructor
	MemoryLoad(OrpsocAccess * _accessor);

	// Label access function
	struct label_entry *get_label(oraddr_t addr);

	uint32_t loadcode(char *filename,
			  oraddr_t startaddr, oraddr_t virtphy_transl);

private:

	//! The accessor for the Orpsoc instance
	 OrpsocAccess * accessor;

#define MEMORY_LEN  0x100000000ULL

	/*!Whether to do immediate statistics. This seems to be for local debugging
	   of parse.c */
#define IMM_STATS 0

	/*!Unused mem memory marker. It is used when allocating program and data
	   memory during parsing */
	unsigned int freemem;

	/*!Translation table provided by microkernel. Only used if simulating
	   microkernel. */
	oraddr_t transl_table;

	/*!Used to signal whether during loading of programs a translation fault
	   occured. */
	uint32_t transl_error;

#if IMM_STATS
	int bcnt[33][3] = { 0 };
	int bsum[3] = { 0 };
	uint32_t movhi = 0;
#endif /* IMM_STATS */

	// A large number, for the Linux kernel (~8000 functions)
#define LABELS_HASH_SIZE 10000
	/* Local list of labels (symbols) */
	struct label_entry *label_hash[LABELS_HASH_SIZE];

	/* Function prototypes for external use */
	char *strstrip(char *dst, const char *src, int n);

	oraddr_t translate(oraddr_t laddr, int *breakpoint);

	int bits(uint32_t val);

	void check_insn(uint32_t insn);

	void addprogram(oraddr_t address, uint32_t insn);

	void readfile_coff(char *filename, short sections);

	void readsyms_coff(char *filename, uint32_t symptr, uint32_t syms);

	void readfile_elf(char *filename);

	void identifyfile(char *filename);

	void init_labels();

	void add_label(oraddr_t addr, char *name);

	struct label_entry *find_label(char *name);
	oraddr_t eval_label(char *name);

};

#endif /* MEMORYLOAD__H */
