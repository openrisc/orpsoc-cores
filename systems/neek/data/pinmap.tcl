# Clock / Reset
set_location_assignment PIN_V9 -to clock_50_pad_i
set_location_assignment PIN_N2 -to reset_n_pad_i

# LCD
set_location_assignment PIN_R4  -to lcd_data_pad_o[0]
set_location_assignment PIN_T17 -to lcd_data_pad_o[1]
set_location_assignment PIN_T18 -to lcd_data_pad_o[2]
set_location_assignment PIN_L16 -to lcd_data_pad_o[3]
set_location_assignment PIN_M17 -to lcd_data_pad_o[4]
set_location_assignment PIN_N6  -to lcd_data_pad_o[5]
set_location_assignment PIN_M13 -to lcd_data_pad_o[6]
set_location_assignment PIN_N13 -to lcd_data_pad_o[7]
set_location_assignment PIN_D14 -to pixel_clock_pad_o
set_location_assignment PIN_R17 -to blank_n_pad_o
set_location_assignment PIN_M14 -to hsync_n_pad_o
set_location_assignment PIN_L13 -to vsync_n_pad_o
set_location_assignment PIN_R18 -to lcd_rst_n_pad_o
set_location_assignment PIN_M6 -to lcd_scen_pad_o
set_location_assignment PIN_V18 -to lcd_scl_pad_o
set_location_assignment PIN_T2 -to lcd_sda_pad_io

# VGA
set_location_assignment PIN_K17 -to vga_data_pad_o[0]
set_location_assignment PIN_P11 -to vga_data_pad_o[1]
set_location_assignment PIN_B2 -to vga_data_pad_o[2]
set_location_assignment PIN_B1 -to vga_data_pad_o[3]
set_location_assignment PIN_G2 -to vga_data_pad_o[4]
set_location_assignment PIN_G1 -to vga_data_pad_o[5]
set_location_assignment PIN_K2 -to vga_data_pad_o[6]
set_location_assignment PIN_K1 -to vga_data_pad_o[7]
set_location_assignment PIN_L2 -to vga_data_pad_o[8]
set_location_assignment PIN_L1 -to vga_data_pad_o[9]
set_location_assignment PIN_C14 -to vga_clock_pad_o
set_location_assignment PIN_H15 -to vga_hsync_pad_o
set_location_assignment PIN_J13 -to vga_vsync_pad_o
set_location_assignment PIN_N10 -to vga_blank_pad_o
set_location_assignment PIN_N11 -to vga_sync_pad_o


# DDR
set_location_assignment PIN_V8 -to ddr_dm_pad_o[1]
set_location_assignment PIN_V3 -to ddr_dm_pad_o[0]
set_location_assignment PIN_V14 -to ddr_dq_pad_io[15]
set_location_assignment PIN_P10 -to ddr_dq_pad_io[14]
set_location_assignment PIN_R11 -to ddr_dq_pad_io[13]
set_location_assignment PIN_U14 -to ddr_dq_pad_io[12]
set_location_assignment PIN_V15 -to ddr_dq_pad_io[11]
set_location_assignment PIN_U11 -to ddr_dq_pad_io[10]
set_location_assignment PIN_U12 -to ddr_dq_pad_io[9]
set_location_assignment PIN_U13 -to ddr_dq_pad_io[8]
set_location_assignment PIN_V7 -to ddr_dq_pad_io[7]
set_location_assignment PIN_V6 -to ddr_dq_pad_io[6]
set_location_assignment PIN_U6 -to ddr_dq_pad_io[5]
set_location_assignment PIN_P9 -to ddr_dq_pad_io[4]
set_location_assignment PIN_V5 -to ddr_dq_pad_io[3]
set_location_assignment PIN_R8 -to ddr_dq_pad_io[2]
set_location_assignment PIN_V4 -to ddr_dq_pad_io[1]
set_location_assignment PIN_U4 -to ddr_dq_pad_io[0]
set_location_assignment PIN_T8 -to ddr_dqs_pad_io[1]
set_location_assignment PIN_U3 -to ddr_dqs_pad_io[0]
set_location_assignment PIN_U16 -to ddr_a_pad_o[12]
set_location_assignment PIN_V17 -to ddr_a_pad_o[11]
set_location_assignment PIN_U17 -to ddr_a_pad_o[10]
set_location_assignment PIN_V13 -to ddr_a_pad_o[9]
set_location_assignment PIN_T13 -to ddr_a_pad_o[8]
set_location_assignment PIN_T14 -to ddr_a_pad_o[7]
set_location_assignment PIN_P6 -to ddr_a_pad_o[6]
set_location_assignment PIN_P7 -to ddr_a_pad_o[5]
set_location_assignment PIN_P8 -to ddr_a_pad_o[4]
set_location_assignment PIN_U8 -to ddr_a_pad_o[3]
set_location_assignment PIN_U7 -to ddr_a_pad_o[2]
set_location_assignment PIN_U5 -to ddr_a_pad_o[1]
set_location_assignment PIN_U1 -to ddr_a_pad_o[0]
set_location_assignment PIN_V12 -to ddr_ba_pad_o[1]
set_location_assignment PIN_V11 -to ddr_ba_pad_o[0]
set_location_assignment PIN_T4 -to ddr_cas_n_pad_o
set_location_assignment PIN_R13 -to ddr_cke_pad_o
set_location_assignment PIN_U2 -to ddr_clk_pad_o
set_location_assignment PIN_V2 -to ddr_clk_n_pad_o
set_location_assignment PIN_V1 -to ddr_cs_n_pad_o
set_location_assignment PIN_V16 -to ddr_ras_n_pad_o
set_location_assignment PIN_U15 -to ddr_we_n_pad_o

