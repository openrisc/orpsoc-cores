#
# Clock / Reset
#
set_location_assignment PIN_AD27 -to rst_n_pad_i
set_location_assignment PIN_AF14 -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "1.5 V" -to sys_clk_pad_i
set_location_assignment PIN_AA16 -to fpga_ddr3_ref_clk_pad_i
set_instance_assignment -name IO_STANDARD "1.5 V" -to fpga_ddr3_ref_clk_pad_i

#
# GPIO
#
# gpio0_io[3:0] connected to leds
set_location_assignment PIN_AF10 -to gpio0_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[0]
set_location_assignment PIN_AD10 -to gpio0_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[1]
set_location_assignment PIN_AE11 -to gpio0_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[2]
set_location_assignment PIN_AD7 -to gpio0_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[3]
#set_location_assignment PIN_xxx -to gpio0_io[4]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[4]
#set_location_assignment PIN_xxx -to gpio0_io[5]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[5]
#set_location_assignment PIN_xxx -to gpio0_io[6]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[6]
#set_location_assignment PIN_xxx -to gpio0_io[7]
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[7]

#
# AUDIO (I2S and I2C)
#

set_location_assignment PIN_AF30 -to i2c0_sda_io
set_location_assignment PIN_AH30 -to i2c0_scl_io
set_location_assignment PIN_AC9 -to i2s0_mclk
set_location_assignment PIN_AE7 -to i2s0_sclk
set_location_assignment PIN_AG3 -to i2s0_tx_sdata
set_location_assignment PIN_AH4 -to i2s0_tx_lrclk
#set_location_assignment PIN_AC27 -to i2s0_rx_sdata
#set_location_assignment PIN_AG30 -to i2s0_rx_lrclk
set_location_assignment PIN_AD26 -to mute_n

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2c0_sda_io
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2c0_scl_io
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_mclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_sclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_tx_sdata
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_tx_lrclk
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_rx_sdata
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i2s0_rx_lrclk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to mute_n

#
# VGA
#
set_location_assignment PIN_W20 -to vga0_clk_pad_o
set_location_assignment PIN_AD12 -to vga0_hsync_pad_o
set_location_assignment PIN_AC12 -to vga0_vsync_pad_o
set_location_assignment PIN_AG2 -to vga0_csync_n_pad_o
set_location_assignment PIN_AH3 -to vga0_blank_n_pad_o
set_location_assignment PIN_AG5 -to vga0_r_pad_o[0]
set_location_assignment PIN_AA12 -to vga0_r_pad_o[1]
set_location_assignment PIN_AB12 -to vga0_r_pad_o[2]
set_location_assignment PIN_AF6 -to vga0_r_pad_o[3]
set_location_assignment PIN_AG6 -to vga0_r_pad_o[4]
set_location_assignment PIN_AJ2 -to vga0_r_pad_o[5]
set_location_assignment PIN_AH5 -to vga0_r_pad_o[6]
set_location_assignment PIN_AJ1 -to vga0_r_pad_o[7]
set_location_assignment PIN_Y21 -to vga0_g_pad_o[0]
set_location_assignment PIN_AA25 -to vga0_g_pad_o[1]
set_location_assignment PIN_AB26 -to vga0_g_pad_o[2]
set_location_assignment PIN_AB22 -to vga0_g_pad_o[3]
set_location_assignment PIN_AB23 -to vga0_g_pad_o[4]
set_location_assignment PIN_AA24 -to vga0_g_pad_o[5]
set_location_assignment PIN_AB25 -to vga0_g_pad_o[6]
set_location_assignment PIN_AE27 -to vga0_g_pad_o[7]
set_location_assignment PIN_AE28 -to vga0_b_pad_o[0]
set_location_assignment PIN_Y23 -to vga0_b_pad_o[1]
set_location_assignment PIN_Y24 -to vga0_b_pad_o[2]
set_location_assignment PIN_AG28 -to vga0_b_pad_o[3]
set_location_assignment PIN_AF28 -to vga0_b_pad_o[4]
set_location_assignment PIN_V23 -to vga0_b_pad_o[5]
set_location_assignment PIN_W24 -to vga0_b_pad_o[6]
set_location_assignment PIN_AF29 -to vga0_b_pad_o[7]

