wb_altera_ddr_wrapper
=====================

This core is heavily based on Stefan Kristiansson SDRAM controller with multiple whisbone slave ports (https://github.com/skristiansson/wb_sdram_ctrl).

It has some small changes in the arbiter and whisbone port modules to fit our needs.
The wb_sdram_ctrl module is replaced with a wrapper to connect wishbone ports (wb_port.v) to the Altera DDR controller IP.

This design has been tested with a 32MB - 16 bits wide DDR device (PSCA2S56D40CTP-G5).
The wrapper only supports local interface width of 32 bits (in the tested configuration, the local interface is running at full data rate).

Controllers settings for the tested device are:
 - Enable Auto-Precharge Control,
 - Enable Reordering with starvation limit for each command (10),
 - Local-to-Memory Address Mapping CHIP-BANK-ROW-COL,
 - Command Queue Look-Ahead Depth (8)
 - Local Maximum Burst Count (64).
