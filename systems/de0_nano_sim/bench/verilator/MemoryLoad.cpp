/* MemoryLoad.cpp -- Program load functions

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

/* This program is commented throughout in a fashion suitable for processing
   with Doxygen. */

/* System includes */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "MemoryLoad.h"
#include "OrpsocMain.h"

//! Constructor for the ORPSoC memory loader class

//! Initializes various values

//! @param[in] orpsoc  The SystemC Verilated ORPSoC instance
//! @param[in] accessor  Accessor class for this Verilated ORPSoC model

MemoryLoad::MemoryLoad(OrpsocAccess * _accessor)
{
	accessor = _accessor;
}				// MemoryAccess ()

/*---------------------------------------------------------------------------*/
/*!Copy a string with null termination

   This function is very similar to strncpy, except it null terminates the
   string. A global function also used by the CUC.

   @param[in] dst  The destination string
   @param[in] src  The source string
   @param[in] n    Number of chars to copy EXCLUDING the null terminator
                   (i.e. dst had better have room for n+1 chars)

   @return  A pointer to dst                                                 */
/*---------------------------------------------------------------------------*/
char *MemoryLoad::strstrip(char *dst, const char *src, int n)
{
	strncpy(dst, src, n);
	*(dst + n) = '\0';

	return dst;

}				/* strstrip () */

#if IMM_STATS
int MemoryLoad::bits(uint32_t val)
{
	int i = 1;
	if (!val)
		return 0;
	while (val != 0 && (int32_t) val != -1) {
		i++;
		val = (int32_t) val >> 1;
	}
	return i;
}

void MemoryLoad::check_insn(uint32_t insn)
{
	int insn_index = insn_decode(insn);
	struct insn_op_struct *opd = op_start[insn_index];
	uint32_t data = 0;
	int dis = 0;
	const char *name;
	if (!insn || insn_index < 0)
		return;
	name = insn_name(insn_index);
	if (strcmp(name, "l.nop") == 0 || strcmp(name, "l.sys") == 0)
		return;

	while (1) {
		uint32_t tmp = 0 unsigned int nbits = 0;
		while (1) {
			tmp |=
			    ((insn >> (opd->type & OPTYPE_SHR)) &
			     ((1 << opd->data) - 1)) << nbits;
			nbits += opd->data;
			if (opd->type & OPTYPE_OP)
				break;
			opd++;
		}

		/* Do we have to sign extend? */
		if (opd->type & OPTYPE_SIG) {
			int sbit = (opd->type & OPTYPE_SBIT) >> OPTYPE_SBIT_SHR;
			if (tmp & (1 << sbit))
				tmp |= 0xFFFFFFFF << sbit;
		}
		if (opd->type & OPTYPE_DIS) {
			/* We have to read register later.  */
			data += tmp;
			dis = 1;
		} else {
			if (!(opd->type & OPTYPE_REG) || dis) {
				if (!dis)
					data = tmp;
				if (strcmp(name, "l.movhi") == 0) {
					movhi = data << 16;
				} else {
					data |= movhi;
					//PRINTF ("%08x %s\n", data, name);
					if (!
					    (or32_opcodes[insn_index].flags &
					     OR32_IF_DELAY)) {
						bcnt[bits(data)][0]++;
						bsum[0]++;
					} else {
						if (strcmp(name, "l.bf") == 0
						    || strcmp(name,
							      "l.bnf") == 0) {
							bcnt[bits(data)][1]++;
							bsum[1]++;
						} else {
							bcnt[bits(data)][2]++;
							bsum[2]++;
						}
					}
				}
			}
			data = 0;
			dis = 0;
		}
		if (opd->type & OPTYPE_LAST) {
			return;
		}
		opd++;
	}
}
#endif

/*---------------------------------------------------------------------------*/
/*!Add an instruction to the program

  @note insn must be in big endian format

  @param[in] address     The address to use
  @param[in] insn        The instruction to add                              */
/*---------------------------------------------------------------------------*/
void MemoryLoad::addprogram(oraddr_t address, uint32_t insn)
{

	int vaddr = (int)address;
	/* Use the whole-word write */
	accessor->set_mem32(vaddr, insn);
	/*printf("*  addprogram: addr 0x%.8x insn: 0x%.8x (conf: 0x%.8x)\n", 
	   vaddr, insn, accessor->get_mem32(vaddr)); */
	freemem += 4;

}				/* addprogram () */

