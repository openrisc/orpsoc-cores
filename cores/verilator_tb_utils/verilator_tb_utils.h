#ifndef __VERILATOR_TB_UTILS_H__
#define __VERILATOR_TB_UTILS_H__

#include <stdint.h>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "jtagServer.h"

extern struct argp verilator_tb_utils_argp;

class VerilatorTbUtils {
public:
  VerilatorTbUtils(uint32_t *mem);
  ~VerilatorTbUtils();

  VerilatedVcdC* tfp;

  VerilatorJtagServer* jtag;

  bool doCycle();

  bool doJTAG(uint8_t *tms, uint8_t *tdi, uint8_t *tck, uint8_t tdo);

  uint64_t getTime() { return t; }

  uint64_t getTimeout() { return timeout; }
  bool getVcdDump() { return vcdDump; }
  uint64_t getVcdDumpStart() { return vcdDumpStart; }
  uint64_t getVcdDumpStop() { return vcdDumpStop; }
  char *getVcdFileName() { return vcdFileName; }

  bool getJtagEnable() { return jtagEnable; }
  int getJtagPort() { return jtagPort; }

  static int parseOpts(int key, char *arg, struct argp_state *state);

private:
  uint64_t t;

  uint64_t timeout;

  bool vcdDump;
  uint64_t vcdDumpStart;
  uint64_t vcdDumpStop;
  char *vcdFileName;
  bool vcdDumping;

  bool jtagEnable;
  int jtagPort;

  uint32_t *mem;

  bool loadElf(char *fileName);
  bool loadBin(char *fileName);
};

#endif
