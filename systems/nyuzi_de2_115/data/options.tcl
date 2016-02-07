set_global_assignment -name VERILOG_INPUT_VERSION SYSTEMVERILOG_2005
set_global_assignment -name VERILOG_MACRO "VENDOR_ALTERA=1"

# Workaround for synthesis tool crash, solution ID rd11072013_978
set_global_assignment -name AUTO_RAM_BLOCK_BALANCING OFF