# Flash / SSRAM
set_location_assignment PIN_E2 -to flash_ce_n_pad_o
set_location_assignment PIN_D17 -to flash_oe_n_pad_o
set_location_assignment PIN_D18 -to flash_we_n_pad_o
set_location_assignment PIN_C18 -to flash_adr_pad_o[22]
set_location_assignment PIN_C17 -to flash_adr_pad_o[21]
set_location_assignment PIN_B18 -to flash_adr_pad_o[20]
set_location_assignment PIN_A6 -to flash_adr_pad_o[19]
set_location_assignment PIN_A7 -to flash_adr_pad_o[18]
set_location_assignment PIN_D9 -to flash_adr_pad_o[17]
set_location_assignment PIN_C9 -to flash_adr_pad_o[16]
set_location_assignment PIN_E10 -to flash_adr_pad_o[15]
set_location_assignment PIN_D10 -to flash_adr_pad_o[14]
set_location_assignment PIN_C10 -to flash_adr_pad_o[13]
set_location_assignment PIN_B11 -to flash_adr_pad_o[12]
set_location_assignment PIN_A11 -to flash_adr_pad_o[11]
set_location_assignment PIN_B12 -to flash_adr_pad_o[10]
set_location_assignment PIN_A12 -to flash_adr_pad_o[9]
set_location_assignment PIN_B13 -to flash_adr_pad_o[8]
set_location_assignment PIN_A13 -to flash_adr_pad_o[7]
set_location_assignment PIN_B14 -to flash_adr_pad_o[6]
set_location_assignment PIN_A14 -to flash_adr_pad_o[5]
set_location_assignment PIN_B15 -to flash_adr_pad_o[4]
set_location_assignment PIN_A15 -to flash_adr_pad_o[3]
set_location_assignment PIN_B16 -to flash_adr_pad_o[2]
set_location_assignment PIN_A16 -to flash_adr_pad_o[1]
set_location_assignment PIN_E12 -to flash_adr_pad_o[0]

set_location_assignment PIN_B6 -to flash_dq_pad_io[15]
set_location_assignment PIN_A5 -to flash_dq_pad_io[14]
set_location_assignment PIN_B5 -to flash_dq_pad_io[13]
set_location_assignment PIN_D5 -to flash_dq_pad_io[12]
set_location_assignment PIN_B3 -to flash_dq_pad_io[11]
set_location_assignment PIN_A3 -to flash_dq_pad_io[10]
set_location_assignment PIN_E7 -to flash_dq_pad_io[9]
set_location_assignment PIN_B4 -to flash_dq_pad_io[8]
set_location_assignment PIN_A4 -to flash_dq_pad_io[7]
set_location_assignment PIN_E8 -to flash_dq_pad_io[6]
set_location_assignment PIN_C5 -to flash_dq_pad_io[5]
set_location_assignment PIN_B7 -to flash_dq_pad_io[4]
set_location_assignment PIN_B8 -to flash_dq_pad_io[3]
set_location_assignment PIN_A8 -to flash_dq_pad_io[2]
set_location_assignment PIN_D1 -to flash_dq_pad_io[1]
set_location_assignment PIN_H3 -to flash_dq_pad_io[0]

