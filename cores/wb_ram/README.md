wb_ram
======

wb_ram is a generic memory that is intended to map against on-chip RAM or registers. It is currently hard coded to use 32 bits and has a Wishbone B3 interface for burst accesses

Parameters
----------

Name  | Description          | Default value             |
----- | -------------------- | ------------------------- |
dw    | Wishbone data width  | 32 (only supported value) |
depth | Memory size in bytes | 256                       |
aw    | Address width        | clog2(depth)              |

Test bench
----------
wb_ram comes with a self-checking test bench that uses the [wb_bfm_transactor](../wb_bfm/wb_bfm_transactor.v) from [wb_bfm](../wb_bfm).

TODO
----

- Make width configurable
- Add technology-specific backends
- Move wb_funcs to common wishbone utilities
- Only allow wrap bursts less than memory size
