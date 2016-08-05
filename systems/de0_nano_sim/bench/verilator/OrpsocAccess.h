// ----------------------------------------------------------------------------

// Access functions for the ORPSoC Verilator model: definition

// Copyright (C) 2008  Embecosm Limited <info@embecosm.com>

// Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>

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

// $Id: OrpsocAccess.h 303 2009-02-16 11:20:17Z jeremy $

#ifndef ORPSOC_ACCESS__H
#define ORPSOC_ACCESS__H

#include <stdint.h>
#define wishbone_ram orpsoc_top->v->ram_wb0->ram_wb_b3_0

class Vorpsoc_top;
class Vorpsoc_top_orpsoc_top;
class Vorpsoc_top_or1200_ctrl;
class Vorpsoc_top_or1200_except;
class Vorpsoc_top_or1200_sprs;
class Vorpsoc_top_or1200_dpram;
// Main memory access class - will change if main memory size or other 
// parameters change
//Old ram_wbclass: class Vorpsoc_top_ram_wb_sc_sw__D20_A19_M800000;
//class Vorpsoc_top_wb_ram_b3__D20_A17_M800000;
class Vorpsoc_top_ram_wb_b3__pi3;
// SoC Arbiter class - will also change if any modifications to bus architecture
//class Vorpsoc_top_wb_conbus_top__pi1;

//! Access functions to the Verilator model

//! This class encapsulates access to the Verilator model, allowing other
//! Classes to access model state, without needing to be built within the
//! Verilator environment.
class OrpsocAccess {
public:

	// Constructor
	OrpsocAccess(Vorpsoc_top * orpsoc_top);

	// Accessor functions
	bool getExFreeze();
	bool getWbFreeze();
	uint32_t getWbInsn();
	uint32_t getIdInsn();
	uint32_t getExInsn();
	uint32_t getWbPC();
	uint32_t getIdPC();
	uint32_t getExPC();
	bool getExceptFlushpipe();
	bool getExDslot();
	uint32_t getExceptType();
	// Get a specific GPR from the register file
	uint32_t getGpr(uint32_t regNum);
	void setGpr(uint32_t regNum, uint32_t value);
	//SPR accessessors
	uint32_t getSprSr();
	uint32_t getSprEpcr();
	uint32_t getSprEear();
	uint32_t getSprEsr();

	// Wishbone SRAM accessor functions
	uint32_t get_mem32(uint32_t addr);
	uint8_t get_mem8(uint32_t addr);

	void set_mem32(uint32_t addr, uint32_t data);
	// Trigger a $readmemh for the RAM array
	void do_ram_readmemh(void);
	/*
	   // Arbiter access functions
	   uint8_t getWbArbGrant ();
	   // Master Signal Access functions
	   uint32_t  getWbArbMastDatI (uint32_t mast_num);
	   uint32_t  getWbArbMastDatO (uint32_t mast_num);
	   uint32_t  getWbArbMastAdrI (uint32_t mast_num);
	   uint8_t  getWbArbMastSelI (uint32_t mast_num);
	   uint8_t getWbArbMastSlaveSelDecoded (uint32_t mast_num);
	   bool  getWbArbMastWeI (uint32_t mast_num);
	   bool  getWbArbMastCycI (uint32_t mast_num);
	   bool  getWbArbMastStbI (uint32_t mast_num);
	   bool  getWbArbMastAckO (uint32_t mast_num);
	   bool  getWbArbMastErrO (uint32_t mast_num);
	 */

private:

	// Pointers to modules with accessor functions
	 Vorpsoc_top_or1200_ctrl * or1200_ctrl;
	Vorpsoc_top_or1200_except *or1200_except;
	Vorpsoc_top_or1200_sprs *or1200_sprs;
	Vorpsoc_top_or1200_dpram *rf_a;
	Vorpsoc_top *orpsoc_top;
};				// OrpsocAccess ()

#endif // ORPSOC_ACCESS__H
