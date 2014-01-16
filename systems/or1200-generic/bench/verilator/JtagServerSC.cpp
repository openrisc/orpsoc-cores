/*
 * TCP/IP controlled JTAG Interface.
 * Based on Julius Baxter's work on jtag_vpi.c
 *
 * Copyright (C) 2013 Jose T. de Sousa, <jts@inesc-id.pt>
 *
 * See file CREDITS for list of people who contributed to this
 * project.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */

#include <iostream>
using namespace std;

#include "JtagServerSC.h"
using namespace sc_core;
using sc_core::sc_fifo;
using sc_core::sc_module_name;
using sc_core::sc_stop;
using sc_core::sc_time;

SC_HAS_PROCESS(JtagServerSC);


#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <arpa/inet.h>

#define RSP_SERVER_PORT	5555
#define	XFERT_MAX_SIZE	512

const char * cmd_to_string[] = {"CMD_RESET",
				"CMD_TMS_SEQ",
				"CMD_SCAN_CHAIN"};

struct vpi_cmd {
	int cmd;
	unsigned char buffer_out[XFERT_MAX_SIZE];
	unsigned char buffer_in[XFERT_MAX_SIZE];
	int length;
	int nb_bits;
};

int listenfd = 0;
int connfd = 0;


JtagServerSC::JtagServerSC(sc_core::sc_module_name name){

  cout << "Launching JTAG Server...";

  //Launch SysC thread
  SC_THREAD(MainThread);
} //JtagServerSC

JtagServerSC::~JtagServerSC()
{
	cout << "Destructor must exist and have non-empty body";

} // ~JtagServerSC


int JtagServerSC::InitJtagServer(const int port)
{
	struct sockaddr_in serv_addr;
	int flags;

	printf("Listening on port %d\n", port);

	listenfd = socket(AF_INET, SOCK_STREAM, 0);
	memset(&serv_addr, '0', sizeof(serv_addr));

	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port = htons(port);

	bind(listenfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr));

	listen(listenfd, 10);

	printf("Waiting for client connection...");
	connfd = accept(listenfd, (struct sockaddr*)NULL, NULL);
	printf("ok\n");

	flags = fcntl(listenfd, F_GETFL, 0);
	fcntl(listenfd, F_SETFL, flags | O_NONBLOCK);

	return 0;
}


void JtagServerSC::CheckForCommand(int *cmd, int *length, int *nb_bits, unsigned char *buffer_out)
{
	int nb;
	int loaded_words = 0;
	struct vpi_cmd vpi;

	// Get the command from TCP server
	if(!connfd)
	  InitJtagServer(RSP_SERVER_PORT);
	nb = read(connfd, &vpi, sizeof(struct vpi_cmd));

	if (((nb < 0) && (errno == EAGAIN)) || (nb == 0)) {
		// Nothing in the fifo this time, let's return
		return;
	} else {
		if (nb < 0) {
			// some sort of error
			perror("check_for_command");
			exit(1);
		}
	}

	*cmd = vpi.cmd;
	*length = vpi.length;
	*nb_bits = vpi.nb_bits;
	bcopy(vpi.buffer_out, buffer_out, vpi.length);
}

void JtagServerSC::SendResultToServer(const int length, const unsigned char buffer_in[])
{
	int n;
	struct vpi_cmd vpi;

	bcopy(buffer_in, vpi.buffer_in, length);
	n = write(connfd, &vpi, sizeof(struct vpi_cmd));
}


void JtagServerSC::MainThread(){

  tck = 0;

  tdi = 0;

  tms = 0;

  ResetTap();
  GotoRunTestIdle();

  cout << "Running Jtag Server...\n";

  while (1) {

    sc_time t3;
    int cmd;
    unsigned char buffer_out[XFERT_MAX_SIZE];
    unsigned char buffer_in[XFERT_MAX_SIZE];
    int length;
    int nb_bits;

    bool flip_tms;
    

    // Check for incoming command
    // wait until a command is sent
    // poll with a delay here
    cmd = -1;
    flip_tms = 0;

    while (cmd == -1){
      wait(1000, SC_NS);
      CheckForCommand(&cmd, &length, &nb_bits, buffer_out);
    }

    // now switch on the command
    switch (cmd){

    case CMD_RESET :
      if (DEBUG_INFO){
	t3 = sc_time_stamp();
	cout << t3.to_string() << "----> CMD_RESET" << length << endl;
      }			
      ResetTap();
      GotoRunTestIdle();
      break;

    case CMD_TMS_SEQ :
      if (DEBUG_INFO){
	t3 = sc_time_stamp();
	cout << t3.to_string() << "----> CMD_TMS_SEQ" << endl;			
      }
      DoTmsSeq(length, nb_bits, buffer_out);
      break;

    case CMD_SCAN_CHAIN :
      if (DEBUG_INFO){
	t3 = sc_time_stamp();
	cout << t3.to_string() << "----> CMD_SCAN_CHAIN" << endl;			
      }
      DoScanChain(length, nb_bits, buffer_in, buffer_out, flip_tms);
      SendResultToServer(length, buffer_in);
      break;

    case CMD_SCAN_CHAIN_FLIP_TMS :
      if(DEBUG_INFO){
	t3 = sc_time_stamp();
	cout << t3.to_string() << "----> CMD_SCAN_CHAIN_FLIP_TMS" << endl;			
      }

      flip_tms = 1;
      DoScanChain(length, nb_bits, buffer_in, buffer_out, flip_tms);
      SendResultToServer(length, buffer_in);
      break;

    case CMD_STOP_SIMU :
      if(DEBUG_INFO){
	t3 = sc_time_stamp();
	cout << t3.to_string() << "----> End of simulation" << endl;		    
      }
      sc_stop();
      break;

    default:
      cout << "Somehow got to the default case in the command case statement." << endl;
      cout << "Command was: " << cmd << endl;
      cout << "Exiting..." << endl;
      sc_stop();
      break;
    }// switch (cmd)

  } // while (1)    
}    //MainThread

