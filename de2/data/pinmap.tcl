# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II 32-bit Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition
# File: /home/pe/projects/openrisc/build/de1/bld-quartus/de1.tcl
# Generated on: Sun May  3 16:59:07 2015

package require ::quartus::project

set_location_assignment PIN_W26 -to rst_n_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to rst_n_pad_i
set_location_assignment PIN_N2 -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_clk_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_cmd_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_dat_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_dat3_pad_o
set_location_assignment PIN_C25 -to uart0_srx_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_srx_pad_i
set_location_assignment PIN_B25 -to uart0_stx_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_stx_pad_o
set_location_assignment PIN_T6 -to sdram_a_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[0]
set_location_assignment PIN_V4 -to sdram_a_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[1]
set_location_assignment PIN_V3 -to sdram_a_pad_o[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[2]
set_location_assignment PIN_W2 -to sdram_a_pad_o[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[3]
set_location_assignment PIN_W1 -to sdram_a_pad_o[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[4]
set_location_assignment PIN_U6 -to sdram_a_pad_o[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[5]
set_location_assignment PIN_U7 -to sdram_a_pad_o[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[6]
set_location_assignment PIN_U5 -to sdram_a_pad_o[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[7]
set_location_assignment PIN_W4 -to sdram_a_pad_o[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[8]
set_location_assignment PIN_W3 -to sdram_a_pad_o[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[9]
set_location_assignment PIN_Y1 -to sdram_a_pad_o[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[10]
set_location_assignment PIN_V5 -to sdram_a_pad_o[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_a_pad_o[11]
set_location_assignment PIN_V6 -to sdram_dq_pad_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[0]
set_location_assignment PIN_AA2 -to sdram_dq_pad_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[1]
set_location_assignment PIN_AA1 -to sdram_dq_pad_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[2]
set_location_assignment PIN_Y3 -to sdram_dq_pad_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[3]
set_location_assignment PIN_Y4 -to sdram_dq_pad_io[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[4]
set_location_assignment PIN_R8 -to sdram_dq_pad_io[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[5]
set_location_assignment PIN_T8 -to sdram_dq_pad_io[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[6]
set_location_assignment PIN_V7 -to sdram_dq_pad_io[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[7]
set_location_assignment PIN_W6 -to sdram_dq_pad_io[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[8]
set_location_assignment PIN_AB2 -to sdram_dq_pad_io[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[9]
set_location_assignment PIN_AB1 -to sdram_dq_pad_io[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[10]
set_location_assignment PIN_AA4 -to sdram_dq_pad_io[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[11]
set_location_assignment PIN_AA3 -to sdram_dq_pad_io[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[12]
set_location_assignment PIN_AC2 -to sdram_dq_pad_io[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[13]
set_location_assignment PIN_AC1 -to sdram_dq_pad_io[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[14]
set_location_assignment PIN_AA5 -to sdram_dq_pad_io[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dq_pad_io[15]
set_location_assignment PIN_AD2 -to sdram_dqm_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dqm_pad_o[0]
set_location_assignment PIN_Y5 -to sdram_dqm_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_dqm_pad_o[1]
set_location_assignment PIN_AE2 -to sdram_ba_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ba_pad_o[0]
set_location_assignment PIN_AE3 -to sdram_ba_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ba_pad_o[1]
set_location_assignment PIN_AB3 -to sdram_cas_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cas_pad_o
set_location_assignment PIN_AA6 -to sdram_cke_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cke_pad_o
set_location_assignment PIN_AC3 -to sdram_cs_n_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_cs_n_pad_o
set_location_assignment PIN_AB4 -to sdram_ras_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_ras_pad_o
set_location_assignment PIN_AD3 -to sdram_we_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_we_pad_o
set_location_assignment PIN_AA7 -to sdram_clk_pad_o
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sdram_clk_pad_o
set_location_assignment PIN_AE23 -to led_r_pad_o[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[0]
set_location_assignment PIN_AF23 -to led_r_pad_o[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[1]
set_location_assignment PIN_AB21 -to led_r_pad_o[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[2]
set_location_assignment PIN_AC22 -to led_r_pad_o[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[3]
set_location_assignment PIN_AD22 -to led_r_pad_o[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[4]
set_location_assignment PIN_AD23 -to led_r_pad_o[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[5]
set_location_assignment PIN_AD21 -to led_r_pad_o[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[6]
set_location_assignment PIN_AC21 -to led_r_pad_o[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[7]
set_location_assignment PIN_AA14 -to led_r_pad_o[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[8]
set_location_assignment PIN_Y13 -to led_r_pad_o[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to led_r_pad_o[9]
set_location_assignment PIN_D25 -to gpio0_io[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[0]
set_location_assignment PIN_J22 -to gpio0_io[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[1]
set_location_assignment PIN_E26 -to gpio0_io[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[2]
set_location_assignment PIN_E25 -to gpio0_io[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[3]
set_location_assignment PIN_F24 -to gpio0_io[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[4]
set_location_assignment PIN_F23 -to gpio0_io[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[5]
set_location_assignment PIN_J21 -to gpio0_io[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[6]
set_location_assignment PIN_J20 -to gpio0_io[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[7]
set_location_assignment PIN_G26 -to key_pad_i[0]
set_location_assignment PIN_N23 -to key_pad_i[1]
set_location_assignment PIN_P23 -to key_pad_i[2]
set_location_assignment PIN_N25 -to switch_pad_i[0]
set_location_assignment PIN_N26 -to switch_pad_i[1]
set_location_assignment PIN_V2 -to switch_pad_i[17]
set_location_assignment PIN_V1 -to switch_pad_i[16]
set_location_assignment PIN_U4 -to switch_pad_i[15]
set_location_assignment PIN_U3 -to switch_pad_i[14]
set_location_assignment PIN_T7 -to switch_pad_i[13]
set_location_assignment PIN_P2 -to switch_pad_i[12]
set_location_assignment PIN_P1 -to switch_pad_i[11]
set_location_assignment PIN_N1 -to switch_pad_i[10]
set_location_assignment PIN_A13 -to switch_pad_i[9]
set_location_assignment PIN_B13 -to switch_pad_i[8]
set_location_assignment PIN_C13 -to switch_pad_i[7]
set_location_assignment PIN_AC13 -to switch_pad_i[6]
set_location_assignment PIN_AD13 -to switch_pad_i[5]
set_location_assignment PIN_AA13 -to led_r_pad_o[10]
set_location_assignment PIN_AF14 -to switch_pad_i[4]
set_location_assignment PIN_AE14 -to switch_pad_i[3]
set_location_assignment PIN_P25 -to switch_pad_i[2]
set_location_assignment PIN_AD25 -to sd_clk_pad_o
set_location_assignment PIN_AD24 -to sd_dat_pad_i
set_location_assignment PIN_AC23 -to sd_dat3_pad_o
set_location_assignment PIN_Y21 -to sd_cmd_pad_o
set_location_assignment PIN_AD12 -to led_r_pad_o[17]
set_location_assignment PIN_AE12 -to led_r_pad_o[16]
set_location_assignment PIN_AE13 -to led_r_pad_o[15]
set_location_assignment PIN_AF13 -to led_r_pad_o[14]
set_location_assignment PIN_AE15 -to led_r_pad_o[13]
set_location_assignment PIN_AD15 -to led_r_pad_o[12]
set_location_assignment PIN_AC14 -to led_r_pad_o[11]
set_location_assignment PIN_Y12 -to led_g_pad_o[8]
set_location_assignment PIN_Y18 -to led_g_pad_o[7]
set_location_assignment PIN_AA20 -to led_g_pad_o[6]
set_location_assignment PIN_U17 -to led_g_pad_o[5]
set_location_assignment PIN_U18 -to led_g_pad_o[4]
set_location_assignment PIN_V18 -to led_g_pad_o[3]
set_location_assignment PIN_W19 -to led_g_pad_o[2]
set_location_assignment PIN_AF22 -to led_g_pad_o[1]
set_location_assignment PIN_AE22 -to led_g_pad_o[0]