set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_clk_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_hsync_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_vsync_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_csync_n_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_blank_n_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_r_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_g_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to vga0_b_pad_o[0]

#
# DDR3 SDRAM (FPGA)
#
set_location_assignment PIN_AJ14 -to fpga_ddr3_mem_a[0]
set_location_assignment PIN_AK14 -to fpga_ddr3_mem_a[1]
set_location_assignment PIN_AH12 -to fpga_ddr3_mem_a[2]
set_location_assignment PIN_AJ12 -to fpga_ddr3_mem_a[3]
set_location_assignment PIN_AG15 -to fpga_ddr3_mem_a[4]
set_location_assignment PIN_AH15 -to fpga_ddr3_mem_a[5]
set_location_assignment PIN_AK12 -to fpga_ddr3_mem_a[6]
set_location_assignment PIN_AK13 -to fpga_ddr3_mem_a[7]
set_location_assignment PIN_AH13 -to fpga_ddr3_mem_a[8]
set_location_assignment PIN_AH14 -to fpga_ddr3_mem_a[9]
set_location_assignment PIN_AJ9 -to fpga_ddr3_mem_a[10]
set_location_assignment PIN_AK9 -to fpga_ddr3_mem_a[11]
set_location_assignment PIN_AK7 -to fpga_ddr3_mem_a[12]
set_location_assignment PIN_AK8 -to fpga_ddr3_mem_a[13]
set_location_assignment PIN_AG12 -to fpga_ddr3_mem_a[14]

set_location_assignment PIN_AH10 -to fpga_ddr3_mem_ba[0]
set_location_assignment PIN_AJ11 -to fpga_ddr3_mem_ba[1]
set_location_assignment PIN_AK11 -to fpga_ddr3_mem_ba[2]

set_location_assignment PIN_AH7 -to fpga_ddr3_mem_cas_n[0]

set_location_assignment PIN_AJ21 -to fpga_ddr3_mem_cke[0]
set_location_assignment PIN_AA15 -to fpga_ddr3_mem_ck_n[0]
set_location_assignment PIN_AA14 -to fpga_ddr3_mem_ck[0]
set_location_assignment PIN_AB15 -to fpga_ddr3_mem_cs_n[0]

set_location_assignment PIN_AH17 -to fpga_ddr3_mem_dm[0]
set_location_assignment PIN_AG23 -to fpga_ddr3_mem_dm[1]
set_location_assignment PIN_AK23 -to fpga_ddr3_mem_dm[2]
set_location_assignment PIN_AJ27 -to fpga_ddr3_mem_dm[3]

set_location_assignment PIN_AF18 -to fpga_ddr3_mem_dq[0]
set_location_assignment PIN_AE17 -to fpga_ddr3_mem_dq[1]
set_location_assignment PIN_AG16 -to fpga_ddr3_mem_dq[2]
set_location_assignment PIN_AF16 -to fpga_ddr3_mem_dq[3]
set_location_assignment PIN_AH20 -to fpga_ddr3_mem_dq[4]
set_location_assignment PIN_AG21 -to fpga_ddr3_mem_dq[5]
set_location_assignment PIN_AJ16 -to fpga_ddr3_mem_dq[6]
set_location_assignment PIN_AH18 -to fpga_ddr3_mem_dq[7]
set_location_assignment PIN_AK18 -to fpga_ddr3_mem_dq[8]
set_location_assignment PIN_AJ17 -to fpga_ddr3_mem_dq[9]
set_location_assignment PIN_AG18 -to fpga_ddr3_mem_dq[10]
set_location_assignment PIN_AK19 -to fpga_ddr3_mem_dq[11]
set_location_assignment PIN_AG20 -to fpga_ddr3_mem_dq[12]
set_location_assignment PIN_AF19 -to fpga_ddr3_mem_dq[13]
set_location_assignment PIN_AJ20 -to fpga_ddr3_mem_dq[14]
set_location_assignment PIN_AH24 -to fpga_ddr3_mem_dq[15]
set_location_assignment PIN_AE19 -to fpga_ddr3_mem_dq[16]
set_location_assignment PIN_AE18 -to fpga_ddr3_mem_dq[17]
set_location_assignment PIN_AG22 -to fpga_ddr3_mem_dq[18]
set_location_assignment PIN_AK22 -to fpga_ddr3_mem_dq[19]
set_location_assignment PIN_AF21 -to fpga_ddr3_mem_dq[20]
set_location_assignment PIN_AF20 -to fpga_ddr3_mem_dq[21]
set_location_assignment PIN_AH23 -to fpga_ddr3_mem_dq[22]
set_location_assignment PIN_AK24 -to fpga_ddr3_mem_dq[23]
set_location_assignment PIN_AF24 -to fpga_ddr3_mem_dq[24]
set_location_assignment PIN_AF23 -to fpga_ddr3_mem_dq[25]
set_location_assignment PIN_AJ24 -to fpga_ddr3_mem_dq[26]
set_location_assignment PIN_AK26 -to fpga_ddr3_mem_dq[27]
set_location_assignment PIN_AE23 -to fpga_ddr3_mem_dq[28]
set_location_assignment PIN_AE22 -to fpga_ddr3_mem_dq[29]
set_location_assignment PIN_AG25 -to fpga_ddr3_mem_dq[30]
set_location_assignment PIN_AK27 -to fpga_ddr3_mem_dq[31]

