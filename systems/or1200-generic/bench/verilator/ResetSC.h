// ----------------------------------------------------------------------------

// SystemC reset signal generator header

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

// $Id: ResetSC.h 286 2009-02-03 11:19:30Z jeremy $

#ifndef RESET_SC__H
#define RESET_SC__H

#include "systemc" 

//! Provide a SystemC reset signal at startup

//! The reset signal is driven for a specified number of cycles after
//! creation. For convenience synchronous versions of the reset signal are
//! provided in both active high and active low formats.

class ResetSC:public sc_core::sc_module {
public:

	// Constructor
	ResetSC(sc_core::sc_module_name name, int _resetCounter = 5);

	// Method to drive the reset
	void driveReset();

	// The ports
	sc_core::sc_in < bool > clk;
	sc_core::sc_out < bool > rst;	// Active high reset
	sc_core::sc_out < bool > rstn;	// Active low reset

private:

	int resetCounter;

};				// ResetSC ()

#endif // RESET_SC__H
