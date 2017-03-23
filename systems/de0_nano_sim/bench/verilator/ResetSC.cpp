// ----------------------------------------------------------------------------

// SystemC reset signal generator

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

// $Id: ResetSC.cpp 286 2009-02-03 11:19:30Z jeremy $

#include "ResetSC.h"

SC_HAS_PROCESS(ResetSC);

//! Constructor for the reset generator

//! @param name          Name of this module, passed to the parent
//!                      constructor.
//! @param resetCounter  Number of cycles of reset to provide.

ResetSC::ResetSC(sc_core::sc_module_name name, int _resetCounter):
sc_module(name), resetCounter(_resetCounter)
{
	SC_METHOD(driveReset);
	sensitive << clk.neg();

}				// ResetSC ()

//! Method to drive the reset port (active low). We will be called as an
//! initialization, which can be used to drive the reset low.
void ResetSC::driveReset()
{
	if (resetCounter > 0) {
		rst = 1;
		rstn = 0;
		resetCounter--;
	} else {
		rst = 0;
		rstn = 1;
	}
}				// driveReset()
