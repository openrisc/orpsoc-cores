// ----------------------------------------------------------------------------

// SystemC Uart: implementation

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

#include <iostream>
#include <iomanip>

#include "UartSC.h"

//#define UART_SC_DEBUG

// Keep disabled for now, to stop any portability problems cropping up.
//#define UART_SC_STDIN_ENABLE

#ifdef UART_SC_STDIN_ENABLE
#include <termios.h>
#include <unistd.h>
#endif

SC_HAS_PROCESS(UartSC);

//! Constructor for the Uart system C model

//! @param[in] name  Name of this module, passed to the parent constructor.
// Todo: Probably some sort of scaler parameter

UartSC::UartSC(sc_core::sc_module_name uart):
	sc_module(uart)
{
#ifdef UART_SC_STDIN_ENABLE
	SC_THREAD(driveRx);
#endif
	SC_THREAD(checkTx);
	dont_initialize();
	sensitive << uarttx;

}				// UartSC ()

void
UartSC::initUart(int uart_baud)
{
	// Calculate number of ns per UART bit
	ns_per_bit = (int) ((long long)1000000000/(long long)uart_baud);
	bits_received = 0;

	// Init state of RX
	rx_state = 0;
	
	// Set input, ORPSoC's RX, line to high
	uartrx.write(true);
	

#ifdef UART_SC_DEBUG
	printf
		("UartSC Initialised: Baud: %d, ns per bit: %d\n",
		 uart_baud, ns_per_bit);
#endif
}

// Some C from 
// http://cc.byexamples.com/2007/04/08/non-blocking-user-input-in-loop-without-ncurses/
//
int UartSC::kbhit()
{
#ifdef UART_SC_STDIN_ENABLE
    struct timeval tv;
    fd_set fds;
    tv.tv_sec = 0;
    tv.tv_usec = 0;
    FD_ZERO(&fds);
    FD_SET(STDIN_FILENO, &fds); //STDIN_FILENO is 0
    select(STDIN_FILENO+1, &fds, NULL, NULL, &tv);
    return FD_ISSET(STDIN_FILENO, &fds);
#else
    return 0;
#endif
}

#define NB_ENABLE 1
#define NB_DISABLE 0

// The following is apparently VERY Linux-centric. Maybe a ncurses version could
// be handy if this gets used on various platforms.
void UartSC::nonblock(int state)
{
#ifdef UART_SC_STDIN_ENABLE
	struct termios ttystate;
	
	//get the terminal state
	tcgetattr(STDIN_FILENO, &ttystate);
	
	if (state==NB_ENABLE)
	{
		//turn off canonical mode
		ttystate.c_lflag &= ~ICANON;
		//minimum of number input read.
		ttystate.c_cc[VMIN] = 1;
	}
	else if (state==NB_DISABLE)
	{
		//turn on canonical mode
		ttystate.c_lflag |= ICANON;
	}
	//set the terminal attributes.
	tcsetattr(STDIN_FILENO, TCSANOW, &ttystate);
#endif	
}



void UartSC::driveRx()
{
	static char c;

	UartSC::nonblock(NB_ENABLE);

	while(1)
	{
		if (rx_state == 0) // Waiting for a character input from user
		{

			// Do we have a character on input?
			//c=cin.peek();

			
			if (kbhit())
			{
				
				c = fgetc(stdin);
#ifdef UART_SC_DEBUG
				cout << "UartSC::driveRX got " << c << endl;
#endif
				rx_state++;				
			}

			wait(1000000, SC_NS);

		}
		else if (rx_state == 1)
		{
#ifdef UART_SC_DEBUG
			cout << "UartSC::driveRX start-bit " << c << endl;
#endif
			// Start bit - low
			uartrx.write(false);
			rx_state++;
			// Wait a bit
			wait(ns_per_bit, SC_NS);
		}
		else if (rx_state > 1 && rx_state < 10)
		{
#ifdef UART_SC_DEBUG
			cout << "UartSC::driveRX bit " << rx_state-2 << " " <<
			     (c & (1 << rx_state-2)) << endl;
#endif

			if (c & (1 << rx_state-2))
				uartrx.write(true);
			else
				uartrx.write(false);
			
			rx_state++;
			
			// Wait a bit
			wait(ns_per_bit, SC_NS);
		}
		else if (rx_state == 10) 
		{
#ifdef UART_SC_DEBUG
			cout << "UartSC::driveRX stop bit" << endl;
#endif
			rx_state = 0;
			// Stop bit
			uartrx.write(true);
			// Wait a bit
			wait(ns_per_bit + (ns_per_bit/2), SC_NS);
			
		}
	}
}


// Maybe do this with threads instead?!
void UartSC::checkTx()
{
	while(1){

		// Check the number of bits received
		if (bits_received == 0) {
			// Check if tx is low
			if ((uarttx.read() & 1) == 0) {
			
				// Line pulled low, begin receive of new char
				current_char = 0;
			
				//counter = 1;			

				bits_received++;	// We got the start bit
			
				// Now wait until next bit
				wait(ns_per_bit, SC_NS);
#ifdef UART_SC_DEBUG
				cout << "UartSC checkTx: got start bit at time "
				     <<	sc_time_stamp() << endl;
#endif
			}
			else
				// Nothing yet - keep waiting
				wait(ns_per_bit/2, SC_NS);

		} else if (bits_received > 0 && bits_received < 9) {
			
			current_char |=	((uarttx.read() & 1) << 
					 (bits_received - 1));
			
			// Increment bit number
			bits_received++;

			// Wait for next bit
			wait(ns_per_bit, SC_NS);
			
			
		} else if (bits_received == 9) {

			// Now check for stop bit 1
			if ((uarttx.read() & 1) != 1) {
				printf("UART TX framing error at time\n");
				cout << sc_time_stamp() << endl;
				
				// Perhaps do something else here to deal with 
				// this.
				bits_received = 0;
			}
			else
			{
				// Print the char
#ifdef UART_SC_DEBUG
				printf("Char received: 0x%2x time: ",
				       current_char);
				cout << sc_time_stamp() << endl;
#endif
				// cout'ing the char didn't work for some 
				// systems.
				//cout << current_char;
				printf("%c", current_char);
				
				bits_received = 0;
			}
		}
	}
}
