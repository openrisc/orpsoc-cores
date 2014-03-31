#ifndef __VERILATOR_TB_UTILS_H__
#define __VERILATOR_TB_UTILS_H__

#include <verilated.h>
#include <verilated_vcd_c.h>

extern struct argp verilator_tb_utils_argp;

class VerilatorTbUtils {
public:
  VerilatorTbUtils(uint32_t *mem);
  ~VerilatorTbUtils();

  VerilatedVcdC* tfp;

  bool doCycle();

  unsigned long getTime() { return t; }

  unsigned long getTimeout() { return timeout; }
  bool getVcdDump() { return vcdDump; }
  unsigned long getVcdDumpStart() { return vcdDumpStart; }
  unsigned long getVcdDumpStop() { return vcdDumpStop; }
  char *getVcdFileName() { return vcdFileName; }

  bool getRspServerEnable() { return rspServerEnable; }
  int getRspServerPort() { return rspServerPort; }

  static int parseOpts(int key, char *arg, struct argp_state *state);

private:
  unsigned long t;

  unsigned long timeout;

  bool vcdDump;
  unsigned long vcdDumpStart;
  unsigned long vcdDumpStop;
  char *vcdFileName;
  bool vcdDumping;

  bool rspServerEnable;
  int rspServerPort;

  uint32_t *mem;

  bool loadElf(char *fileName);
  bool loadBin(char *fileName);
};

#endif
