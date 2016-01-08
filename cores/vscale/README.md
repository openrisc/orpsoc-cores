vscale
======

Verilog Implementation of the RISC-V ISA.

Quick start
-----------

rv32 binaries converted to hex files can be loaded directly into the simulator. To launch an Icarus verilog simulation with a preloaded hex file run:
`fusesoc sim vscale --loadmem=/path/to/file.hex`

If you want to run many testcases without recompiling the verilog between each testcase run the following commands:
```
fusesoc sim --build-only vscale
for f in /path/to/testcases/*hex; do fusesoc sim --keep vscale --loadmem=$f; done```

