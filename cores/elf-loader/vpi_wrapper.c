/*
 *  VPI wrapper for elf-loader
 *
 *  Copyright (C) 2015  Olof Kindgren <olof.kindgren@gmail.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <stdlib.h>
#include <ctype.h>
#include <vpi_user.h>
#include "elf-loader.h"

//install a callback on simulation reset which calls setup
void setup_reset_callbacks();
//install a callback on simulation compilation finish
void setup_endofcompile_callbacks();
//install a callback on simulation finish
void setup_finish_callbacks();
//callback function which closes and clears the socket file descriptors
// on simulation reset
void sim_reset_callback();
void sim_endofcompile_callback();
void sim_finish_callback();

uint8_t *bin_file;
int size;

void elf_load_file() {
  vpiHandle func_h, args_iter, arg_h;
  struct t_vpi_value argval;

  char *elf_file_name;
  func_h = vpi_handle(vpiSysTfCall, NULL);
  args_iter = vpi_iterate(vpiArgument, func_h);
 

  if(!bin_file) {
    arg_h = vpi_scan(args_iter);
    argval.format = vpiStringVal;
    vpi_get_value(arg_h, &argval);
    elf_file_name = argval.value.str;

    while(isspace(*elf_file_name))
      elf_file_name++;

    bin_file = load_elf_file(elf_file_name, &size);
    if(bin_file)
      vpi_printf("elf-loader: %s was loaded\n", elf_file_name);
    else
      vpi_printf("Error: Failed to load elf file from \"%s\"\n", elf_file_name);
  }
  //vpi_printf("elf_load_file done\n");
}

void elf_get_size() {
  vpiHandle func_h;
  struct t_vpi_value argval;

  if(!bin_file) {
    vpi_printf("Error: $elf_load_file must be called first\n");
    return;
  }
  func_h = vpi_handle(vpiSysTfCall, NULL);

  argval.format = vpiIntVal;
  argval.value.integer = size;
 
  vpi_put_value(func_h, &argval, NULL, vpiNoDelay);
  //vpi_printf("elf_get_size done\n");
}

void elf_read_32() {
  vpiHandle func_h, arg_h, args_iter;
  struct t_vpi_value argval;
  unsigned int address;
  unsigned int data;

  //vpi_printf("elf_read_32 start\n");
  if(!bin_file) {
    vpi_printf("Error: $elf_load_file must be called first\n");
    return;
  }

  func_h = vpi_handle(vpiSysTfCall, NULL);
  args_iter = vpi_iterate(vpiArgument, func_h);
 
  // Grab the value of the first argument
  arg_h = vpi_scan(args_iter);
  argval.format = vpiIntVal;
  vpi_get_value(arg_h, &argval);
  address = argval.value.integer;

  data = read_32(bin_file, address);
  
  argval.value.integer = data;
  vpi_put_value(func_h, &argval, NULL, vpiNoDelay);
  vpi_free_object(args_iter);
  //vpi_printf("elf_read_32 done\n");
}

void elf_read_16() {
  vpiHandle func_h, arg_h, args_iter;
  struct t_vpi_value argval;
  unsigned int address;
  unsigned short data;

  if(!bin_file) {
    vpi_printf("Error: $elf_load_file must be called first\n");
    return;
  }

  func_h = vpi_handle(vpiSysTfCall, NULL);
  args_iter = vpi_iterate(vpiArgument, func_h);
 
  // Grab the value of the first argument
  arg_h = vpi_scan(args_iter);
  argval.format = vpiIntVal;
  vpi_get_value(arg_h, &argval);
  address = argval.value.integer;

  data = read_16(bin_file, address);
  
  argval.value.integer = data;
  vpi_put_value(func_h, &argval, NULL, vpiNoDelay);
  vpi_free_object(args_iter);
  //vpi_printf("elf_read_16 done\n");
}

void setup_user_functions() {
  s_vpi_systf_data task_data_s;
  p_vpi_systf_data task_data_p = &task_data_s;

  task_data_p->type = vpiSysTask;
  task_data_p->sysfunctype = vpiIntFunc;
  task_data_p->tfname = "$elf_load_file";
  task_data_p->calltf = (void *)elf_load_file;
  task_data_p->sizetf = 0;
  task_data_p->compiletf = 0;

  vpi_register_systf(task_data_p);

  task_data_p->type = vpiSysFunc;
  task_data_p->tfname = "$elf_get_size";
  task_data_p->calltf = (void *)elf_get_size;
  task_data_p->compiletf = 0;

  vpi_register_systf(task_data_p);

  task_data_p->type = vpiSysFunc;
  task_data_p->tfname = "$elf_read_32";
  task_data_p->calltf = (void *)elf_read_32;
  task_data_p->compiletf = 0;

  vpi_register_systf(task_data_p);

  task_data_p->type = vpiSysFunc;
  task_data_p->tfname = "$elf_read_16";
  task_data_p->calltf = (void *)elf_read_16;
  task_data_p->compiletf = 0;

  vpi_register_systf(task_data_p);

}  

void setup_reset_callbacks()
{

  // here we setup and install callbacks for
  // the setup and management of connections to
  // the simulator upon simulation start and
  // reset

  static s_vpi_time time_s = {vpiScaledRealTime};
  static s_vpi_value value_s = {vpiBinStrVal};
  static s_cb_data cb_data_s =
    {
      cbEndOfReset, // or start of simulation - initing socket fds etc
      (void *)sim_reset_callback,
      NULL,
      &time_s,
      &value_s
    };

  cb_data_s.obj = NULL;  /* trigger object */

  cb_data_s.user_data = NULL;

  // actual call to register the callback
  vpi_register_cb(&cb_data_s);

}

void sim_reset_callback()
{

  // nothing to do!

  return;

}

void setup_endofcompile_callbacks()
{

  // here we setup and install callbacks for
  // simulation finish

  static s_vpi_time time_s = {vpiScaledRealTime};
  static s_vpi_value value_s = {vpiBinStrVal};
  static s_cb_data cb_data_s =
    {
      cbEndOfCompile, // end of compile
      (void *)sim_endofcompile_callback,
      NULL,
      &time_s,
      &value_s
    };

  cb_data_s.obj = NULL;  /* trigger object */

  cb_data_s.user_data = NULL;

  // actual call to register the callback
  vpi_register_cb(&cb_data_s);

}

void sim_endofcompile_callback()
{
  return;
}


void setup_finish_callbacks()
{

  // here we setup and install callbacks for
  // simulation finish

  static s_vpi_time time_s = {vpiScaledRealTime};
  static s_vpi_value value_s = {vpiBinStrVal};
  static s_cb_data cb_data_s =
    {
      cbEndOfSimulation, // end of simulation
      (void *)sim_finish_callback,
      NULL,
      &time_s,
      &value_s
    };

  cb_data_s.obj = NULL;  /* trigger object */

  cb_data_s.user_data = NULL;

  // actual call to register the callback
  vpi_register_cb(&cb_data_s);

}

void sim_finish_callback()
{
  free(bin_file);
  return;
}


void (*vlog_startup_routines[ ] ) () = {
#ifdef CDS_VPI
  // this installs a callback on simulator reset - something which
  // icarus does not do, so we only do it for cadence currently
  setup_reset_callbacks,
#endif
  setup_endofcompile_callbacks,
  setup_finish_callbacks,
  setup_user_functions,
  0  // last entry must be 0
};
