# Clock / Reset

set_location_assignment PIN_G26 -to rst_n_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to rst_n_pad_i
set_location_assignment PIN_N2 -to sys_clk_pad_i
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sys_clk_pad_i

# SD card
#set_location_assignment PIN_V20 -to sd_clk_pad_o
  
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_clk_pad_o
#set_location_assignment PIN_Y20 -to sd_cmd_pad_o
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_cmd_pad_o
#set_location_assignment PIN_W20 -to sd_dat_pad_i
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_dat_pad_i
#set_location_assignment PIN_U20 -to sd_dat3_pad_o
#set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to sd_dat3_pad_o

# UART
set_location_assignment PIN_C25 -to uart0_srx_pad_i
   
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_srx_pad_i
set_location_assignment PIN_B25 -to uart0_stx_pad_o
  
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart0_stx_pad_o

# SDRAM
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

# RED LED
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

# GREEN LED
set_location_assignment PIN_AE22 -to gpio0_io[0]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[0]
set_location_assignment PIN_AF22 -to gpio0_io[1]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[1]
set_location_assignment PIN_W19 -to gpio0_io[2]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[2]
set_location_assignment PIN_V18 -to gpio0_io[3]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[3]
set_location_assignment PIN_U18 -to gpio0_io[4]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[4]
set_location_assignment PIN_U17 -to gpio0_io[5]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[5]
set_location_assignment PIN_AA20 -to gpio0_io[6]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[6]
set_location_assignment PIN_Y18 -to gpio0_io[7]
		
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to gpio0_io[7]