/*---------------------------------------------------------------------------*/
/*!Load big-endian COFF file

   @param[in] filename  File to load
   @param[in] sections  Number of sections in file                           */
/*---------------------------------------------------------------------------*/
void MemoryLoad::readfile_coff(char *filename, short sections)
{
	FILE *inputfs;
	char inputbuf[4];
	uint32_t insn;
	int32_t sectsize;
	COFF_AOUTHDR coffaouthdr;
	struct COFF_scnhdr coffscnhdr;
	int len;
	int firstthree = 0;
	int breakpoint = 0;

	if (!(inputfs = fopen(filename, "r"))) {
		perror("readfile_coff");
		exit(1);
	}

	if (fseek(inputfs, sizeof(COFF_FILHDR), SEEK_SET) == -1) {
		fclose(inputfs);
		perror("readfile_coff");
		exit(1);
	}

	if (fread(&coffaouthdr, sizeof(coffaouthdr), 1, inputfs) != 1) {
		fclose(inputfs);
		perror("readfile_coff");
		exit(1);
	}

	while (sections--) {
		uint32_t scnhdr_pos =
		    sizeof(COFF_FILHDR) + sizeof(coffaouthdr) +
		    sizeof(struct COFF_scnhdr) * firstthree;
		if (fseek(inputfs, scnhdr_pos, SEEK_SET) == -1) {
			fclose(inputfs);
			perror("readfile_coff");
			exit(1);
		}
		if (fread(&coffscnhdr, sizeof(struct COFF_scnhdr), 1, inputfs)
		    != 1) {
			fclose(inputfs);
			perror("readfile_coff");
			exit(1);
		}
		PRINTF("Section: %s,", coffscnhdr.s_name);
		PRINTF(" paddr: 0x%.8lx,", COFF_LONG_H(coffscnhdr.s_paddr));
		PRINTF(" vaddr: 0x%.8lx,", COFF_LONG_H(coffscnhdr.s_vaddr));
		PRINTF(" size: 0x%.8lx,", COFF_LONG_H(coffscnhdr.s_size));
		PRINTF(" scnptr: 0x%.8lx\n", COFF_LONG_H(coffscnhdr.s_scnptr));

		sectsize = COFF_LONG_H(coffscnhdr.s_size);
		++firstthree;

		/* loading section */
		freemem = COFF_LONG_H(coffscnhdr.s_paddr);
		if (fseek(inputfs, COFF_LONG_H(coffscnhdr.s_scnptr), SEEK_SET)
		    == -1) {
			fclose(inputfs);
			perror("readfile_coff");
			exit(1);
		}
		while (sectsize > 0
		       && (len =
			   fread(&inputbuf, sizeof(inputbuf), 1, inputfs))) {
			insn = COFF_LONG_H(inputbuf);
			//len = insn_len (insn_decode (insn));
			len = 4;
			if (len == 2) {
				fseek(inputfs, -2, SEEK_CUR);
			}

			addprogram(freemem, insn);
			sectsize -= len;
		}
	}
	if (firstthree < 3) {
		PRINTF("One or more missing sections. At least");
		PRINTF(" three sections expected (.text, .data, .bss).\n");
		exit(1);
	}
	if (firstthree > 3) {
		PRINTF("Warning: one or more extra sections. These");
		PRINTF(" sections were handled as .data sections.\n");
	}

	fclose(inputfs);
	PRINTF("Finished loading COFF.\n");
	return;

}				/* readfile_coff () */

/*---------------------------------------------------------------------------*/
/*!Load symbols from big-endian COFF file

   @param[in] filename  File to load
   @param[in] symptr    Symbol pointer value
   @param[in] syms      Symbols value                                        */
/*---------------------------------------------------------------------------*/