// Generation of the TCK signal
void JtagServerSC::GenClk(const int number){

  int i;

  for (i = 0; i < number; i++) {
    wait(TCK_HALF_PERIOD-1, SC_NS); tck = 1;
    wait(TCK_HALF_PERIOD-1, SC_NS); tck = 0;
  }
}


void JtagServerSC::ResetTap(){
  
  sc_time t3;

  if(DEBUG_INFO){
    t3 = sc_time_stamp();
    cout << t3.to_string() << "----> Task reset_tap" << endl;
  }
  //wait(1, SC_NS); 
  tms = 1;
  GenClk(5);
}

void JtagServerSC::GotoRunTestIdle(){
  sc_time t3;
  
  if(DEBUG_INFO){
    t3 = sc_time_stamp();
    cout << t3.to_string() << "Going to Run Test / Idle..." << endl;
  }
  //wait(1, SC_NS); 
  tms = 0;
  GenClk(1);
}

void JtagServerSC::DoTmsSeq(const int length, const int nb_bits, const unsigned char buffer_out[]){

  int i,j;

  int nb_bits_rem;
  int nb_bits_in_this_byte;

  sc_time t3;
  sc_uint<32> data;

  if (DEBUG_INFO){
    t3 = sc_time_stamp();
    cout << t3.to_string() << "Task do_tms_seq" << endl;
  }


  // Number of bits to send in the last byte
  nb_bits_rem = nb_bits % 8;

  for (i = 0; i < length; i = i + 1){
    // If we are in the last byte, we have to send only
    // nb_bits_rem bits. If not, we send the whole byte.
    nb_bits_in_this_byte = (i == (length - 1)) ? nb_bits_rem : 8;

    data = buffer_out[i];
    for (j = 0; j < nb_bits_in_this_byte; j = j + 1){
      //wait(1, SC_NS); 
      tms = 0;
      if (data[j] == 1) {
	//wait(1, SC_NS); 
	tms = 1;
      }
      GenClk(1);
    }
  }
  //wait(1, SC_NS); 
  tms = 0;
} //DoTmsSeq


void JtagServerSC::DoScanChain(const int length, const int nb_bits, unsigned char buffer_in[], const unsigned char buffer_out[], const bool flip_tms) {

  int		bit;
  int		nb_bits_rem;
  int		nb_bits_in_this_byte;
  int		index;

  sc_uint<32>           data_in, data_out;
  sc_time       t3;

  if (DEBUG_INFO){
    t3 = sc_time_stamp();
    cout << t3.to_string() << "Task do_scan_chain" << endl;
  }

  // Number of bits to send in the last byte
  nb_bits_rem = nb_bits % 8;

  for (index = 0; index < length; index = index + 1){
      // If we are in the last byte, we have to send only
      // nb_bits_rem bits if it's not zero.
      // If not, we send the whole byte.
      nb_bits_in_this_byte = (index == (length - 1)) ? ((nb_bits_rem == 0) ? 8 : nb_bits_rem) : 8;

      data_out = buffer_out[index];
      for (bit = 0; bit < nb_bits_in_this_byte; bit = bit + 1){
	tdi = 0;
	if (data_out[bit] == 1)
	  tdi = 1;
	// On the last bit, set TMS to '1'
	if (((bit == (nb_bits_in_this_byte - 1)) && (index == (length - 1))) && (flip_tms == 1))
	  tms = 1;

	wait(TCK_HALF_PERIOD-1, SC_NS); tck = 1;
	data_in[bit] = tdo;
	wait(TCK_HALF_PERIOD-1, SC_NS); tck = 0;
      }
     
      buffer_in[index] = data_in;
  }
      tdi = 0;
      tms = 0;
}// DoScanChain
