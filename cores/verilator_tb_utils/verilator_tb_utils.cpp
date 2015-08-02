#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <argp.h>
#include <elf-loader/elf-loader.h>
#include "verilator_tb_utils.h"
#include "jtagServer.h"

#define VCD_DEFAULT_NAME "../sim.vcd"

VerilatorTbUtils::VerilatorTbUtils(uint32_t *mem)
  : mem(mem), t(0), timeout(0), vcdDump(false), vcdDumpStart(0), vcdDumpStop(0),
    vcdFileName((char *)VCD_DEFAULT_NAME), jtagEnable(false),
    jtagPort(5555) {
  tfp = new VerilatedVcdC;
  jtag = new VerilatorJtagServer(10); /* Jtag clock is 10 period */

  Verilated::traceEverOn(true);
}

VerilatorTbUtils::~VerilatorTbUtils() {
    if (vcdDumping)
      tfp->close();
}

bool VerilatorTbUtils::doJTAG(uint8_t *tms, uint8_t *tdi, uint8_t *tck, uint8_t tdo) {
  if (jtagEnable)
    jtag->doJTAG(t, tms, tdi, tck, tdo);
  return true;
}

bool VerilatorTbUtils::doCycle() {
  if (vcdDumpStop && t >= vcdDumpStop) {
    if (vcdDumping) {
      printf("VCD dump stopped (%lu)\n", t);
      tfp->close();
    }
    vcdDumping = false;
  } else if (vcdDump && t >= vcdDumpStart) {
    if (!vcdDumping) {
      printf("VCD dump started (%lu)\n", t);
      tfp->open(vcdFileName);
    }
    vcdDumping = true;
  }

  if (vcdDumping)
    tfp->dump((vluint64_t)t);

  if(timeout && t >= timeout) {
    printf("Timeout reached\n");
    return false;
  }

  if (Verilated::gotFinish()) {
    printf("Caught $finish()\n");
    return false;
  }

  t++;
  return true;
}

bool VerilatorTbUtils::loadElf(char *fileName) {
  uint8_t *bin_data;
  int size;

  printf("Loading %s\n", fileName);
  bin_data = load_elf_file(fileName, &size);
  if (bin_data == NULL) {
    printf("Error loading elf file\n");
    return false;
  }

  for (int i = 0; i < size; i += 4)
    this->mem[i/4] = read_32(bin_data, i);

  free(bin_data);

  return true;
}

bool VerilatorTbUtils::loadBin(char *fileName) {
  uint8_t *bin_data;
  int size;
  FILE *bin_file = fopen(fileName, "rb");

  printf("Loading %s\n", fileName);

  if (bin_file == NULL) {
    printf("Error opening bin file\n");
    return false;
  }
  fseek(bin_file, 0, SEEK_END);
  size = ftell(bin_file);
  rewind(bin_file);
  bin_data = (uint8_t *)malloc(size);
  if (fread(bin_data, 1, size, bin_file) != size) {
    printf("Error reading bin file\n");
    return false;
  }

  for (int i=0; i < size; i+=4)
    this->mem[i/4] = read_32(bin_data, i);

  free(bin_data);

  return true;
}

#define OPT_TIMEOUT 512
#define OPT_ELFLOAD 513
#define OPT_BINLOAD 514

static struct argp_option options[] = {
  { 0, 0, 0, 0, "Simulation control:", 1 },
  { "timeout", OPT_TIMEOUT, "VAL", 0, "Stop the sim at VAL" },
  { "elf-load", OPT_ELFLOAD, "FILE", 0, "Load program from ELF FILE" },
  { "bin-load", OPT_BINLOAD, "FILE", 0, "Load program from binary FILE" },
  { 0, 0, 0, 0, "VCD generation:", 2 },
  { "vcd", 'v', "FILE", OPTION_ARG_OPTIONAL, "Enable and save VCD to FILE" },
  { "vcdstart", 's', "VAL", 0, "Delay VCD generation until VAL" },
  { "vcdstop", 't', "VAL", 0, "Terminate VCD generation at VAL" },
  { 0, 0, 0, 0, "Remote debugging:", 3 },
  { "jtag-server", 'j', "PORT", OPTION_ARG_OPTIONAL, "Enable openocd JTAG server, opt. specify PORT" },
  { 0 },
};

struct argp verilator_tb_utils_argp = {options, VerilatorTbUtils::parseOpts,
                                       0, 0};

int VerilatorTbUtils::parseOpts(int key, char *arg, struct argp_state *state) {
  VerilatorTbUtils *tbUtils = static_cast<VerilatorTbUtils *>(state->input);

  switch (key) {
  case OPT_TIMEOUT:
    tbUtils->timeout = strtol(arg, NULL, 10);
    break;

  case OPT_ELFLOAD:
    tbUtils->loadElf(arg);
    break;

  case OPT_BINLOAD:
    tbUtils->loadBin(arg);
    break;

  case 'v':
    tbUtils->vcdDump = true;
    if (arg)
      tbUtils->vcdFileName = arg;
    break;

  case 's':
    tbUtils->vcdDumpStart = strtol(arg, NULL, 10);
    break;

  case 't':
    tbUtils->vcdDumpStop = strtol(arg, NULL, 10);
    break;

  case 'j':
      tbUtils->jtagEnable = true;
      if (arg)
        tbUtils->jtagPort = atoi(arg);
      tbUtils->jtag->init_jtag_server(tbUtils->jtagPort);
    break;

  default:
    return ARGP_ERR_UNKNOWN;
  }

  return 0;
}