void MemoryLoad::readsyms_coff(char *filename, uint32_t symptr, uint32_t syms)
{
	FILE *inputfs;
	struct COFF_syment coffsymhdr;
	int count = 0;
	uint32_t nsyms = syms;
	if (!(inputfs = fopen(filename, "r"))) {
		perror("readsyms_coff");
		exit(1);
	}

	if (fseek(inputfs, symptr, SEEK_SET) == -1) {
		fclose(inputfs);
		perror("readsyms_coff");
		exit(1);
	}

	while (syms--) {
		int i, n;
		if (fread(&coffsymhdr, COFF_SYMESZ, 1, inputfs) != 1) {
			fclose(inputfs);
			perror("readsyms_coff");
			exit(1);
		}

		n = (unsigned char)coffsymhdr.e_numaux[0];

		/* check whether this symbol belongs to a section and is external
		   symbol; ignore all others */
		if (COFF_SHORT_H(coffsymhdr.e_scnum) >= 0
		    && coffsymhdr.e_sclass[0] == C_EXT) {
			if (*((uint32_t *) coffsymhdr.e.e.e_zeroes)) {
				if (strlen(coffsymhdr.e.e_name)
				    && strlen(coffsymhdr.e.e_name) < 9)
					add_label(COFF_LONG_H
						  (coffsymhdr.e_value),
						  coffsymhdr.e.e_name);
			} else {
				uint32_t fpos = ftell(inputfs);

				if (fseek
				    (inputfs,
				     symptr + nsyms * COFF_SYMESZ +
				     COFF_LONG_H(coffsymhdr.e.e.e_offset),
				     SEEK_SET) == 0) {
					char tmp[33], *s = &tmp[0];
					while (s != &tmp[32])
						if ((*(s++) =
						     fgetc(inputfs)) == 0)
							break;
					tmp[32] = 0;
					add_label(COFF_LONG_H
						  (coffsymhdr.e_value),
						  &tmp[0]);
				}
				fseek(inputfs, fpos, SEEK_SET);
			}
		}

		for (i = 0; i < n; i++)
			if (fread(&coffsymhdr, COFF_SYMESZ, 1, inputfs) != 1) {
				fclose(inputfs);
				perror("readsyms_coff3");
				exit(1);
			}
		syms -= n;
		count += n;
	}

	fclose(inputfs);
	PRINTF("Finished loading symbols.\n");
	return;
}

/*---------------------------------------------------------------------------*/
/*!Read an ELF file

   @param[in] filename  File to load                                         */
