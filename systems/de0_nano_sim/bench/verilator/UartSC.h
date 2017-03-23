// ----------------------------------------------------------------------------

// SystemC Uart: definition

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

// $Id: $

#ifndef UART_SC__H
#define UART_SC__H

#include "systemc.h"
#include <stdint.h>

//! Handle UART I/O

class UartSC:public sc_core::sc_module {
public:

	// Constructor
	UartSC(sc_core::sc_module_name name);

	// The ports
	sc_in < bool > clk;
	sc_in < bool > uarttx;
	sc_out < bool > uartrx;

	// Init function
	void initUart(int uart_baud);
	// Transmit (from ORPSoC) handling function
	void checkTx();
	// Receieve (in ORPSoC) generation function
	void driveRx();
	// Check keyboard for entry
	int kbhit();
	// Enable canonical mode on console
	void nonblock(int state);

private:
	uint8_t current_char;
	int counter;
	int bits_received;
	int ns_per_bit;

	int rx_state;
	int rx_counter;
	int rx_bits_sent;
	char rx_char;

};				// UartSC ()

#endif // UART_SC__H
