# Main system clock (50 Mhz)
create_clock -name "sys_clk_pad_i" -period 20.000ns [get_ports {sys_clk_pad_i}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty

# Ignore timing on the reset input
# set_false_path -through [get_nets {rst_n_pad_i}]

# Set false paths between wishbone clock and VGA pixel clock
set_false_path -from [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {clkgen0|pll1|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]
set_false_path -from [get_clocks {clkgen0|pll1|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]

# Set false paths between wishbone clock and hps DDR3
set_false_path -from [get_clocks {hps|mem_if_ddr3_emif_0|pll0|pll1~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]
set_false_path -from [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {hps|mem_if_ddr3_emif_0|pll0|pll1~PLL_OUTPUT_COUNTER|divclk}]

# Set false paths between wishbone clock and hps reset logic
set_false_path -from [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {hps|mem_if_ddr3_emif_0|pll0|pll6~PLL_OUTPUT_COUNTER|divclk}]
set_false_path -from [get_clocks {hps|mem_if_ddr3_emif_0|pll0|pll6~PLL_OUTPUT_COUNTER|divclk}] -to [get_clocks {clkgen0|pll0|general[0].gpll~PLL_OUTPUT_COUNTER|divclk}]
