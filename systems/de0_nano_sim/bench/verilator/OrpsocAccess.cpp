// ----------------------------------------------------------------------------

// Access functions for the ORPSoC Verilator model: implementation

// Copyright (C) 2008  Embecosm Limited <info@embecosm.com>

// Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
// Contributor Julius Baxter <jb@orsoc.se>

// This file is part of the cycle accurate model of the OpenRISC 1000 based
// system-on-chip, ORPSoC, built using Verilator.

// This program is free software: you can redistribute it and/or modify it
// under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.

// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
// License for more details.

// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// ----------------------------------------------------------------------------

// $Id: OrpsocAccess.cpp 303 2009-02-16 11:20:17Z jeremy $

#include "OrpsocAccess.h"

#include "Vorpsoc_top__Syms.h"

#include "Vorpsoc_top.h"
#include "Vorpsoc_top_orpsoc_top.h"
#include "Vorpsoc_top_or1200_top.h"
#include "Vorpsoc_top_or1200_cpu.h"
#include "Vorpsoc_top_or1200_ctrl.h"
#include "Vorpsoc_top_or1200_except.h"
#include "Vorpsoc_top_or1200_sprs.h"
#include "Vorpsoc_top_or1200_rf.h"
#include "Vorpsoc_top_or1200_dpram.h"

//! Constructor for the ORPSoC access class

//! Initializes the pointers to the various module instances of interest
//! within the Verilator model.

//! @param[in] orpsoc  The SystemC Verilated ORPSoC instance

OrpsocAccess::OrpsocAccess(Vorpsoc_top * orpsoc_top)
{
	// Assign processor accessor objects
	or1200_ctrl = orpsoc_top->v->or1200_top0->or1200_cpu->or1200_ctrl;
	or1200_except = orpsoc_top->v->or1200_top0->or1200_cpu->or1200_except;
	or1200_sprs = orpsoc_top->v->or1200_top0->or1200_cpu->or1200_sprs;
	rf_a = orpsoc_top->v->or1200_top0->or1200_cpu->or1200_rf->rf_a;

	this->orpsoc_top = orpsoc_top;

}				// OrpsocAccess ()

//! Access for the ex_freeze signal

//! @return  The value of the or1200_ctrl.ex_freeze signal

bool OrpsocAccess::getExFreeze()
{
	return or1200_ctrl->ex_freeze;

}				// getExFreeze ()

//! Access for the wb_freeze signal

//! @return  The value of the or1200_ctrl.wb_freeze signal

bool OrpsocAccess::getWbFreeze()
{
	return or1200_ctrl->wb_freeze;

}				// getWbFreeze ()

//! Access for the except_flushpipe signal

//! @return  The value of the or1200_except.except_flushpipe signal

bool OrpsocAccess::getExceptFlushpipe()
{
	return or1200_except->except_flushpipe;

}				// getExceptFlushpipe ()

//! Access for the ex_dslot signal

//! @return  The value of the or1200_except.ex_dslot signalfac

bool OrpsocAccess::getExDslot()
{
	return or1200_except->ex_dslot;

}				// getExDslot ()

//! Access for the except_type value

//! @return  The value of the or1200_except.except_type register

uint32_t OrpsocAccess::getExceptType()
{
	return (or1200_except->get_except_type) ();

}				// getExceptType ()

//! Access for the id_pc register

//! @return  The value of the or1200_except.id_pc register

uint32_t OrpsocAccess::getIdPC()
{
	return (or1200_except->get_id_pc) ();

}				// getIdPC ()

//! Access for the ex_pc register

//! @return  The value of the or1200_except.id_ex register

uint32_t OrpsocAccess::getExPC()
{
	return (or1200_except->get_ex_pc) ();

}				// getExPC ()

//! Access for the wb_pc register

//! @return  The value of the or1200_except.wb_pc register

uint32_t OrpsocAccess::getWbPC()
{
	return (or1200_except->get_wb_pc) ();

}				// getWbPC ()

//! Access for the id_insn register

//! @return  The value of the or1200_ctrl.wb_insn register

uint32_t OrpsocAccess::getIdInsn()
{
	return (or1200_ctrl->get_id_insn) ();

}				// getIdInsn ()

//! Access for the ex_insn register

//! @return  The value of the or1200_ctrl.ex_insn register

uint32_t OrpsocAccess::getExInsn()
{
	return (or1200_ctrl->get_ex_insn) ();

}				// getExInsn ()

//! Access for the wb_insn register

//! @return  The value of the or1200_ctrl.wb_insn register

uint32_t OrpsocAccess::getWbInsn()
{
	return (or1200_ctrl->get_wb_insn) ();

}				// getWbInsn ()

//! Access the Wishbone SRAM memory

//! @return  The value of the 32-bit memory word at addr

uint32_t OrpsocAccess::get_mem32(uint32_t addr)
{
	return (wishbone_ram->get_mem32) (addr / 4);

}				// get_mem32 ()

//! Access a byte from the Wishbone SRAM memory

//! @return  The value of the memory byte at addr

uint8_t OrpsocAccess::get_mem8(uint32_t addr)
{

	uint32_t word;
	static uint32_t cached_word;
	static uint32_t cached_word_addr = 0xffffffff;
	int sel = addr & 0x3;	// Remember which byte we want
	addr = addr / 4;
	if (addr != cached_word_addr) {
		cached_word_addr = addr;
		// Convert address to word number here
		word = (wishbone_ram->get_mem8) (addr);
		cached_word = word;
	} else
		word = cached_word;

	switch (sel) {
		/* Big endian word expected */
	case 0:
		return ((word >> 24) & 0xff);
		break;
	case 1:
		return ((word >> 16) & 0xff);
		break;
	case 2:
		return ((word >> 8) & 0xff);
		break;
	case 3:
		return ((word >> 0) & 0xff);
		break;
	default:
		return 0;
	}

}				// get_mem8 ()

//! Write value to the Wishbone SRAM memory

void OrpsocAccess::set_mem32(uint32_t addr, uint32_t data)
{
	(wishbone_ram->set_mem32) (addr / 4, data);

}				// set_mem32 ()

//! Trigger the $readmemh() system call

void OrpsocAccess::do_ram_readmemh(void)
{
	(wishbone_ram->do_readmemh) ();

}				// do_ram_readmemh ()

//! Access for the OR1200 GPRs

//! These are extracted from memory using the Verilog function

//! @param[in] regNum  The GPR whose value is wanted

//! @return            The value of the GPR

uint32_t OrpsocAccess::getGpr(uint32_t regNum)
{
	return (rf_a->get_gpr) (regNum);

}				// getGpr ()

//! Access for the OR1200 GPRs

//! These are extracted from memory using the Verilog function

//! @param[in] regNum  The GPR whose value is wanted
//! @param[in] value   The value of GPR to write

void OrpsocAccess::setGpr(uint32_t regNum, uint32_t value)
{
	(rf_a->set_gpr) (regNum, value);

}				// getGpr ()

//! Access for the sr register

//! @return  The value of the or1200_sprs.sr register

uint32_t OrpsocAccess::getSprSr()
{
	return (or1200_sprs->get_sr) ();

}				// getSprSr ()

//! Access for the epcr register

//! @return  The value of the or1200_sprs.epcr register

uint32_t OrpsocAccess::getSprEpcr()
{
	return (or1200_sprs->get_epcr) ();

}				// getSprEpcr ()

//! Access for the eear register

//! @return  The value of the or1200_sprs.eear register

uint32_t OrpsocAccess::getSprEear()
{
	return (or1200_sprs->get_eear) ();

}				// getSprEear ()

//! Access for the esr register

//! @return  The value of the or1200_sprs.esr register

uint32_t OrpsocAccess::getSprEsr()
{
	return (or1200_sprs->get_esr) ();

}				// getSprEsr ()

/*
//! Access for the arbiter's grant signal

//! @return  The value of the wb_conmax_top.arb signal

uint8_t
OrpsocAccess::getWbArbGrant ()
{
  return  (wb_arbiter->get_gnt) ();

}	// getWbArbGrant ()

//! Arbiter master[mast_num] access functions

//! Access for the arbiter's master[mast_num] data in signal

//! @return  The value of the wb_conmax_top.m_dat_i[mast_num]

uint32_t
OrpsocAccess::getWbArbMastDatI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_dat_i) (mast_num);

}	// getWbArbMastDatI ()

//! Access for the arbiter's master[mast_num] data out signal

//! @return  The value of the wb_conmax_top.m_dat_o[mast_num]

uint32_t
OrpsocAccess::getWbArbMastDatO (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_dat_o) (mast_num);

}	// getWbArbMastDatO ()

//! Access for the arbiter's master[mast_num] data out

//! @return  The value of the wb_conmax_top.m_adr_i[mast_num]

uint32_t
OrpsocAccess::getWbArbMastAdrI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_adr_i) (mast_num);

}	// getWbArbMastAdrI ()

//! Access for the arbiter's master[mast_num] select signal

//! @return  The value of the wb_conmax_top.m_sel_i[mast_num]

uint8_t
OrpsocAccess::getWbArbMastSelI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_sel_i) (mast_num);

}	// getWbArbMastSelI ()

//! Access for the arbiter's master[mast_num] decoded slave select signal

//! @return  The value of the wb_conmax_top.m_ssel_dec[mast_num]

uint8_t
OrpsocAccess::getWbArbMastSlaveSelDecoded (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_ssel_dec) (mast_num);

}	// getWbArbMastSlaveSelDecoded ()

//! Access for the arbiter's master[mast_num] write enable signal

//! @return  The value of the wb_conmax_top.m_we_i[mast_num]

bool
OrpsocAccess::getWbArbMastWeI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_we_i) (mast_num);

}	// getWbArbMastWeI ()

//! Access for the arbiter's master[mast_num] cycle input signal

//! @return  The value of the wb_conmax_top.m_cyc_i[mast_num]

bool
OrpsocAccess::getWbArbMastCycI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_cyc_i) (mast_num);

}	// getWbArbMastCycI ()

//! Access for the arbiter's master[mast_num] strobe input signal

//! @return  The value of the wb_conmax_top.m_stb_i[mast_num]

bool
OrpsocAccess::getWbArbMastStbI (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_stb_i) (mast_num);

}	// getWbArbMastStbI ()

//! Access for the arbiter's master[mast_num] ACK output signal

//! @return  The value of the wb_conmax_top.m_ack_o[mast_num]

bool
OrpsocAccess::getWbArbMastAckO (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_ack_o) (mast_num);

}	// getWbArbMastAckO ()

//! Access for the arbiter's master[mast_num] error input signal

//! @return  The value of the wb_conmax_top.m_err_o[mast_num]

bool
OrpsocAccess::getWbArbMastErrO (uint32_t mast_num)
{
  return  (wb_arbiter->get_m_err_o) (mast_num);

}	// getWbArbMastErrO ()

*/