set_location_assignment PIN_W16 -to fpga_ddr3_mem_dqs_n[0]
set_location_assignment PIN_W17 -to fpga_ddr3_mem_dqs_n[1]
set_location_assignment PIN_AA18 -to fpga_ddr3_mem_dqs_n[2]
set_location_assignment PIN_AD19 -to fpga_ddr3_mem_dqs_n[3]

set_location_assignment PIN_V16 -to fpga_ddr3_mem_dqs[0]
set_location_assignment PIN_V17 -to fpga_ddr3_mem_dqs[1]
set_location_assignment PIN_Y17 -to fpga_ddr3_mem_dqs[2]
set_location_assignment PIN_AC20 -to fpga_ddr3_mem_dqs[3]

set_location_assignment PIN_AE16 -to fpga_ddr3_mem_odt[0]

set_location_assignment PIN_AH8 -to fpga_ddr3_mem_ras_n[0]

set_location_assignment PIN_AK21 -to fpga_ddr3_mem_reset_n[0]

set_location_assignment PIN_AJ6 -to fpga_ddr3_mem_we_n[0]

set_location_assignment PIN_AG17 -to fpga_ddr3_oct_rzqin

set_instance_assignment -name IO_STANDARD "SSTL-15" -to fpga_ddr3_oct_rzqin -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[15] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[15] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[15] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[16] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[16] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[16] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[17] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[17] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[17] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[18] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[18] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[18] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[19] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[19] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[19] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[20] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[20] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[20] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[21] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[21] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[21] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[22] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[22] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[22] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[23] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[23] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[23] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[24] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[24] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[24] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[25] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[25] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[25] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[26] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[26] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[26] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[27] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[27] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[27] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[28] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[28] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[28] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[29] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[29] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[29] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[30] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[30] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[30] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dq[31] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[31] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dq[31] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs_n[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs_n[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_dqs_n[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dqs_n[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_ck[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to fpga_ddr3_mem_ck[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name D5_DELAY 2 -to fpga_ddr3_mem_ck[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to fpga_ddr3_mem_ck_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to fpga_ddr3_mem_ck_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name D5_DELAY 2 -to fpga_ddr3_mem_ck_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_a[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_a[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_ba[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_ba[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_ba[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_ba[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_ba[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_ba[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_cas_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_cas_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_cke[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_cke[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_cs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_cs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_odt[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_odt[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_ras_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_ras_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_we_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_we_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD 1.5V -to fpga_ddr3_mem_reset_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to fpga_ddr3_mem_reset_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dm[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dm[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dm[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dm[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dm[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dm[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to fpga_ddr3_mem_dm[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to fpga_ddr3_mem_dm[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[15] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[16] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[17] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[18] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[19] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[20] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[21] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[22] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[23] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[24] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[25] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[26] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[27] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[28] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[29] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[30] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dq[31] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dm[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dm[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dm[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dm[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs_n[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs_n[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_dqs_n[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[10] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[11] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[12] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[13] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[14] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[4] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[5] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[6] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[7] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[8] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_a[9] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ba[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ba[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ba[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_cas_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_cke[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_cs_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_odt[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ras_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_we_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_reset_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ck[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to fpga_ddr3_mem_ck_n[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL "DUAL-REGIONAL CLOCK" -to hps|mem_if_ddr3_emif_0|pll0|pll_avl_clk -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL "DUAL-REGIONAL CLOCK" -to hps|mem_if_ddr3_emif_0|pll0|pll_config_clk -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|ureset|phy_reset_mem_stable_n -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|ureset|phy_reset_n -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|s0|sequencer_rw_mgr_inst|rw_mgr_inst|rw_mgr_core_inst|rw_soft_reset_n -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uio_pads|dq_ddio[0].read_capture_clk_buffer -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_write_side[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[0] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uio_pads|dq_ddio[1].read_capture_clk_buffer -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_write_side[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[1] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uio_pads|dq_ddio[2].read_capture_clk_buffer -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_write_side[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[2] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uio_pads|dq_ddio[3].read_capture_clk_buffer -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_write_side[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps|mem_if_ddr3_emif_0|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[3] -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name ENABLE_BENEFICIAL_SKEW_OPTIMIZATION_FOR_NON_GLOBAL_CLOCKS ON -to hps|mem_if_ddr3_emif_0 -tag __sockit_mem_if_ddr3_emif_0_p0
set_instance_assignment -name PLL_COMPENSATION_MODE DIRECT -to hps|mem_if_ddr3_emif_0|pll0|fbout -tag __sockit_mem_if_ddr3_emif_0_p0
set_global_assignment -name UNIPHY_SEQUENCER_DQS_CONFIG_ENABLE ON


#
# HPS (Hard Processor System
#
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[1].read_capture_clk_buffer -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[2].read_capture_clk_buffer -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[3].read_capture_clk_buffer -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[3] -entity sockit -tag __hps_sdram_p0


set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D4
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D5
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D6
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_D7
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_STP
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_usb1_inst_NXT
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_uart0_inst_TX
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_uart0_inst_RX
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_IO0
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_IO1
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_IO2
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_IO3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_SS0
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_qspi_inst_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_CLK_IN
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D0
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D1
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D2
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D3
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D4
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D5
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D6
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_D7
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_PWREN
set_instance_assignment -name IO_STANDARD "3.3-V LVCMOS" -to hps_0_hps_io_hps_io_sdio_inst_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim0_inst_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim0_inst_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim0_inst_SS0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim1_inst_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim1_inst_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim1_inst_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim1_inst_SS0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_spim0_inst_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_MDIO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RXD0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RXD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RXD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RXD3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_RX_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TXD0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TXD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TXD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TXD3
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TX_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_TX_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_emac1_inst_MDC
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO09
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO35
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO48
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO53
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO54
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO55
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO56
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO61
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO62
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_gpio_inst_GPIO00
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ba -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_oct_rzqin -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_i2c1_inst_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to hps_0_hps_io_hps_io_i2c1_inst_SCL

set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[4] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[4] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[5] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[5] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[6] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[6] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[7] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[7] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[8] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[8] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[9] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[9] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[10] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[10] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[11] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[11] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[12] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[12] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[13] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[13] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[14] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[14] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[15] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[15] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[16] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[16] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[17] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[17] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[18] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[18] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[19] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[19] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[20] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[20] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[21] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[21] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[22] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[22] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[23] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[23] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[24] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[24] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[25] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[25] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[26] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[26] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[27] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[27] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[28] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[28] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[29] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[29] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[30] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[30] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[31] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[31] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to memory_mem_ck -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to memory_mem_ck_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[10] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[11] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[12] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[13] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[14] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[4] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[5] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[6] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[7] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[8] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[9] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cas_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cke -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cs_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_odt -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ras_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_we_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_reset_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[10] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[11] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[12] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[13] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[14] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[4] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[5] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[6] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[7] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[8] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_a[9] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ba[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ba[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ba[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_cas_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ck -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ck_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_cke -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_cs_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[10] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[11] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[12] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[13] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[14] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[15] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[16] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[17] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[18] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[19] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[20] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[21] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[22] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[23] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[24] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[25] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[26] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[27] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[28] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[29] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[30] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[31] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[4] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[5] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[6] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[7] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[8] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq[9] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n[0] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n[1] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n[2] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n[3] -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_odt -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ras_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_reset_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_we_n -entity sockit -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_mem_stable_n -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|ureset|phy_reset_n -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[0].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[0] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[0] -tag __hps_sdram_p0
set_instance_assignment -name ENABLE_BENEFICIAL_SKEW_OPTIMIZATION_FOR_NON_GLOBAL_CLOCKS ON -to hps_0|hps_io|border|hps_sdram_inst -tag __hps_sdram_p0
set_instance_assignment -name PLL_COMPENSATION_MODE DIRECT -to hps_0|hps_io|border|hps_sdram_inst|pll0|fbout -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[1].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[1] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[1] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[2].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[2] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[2] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uio_pads|dq_ddio[3].read_capture_clk_buffer -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_write_side[3] -tag __hps_sdram_p0
set_instance_assignment -name GLOBAL_SIGNAL OFF -to hps_0|hps_io|border|hps_sdram_inst|p0|umemphy|uread_datapath|reset_n_fifo_wraddress[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[4] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[5] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[6] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[7] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[8] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[9] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[10] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[11] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[12] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[13] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_a[14] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_ba -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ba[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ba[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ba[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_cas_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ck -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ck_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_cke -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_cs_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dm -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dm[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dm[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dm[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dm[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dq -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[4] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[5] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[6] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[7] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[8] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[9] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[10] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[11] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[12] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[13] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[14] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[15] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[16] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[17] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[18] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[19] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[20] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[21] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[22] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[23] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[24] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[25] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[26] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[27] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[28] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[29] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[30] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dq[31] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_mem_dqs_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs_n[0] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs_n[1] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs_n[2] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_dqs_n[3] -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_odt -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_ras_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_reset_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION OFF -to memory_mem_we_n -tag __hps_sdram_p0
set_instance_assignment -name PACKAGE_SKEW_COMPENSATION ON -to memory_oct_rzqin -tag __hps_sdram_p0

# mem io standards
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_oct_rzqin -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[3] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[4] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[4] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[4] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[5] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[5] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[5] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[6] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[6] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[6] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[7] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[7] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[7] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[8] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[8] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[8] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[9] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[9] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[9] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[10] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[10] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[10] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[11] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[11] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[11] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[12] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[12] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[12] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[13] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[13] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[13] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[14] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[14] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[14] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[15] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[15] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[15] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[16] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[16] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[16] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[17] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[17] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[17] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[18] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[18] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[18] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[19] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[19] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[19] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[20] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[20] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[20] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[21] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[21] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[21] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[22] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[22] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[22] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[23] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[23] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[23] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[24] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[24] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[24] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[25] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[25] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[25] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[26] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[26] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[26] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[27] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[27] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[27] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[28] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[28] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[28] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[29] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[29] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[29] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[30] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[30] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[30] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dq[31] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dq[31] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dq[31] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs[3] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs_n[0] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs_n[1] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs_n[2] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_dqs_n[3] -tag __hps_sdram_p0
set_instance_assignment -name INPUT_TERMINATION "PARALLEL 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dqs_n[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_ck -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to memory_mem_ck -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "DIFFERENTIAL 1.5-V SSTL CLASS I" -to memory_mem_ck_n -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITHOUT CALIBRATION" -to memory_mem_ck_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[0] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[10] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[10] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[11] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[11] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[12] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[12] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[13] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[13] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[14] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[14] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[1] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[2] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[3] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[3] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[4] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[4] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[5] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[5] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[6] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[6] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[7] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[7] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[8] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[8] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_a[9] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_a[9] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_ba[0] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_ba[1] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_ba[2] -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ba[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_cas_n -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cas_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_cke -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cke -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_cs_n -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_cs_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_odt -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_odt -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_ras_n -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_ras_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_we_n -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_we_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_reset_n -tag __hps_sdram_p0
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to memory_mem_reset_n -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dm[0] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[0] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dm[1] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[1] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dm[2] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[2] -tag __hps_sdram_p0
set_instance_assignment -name IO_STANDARD "SSTL-15 CLASS I" -to memory_mem_dm[3] -tag __hps_sdram_p0
set_instance_assignment -name OUTPUT_TERMINATION "SERIES 50 OHM WITH CALIBRATION" -to memory_mem_dm[3] -tag __hps_sdram_p0
