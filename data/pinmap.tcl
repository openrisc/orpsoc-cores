# Main system clock (50 Mhz)
create_clock -name "sys_clk_pad_i" -period 20.000ns [get_ports {sys_clk_pad_i}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty
