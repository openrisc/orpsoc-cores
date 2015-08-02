wb_common
======

wb_common is a set of constants and function that can be used for anyone implementing a Wishbone-compatbile device

Files
-----

- wb_common_params.v : Contains Wishbone constants
- wb_common.v : Contains Wishbone utility functions

Functions
---------

- get_cycle_type(cti) : Returns 1 for burst cycles and 0 for classic cycles
- wb_is_last(cti) : Returns 1 for last cycle of a burst or single cycle accesses. Returns 0 if more cycles are expected
- wb_next_adr(adr, cti, bte, dw) : Calculates the next address for incrementing burst accesses. Returns adr for other accesses