set_location_assignment PIN_H4 -to flash_clk_pad_o
set_location_assignment PIN_H14 -to flash_adv_n_pad_o
set_location_assignment PIN_C3 -to flash_rst_n_pad_o
set_location_assignment PIN_H13 -to flash_wait_pad_i

# UART
set_location_assignment PIN_E18 -to uart_rx_pad_i
set_location_assignment PIN_H17 -to uart_tx_pad_o

# Ethernet
set_location_assignment PIN_H18 -to eth0_rst_n_pad_o
set_location_assignment PIN_P18 -to eth0_mdc_pad_o
set_location_assignment PIN_N7 -to eth0_md_pad_io
set_location_assignment PIN_F17 -to eth0_rx_clk_pad_i
set_location_assignment PIN_G17 -to eth0_col_pad_i
set_location_assignment PIN_L3 -to eth0_crs_pad_i
set_location_assignment PIN_R3 -to eth0_rx_data_pad_i[3]
set_location_assignment PIN_T3 -to eth0_rx_data_pad_i[2]
set_location_assignment PIN_P1 -to eth0_rx_data_pad_i[1]
set_location_assignment PIN_P2 -to eth0_rx_data_pad_i[0]
set_location_assignment PIN_G18 -to eth0_rx_dv_pad_i
set_location_assignment PIN_L4 -to eth0_rx_err_pad_i
set_location_assignment PIN_N18 -to eth0_tx_clk_pad_i
set_location_assignment PIN_P17 -to eth0_tx_data_pad_o[3]
set_location_assignment PIN_L15 -to eth0_tx_data_pad_o[2]
set_location_assignment PIN_L14 -to eth0_tx_data_pad_o[1]
set_location_assignment PIN_M18 -to eth0_tx_data_pad_o[0]
set_location_assignment PIN_L17 -to eth0_tx_en_pad_o

# SPI (SDCARD)
set_location_assignment PIN_M3 -to spi0_miso_pad_i
set_location_assignment PIN_L6 -to spi0_mosi_pad_o
set_location_assignment PIN_M2 -to spi0_sck_pad_o
set_location_assignment PIN_N8 -to spi0_ss_pad_o

# LEDs
# set_location_assignment PIN_P13 -to led_debug_pad_o[0]
# set_location_assignment PIN_N12 -to led_debug_pad_o[2]
# set_location_assignment PIN_N9 -to led_debug_pad_o[3]

# Fitter Assignments

set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_clk_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_clk_n_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_cs_n_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_cke_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[2]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[3]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[4]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[5]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[6]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[7]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[8]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_a_pad_o[12]

set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_ba_pad_o[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_ba_pad_o[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_ras_n_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_cas_n_pad_o
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to ddr_we_n_pad_o

set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[2]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[3]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[4]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[5]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[6]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[7]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[8]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[9]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[10]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[11]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[12]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[13]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[14]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dq_pad_io[15]

set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dqs_pad_io[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dqs_pad_io[1]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dm_pad_o[0]
set_instance_assignment -name CURRENT_STRENGTH_NEW 12MA -to ddr_dm_pad_o[1]

set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "2.5 V"
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dm_pad_o[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dm_pad_o[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[15]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[14]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[13]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[12]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[11]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[10]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[9]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[8]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[7]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[6]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[5]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[4]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[3]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[2]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dq_pad_io[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dqs_pad_io[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_dqs_pad_io[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[12]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[11]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[10]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[9]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[8]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[7]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[6]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[5]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[4]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[3]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[2]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_a_pad_o[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_ba_pad_o[1]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_ba_pad_o[0]
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_cas_n_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_cke_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_clk_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_clk_n_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_cs_n_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_ras_n_pad_o
set_instance_assignment -name IO_STANDARD "SSTL-2 CLASS I" -to ddr_we_n_pad_o

set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dm_pad_o[1]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dm_pad_o[0]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[15]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[14]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[13]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[12]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[11]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[10]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[9]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[8]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[7]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[6]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[5]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[4]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[3]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[2]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[1]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dq_pad_io[0]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dqs_pad_io[1]
set_instance_assignment -name OUTPUT_ENABLE_GROUP 1 -to ddr_dqs_pad_io[0]
