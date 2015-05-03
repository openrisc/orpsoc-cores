//////////////////////////////////////////////////////////////////////
///                                                               //// 
/// bootrom                                                       ////
///                                                               ////
/// Assembly programs to be embedded inside system to aid boot    ////
///                                                               ////
/// Julius Baxter, julius@opencores.org                           ////
/// Olof Kindgren, olof.kindgren@gmail.com                        ////
///                                                               ////
//////////////////////////////////////////////////////////////////////
////                                                              ////
//// Copyright (C) 2009, 2010 Authors and OPENCORES.ORG           ////
////                                                              ////
//// This source file may be used and distributed without         ////
//// restriction provided that this copyright statement is not    ////
//// removed from the file and that any derivative work contains  ////
//// the original copyright notice and the associated disclaimer. ////
////                                                              ////
//// This source file is free software; you can redistribute it   ////
//// and/or modify it under the terms of the GNU Lesser General   ////
//// Public License as published by the Free Software Foundation; ////
//// either version 2.1 of the License, or (at your option) any   ////
//// later version.                                               ////
////                                                              ////
//// This source is distributed in the hope that it will be       ////
//// useful, but WITHOUT ANY WARRANTY; without even the implied   ////
//// warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      ////
//// PURPOSE.  See the GNU Lesser General Public License for more ////
//// details.                                                     ////
////                                                              ////
//// You should have received a copy of the GNU Lesser General    ////
//// Public License along with this source; if not, download it   ////
//// from http://www.opencores.org/lgpl.shtml                     ////
////                                                              ////
//////////////////////////////////////////////////////////////////////

	/* Assembly program to go into the boot ROM */
	/* For use with simple_spi SPI master core and standard SPI flash
	   interface-compatible parts (ST M25P16 for example.)*/
	/* Currently just loads a program from SPI flash into RAM */
	/* Assuming address at RAM_LOAD_BASE gets clobbered, we need
	   a byte writable address somewhere!*/

/* Address in RAM where the application should be written */
#ifndef RAM_LOAD_BASE
#define RAM_LOAD_BASE 0x00000000
#endif	

/* Base address of the Simple SPI instance used to communicate with the Flash */
#ifndef SPI_BASE
#define SPI_BASE 0xB0000000
#endif

/* Address to start executing after program is loaded to RAM */
#ifndef RESET_ADDR
#define RESET_ADDR 0x00000100
#endif

/* 24-bit address in SPI Flash where application image is stored */
#ifndef BOOTROM_ADDR
#define BOOTROM_ADDR 0x000000
#endif	

#ifndef INIT_DELAY
#define INIT_DELAY 1250 //FIXME 0
#endif	
	
#define SPI_SPCR 0x0
#define SPI_SPSR 0x1
#define SPI_SPDR 0x2
#define SPI_SPER 0x3
#define SPI_SPSS 0x4

#define SPI_SPCR_XFER_GO 0x51
#define SPI_SPSS_INIT 0x1
#define SPI_SPSR_RX_CHECK 0x01 /* Check bit 0 is cleared, fifo !empty*/


boot_init:	
	l.movhi r0, 0

	l.movhi r1,     hi(INIT_DELAY)
	l.ori   r1, r1, lo(INIT_DELAY)
1:	l.sfeqi r1, 0
	l.bnf 1b
	l.addi r1, r1, -1
	
	l.movhi r1,     hi(RAM_LOAD_BASE)
	l.ori   r1, r1, lo(RAM_LOAD_BASE)
	l.movhi r4, hi(SPI_BASE)

spi_init:
	l.ori 	r2, r0, SPI_SPCR_XFER_GO /* Setup SPCR with enable bit set */
	l.sb 	SPI_SPCR(r4), r2
	l.sb  	SPI_SPSS(r4), r0         /* Clear SPI slave selects */
	l.ori 	r6, r0, SPI_SPSS_INIT
	l.sb  	SPI_SPSS(r4), r6         /* Set appropriate slave select */
	l.jal	spi_xfer
	l.ori 	r3, r0, 0x3              /* READ command opcode for SPI device*/
	l.jal 	spi_xfer

	/* Set start address in SPI Flash */
	l.ori 	r3, r0, ((BOOTROM_ADDR >> 16) & 0xff)
	l.jal 	spi_xfer
	l.ori 	r3, r0, ((BOOTROM_ADDR >>  8) & 0xff)
	l.jal 	spi_xfer
	l.ori 	r3, r0, ((BOOTROM_ADDR      ) & 0xff)

	l.movhi r6, 0
	l.movhi r7, 0xffff	

copy:	
	l.jal 	spi_xfer         /* Read a byte into r3 */
	l.add 	r8, r1, r6       /* Calculate store address */
	l.sb 	0(r8), r3        /* Write byte to memory */
	l.addi 	r6, r6, 1        /* Increment counter */
	l.sfeqi r6, 0x4          /* Is this the first word ?*/
	l.bf 	store_sizeword   /* put sizeword in the register */
	l.sfeq 	r6, r7           /* Check if we've finished loading the words */
	l.bnf 	copy             /* Continue copying if not last word */
	l.nop

goto_reset:
	l.ori 	r1, r1, RESET_ADDR
	l.jr 	r1
	l.sb  	SPI_SPSS(r4), r0 /* Clear SPI slave selects */
	
store_sizeword:
#ifdef SPI_RETRY_IF_INSANE_SIZEWORD
	l.lwz 	r7, 0(r1)        /* Size word is in first word of SDRAM */
	l.srli	r10, r7, 16	 /* Chop the sizeword we read in half */
	l.sfgtui r10, 0x0200	 /* It's unlikely we'll ever load > 32MB */
	l.bf	boot_init
	l.nop
	l.j 	copy
	l.nop

#else	
	l.j 	copy
	l.lwz 	r7, 0(r1)         /* Size word is in first word of SDRAM */
#endif
	
spi_xfer:
	l.sb 	SPI_SPDR(r4), r3  /* Dummy write what's in r3 */
	l.ori 	r3, r0, SPI_SPSR_RX_CHECK /* r3 = , ensure loop just once */
spi_xfer_poll:	
	l.andi 	r3, r3, SPI_SPSR_RX_CHECK /* AND read fifo bit empty */
	l.sfeqi r3, SPI_SPSR_RX_CHECK    /* is bit set? ... */
	l.bf 	spi_xfer_poll     /* ... if so, rxfifo empty, keep polling */
	l.lbz 	r3, SPI_SPSR(r4) /* Read SPSR */
	l.jr 	r9
	l.lbz 	r3, SPI_SPDR(r4) /* Get data byte */