/*---------------------------------------------------------------------------*/
void MemoryLoad::readfile_elf(char *filename)
{

	FILE *inputfs;
	struct elf32_hdr elfhdr;
	struct elf32_phdr *elf_phdata = NULL;
	struct elf32_shdr *elf_spnt, *elf_shdata;
	struct elf32_sym *sym_tbl = (struct elf32_sym *)0;
	uint32_t syms = 0;
	char *str_tbl = (char *)0;
	char *s_str = (char *)0;
	int breakpoint = 0;
	uint32_t inputbuf;
	uint32_t padd;
	uint32_t insn;
	int i, j, sectsize, len;

	if (!(inputfs = fopen(filename, "r"))) {
		perror("readfile_elf");
		exit(1);
	}

	if (fread(&elfhdr, sizeof(elfhdr), 1, inputfs) != 1) {
		perror("readfile_elf");
		exit(1);
	}

	if ((elf_shdata =
	     (struct elf32_shdr *)malloc(ELF_SHORT_H(elfhdr.e_shentsize) *
					 ELF_SHORT_H(elfhdr.e_shnum))) == NULL)
	{
		perror("readfile_elf");
		exit(1);
	}

	if (fseek(inputfs, ELF_LONG_H(elfhdr.e_shoff), SEEK_SET) != 0) {
		perror("readfile_elf");
		exit(1);
	}

	if (fread
	    (elf_shdata,
	     ELF_SHORT_H(elfhdr.e_shentsize) * ELF_SHORT_H(elfhdr.e_shnum), 1,
	     inputfs) != 1) {
		perror("readfile_elf");
		exit(1);
	}

	if (ELF_LONG_H(elfhdr.e_phoff)) {
		if ((elf_phdata =
		     (struct elf32_phdr *)malloc(ELF_SHORT_H(elfhdr.e_phnum) *
						 ELF_SHORT_H
						 (elfhdr.e_phentsize))) ==
		    NULL) {
			perror("readfile_elf");
			exit(1);
		}

		if (fseek(inputfs, ELF_LONG_H(elfhdr.e_phoff), SEEK_SET) != 0) {
			perror("readfile_elf");
			exit(1);
		}

		if (fread
		    (elf_phdata,
		     ELF_SHORT_H(elfhdr.e_phnum) *
		     ELF_SHORT_H(elfhdr.e_phentsize), 1, inputfs) != 1) {
			perror("readfile_elf");
			exit(1);
		}
	}

	for (i = 0, elf_spnt = elf_shdata; i < ELF_SHORT_H(elfhdr.e_shnum);
	     i++, elf_spnt++) {

		if (ELF_LONG_H(elf_spnt->sh_type) == SHT_STRTAB) {
			if (NULL != str_tbl) {
				free(str_tbl);
			}

			if ((str_tbl =
			     (char *)malloc(ELF_LONG_H(elf_spnt->sh_size))) ==
			    NULL) {
				perror("readfile_elf");
				exit(1);
			}

			if (fseek
			    (inputfs, ELF_LONG_H(elf_spnt->sh_offset),
			     SEEK_SET) != 0) {
				perror("readfile_elf");
				exit(1);
			}

			if (fread
			    (str_tbl, ELF_LONG_H(elf_spnt->sh_size), 1,
			     inputfs) != 1) {
				perror("readfile_elf");
				exit(1);
			}
		} else if (ELF_LONG_H(elf_spnt->sh_type) == SHT_SYMTAB) {

			if (NULL != sym_tbl) {
				free(sym_tbl);
			}

			if ((sym_tbl = (struct elf32_sym *)
			     malloc(ELF_LONG_H(elf_spnt->sh_size)))
			    == NULL) {
				perror("readfile_elf");
				exit(1);
			}

			if (fseek
			    (inputfs, ELF_LONG_H(elf_spnt->sh_offset),
			     SEEK_SET) != 0) {
				perror("readfile_elf");
				exit(1);
			}

			if (fread
			    (sym_tbl, ELF_LONG_H(elf_spnt->sh_size), 1,
			     inputfs) != 1) {
				perror("readfile_elf");
				exit(1);
			}

			syms =
			    ELF_LONG_H(elf_spnt->sh_size) /
			    ELF_LONG_H(elf_spnt->sh_entsize);
		}
	}

	if (ELF_SHORT_H(elfhdr.e_shstrndx) != SHN_UNDEF) {
		elf_spnt = &elf_shdata[ELF_SHORT_H(elfhdr.e_shstrndx)];

		if ((s_str =
		     (char *)malloc(ELF_LONG_H(elf_spnt->sh_size))) == NULL) {
			perror("readfile_elf");
			exit(1);
		}

		if (fseek(inputfs, ELF_LONG_H(elf_spnt->sh_offset), SEEK_SET) !=
		    0) {
			perror("readfile_elf");
			exit(1);
		}

		if (fread(s_str, ELF_LONG_H(elf_spnt->sh_size), 1, inputfs) !=
		    1) {
			perror("readfile_elf");
			exit(1);
		}
	}

	for (i = 0, elf_spnt = elf_shdata; i < ELF_SHORT_H(elfhdr.e_shnum);
	     i++, elf_spnt++) {

		if ((ELF_LONG_H(elf_spnt->sh_type) & SHT_PROGBITS)
		    && (ELF_LONG_H(elf_spnt->sh_flags) & SHF_ALLOC)) {

			padd = ELF_LONG_H(elf_spnt->sh_addr);
			for (j = 0; j < ELF_SHORT_H(elfhdr.e_phnum); j++) {
				if (ELF_LONG_H(elf_phdata[j].p_offset) &&
				    ELF_LONG_H(elf_phdata[j].p_offset) <=
				    ELF_LONG_H(elf_spnt->sh_offset)
				    && (ELF_LONG_H(elf_phdata[j].p_offset) +
					ELF_LONG_H(elf_phdata[j].p_memsz)) >
				    ELF_LONG_H(elf_spnt->sh_offset))
					padd =
					    ELF_LONG_H(elf_phdata[j].p_paddr) +
					    ELF_LONG_H(elf_spnt->sh_offset) -
					    ELF_LONG_H(elf_phdata[j].p_offset);
			}
			
			if (!gQuiet)
			{
				if (ELF_LONG_H(elf_spnt->sh_name) && s_str)
					printf("* Section: %s,",
					       &s_str[ELF_LONG_H(elf_spnt->sh_name)]);
				else
					printf("* Section: noname,");
				printf("* vaddr: 0x%.8lx,",
				       ELF_LONG_H(elf_spnt->sh_addr));
				printf("* paddr: 0x%" PRIx32, padd);
				printf("* offset: 0x%.8lx,",
				       ELF_LONG_H(elf_spnt->sh_offset));
				printf("* size: 0x%.8lx\n",
				       ELF_LONG_H(elf_spnt->sh_size));
			}
			
			freemem = padd;
			sectsize = ELF_LONG_H(elf_spnt->sh_size);

			if (fseek
			    (inputfs, ELF_LONG_H(elf_spnt->sh_offset),
			     SEEK_SET) != 0) {
				perror("readfile_elf");
				free(elf_phdata);
				exit(1);
			}

			while (sectsize > 0
			       && (len =
				   fread(&inputbuf, sizeof(inputbuf), 1,
					 inputfs))) {
				insn = ELF_LONG_H(inputbuf);
				//PRINTF("* addprogram(%.8x, %.8x, %d)\n", freemem, insn, breakpoint);
				addprogram(freemem, insn);
				sectsize -= 4;
			}
		}
	}

	if (str_tbl) {
		i = 0;
		while (syms--) {
			if (sym_tbl[i].st_name && sym_tbl[i].st_info
			    && ELF_SHORT_H(sym_tbl[i].st_shndx) < 0x8000) {
				add_label(ELF_LONG_H(sym_tbl[i].st_value),
					  &str_tbl[ELF_LONG_H
						   (sym_tbl[i].st_name)]);
			}
			i++;
		}
	}

	if (NULL != str_tbl) {
		free(str_tbl);
	}

	if (NULL != sym_tbl) {
		free(sym_tbl);
	}

	free(s_str);
	free(elf_phdata);
	free(elf_shdata);

}

