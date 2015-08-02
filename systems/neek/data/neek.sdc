# Constrain clock port clk with a 20-ns requirement

create_clock -name {clock_50_pad_i} -period 20 [get_ports clock_50_pad_i]
create_clock -name {eth0_rx_clk_pad_i} -period 40 [get_ports eth0_rx_clk_pad_i]
create_clock -name {eth0_tx_clk_pad_i} -period 40 [get_ports eth0_tx_clk_pad_i]

# Automatically apply a generate clock on the output of phase-locked loops (PLLs)
# This command can be safely left in the SDC even if no PLLs exist in the design

derive_pll_clocks

# Create altera_reserved_tck clock

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}]
set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}]

set_clock_groups -asynchronous -group [get_clocks {eth0_rx_clk_pad_i}]
set_clock_groups -asynchronous -group [get_clocks {eth0_tx_clk_pad_i}]

#                                                            ####wb_clk ####                           ##### sdram_clk ####
set_clock_groups -logically_exclusive -group [get_clocks {clkgen0|pll0|*|clk[0]}] -group [get_clocks {ddr_ctrl_ip|*|pll1|clk[1]}]
