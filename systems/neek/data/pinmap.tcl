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
set_location_assignment PIN_E2 -to FLASH_CS_N
set_location_assignment PIN_D17 -to FLASH_OE_N
set_location_assignment PIN_D18 -to FLASH_WR_N
set_location_assignment PIN_C18 -to FLASHSSRAM_ADDR[23]
set_location_assignment PIN_C17 -to FLASHSSRAM_ADDR[22]
set_location_assignment PIN_B18 -to FLASHSSRAM_ADDR[21]
set_location_assignment PIN_A6 -to FLASHSSRAM_ADDR[20]
set_location_assignment PIN_A7 -to FLASHSSRAM_ADDR[19]
set_location_assignment PIN_D9 -to FLASHSSRAM_ADDR[18]
set_location_assignment PIN_C9 -to FLASHSSRAM_ADDR[17]
set_location_assignment PIN_E10 -to FLASHSSRAM_ADDR[16]
set_location_assignment PIN_D10 -to FLASHSSRAM_ADDR[15]
set_location_assignment PIN_C10 -to FLASHSSRAM_ADDR[14]
set_location_assignment PIN_B11 -to FLASHSSRAM_ADDR[13]
set_location_assignment PIN_A11 -to FLASHSSRAM_ADDR[12]
set_location_assignment PIN_B12 -to FLASHSSRAM_ADDR[11]
set_location_assignment PIN_A12 -to FLASHSSRAM_ADDR[10]
set_location_assignment PIN_B13 -to FLASHSSRAM_ADDR[9]
set_location_assignment PIN_A13 -to FLASHSSRAM_ADDR[8]
set_location_assignment PIN_B14 -to FLASHSSRAM_ADDR[7]
set_location_assignment PIN_A14 -to FLASHSSRAM_ADDR[6]
set_location_assignment PIN_B15 -to FLASHSSRAM_ADDR[5]
set_location_assignment PIN_A15 -to FLASHSSRAM_ADDR[4]
set_location_assignment PIN_B16 -to FLASHSSRAM_ADDR[3]
set_location_assignment PIN_A16 -to FLASHSSRAM_ADDR[2]
set_location_assignment PIN_E12 -to FLASHSSRAM_ADDR[1]
set_location_assignment PIN_C7 -to FLASHSSRAM_DQ[31]
set_location_assignment PIN_G6 -to FLASHSSRAM_DQ[30]
set_location_assignment PIN_E6 -to FLASHSSRAM_DQ[29]
set_location_assignment PIN_F6 -to FLASHSSRAM_DQ[28]
set_location_assignment PIN_D7 -to FLASHSSRAM_DQ[27]
set_location_assignment PIN_F8 -to FLASHSSRAM_DQ[26]
set_location_assignment PIN_A18 -to FLASHSSRAM_DQ[25]
set_location_assignment PIN_C12 -to FLASHSSRAM_DQ[24]
set_location_assignment PIN_D16 -to FLASHSSRAM_DQ[23]
set_location_assignment PIN_A17 -to FLASHSSRAM_DQ[22]
set_location_assignment PIN_E14 -to FLASHSSRAM_DQ[21]
set_location_assignment PIN_E13 -to FLASHSSRAM_DQ[20]
set_location_assignment PIN_D2 -to FLASHSSRAM_DQ[19]
set_location_assignment PIN_E11 -to FLASHSSRAM_DQ[18]
set_location_assignment PIN_D12 -to FLASHSSRAM_DQ[17]
set_location_assignment PIN_C16 -to FLASHSSRAM_DQ[16]
set_location_assignment PIN_B6 -to FLASHSSRAM_DQ[15]
set_location_assignment PIN_A5 -to FLASHSSRAM_DQ[14]
set_location_assignment PIN_B5 -to FLASHSSRAM_DQ[13]
set_location_assignment PIN_D5 -to FLASHSSRAM_DQ[12]
set_location_assignment PIN_B3 -to FLASHSSRAM_DQ[11]
set_location_assignment PIN_A3 -to FLASHSSRAM_DQ[10]
set_location_assignment PIN_E7 -to FLASHSSRAM_DQ[9]
set_location_assignment PIN_B4 -to FLASHSSRAM_DQ[8]
set_location_assignment PIN_A4 -to FLASHSSRAM_DQ[7]
set_location_assignment PIN_E8 -to FLASHSSRAM_DQ[6]
set_location_assignment PIN_C5 -to FLASHSSRAM_DQ[5]
set_location_assignment PIN_B7 -to FLASHSSRAM_DQ[4]
set_location_assignment PIN_B8 -to FLASHSSRAM_DQ[3]
set_location_assignment PIN_A8 -to FLASHSSRAM_DQ[2]
set_location_assignment PIN_D1 -to FLASHSSRAM_DQ[1]
set_location_assignment PIN_H3 -to FLASHSSRAM_DQ[0]
set_location_assignment PIN_C3 -to FLASHSSRAM_RST_N
set_location_assignment PIN_F7 -to SSRAM_ADSC_N
set_location_assignment PIN_F13 -to SSRAM_BW_N[3]
set_location_assignment PIN_F12 -to SSRAM_BW_N[2]
set_location_assignment PIN_F11 -to SSRAM_BW_N[1]
set_location_assignment PIN_F10 -to SSRAM_BW_N[0]
set_location_assignment PIN_G13 -to SSRAM_BWE_N
set_location_assignment PIN_F9 -to SSRAM_CE_N
set_location_assignment PIN_A2 -to SSRAM_CLK
set_location_assignment PIN_E9 -to SSRAM_OE_N

# UART
set_location_assignment PIN_E18 -to uart_rx_pad_i
set_location_assignment PIN_H17 -to uart_tx_pad_o

# Ethernet
set_location_assignment PIN_H18 -to HC_ETH_RESET_N
set_location_assignment PIN_P18 -to HC_MDC
set_location_assignment PIN_N7 -to HC_MDIO
set_location_assignment PIN_F17 -to HC_RX_CLK
set_location_assignment PIN_G17 -to HC_RX_COL
set_location_assignment PIN_L3 -to HC_RX_CRS
set_location_assignment PIN_R3 -to HC_RX_D[3]
set_location_assignment PIN_T3 -to HC_RX_D[2]
set_location_assignment PIN_P1 -to HC_RX_D[1]
set_location_assignment PIN_P2 -to HC_RX_D[0]
set_location_assignment PIN_G18 -to HC_RX_DV
set_location_assignment PIN_L4 -to HC_RX_ERR
set_location_assignment PIN_N18 -to HC_TX_CLK
set_location_assignment PIN_P17 -to HC_TX_D[3]
set_location_assignment PIN_L15 -to HC_TX_D[2]
set_location_assignment PIN_L14 -to HC_TX_D[1]
set_location_assignment PIN_M18 -to HC_TX_D[0]
set_location_assignment PIN_L17 -to HC_TX_EN

# SPI (SDCARD)
set_location_assignment PIN_M3 -to MISO
set_location_assignment PIN_L6 -to MOSI
set_location_assignment PIN_M2 -to SCLK
set_location_assignment PIN_N8 -to SSn

# LEDs
set_location_assignment PIN_P13 -to led_debug_pad_o[0]
set_location_assignment PIN_N12 -to led_debug_pad_o[2]
set_location_assignment PIN_N9 -to led_debug_pad_o[3]

# Fitter Assignments
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

set_instance_assignment -name VIRTUAL_PIN ON -to FLASHSSRAM_ADDR[0]
set_instance_assignment -name VIRTUAL_PIN ON -to led_debug_pad_o[1]