/* Identify file type and call appropriate readfile_X routine. It only
handles orX-coff-big executables at the moment. */

void MemoryLoad::identifyfile(char *filename)
{
	FILE *inputfs;
	COFF_FILHDR coffhdr;
	struct elf32_hdr elfhdr;

	if (!(inputfs = fopen(filename, "r"))) {
		perror(filename);
		fflush(stdout);
		fflush(stderr);
		exit(1);
	}

	if (fread(&coffhdr, sizeof(coffhdr), 1, inputfs) == 1) {
		if (COFF_SHORT_H(coffhdr.f_magic) == 0x17a) {
			uint32_t opthdr_size;
			PRINTF("COFF magic: 0x%.4x\n",
			       COFF_SHORT_H(coffhdr.f_magic));
			PRINTF("COFF flags: 0x%.4x\n",
			       COFF_SHORT_H(coffhdr.f_flags));
			PRINTF("COFF symptr: 0x%.8lx\n",
			       COFF_LONG_H(coffhdr.f_symptr));
			if ((COFF_SHORT_H(coffhdr.f_flags) & COFF_F_EXEC) !=
			    COFF_F_EXEC) {
				PRINTF("This COFF is not an executable.\n");
				exit(1);
			}
			opthdr_size = COFF_SHORT_H(coffhdr.f_opthdr);
			if (opthdr_size != sizeof(COFF_AOUTHDR)) {
				PRINTF
				    ("COFF optional header is missing or not recognized.\n");
				PRINTF("COFF f_opthdr: 0x%" PRIx32 "\n",
				       opthdr_size);
				exit(1);
			}
			fclose(inputfs);
			readfile_coff(filename, COFF_SHORT_H(coffhdr.f_nscns));
			readsyms_coff(filename, COFF_LONG_H(coffhdr.f_symptr),
				      COFF_LONG_H(coffhdr.f_nsyms));
			return;
		} else {
			PRINTF("Not COFF file format\n");
			fseek(inputfs, 0, SEEK_SET);
		}
	}
	if (fread(&elfhdr, sizeof(elfhdr), 1, inputfs) == 1) {
		if (elfhdr.e_ident[0] == 0x7f && elfhdr.e_ident[1] == 0x45
		    && elfhdr.e_ident[2] == 0x4c && elfhdr.e_ident[3] == 0x46) {
			PRINTF("ELF type: 0x%.4x\n",
			       ELF_SHORT_H(elfhdr.e_type));
			PRINTF("ELF machine: 0x%.4x\n",
			       ELF_SHORT_H(elfhdr.e_machine));
			PRINTF("ELF version: 0x%.8lx\n",
			       ELF_LONG_H(elfhdr.e_version));
			PRINTF("ELF sec = %d\n", ELF_SHORT_H(elfhdr.e_shnum));
			if (ELF_SHORT_H(elfhdr.e_type) != ET_EXEC) {
				PRINTF("This ELF is not an executable.\n");
				exit(1);
			}
			fclose(inputfs);
			readfile_elf(filename);
			return;
		} else {
			PRINTF("Not ELF file format.\n");
			fseek(inputfs, 0, SEEK_SET);
		}
	}

	perror("identifyfile2");
	fclose(inputfs);

	return;
}

