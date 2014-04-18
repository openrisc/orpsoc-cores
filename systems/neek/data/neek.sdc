# Constrain clock port clk with a 20-ns requirement

create_clock -period 20 [get_ports clock_50_pad_i]
# create_clock -period 40 [get_ports HC_TX_CLK]
# create_clock -period 40 [get_ports HC_RX_CLK]

# Automatically apply a generate clock on the output of phase-locked loops (PLLs)
# This command can be safely left in the SDC even if no PLLs exist in the design

derive_pll_clocks

# Create altera_reserved_tck clock

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}]
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}]