/*---------------------------------------------------------------------------*/
/*!Load file to memory

   Loads file to memory starting at address startaddr and returns freemem.

   @param[in] filename        File to load
   @param[in] startaddr       Start address at which to load
   @param[in] virtphy_transl  Virtual to physical transation table if
                              required. Only used for microkernel simulation,
			      and not used in Ork1sim at present (set to NULL)

   @return  zero on success, negative on failure.                            */
/*---------------------------------------------------------------------------*/
uint32_t
    MemoryLoad::loadcode(char *filename, oraddr_t startaddr,
			 oraddr_t virtphy_transl)
{

	init_labels();		// jb

	transl_table = virtphy_transl;
	freemem = startaddr;
	/*printf ("*  MemoryLoad::loadcode: filename %s  startaddr=%" PRIxADDR "  virtphy_transl=%" PRIxADDR "\n", filename, startaddr, virtphy_transl); */

	identifyfile(filename);

	return (uint32_t) freemem;

}

/* From arch sim labels.c */
void
 MemoryLoad::init_labels()
{
	int i;
	for (i = 0; i < LABELS_HASH_SIZE; i++)
		label_hash[i] = NULL;
}

void MemoryLoad::add_label(oraddr_t addr, char *name)
{
	struct label_entry **tmp;
	tmp = &(label_hash[addr % LABELS_HASH_SIZE]);
	for (; *tmp; tmp = &((*tmp)->next)) ;
	*tmp = (label_entry *) malloc(sizeof(**tmp));
	(*tmp)->name = (char *)malloc(strlen(name) + 1);
	(*tmp)->addr = addr;
	strcpy((*tmp)->name, name);
	(*tmp)->next = NULL;
}

struct label_entry *MemoryLoad::get_label(oraddr_t addr)
{
	struct label_entry *tmp = label_hash[addr % LABELS_HASH_SIZE];
	while (tmp) {
		if (tmp->addr == addr)
			return tmp;
		tmp = tmp->next;
	}
	return NULL;
}

struct label_entry *MemoryLoad::find_label(char *name)
{
	int i;
	for (i = 0; i < LABELS_HASH_SIZE; i++) {
		struct label_entry *tmp = label_hash[i % LABELS_HASH_SIZE];
		while (tmp) {
			if (strcmp(tmp->name, name) == 0)
				return tmp;
			tmp = tmp->next;
		}
	}
	return NULL;
}

/* Searches mem array for a particular label and returns label's address.
   If label does not exist, returns 0. */
oraddr_t MemoryLoad::eval_label(char *name)
{
	struct label_entry *le;
	char *plus;
	char *minus;
	int positive_offset = 0;
	int negative_offset = 0;

	if ((plus = strchr(name, '+'))) {
		*plus = '\0';
		positive_offset = atoi(++plus);
	}

	if ((minus = strchr(name, '-'))) {
		*minus = '\0';
		negative_offset = atoi(++minus);
	}
	le = find_label(name);
	if (!le)
		return 0;

	return le->addr + positive_offset - negative_offset;
}
