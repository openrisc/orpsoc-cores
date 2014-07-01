module wb_intercon
   (input         wb_clk_i,
    input         wb_rst_i,
    input  [31:0] wb_or1k0_i_adr_i,
    input  [31:0] wb_or1k0_i_dat_i,
    input   [3:0] wb_or1k0_i_sel_i,
    input         wb_or1k0_i_we_i,
    input         wb_or1k0_i_cyc_i,
    input         wb_or1k0_i_stb_i,
    input   [2:0] wb_or1k0_i_cti_i,
    input   [1:0] wb_or1k0_i_bte_i,
    output [31:0] wb_or1k0_i_dat_o,
    output        wb_or1k0_i_ack_o,
    output        wb_or1k0_i_err_o,
    output        wb_or1k0_i_rty_o,
    input  [31:0] wb_or1k0_d_adr_i,
    input  [31:0] wb_or1k0_d_dat_i,
    input   [3:0] wb_or1k0_d_sel_i,
    input         wb_or1k0_d_we_i,
    input         wb_or1k0_d_cyc_i,
    input         wb_or1k0_d_stb_i,
    input   [2:0] wb_or1k0_d_cti_i,
    input   [1:0] wb_or1k0_d_bte_i,
    output [31:0] wb_or1k0_d_dat_o,
    output        wb_or1k0_d_ack_o,
    output        wb_or1k0_d_err_o,
    output        wb_or1k0_d_rty_o,
    input  [31:0] wb_or1k1_i_adr_i,
    input  [31:0] wb_or1k1_i_dat_i,
    input   [3:0] wb_or1k1_i_sel_i,
    input         wb_or1k1_i_we_i,
    input         wb_or1k1_i_cyc_i,
    input         wb_or1k1_i_stb_i,
    input   [2:0] wb_or1k1_i_cti_i,
    input   [1:0] wb_or1k1_i_bte_i,
    output [31:0] wb_or1k1_i_dat_o,
    output        wb_or1k1_i_ack_o,
    output        wb_or1k1_i_err_o,
    output        wb_or1k1_i_rty_o,
    input  [31:0] wb_or1k1_d_adr_i,
    input  [31:0] wb_or1k1_d_dat_i,
    input   [3:0] wb_or1k1_d_sel_i,
    input         wb_or1k1_d_we_i,
    input         wb_or1k1_d_cyc_i,
    input         wb_or1k1_d_stb_i,
    input   [2:0] wb_or1k1_d_cti_i,
    input   [1:0] wb_or1k1_d_bte_i,
    output [31:0] wb_or1k1_d_dat_o,
    output        wb_or1k1_d_ack_o,
    output        wb_or1k1_d_err_o,
    output        wb_or1k1_d_rty_o,
    input  [31:0] wb_vga0_master_adr_i,
    input  [31:0] wb_vga0_master_dat_i,
    input   [3:0] wb_vga0_master_sel_i,
    input         wb_vga0_master_we_i,
    input         wb_vga0_master_cyc_i,
    input         wb_vga0_master_stb_i,
    input   [2:0] wb_vga0_master_cti_i,
    input   [1:0] wb_vga0_master_bte_i,
    output [31:0] wb_vga0_master_dat_o,
    output        wb_vga0_master_ack_o,
    output        wb_vga0_master_err_o,
    output        wb_vga0_master_rty_o,
    input  [31:0] wb_dbg_adr_i,
    input  [31:0] wb_dbg_dat_i,
    input   [3:0] wb_dbg_sel_i,
    input         wb_dbg_we_i,
    input         wb_dbg_cyc_i,
    input         wb_dbg_stb_i,
    input   [2:0] wb_dbg_cti_i,
    input   [1:0] wb_dbg_bte_i,
    output [31:0] wb_dbg_dat_o,
    output        wb_dbg_ack_o,
    output        wb_dbg_err_o,
    output        wb_dbg_rty_o,
    input  [31:0] wb_h2f_lw_adr_i,
    input  [31:0] wb_h2f_lw_dat_i,
    input   [3:0] wb_h2f_lw_sel_i,
    input         wb_h2f_lw_we_i,
    input         wb_h2f_lw_cyc_i,
    input         wb_h2f_lw_stb_i,
    input   [2:0] wb_h2f_lw_cti_i,
    input   [1:0] wb_h2f_lw_bte_i,
    output [31:0] wb_h2f_lw_dat_o,
    output        wb_h2f_lw_ack_o,
    output        wb_h2f_lw_err_o,
    output        wb_h2f_lw_rty_o,
    output [31:0] wb_fpga_ddr3_adr_o,
    output [31:0] wb_fpga_ddr3_dat_o,
    output  [3:0] wb_fpga_ddr3_sel_o,
    output        wb_fpga_ddr3_we_o,
    output        wb_fpga_ddr3_cyc_o,
    output        wb_fpga_ddr3_stb_o,
    output  [2:0] wb_fpga_ddr3_cti_o,
    output  [1:0] wb_fpga_ddr3_bte_o,
    input  [31:0] wb_fpga_ddr3_dat_i,
    input         wb_fpga_ddr3_ack_i,
    input         wb_fpga_ddr3_err_i,
    input         wb_fpga_ddr3_rty_i,
    output [31:0] wb_gpio0_adr_o,
    output  [7:0] wb_gpio0_dat_o,
    output  [3:0] wb_gpio0_sel_o,
    output        wb_gpio0_we_o,
    output        wb_gpio0_cyc_o,
    output        wb_gpio0_stb_o,
    output  [2:0] wb_gpio0_cti_o,
    output  [1:0] wb_gpio0_bte_o,
    input   [7:0] wb_gpio0_dat_i,
    input         wb_gpio0_ack_i,
    input         wb_gpio0_err_i,
    input         wb_gpio0_rty_i,
    output [31:0] wb_hps_ddr3_adr_o,
    output [31:0] wb_hps_ddr3_dat_o,
    output  [3:0] wb_hps_ddr3_sel_o,
    output        wb_hps_ddr3_we_o,
    output        wb_hps_ddr3_cyc_o,
    output        wb_hps_ddr3_stb_o,
    output  [2:0] wb_hps_ddr3_cti_o,
    output  [1:0] wb_hps_ddr3_bte_o,
    input  [31:0] wb_hps_ddr3_dat_i,
    input         wb_hps_ddr3_ack_i,
    input         wb_hps_ddr3_err_i,
    input         wb_hps_ddr3_rty_i,
    output [31:0] wb_vga0_slave_adr_o,
    output [31:0] wb_vga0_slave_dat_o,
    output  [3:0] wb_vga0_slave_sel_o,
    output        wb_vga0_slave_we_o,
    output        wb_vga0_slave_cyc_o,
    output        wb_vga0_slave_stb_o,
    output  [2:0] wb_vga0_slave_cti_o,
    output  [1:0] wb_vga0_slave_bte_o,
    input  [31:0] wb_vga0_slave_dat_i,
    input         wb_vga0_slave_ack_i,
    input         wb_vga0_slave_err_i,
    input         wb_vga0_slave_rty_i,
    output [31:0] wb_rom0_adr_o,
    output [31:0] wb_rom0_dat_o,
    output  [3:0] wb_rom0_sel_o,
    output        wb_rom0_we_o,
    output        wb_rom0_cyc_o,
    output        wb_rom0_stb_o,
    output  [2:0] wb_rom0_cti_o,
    output  [1:0] wb_rom0_bte_o,
    input  [31:0] wb_rom0_dat_i,
    input         wb_rom0_ack_i,
    input         wb_rom0_err_i,
    input         wb_rom0_rty_i,
    output [31:0] wb_vga0_ddr3_adr_o,
    output [31:0] wb_vga0_ddr3_dat_o,
    output  [3:0] wb_vga0_ddr3_sel_o,
    output        wb_vga0_ddr3_we_o,
    output        wb_vga0_ddr3_cyc_o,
    output        wb_vga0_ddr3_stb_o,
    output  [2:0] wb_vga0_ddr3_cti_o,
    output  [1:0] wb_vga0_ddr3_bte_o,
    input  [31:0] wb_vga0_ddr3_dat_i,
    input         wb_vga0_ddr3_ack_i,
    input         wb_vga0_ddr3_err_i,
    input         wb_vga0_ddr3_rty_i,
    output [31:0] wb_ipi_adr_o,
    output [31:0] wb_ipi_dat_o,
    output  [3:0] wb_ipi_sel_o,
    output        wb_ipi_we_o,
    output        wb_ipi_cyc_o,
    output        wb_ipi_stb_o,
    output  [2:0] wb_ipi_cti_o,
    output  [1:0] wb_ipi_bte_o,
    input  [31:0] wb_ipi_dat_i,
    input         wb_ipi_ack_i,
    input         wb_ipi_err_i,
    input         wb_ipi_rty_i,
    output [31:0] wb_uart0_adr_o,
    output  [7:0] wb_uart0_dat_o,
    output  [3:0] wb_uart0_sel_o,
    output        wb_uart0_we_o,
    output        wb_uart0_cyc_o,
    output        wb_uart0_stb_o,
    output  [2:0] wb_uart0_cti_o,
    output  [1:0] wb_uart0_bte_o,
    input   [7:0] wb_uart0_dat_i,
    input         wb_uart0_ack_i,
    input         wb_uart0_err_i,
    input         wb_uart0_rty_i,
    output [31:0] wb_sram0_adr_o,
    output [31:0] wb_sram0_dat_o,
    output  [3:0] wb_sram0_sel_o,
    output        wb_sram0_we_o,
    output        wb_sram0_cyc_o,
    output        wb_sram0_stb_o,
    output  [2:0] wb_sram0_cti_o,
    output  [1:0] wb_sram0_bte_o,
    input  [31:0] wb_sram0_dat_i,
    input         wb_sram0_ack_i,
    input         wb_sram0_err_i,
    input         wb_sram0_rty_i,
    output [31:0] wb_clkgen_adr_o,
    output [31:0] wb_clkgen_dat_o,
    output  [3:0] wb_clkgen_sel_o,
    output        wb_clkgen_we_o,
    output        wb_clkgen_cyc_o,
    output        wb_clkgen_stb_o,
    output  [2:0] wb_clkgen_cti_o,
    output  [1:0] wb_clkgen_bte_o,
    input  [31:0] wb_clkgen_dat_i,
    input         wb_clkgen_ack_i,
    input         wb_clkgen_err_i,
    input         wb_clkgen_rty_i,
    output [31:0] wb_i2c0_adr_o,
    output  [7:0] wb_i2c0_dat_o,
    output  [3:0] wb_i2c0_sel_o,
    output        wb_i2c0_we_o,
    output        wb_i2c0_cyc_o,
    output        wb_i2c0_stb_o,
    output  [2:0] wb_i2c0_cti_o,
    output  [1:0] wb_i2c0_bte_o,
    input   [7:0] wb_i2c0_dat_i,
    input         wb_i2c0_ack_i,
    input         wb_i2c0_err_i,
    input         wb_i2c0_rty_i,
    output [31:0] wb_tc_adr_o,
    output [31:0] wb_tc_dat_o,
    output  [3:0] wb_tc_sel_o,
    output        wb_tc_we_o,
    output        wb_tc_cyc_o,
    output        wb_tc_stb_o,
    output  [2:0] wb_tc_cti_o,
    output  [1:0] wb_tc_bte_o,
    input  [31:0] wb_tc_dat_i,
    input         wb_tc_ack_i,
    input         wb_tc_err_i,
    input         wb_tc_rty_i,
    output [31:0] wb_diila_adr_o,
    output [31:0] wb_diila_dat_o,
    output  [3:0] wb_diila_sel_o,
    output        wb_diila_we_o,
    output        wb_diila_cyc_o,
    output        wb_diila_stb_o,
    output  [2:0] wb_diila_cti_o,
    output  [1:0] wb_diila_bte_o,
    input  [31:0] wb_diila_dat_i,
    input         wb_diila_ack_i,
    input         wb_diila_err_i,
    input         wb_diila_rty_i);

wire [31:0] wb_m2s_or1k0_i_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k0_i_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k0_i_hps_ddr3_sel;
wire        wb_m2s_or1k0_i_hps_ddr3_we;
wire        wb_m2s_or1k0_i_hps_ddr3_cyc;
wire        wb_m2s_or1k0_i_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k0_i_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k0_i_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k0_i_hps_ddr3_dat;
wire        wb_s2m_or1k0_i_hps_ddr3_ack;
wire        wb_s2m_or1k0_i_hps_ddr3_err;
wire        wb_s2m_or1k0_i_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k0_i_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k0_i_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k0_i_fpga_ddr3_sel;
wire        wb_m2s_or1k0_i_fpga_ddr3_we;
wire        wb_m2s_or1k0_i_fpga_ddr3_cyc;
wire        wb_m2s_or1k0_i_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k0_i_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k0_i_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k0_i_fpga_ddr3_dat;
wire        wb_s2m_or1k0_i_fpga_ddr3_ack;
wire        wb_s2m_or1k0_i_fpga_ddr3_err;
wire        wb_s2m_or1k0_i_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k0_i_sram0_adr;
wire [31:0] wb_m2s_or1k0_i_sram0_dat;
wire  [3:0] wb_m2s_or1k0_i_sram0_sel;
wire        wb_m2s_or1k0_i_sram0_we;
wire        wb_m2s_or1k0_i_sram0_cyc;
wire        wb_m2s_or1k0_i_sram0_stb;
wire  [2:0] wb_m2s_or1k0_i_sram0_cti;
wire  [1:0] wb_m2s_or1k0_i_sram0_bte;
wire [31:0] wb_s2m_or1k0_i_sram0_dat;
wire        wb_s2m_or1k0_i_sram0_ack;
wire        wb_s2m_or1k0_i_sram0_err;
wire        wb_s2m_or1k0_i_sram0_rty;
wire [31:0] wb_m2s_or1k0_i_rom0_adr;
wire [31:0] wb_m2s_or1k0_i_rom0_dat;
wire  [3:0] wb_m2s_or1k0_i_rom0_sel;
wire        wb_m2s_or1k0_i_rom0_we;
wire        wb_m2s_or1k0_i_rom0_cyc;
wire        wb_m2s_or1k0_i_rom0_stb;
wire  [2:0] wb_m2s_or1k0_i_rom0_cti;
wire  [1:0] wb_m2s_or1k0_i_rom0_bte;
wire [31:0] wb_s2m_or1k0_i_rom0_dat;
wire        wb_s2m_or1k0_i_rom0_ack;
wire        wb_s2m_or1k0_i_rom0_err;
wire        wb_s2m_or1k0_i_rom0_rty;
wire [31:0] wb_m2s_or1k0_d_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k0_d_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k0_d_hps_ddr3_sel;
wire        wb_m2s_or1k0_d_hps_ddr3_we;
wire        wb_m2s_or1k0_d_hps_ddr3_cyc;
wire        wb_m2s_or1k0_d_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k0_d_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k0_d_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k0_d_hps_ddr3_dat;
wire        wb_s2m_or1k0_d_hps_ddr3_ack;
wire        wb_s2m_or1k0_d_hps_ddr3_err;
wire        wb_s2m_or1k0_d_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k0_d_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k0_d_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k0_d_fpga_ddr3_sel;
wire        wb_m2s_or1k0_d_fpga_ddr3_we;
wire        wb_m2s_or1k0_d_fpga_ddr3_cyc;
wire        wb_m2s_or1k0_d_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k0_d_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k0_d_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k0_d_fpga_ddr3_dat;
wire        wb_s2m_or1k0_d_fpga_ddr3_ack;
wire        wb_s2m_or1k0_d_fpga_ddr3_err;
wire        wb_s2m_or1k0_d_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k0_d_sram0_adr;
wire [31:0] wb_m2s_or1k0_d_sram0_dat;
wire  [3:0] wb_m2s_or1k0_d_sram0_sel;
wire        wb_m2s_or1k0_d_sram0_we;
wire        wb_m2s_or1k0_d_sram0_cyc;
wire        wb_m2s_or1k0_d_sram0_stb;
wire  [2:0] wb_m2s_or1k0_d_sram0_cti;
wire  [1:0] wb_m2s_or1k0_d_sram0_bte;
wire [31:0] wb_s2m_or1k0_d_sram0_dat;
wire        wb_s2m_or1k0_d_sram0_ack;
wire        wb_s2m_or1k0_d_sram0_err;
wire        wb_s2m_or1k0_d_sram0_rty;
wire [31:0] wb_m2s_or1k0_d_uart0_adr;
wire [31:0] wb_m2s_or1k0_d_uart0_dat;
wire  [3:0] wb_m2s_or1k0_d_uart0_sel;
wire        wb_m2s_or1k0_d_uart0_we;
wire        wb_m2s_or1k0_d_uart0_cyc;
wire        wb_m2s_or1k0_d_uart0_stb;
wire  [2:0] wb_m2s_or1k0_d_uart0_cti;
wire  [1:0] wb_m2s_or1k0_d_uart0_bte;
wire [31:0] wb_s2m_or1k0_d_uart0_dat;
wire        wb_s2m_or1k0_d_uart0_ack;
wire        wb_s2m_or1k0_d_uart0_err;
wire        wb_s2m_or1k0_d_uart0_rty;
wire [31:0] wb_m2s_or1k0_d_gpio0_adr;
wire [31:0] wb_m2s_or1k0_d_gpio0_dat;
wire  [3:0] wb_m2s_or1k0_d_gpio0_sel;
wire        wb_m2s_or1k0_d_gpio0_we;
wire        wb_m2s_or1k0_d_gpio0_cyc;
wire        wb_m2s_or1k0_d_gpio0_stb;
wire  [2:0] wb_m2s_or1k0_d_gpio0_cti;
wire  [1:0] wb_m2s_or1k0_d_gpio0_bte;
wire [31:0] wb_s2m_or1k0_d_gpio0_dat;
wire        wb_s2m_or1k0_d_gpio0_ack;
wire        wb_s2m_or1k0_d_gpio0_err;
wire        wb_s2m_or1k0_d_gpio0_rty;
wire [31:0] wb_m2s_or1k0_d_i2c0_adr;
wire [31:0] wb_m2s_or1k0_d_i2c0_dat;
wire  [3:0] wb_m2s_or1k0_d_i2c0_sel;
wire        wb_m2s_or1k0_d_i2c0_we;
wire        wb_m2s_or1k0_d_i2c0_cyc;
wire        wb_m2s_or1k0_d_i2c0_stb;
wire  [2:0] wb_m2s_or1k0_d_i2c0_cti;
wire  [1:0] wb_m2s_or1k0_d_i2c0_bte;
wire [31:0] wb_s2m_or1k0_d_i2c0_dat;
wire        wb_s2m_or1k0_d_i2c0_ack;
wire        wb_s2m_or1k0_d_i2c0_err;
wire        wb_s2m_or1k0_d_i2c0_rty;
wire [31:0] wb_m2s_or1k0_d_clkgen_adr;
wire [31:0] wb_m2s_or1k0_d_clkgen_dat;
wire  [3:0] wb_m2s_or1k0_d_clkgen_sel;
wire        wb_m2s_or1k0_d_clkgen_we;
wire        wb_m2s_or1k0_d_clkgen_cyc;
wire        wb_m2s_or1k0_d_clkgen_stb;
wire  [2:0] wb_m2s_or1k0_d_clkgen_cti;
wire  [1:0] wb_m2s_or1k0_d_clkgen_bte;
wire [31:0] wb_s2m_or1k0_d_clkgen_dat;
wire        wb_s2m_or1k0_d_clkgen_ack;
wire        wb_s2m_or1k0_d_clkgen_err;
wire        wb_s2m_or1k0_d_clkgen_rty;
wire [31:0] wb_m2s_or1k0_d_vga0_slave_adr;
wire [31:0] wb_m2s_or1k0_d_vga0_slave_dat;
wire  [3:0] wb_m2s_or1k0_d_vga0_slave_sel;
wire        wb_m2s_or1k0_d_vga0_slave_we;
wire        wb_m2s_or1k0_d_vga0_slave_cyc;
wire        wb_m2s_or1k0_d_vga0_slave_stb;
wire  [2:0] wb_m2s_or1k0_d_vga0_slave_cti;
wire  [1:0] wb_m2s_or1k0_d_vga0_slave_bte;
wire [31:0] wb_s2m_or1k0_d_vga0_slave_dat;
wire        wb_s2m_or1k0_d_vga0_slave_ack;
wire        wb_s2m_or1k0_d_vga0_slave_err;
wire        wb_s2m_or1k0_d_vga0_slave_rty;
wire [31:0] wb_m2s_or1k0_d_ipi_adr;
wire [31:0] wb_m2s_or1k0_d_ipi_dat;
wire  [3:0] wb_m2s_or1k0_d_ipi_sel;
wire        wb_m2s_or1k0_d_ipi_we;
wire        wb_m2s_or1k0_d_ipi_cyc;
wire        wb_m2s_or1k0_d_ipi_stb;
wire  [2:0] wb_m2s_or1k0_d_ipi_cti;
wire  [1:0] wb_m2s_or1k0_d_ipi_bte;
wire [31:0] wb_s2m_or1k0_d_ipi_dat;
wire        wb_s2m_or1k0_d_ipi_ack;
wire        wb_s2m_or1k0_d_ipi_err;
wire        wb_s2m_or1k0_d_ipi_rty;
wire [31:0] wb_m2s_or1k0_d_tc_adr;
wire [31:0] wb_m2s_or1k0_d_tc_dat;
wire  [3:0] wb_m2s_or1k0_d_tc_sel;
wire        wb_m2s_or1k0_d_tc_we;
wire        wb_m2s_or1k0_d_tc_cyc;
wire        wb_m2s_or1k0_d_tc_stb;
wire  [2:0] wb_m2s_or1k0_d_tc_cti;
wire  [1:0] wb_m2s_or1k0_d_tc_bte;
wire [31:0] wb_s2m_or1k0_d_tc_dat;
wire        wb_s2m_or1k0_d_tc_ack;
wire        wb_s2m_or1k0_d_tc_err;
wire        wb_s2m_or1k0_d_tc_rty;
wire [31:0] wb_m2s_or1k1_i_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k1_i_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k1_i_hps_ddr3_sel;
wire        wb_m2s_or1k1_i_hps_ddr3_we;
wire        wb_m2s_or1k1_i_hps_ddr3_cyc;
wire        wb_m2s_or1k1_i_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k1_i_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k1_i_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k1_i_hps_ddr3_dat;
wire        wb_s2m_or1k1_i_hps_ddr3_ack;
wire        wb_s2m_or1k1_i_hps_ddr3_err;
wire        wb_s2m_or1k1_i_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k1_i_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k1_i_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k1_i_fpga_ddr3_sel;
wire        wb_m2s_or1k1_i_fpga_ddr3_we;
wire        wb_m2s_or1k1_i_fpga_ddr3_cyc;
wire        wb_m2s_or1k1_i_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k1_i_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k1_i_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k1_i_fpga_ddr3_dat;
wire        wb_s2m_or1k1_i_fpga_ddr3_ack;
wire        wb_s2m_or1k1_i_fpga_ddr3_err;
wire        wb_s2m_or1k1_i_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k1_i_sram0_adr;
wire [31:0] wb_m2s_or1k1_i_sram0_dat;
wire  [3:0] wb_m2s_or1k1_i_sram0_sel;
wire        wb_m2s_or1k1_i_sram0_we;
wire        wb_m2s_or1k1_i_sram0_cyc;
wire        wb_m2s_or1k1_i_sram0_stb;
wire  [2:0] wb_m2s_or1k1_i_sram0_cti;
wire  [1:0] wb_m2s_or1k1_i_sram0_bte;
wire [31:0] wb_s2m_or1k1_i_sram0_dat;
wire        wb_s2m_or1k1_i_sram0_ack;
wire        wb_s2m_or1k1_i_sram0_err;
wire        wb_s2m_or1k1_i_sram0_rty;
wire [31:0] wb_m2s_or1k1_i_rom0_adr;
wire [31:0] wb_m2s_or1k1_i_rom0_dat;
wire  [3:0] wb_m2s_or1k1_i_rom0_sel;
wire        wb_m2s_or1k1_i_rom0_we;
wire        wb_m2s_or1k1_i_rom0_cyc;
wire        wb_m2s_or1k1_i_rom0_stb;
wire  [2:0] wb_m2s_or1k1_i_rom0_cti;
wire  [1:0] wb_m2s_or1k1_i_rom0_bte;
wire [31:0] wb_s2m_or1k1_i_rom0_dat;
wire        wb_s2m_or1k1_i_rom0_ack;
wire        wb_s2m_or1k1_i_rom0_err;
wire        wb_s2m_or1k1_i_rom0_rty;
wire [31:0] wb_m2s_or1k1_d_hps_ddr3_adr;
wire [31:0] wb_m2s_or1k1_d_hps_ddr3_dat;
wire  [3:0] wb_m2s_or1k1_d_hps_ddr3_sel;
wire        wb_m2s_or1k1_d_hps_ddr3_we;
wire        wb_m2s_or1k1_d_hps_ddr3_cyc;
wire        wb_m2s_or1k1_d_hps_ddr3_stb;
wire  [2:0] wb_m2s_or1k1_d_hps_ddr3_cti;
wire  [1:0] wb_m2s_or1k1_d_hps_ddr3_bte;
wire [31:0] wb_s2m_or1k1_d_hps_ddr3_dat;
wire        wb_s2m_or1k1_d_hps_ddr3_ack;
wire        wb_s2m_or1k1_d_hps_ddr3_err;
wire        wb_s2m_or1k1_d_hps_ddr3_rty;
wire [31:0] wb_m2s_or1k1_d_fpga_ddr3_adr;
wire [31:0] wb_m2s_or1k1_d_fpga_ddr3_dat;
wire  [3:0] wb_m2s_or1k1_d_fpga_ddr3_sel;
wire        wb_m2s_or1k1_d_fpga_ddr3_we;
wire        wb_m2s_or1k1_d_fpga_ddr3_cyc;
wire        wb_m2s_or1k1_d_fpga_ddr3_stb;
wire  [2:0] wb_m2s_or1k1_d_fpga_ddr3_cti;
wire  [1:0] wb_m2s_or1k1_d_fpga_ddr3_bte;
wire [31:0] wb_s2m_or1k1_d_fpga_ddr3_dat;
wire        wb_s2m_or1k1_d_fpga_ddr3_ack;
wire        wb_s2m_or1k1_d_fpga_ddr3_err;
wire        wb_s2m_or1k1_d_fpga_ddr3_rty;
wire [31:0] wb_m2s_or1k1_d_sram0_adr;
wire [31:0] wb_m2s_or1k1_d_sram0_dat;
wire  [3:0] wb_m2s_or1k1_d_sram0_sel;
wire        wb_m2s_or1k1_d_sram0_we;
wire        wb_m2s_or1k1_d_sram0_cyc;
wire        wb_m2s_or1k1_d_sram0_stb;
wire  [2:0] wb_m2s_or1k1_d_sram0_cti;
wire  [1:0] wb_m2s_or1k1_d_sram0_bte;
wire [31:0] wb_s2m_or1k1_d_sram0_dat;
wire        wb_s2m_or1k1_d_sram0_ack;
wire        wb_s2m_or1k1_d_sram0_err;
wire        wb_s2m_or1k1_d_sram0_rty;
wire [31:0] wb_m2s_or1k1_d_uart0_adr;
wire [31:0] wb_m2s_or1k1_d_uart0_dat;
wire  [3:0] wb_m2s_or1k1_d_uart0_sel;
wire        wb_m2s_or1k1_d_uart0_we;
wire        wb_m2s_or1k1_d_uart0_cyc;
wire        wb_m2s_or1k1_d_uart0_stb;
wire  [2:0] wb_m2s_or1k1_d_uart0_cti;
wire  [1:0] wb_m2s_or1k1_d_uart0_bte;
wire [31:0] wb_s2m_or1k1_d_uart0_dat;
wire        wb_s2m_or1k1_d_uart0_ack;
wire        wb_s2m_or1k1_d_uart0_err;
wire        wb_s2m_or1k1_d_uart0_rty;
wire [31:0] wb_m2s_or1k1_d_gpio0_adr;
wire [31:0] wb_m2s_or1k1_d_gpio0_dat;
wire  [3:0] wb_m2s_or1k1_d_gpio0_sel;
wire        wb_m2s_or1k1_d_gpio0_we;
wire        wb_m2s_or1k1_d_gpio0_cyc;
wire        wb_m2s_or1k1_d_gpio0_stb;
wire  [2:0] wb_m2s_or1k1_d_gpio0_cti;
wire  [1:0] wb_m2s_or1k1_d_gpio0_bte;
wire [31:0] wb_s2m_or1k1_d_gpio0_dat;
wire        wb_s2m_or1k1_d_gpio0_ack;
wire        wb_s2m_or1k1_d_gpio0_err;
wire        wb_s2m_or1k1_d_gpio0_rty;
wire [31:0] wb_m2s_or1k1_d_i2c0_adr;
wire [31:0] wb_m2s_or1k1_d_i2c0_dat;
wire  [3:0] wb_m2s_or1k1_d_i2c0_sel;
wire        wb_m2s_or1k1_d_i2c0_we;
wire        wb_m2s_or1k1_d_i2c0_cyc;
wire        wb_m2s_or1k1_d_i2c0_stb;
wire  [2:0] wb_m2s_or1k1_d_i2c0_cti;
wire  [1:0] wb_m2s_or1k1_d_i2c0_bte;
wire [31:0] wb_s2m_or1k1_d_i2c0_dat;
wire        wb_s2m_or1k1_d_i2c0_ack;
wire        wb_s2m_or1k1_d_i2c0_err;
wire        wb_s2m_or1k1_d_i2c0_rty;
wire [31:0] wb_m2s_or1k1_d_clkgen_adr;
wire [31:0] wb_m2s_or1k1_d_clkgen_dat;
wire  [3:0] wb_m2s_or1k1_d_clkgen_sel;
wire        wb_m2s_or1k1_d_clkgen_we;
wire        wb_m2s_or1k1_d_clkgen_cyc;
wire        wb_m2s_or1k1_d_clkgen_stb;
wire  [2:0] wb_m2s_or1k1_d_clkgen_cti;
wire  [1:0] wb_m2s_or1k1_d_clkgen_bte;
wire [31:0] wb_s2m_or1k1_d_clkgen_dat;
wire        wb_s2m_or1k1_d_clkgen_ack;
wire        wb_s2m_or1k1_d_clkgen_err;
wire        wb_s2m_or1k1_d_clkgen_rty;
wire [31:0] wb_m2s_or1k1_d_vga0_slave_adr;
wire [31:0] wb_m2s_or1k1_d_vga0_slave_dat;
wire  [3:0] wb_m2s_or1k1_d_vga0_slave_sel;
wire        wb_m2s_or1k1_d_vga0_slave_we;
wire        wb_m2s_or1k1_d_vga0_slave_cyc;
wire        wb_m2s_or1k1_d_vga0_slave_stb;
wire  [2:0] wb_m2s_or1k1_d_vga0_slave_cti;
wire  [1:0] wb_m2s_or1k1_d_vga0_slave_bte;
wire [31:0] wb_s2m_or1k1_d_vga0_slave_dat;
wire        wb_s2m_or1k1_d_vga0_slave_ack;
wire        wb_s2m_or1k1_d_vga0_slave_err;
wire        wb_s2m_or1k1_d_vga0_slave_rty;
wire [31:0] wb_m2s_or1k1_d_ipi_adr;
wire [31:0] wb_m2s_or1k1_d_ipi_dat;
wire  [3:0] wb_m2s_or1k1_d_ipi_sel;
wire        wb_m2s_or1k1_d_ipi_we;
wire        wb_m2s_or1k1_d_ipi_cyc;
wire        wb_m2s_or1k1_d_ipi_stb;
wire  [2:0] wb_m2s_or1k1_d_ipi_cti;
wire  [1:0] wb_m2s_or1k1_d_ipi_bte;
wire [31:0] wb_s2m_or1k1_d_ipi_dat;
wire        wb_s2m_or1k1_d_ipi_ack;
wire        wb_s2m_or1k1_d_ipi_err;
wire        wb_s2m_or1k1_d_ipi_rty;
wire [31:0] wb_m2s_or1k1_d_tc_adr;
wire [31:0] wb_m2s_or1k1_d_tc_dat;
wire  [3:0] wb_m2s_or1k1_d_tc_sel;
wire        wb_m2s_or1k1_d_tc_we;
wire        wb_m2s_or1k1_d_tc_cyc;
wire        wb_m2s_or1k1_d_tc_stb;
wire  [2:0] wb_m2s_or1k1_d_tc_cti;
wire  [1:0] wb_m2s_or1k1_d_tc_bte;
wire [31:0] wb_s2m_or1k1_d_tc_dat;
wire        wb_s2m_or1k1_d_tc_ack;
wire        wb_s2m_or1k1_d_tc_err;
wire        wb_s2m_or1k1_d_tc_rty;
wire [31:0] wb_m2s_vga0_master_hps_ddr3_adr;
wire [31:0] wb_m2s_vga0_master_hps_ddr3_dat;
wire  [3:0] wb_m2s_vga0_master_hps_ddr3_sel;
wire        wb_m2s_vga0_master_hps_ddr3_we;
wire        wb_m2s_vga0_master_hps_ddr3_cyc;
wire        wb_m2s_vga0_master_hps_ddr3_stb;
wire  [2:0] wb_m2s_vga0_master_hps_ddr3_cti;
wire  [1:0] wb_m2s_vga0_master_hps_ddr3_bte;
wire [31:0] wb_s2m_vga0_master_hps_ddr3_dat;
wire        wb_s2m_vga0_master_hps_ddr3_ack;
wire        wb_s2m_vga0_master_hps_ddr3_err;
wire        wb_s2m_vga0_master_hps_ddr3_rty;
wire [31:0] wb_m2s_dbg_hps_ddr3_adr;
wire [31:0] wb_m2s_dbg_hps_ddr3_dat;
wire  [3:0] wb_m2s_dbg_hps_ddr3_sel;
wire        wb_m2s_dbg_hps_ddr3_we;
wire        wb_m2s_dbg_hps_ddr3_cyc;
wire        wb_m2s_dbg_hps_ddr3_stb;
wire  [2:0] wb_m2s_dbg_hps_ddr3_cti;
wire  [1:0] wb_m2s_dbg_hps_ddr3_bte;
wire [31:0] wb_s2m_dbg_hps_ddr3_dat;
wire        wb_s2m_dbg_hps_ddr3_ack;
wire        wb_s2m_dbg_hps_ddr3_err;
wire        wb_s2m_dbg_hps_ddr3_rty;
wire [31:0] wb_m2s_dbg_fpga_ddr3_adr;
wire [31:0] wb_m2s_dbg_fpga_ddr3_dat;
wire  [3:0] wb_m2s_dbg_fpga_ddr3_sel;
wire        wb_m2s_dbg_fpga_ddr3_we;
wire        wb_m2s_dbg_fpga_ddr3_cyc;
wire        wb_m2s_dbg_fpga_ddr3_stb;
wire  [2:0] wb_m2s_dbg_fpga_ddr3_cti;
wire  [1:0] wb_m2s_dbg_fpga_ddr3_bte;
wire [31:0] wb_s2m_dbg_fpga_ddr3_dat;
wire        wb_s2m_dbg_fpga_ddr3_ack;
wire        wb_s2m_dbg_fpga_ddr3_err;
wire        wb_s2m_dbg_fpga_ddr3_rty;
wire [31:0] wb_m2s_dbg_sram0_adr;
wire [31:0] wb_m2s_dbg_sram0_dat;
wire  [3:0] wb_m2s_dbg_sram0_sel;
wire        wb_m2s_dbg_sram0_we;
wire        wb_m2s_dbg_sram0_cyc;
wire        wb_m2s_dbg_sram0_stb;
wire  [2:0] wb_m2s_dbg_sram0_cti;
wire  [1:0] wb_m2s_dbg_sram0_bte;
wire [31:0] wb_s2m_dbg_sram0_dat;
wire        wb_s2m_dbg_sram0_ack;
wire        wb_s2m_dbg_sram0_err;
wire        wb_s2m_dbg_sram0_rty;
wire [31:0] wb_m2s_dbg_uart0_adr;
wire [31:0] wb_m2s_dbg_uart0_dat;
wire  [3:0] wb_m2s_dbg_uart0_sel;
wire        wb_m2s_dbg_uart0_we;
wire        wb_m2s_dbg_uart0_cyc;
wire        wb_m2s_dbg_uart0_stb;
wire  [2:0] wb_m2s_dbg_uart0_cti;
wire  [1:0] wb_m2s_dbg_uart0_bte;
wire [31:0] wb_s2m_dbg_uart0_dat;
wire        wb_s2m_dbg_uart0_ack;
wire        wb_s2m_dbg_uart0_err;
wire        wb_s2m_dbg_uart0_rty;
wire [31:0] wb_m2s_dbg_gpio0_adr;
wire [31:0] wb_m2s_dbg_gpio0_dat;
wire  [3:0] wb_m2s_dbg_gpio0_sel;
wire        wb_m2s_dbg_gpio0_we;
wire        wb_m2s_dbg_gpio0_cyc;
wire        wb_m2s_dbg_gpio0_stb;
wire  [2:0] wb_m2s_dbg_gpio0_cti;
wire  [1:0] wb_m2s_dbg_gpio0_bte;
wire [31:0] wb_s2m_dbg_gpio0_dat;
wire        wb_s2m_dbg_gpio0_ack;
wire        wb_s2m_dbg_gpio0_err;
wire        wb_s2m_dbg_gpio0_rty;
wire [31:0] wb_m2s_dbg_i2c0_adr;
wire [31:0] wb_m2s_dbg_i2c0_dat;
wire  [3:0] wb_m2s_dbg_i2c0_sel;
wire        wb_m2s_dbg_i2c0_we;
wire        wb_m2s_dbg_i2c0_cyc;
wire        wb_m2s_dbg_i2c0_stb;
wire  [2:0] wb_m2s_dbg_i2c0_cti;
wire  [1:0] wb_m2s_dbg_i2c0_bte;
wire [31:0] wb_s2m_dbg_i2c0_dat;
wire        wb_s2m_dbg_i2c0_ack;
wire        wb_s2m_dbg_i2c0_err;
wire        wb_s2m_dbg_i2c0_rty;
wire [31:0] wb_m2s_dbg_diila_adr;
wire [31:0] wb_m2s_dbg_diila_dat;
wire  [3:0] wb_m2s_dbg_diila_sel;
wire        wb_m2s_dbg_diila_we;
wire        wb_m2s_dbg_diila_cyc;
wire        wb_m2s_dbg_diila_stb;
wire  [2:0] wb_m2s_dbg_diila_cti;
wire  [1:0] wb_m2s_dbg_diila_bte;
wire [31:0] wb_s2m_dbg_diila_dat;
wire        wb_s2m_dbg_diila_ack;
wire        wb_s2m_dbg_diila_err;
wire        wb_s2m_dbg_diila_rty;
wire [31:0] wb_m2s_dbg_clkgen_adr;
wire [31:0] wb_m2s_dbg_clkgen_dat;
wire  [3:0] wb_m2s_dbg_clkgen_sel;
wire        wb_m2s_dbg_clkgen_we;
wire        wb_m2s_dbg_clkgen_cyc;
wire        wb_m2s_dbg_clkgen_stb;
wire  [2:0] wb_m2s_dbg_clkgen_cti;
wire  [1:0] wb_m2s_dbg_clkgen_bte;
wire [31:0] wb_s2m_dbg_clkgen_dat;
wire        wb_s2m_dbg_clkgen_ack;
wire        wb_s2m_dbg_clkgen_err;
wire        wb_s2m_dbg_clkgen_rty;
wire [31:0] wb_m2s_dbg_vga0_slave_adr;
wire [31:0] wb_m2s_dbg_vga0_slave_dat;
wire  [3:0] wb_m2s_dbg_vga0_slave_sel;
wire        wb_m2s_dbg_vga0_slave_we;
wire        wb_m2s_dbg_vga0_slave_cyc;
wire        wb_m2s_dbg_vga0_slave_stb;
wire  [2:0] wb_m2s_dbg_vga0_slave_cti;
wire  [1:0] wb_m2s_dbg_vga0_slave_bte;
wire [31:0] wb_s2m_dbg_vga0_slave_dat;
wire        wb_s2m_dbg_vga0_slave_ack;
wire        wb_s2m_dbg_vga0_slave_err;
wire        wb_s2m_dbg_vga0_slave_rty;
wire [31:0] wb_m2s_h2f_lw_uart0_adr;
wire [31:0] wb_m2s_h2f_lw_uart0_dat;
wire  [3:0] wb_m2s_h2f_lw_uart0_sel;
wire        wb_m2s_h2f_lw_uart0_we;
wire        wb_m2s_h2f_lw_uart0_cyc;
wire        wb_m2s_h2f_lw_uart0_stb;
wire  [2:0] wb_m2s_h2f_lw_uart0_cti;
wire  [1:0] wb_m2s_h2f_lw_uart0_bte;
wire [31:0] wb_s2m_h2f_lw_uart0_dat;
wire        wb_s2m_h2f_lw_uart0_ack;
wire        wb_s2m_h2f_lw_uart0_err;
wire        wb_s2m_h2f_lw_uart0_rty;
wire [31:0] wb_m2s_h2f_lw_gpio0_adr;
wire [31:0] wb_m2s_h2f_lw_gpio0_dat;
wire  [3:0] wb_m2s_h2f_lw_gpio0_sel;
wire        wb_m2s_h2f_lw_gpio0_we;
wire        wb_m2s_h2f_lw_gpio0_cyc;
wire        wb_m2s_h2f_lw_gpio0_stb;
wire  [2:0] wb_m2s_h2f_lw_gpio0_cti;
wire  [1:0] wb_m2s_h2f_lw_gpio0_bte;
wire [31:0] wb_s2m_h2f_lw_gpio0_dat;
wire        wb_s2m_h2f_lw_gpio0_ack;
wire        wb_s2m_h2f_lw_gpio0_err;
wire        wb_s2m_h2f_lw_gpio0_rty;
wire [31:0] wb_m2s_h2f_lw_i2c0_adr;
wire [31:0] wb_m2s_h2f_lw_i2c0_dat;
wire  [3:0] wb_m2s_h2f_lw_i2c0_sel;
wire        wb_m2s_h2f_lw_i2c0_we;
wire        wb_m2s_h2f_lw_i2c0_cyc;
wire        wb_m2s_h2f_lw_i2c0_stb;
wire  [2:0] wb_m2s_h2f_lw_i2c0_cti;
wire  [1:0] wb_m2s_h2f_lw_i2c0_bte;
wire [31:0] wb_s2m_h2f_lw_i2c0_dat;
wire        wb_s2m_h2f_lw_i2c0_ack;
wire        wb_s2m_h2f_lw_i2c0_err;
wire        wb_s2m_h2f_lw_i2c0_rty;
wire [31:0] wb_m2s_h2f_lw_clkgen_adr;
wire [31:0] wb_m2s_h2f_lw_clkgen_dat;
wire  [3:0] wb_m2s_h2f_lw_clkgen_sel;
wire        wb_m2s_h2f_lw_clkgen_we;
wire        wb_m2s_h2f_lw_clkgen_cyc;
wire        wb_m2s_h2f_lw_clkgen_stb;
wire  [2:0] wb_m2s_h2f_lw_clkgen_cti;
wire  [1:0] wb_m2s_h2f_lw_clkgen_bte;
wire [31:0] wb_s2m_h2f_lw_clkgen_dat;
wire        wb_s2m_h2f_lw_clkgen_ack;
wire        wb_s2m_h2f_lw_clkgen_err;
wire        wb_s2m_h2f_lw_clkgen_rty;
wire [31:0] wb_m2s_h2f_lw_diila_adr;
wire [31:0] wb_m2s_h2f_lw_diila_dat;
wire  [3:0] wb_m2s_h2f_lw_diila_sel;
wire        wb_m2s_h2f_lw_diila_we;
wire        wb_m2s_h2f_lw_diila_cyc;
wire        wb_m2s_h2f_lw_diila_stb;
wire  [2:0] wb_m2s_h2f_lw_diila_cti;
wire  [1:0] wb_m2s_h2f_lw_diila_bte;
wire [31:0] wb_s2m_h2f_lw_diila_dat;
wire        wb_s2m_h2f_lw_diila_ack;
wire        wb_s2m_h2f_lw_diila_err;
wire        wb_s2m_h2f_lw_diila_rty;
wire [31:0] wb_m2s_h2f_lw_vga0_slave_adr;
wire [31:0] wb_m2s_h2f_lw_vga0_slave_dat;
wire  [3:0] wb_m2s_h2f_lw_vga0_slave_sel;
wire        wb_m2s_h2f_lw_vga0_slave_we;
wire        wb_m2s_h2f_lw_vga0_slave_cyc;
wire        wb_m2s_h2f_lw_vga0_slave_stb;
wire  [2:0] wb_m2s_h2f_lw_vga0_slave_cti;
wire  [1:0] wb_m2s_h2f_lw_vga0_slave_bte;
wire [31:0] wb_s2m_h2f_lw_vga0_slave_dat;
wire        wb_s2m_h2f_lw_vga0_slave_ack;
wire        wb_s2m_h2f_lw_vga0_slave_err;
wire        wb_s2m_h2f_lw_vga0_slave_rty;
wire [31:0] wb_m2s_resize_gpio0_adr;
wire [31:0] wb_m2s_resize_gpio0_dat;
wire  [3:0] wb_m2s_resize_gpio0_sel;
wire        wb_m2s_resize_gpio0_we;
wire        wb_m2s_resize_gpio0_cyc;
wire        wb_m2s_resize_gpio0_stb;
wire  [2:0] wb_m2s_resize_gpio0_cti;
wire  [1:0] wb_m2s_resize_gpio0_bte;
wire [31:0] wb_s2m_resize_gpio0_dat;
wire        wb_s2m_resize_gpio0_ack;
wire        wb_s2m_resize_gpio0_err;
wire        wb_s2m_resize_gpio0_rty;
wire [31:0] wb_m2s_resize_uart0_adr;
wire [31:0] wb_m2s_resize_uart0_dat;
wire  [3:0] wb_m2s_resize_uart0_sel;
wire        wb_m2s_resize_uart0_we;
wire        wb_m2s_resize_uart0_cyc;
wire        wb_m2s_resize_uart0_stb;
wire  [2:0] wb_m2s_resize_uart0_cti;
wire  [1:0] wb_m2s_resize_uart0_bte;
wire [31:0] wb_s2m_resize_uart0_dat;
wire        wb_s2m_resize_uart0_ack;
wire        wb_s2m_resize_uart0_err;
wire        wb_s2m_resize_uart0_rty;
wire [31:0] wb_m2s_resize_i2c0_adr;
wire [31:0] wb_m2s_resize_i2c0_dat;
wire  [3:0] wb_m2s_resize_i2c0_sel;
wire        wb_m2s_resize_i2c0_we;
wire        wb_m2s_resize_i2c0_cyc;
wire        wb_m2s_resize_i2c0_stb;
wire  [2:0] wb_m2s_resize_i2c0_cti;
wire  [1:0] wb_m2s_resize_i2c0_bte;
wire [31:0] wb_s2m_resize_i2c0_dat;
wire        wb_s2m_resize_i2c0_ack;
wire        wb_s2m_resize_i2c0_err;
wire        wb_s2m_resize_i2c0_rty;

wb_mux
  #(.num_slaves (4),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'hf0000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffc0}))
 wb_mux_or1k0_i
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k0_i_adr_i),
    .wbm_dat_i (wb_or1k0_i_dat_i),
    .wbm_sel_i (wb_or1k0_i_sel_i),
    .wbm_we_i  (wb_or1k0_i_we_i),
    .wbm_cyc_i (wb_or1k0_i_cyc_i),
    .wbm_stb_i (wb_or1k0_i_stb_i),
    .wbm_cti_i (wb_or1k0_i_cti_i),
    .wbm_bte_i (wb_or1k0_i_bte_i),
    .wbm_dat_o (wb_or1k0_i_dat_o),
    .wbm_ack_o (wb_or1k0_i_ack_o),
    .wbm_err_o (wb_or1k0_i_err_o),
    .wbm_rty_o (wb_or1k0_i_rty_o),
    .wbs_adr_o ({wb_m2s_or1k0_i_hps_ddr3_adr, wb_m2s_or1k0_i_fpga_ddr3_adr, wb_m2s_or1k0_i_sram0_adr, wb_m2s_or1k0_i_rom0_adr}),
    .wbs_dat_o ({wb_m2s_or1k0_i_hps_ddr3_dat, wb_m2s_or1k0_i_fpga_ddr3_dat, wb_m2s_or1k0_i_sram0_dat, wb_m2s_or1k0_i_rom0_dat}),
    .wbs_sel_o ({wb_m2s_or1k0_i_hps_ddr3_sel, wb_m2s_or1k0_i_fpga_ddr3_sel, wb_m2s_or1k0_i_sram0_sel, wb_m2s_or1k0_i_rom0_sel}),
    .wbs_we_o  ({wb_m2s_or1k0_i_hps_ddr3_we, wb_m2s_or1k0_i_fpga_ddr3_we, wb_m2s_or1k0_i_sram0_we, wb_m2s_or1k0_i_rom0_we}),
    .wbs_cyc_o ({wb_m2s_or1k0_i_hps_ddr3_cyc, wb_m2s_or1k0_i_fpga_ddr3_cyc, wb_m2s_or1k0_i_sram0_cyc, wb_m2s_or1k0_i_rom0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k0_i_hps_ddr3_stb, wb_m2s_or1k0_i_fpga_ddr3_stb, wb_m2s_or1k0_i_sram0_stb, wb_m2s_or1k0_i_rom0_stb}),
    .wbs_cti_o ({wb_m2s_or1k0_i_hps_ddr3_cti, wb_m2s_or1k0_i_fpga_ddr3_cti, wb_m2s_or1k0_i_sram0_cti, wb_m2s_or1k0_i_rom0_cti}),
    .wbs_bte_o ({wb_m2s_or1k0_i_hps_ddr3_bte, wb_m2s_or1k0_i_fpga_ddr3_bte, wb_m2s_or1k0_i_sram0_bte, wb_m2s_or1k0_i_rom0_bte}),
    .wbs_dat_i ({wb_s2m_or1k0_i_hps_ddr3_dat, wb_s2m_or1k0_i_fpga_ddr3_dat, wb_s2m_or1k0_i_sram0_dat, wb_s2m_or1k0_i_rom0_dat}),
    .wbs_ack_i ({wb_s2m_or1k0_i_hps_ddr3_ack, wb_s2m_or1k0_i_fpga_ddr3_ack, wb_s2m_or1k0_i_sram0_ack, wb_s2m_or1k0_i_rom0_ack}),
    .wbs_err_i ({wb_s2m_or1k0_i_hps_ddr3_err, wb_s2m_or1k0_i_fpga_ddr3_err, wb_s2m_or1k0_i_sram0_err, wb_s2m_or1k0_i_rom0_err}),
    .wbs_rty_i ({wb_s2m_or1k0_i_hps_ddr3_rty, wb_s2m_or1k0_i_fpga_ddr3_rty, wb_s2m_or1k0_i_sram0_rty, wb_s2m_or1k0_i_rom0_rty}));

wb_mux
  #(.num_slaves (10),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'h90000000, 32'h91000000, 32'ha0000000, 32'h91000100, 32'h97000000, 32'h98000000, 32'h99000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffe0, 32'hfffffffe, 32'hfffffff8, 32'hffffff00, 32'hfffff000, 32'hffffff00, 32'hfffffffc}))
 wb_mux_or1k0_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k0_d_adr_i),
    .wbm_dat_i (wb_or1k0_d_dat_i),
    .wbm_sel_i (wb_or1k0_d_sel_i),
    .wbm_we_i  (wb_or1k0_d_we_i),
    .wbm_cyc_i (wb_or1k0_d_cyc_i),
    .wbm_stb_i (wb_or1k0_d_stb_i),
    .wbm_cti_i (wb_or1k0_d_cti_i),
    .wbm_bte_i (wb_or1k0_d_bte_i),
    .wbm_dat_o (wb_or1k0_d_dat_o),
    .wbm_ack_o (wb_or1k0_d_ack_o),
    .wbm_err_o (wb_or1k0_d_err_o),
    .wbm_rty_o (wb_or1k0_d_rty_o),
    .wbs_adr_o ({wb_m2s_or1k0_d_hps_ddr3_adr, wb_m2s_or1k0_d_fpga_ddr3_adr, wb_m2s_or1k0_d_sram0_adr, wb_m2s_or1k0_d_uart0_adr, wb_m2s_or1k0_d_gpio0_adr, wb_m2s_or1k0_d_i2c0_adr, wb_m2s_or1k0_d_clkgen_adr, wb_m2s_or1k0_d_vga0_slave_adr, wb_m2s_or1k0_d_ipi_adr, wb_m2s_or1k0_d_tc_adr}),
    .wbs_dat_o ({wb_m2s_or1k0_d_hps_ddr3_dat, wb_m2s_or1k0_d_fpga_ddr3_dat, wb_m2s_or1k0_d_sram0_dat, wb_m2s_or1k0_d_uart0_dat, wb_m2s_or1k0_d_gpio0_dat, wb_m2s_or1k0_d_i2c0_dat, wb_m2s_or1k0_d_clkgen_dat, wb_m2s_or1k0_d_vga0_slave_dat, wb_m2s_or1k0_d_ipi_dat, wb_m2s_or1k0_d_tc_dat}),
    .wbs_sel_o ({wb_m2s_or1k0_d_hps_ddr3_sel, wb_m2s_or1k0_d_fpga_ddr3_sel, wb_m2s_or1k0_d_sram0_sel, wb_m2s_or1k0_d_uart0_sel, wb_m2s_or1k0_d_gpio0_sel, wb_m2s_or1k0_d_i2c0_sel, wb_m2s_or1k0_d_clkgen_sel, wb_m2s_or1k0_d_vga0_slave_sel, wb_m2s_or1k0_d_ipi_sel, wb_m2s_or1k0_d_tc_sel}),
    .wbs_we_o  ({wb_m2s_or1k0_d_hps_ddr3_we, wb_m2s_or1k0_d_fpga_ddr3_we, wb_m2s_or1k0_d_sram0_we, wb_m2s_or1k0_d_uart0_we, wb_m2s_or1k0_d_gpio0_we, wb_m2s_or1k0_d_i2c0_we, wb_m2s_or1k0_d_clkgen_we, wb_m2s_or1k0_d_vga0_slave_we, wb_m2s_or1k0_d_ipi_we, wb_m2s_or1k0_d_tc_we}),
    .wbs_cyc_o ({wb_m2s_or1k0_d_hps_ddr3_cyc, wb_m2s_or1k0_d_fpga_ddr3_cyc, wb_m2s_or1k0_d_sram0_cyc, wb_m2s_or1k0_d_uart0_cyc, wb_m2s_or1k0_d_gpio0_cyc, wb_m2s_or1k0_d_i2c0_cyc, wb_m2s_or1k0_d_clkgen_cyc, wb_m2s_or1k0_d_vga0_slave_cyc, wb_m2s_or1k0_d_ipi_cyc, wb_m2s_or1k0_d_tc_cyc}),
    .wbs_stb_o ({wb_m2s_or1k0_d_hps_ddr3_stb, wb_m2s_or1k0_d_fpga_ddr3_stb, wb_m2s_or1k0_d_sram0_stb, wb_m2s_or1k0_d_uart0_stb, wb_m2s_or1k0_d_gpio0_stb, wb_m2s_or1k0_d_i2c0_stb, wb_m2s_or1k0_d_clkgen_stb, wb_m2s_or1k0_d_vga0_slave_stb, wb_m2s_or1k0_d_ipi_stb, wb_m2s_or1k0_d_tc_stb}),
    .wbs_cti_o ({wb_m2s_or1k0_d_hps_ddr3_cti, wb_m2s_or1k0_d_fpga_ddr3_cti, wb_m2s_or1k0_d_sram0_cti, wb_m2s_or1k0_d_uart0_cti, wb_m2s_or1k0_d_gpio0_cti, wb_m2s_or1k0_d_i2c0_cti, wb_m2s_or1k0_d_clkgen_cti, wb_m2s_or1k0_d_vga0_slave_cti, wb_m2s_or1k0_d_ipi_cti, wb_m2s_or1k0_d_tc_cti}),
    .wbs_bte_o ({wb_m2s_or1k0_d_hps_ddr3_bte, wb_m2s_or1k0_d_fpga_ddr3_bte, wb_m2s_or1k0_d_sram0_bte, wb_m2s_or1k0_d_uart0_bte, wb_m2s_or1k0_d_gpio0_bte, wb_m2s_or1k0_d_i2c0_bte, wb_m2s_or1k0_d_clkgen_bte, wb_m2s_or1k0_d_vga0_slave_bte, wb_m2s_or1k0_d_ipi_bte, wb_m2s_or1k0_d_tc_bte}),
    .wbs_dat_i ({wb_s2m_or1k0_d_hps_ddr3_dat, wb_s2m_or1k0_d_fpga_ddr3_dat, wb_s2m_or1k0_d_sram0_dat, wb_s2m_or1k0_d_uart0_dat, wb_s2m_or1k0_d_gpio0_dat, wb_s2m_or1k0_d_i2c0_dat, wb_s2m_or1k0_d_clkgen_dat, wb_s2m_or1k0_d_vga0_slave_dat, wb_s2m_or1k0_d_ipi_dat, wb_s2m_or1k0_d_tc_dat}),
    .wbs_ack_i ({wb_s2m_or1k0_d_hps_ddr3_ack, wb_s2m_or1k0_d_fpga_ddr3_ack, wb_s2m_or1k0_d_sram0_ack, wb_s2m_or1k0_d_uart0_ack, wb_s2m_or1k0_d_gpio0_ack, wb_s2m_or1k0_d_i2c0_ack, wb_s2m_or1k0_d_clkgen_ack, wb_s2m_or1k0_d_vga0_slave_ack, wb_s2m_or1k0_d_ipi_ack, wb_s2m_or1k0_d_tc_ack}),
    .wbs_err_i ({wb_s2m_or1k0_d_hps_ddr3_err, wb_s2m_or1k0_d_fpga_ddr3_err, wb_s2m_or1k0_d_sram0_err, wb_s2m_or1k0_d_uart0_err, wb_s2m_or1k0_d_gpio0_err, wb_s2m_or1k0_d_i2c0_err, wb_s2m_or1k0_d_clkgen_err, wb_s2m_or1k0_d_vga0_slave_err, wb_s2m_or1k0_d_ipi_err, wb_s2m_or1k0_d_tc_err}),
    .wbs_rty_i ({wb_s2m_or1k0_d_hps_ddr3_rty, wb_s2m_or1k0_d_fpga_ddr3_rty, wb_s2m_or1k0_d_sram0_rty, wb_s2m_or1k0_d_uart0_rty, wb_s2m_or1k0_d_gpio0_rty, wb_s2m_or1k0_d_i2c0_rty, wb_s2m_or1k0_d_clkgen_rty, wb_s2m_or1k0_d_vga0_slave_rty, wb_s2m_or1k0_d_ipi_rty, wb_s2m_or1k0_d_tc_rty}));

wb_mux
  #(.num_slaves (4),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'hf0000100}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffc0}))
 wb_mux_or1k1_i
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k1_i_adr_i),
    .wbm_dat_i (wb_or1k1_i_dat_i),
    .wbm_sel_i (wb_or1k1_i_sel_i),
    .wbm_we_i  (wb_or1k1_i_we_i),
    .wbm_cyc_i (wb_or1k1_i_cyc_i),
    .wbm_stb_i (wb_or1k1_i_stb_i),
    .wbm_cti_i (wb_or1k1_i_cti_i),
    .wbm_bte_i (wb_or1k1_i_bte_i),
    .wbm_dat_o (wb_or1k1_i_dat_o),
    .wbm_ack_o (wb_or1k1_i_ack_o),
    .wbm_err_o (wb_or1k1_i_err_o),
    .wbm_rty_o (wb_or1k1_i_rty_o),
    .wbs_adr_o ({wb_m2s_or1k1_i_hps_ddr3_adr, wb_m2s_or1k1_i_fpga_ddr3_adr, wb_m2s_or1k1_i_sram0_adr, wb_m2s_or1k1_i_rom0_adr}),
    .wbs_dat_o ({wb_m2s_or1k1_i_hps_ddr3_dat, wb_m2s_or1k1_i_fpga_ddr3_dat, wb_m2s_or1k1_i_sram0_dat, wb_m2s_or1k1_i_rom0_dat}),
    .wbs_sel_o ({wb_m2s_or1k1_i_hps_ddr3_sel, wb_m2s_or1k1_i_fpga_ddr3_sel, wb_m2s_or1k1_i_sram0_sel, wb_m2s_or1k1_i_rom0_sel}),
    .wbs_we_o  ({wb_m2s_or1k1_i_hps_ddr3_we, wb_m2s_or1k1_i_fpga_ddr3_we, wb_m2s_or1k1_i_sram0_we, wb_m2s_or1k1_i_rom0_we}),
    .wbs_cyc_o ({wb_m2s_or1k1_i_hps_ddr3_cyc, wb_m2s_or1k1_i_fpga_ddr3_cyc, wb_m2s_or1k1_i_sram0_cyc, wb_m2s_or1k1_i_rom0_cyc}),
    .wbs_stb_o ({wb_m2s_or1k1_i_hps_ddr3_stb, wb_m2s_or1k1_i_fpga_ddr3_stb, wb_m2s_or1k1_i_sram0_stb, wb_m2s_or1k1_i_rom0_stb}),
    .wbs_cti_o ({wb_m2s_or1k1_i_hps_ddr3_cti, wb_m2s_or1k1_i_fpga_ddr3_cti, wb_m2s_or1k1_i_sram0_cti, wb_m2s_or1k1_i_rom0_cti}),
    .wbs_bte_o ({wb_m2s_or1k1_i_hps_ddr3_bte, wb_m2s_or1k1_i_fpga_ddr3_bte, wb_m2s_or1k1_i_sram0_bte, wb_m2s_or1k1_i_rom0_bte}),
    .wbs_dat_i ({wb_s2m_or1k1_i_hps_ddr3_dat, wb_s2m_or1k1_i_fpga_ddr3_dat, wb_s2m_or1k1_i_sram0_dat, wb_s2m_or1k1_i_rom0_dat}),
    .wbs_ack_i ({wb_s2m_or1k1_i_hps_ddr3_ack, wb_s2m_or1k1_i_fpga_ddr3_ack, wb_s2m_or1k1_i_sram0_ack, wb_s2m_or1k1_i_rom0_ack}),
    .wbs_err_i ({wb_s2m_or1k1_i_hps_ddr3_err, wb_s2m_or1k1_i_fpga_ddr3_err, wb_s2m_or1k1_i_sram0_err, wb_s2m_or1k1_i_rom0_err}),
    .wbs_rty_i ({wb_s2m_or1k1_i_hps_ddr3_rty, wb_s2m_or1k1_i_fpga_ddr3_rty, wb_s2m_or1k1_i_sram0_rty, wb_s2m_or1k1_i_rom0_rty}));

wb_mux
  #(.num_slaves (10),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'h90000000, 32'h91000000, 32'ha0000000, 32'h91000100, 32'h97000000, 32'h98000000, 32'h99000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffe0, 32'hfffffffe, 32'hfffffff8, 32'hffffff00, 32'hfffff000, 32'hffffff00, 32'hfffffffc}))
 wb_mux_or1k1_d
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_or1k1_d_adr_i),
    .wbm_dat_i (wb_or1k1_d_dat_i),
    .wbm_sel_i (wb_or1k1_d_sel_i),
    .wbm_we_i  (wb_or1k1_d_we_i),
    .wbm_cyc_i (wb_or1k1_d_cyc_i),
    .wbm_stb_i (wb_or1k1_d_stb_i),
    .wbm_cti_i (wb_or1k1_d_cti_i),
    .wbm_bte_i (wb_or1k1_d_bte_i),
    .wbm_dat_o (wb_or1k1_d_dat_o),
    .wbm_ack_o (wb_or1k1_d_ack_o),
    .wbm_err_o (wb_or1k1_d_err_o),
    .wbm_rty_o (wb_or1k1_d_rty_o),
    .wbs_adr_o ({wb_m2s_or1k1_d_hps_ddr3_adr, wb_m2s_or1k1_d_fpga_ddr3_adr, wb_m2s_or1k1_d_sram0_adr, wb_m2s_or1k1_d_uart0_adr, wb_m2s_or1k1_d_gpio0_adr, wb_m2s_or1k1_d_i2c0_adr, wb_m2s_or1k1_d_clkgen_adr, wb_m2s_or1k1_d_vga0_slave_adr, wb_m2s_or1k1_d_ipi_adr, wb_m2s_or1k1_d_tc_adr}),
    .wbs_dat_o ({wb_m2s_or1k1_d_hps_ddr3_dat, wb_m2s_or1k1_d_fpga_ddr3_dat, wb_m2s_or1k1_d_sram0_dat, wb_m2s_or1k1_d_uart0_dat, wb_m2s_or1k1_d_gpio0_dat, wb_m2s_or1k1_d_i2c0_dat, wb_m2s_or1k1_d_clkgen_dat, wb_m2s_or1k1_d_vga0_slave_dat, wb_m2s_or1k1_d_ipi_dat, wb_m2s_or1k1_d_tc_dat}),
    .wbs_sel_o ({wb_m2s_or1k1_d_hps_ddr3_sel, wb_m2s_or1k1_d_fpga_ddr3_sel, wb_m2s_or1k1_d_sram0_sel, wb_m2s_or1k1_d_uart0_sel, wb_m2s_or1k1_d_gpio0_sel, wb_m2s_or1k1_d_i2c0_sel, wb_m2s_or1k1_d_clkgen_sel, wb_m2s_or1k1_d_vga0_slave_sel, wb_m2s_or1k1_d_ipi_sel, wb_m2s_or1k1_d_tc_sel}),
    .wbs_we_o  ({wb_m2s_or1k1_d_hps_ddr3_we, wb_m2s_or1k1_d_fpga_ddr3_we, wb_m2s_or1k1_d_sram0_we, wb_m2s_or1k1_d_uart0_we, wb_m2s_or1k1_d_gpio0_we, wb_m2s_or1k1_d_i2c0_we, wb_m2s_or1k1_d_clkgen_we, wb_m2s_or1k1_d_vga0_slave_we, wb_m2s_or1k1_d_ipi_we, wb_m2s_or1k1_d_tc_we}),
    .wbs_cyc_o ({wb_m2s_or1k1_d_hps_ddr3_cyc, wb_m2s_or1k1_d_fpga_ddr3_cyc, wb_m2s_or1k1_d_sram0_cyc, wb_m2s_or1k1_d_uart0_cyc, wb_m2s_or1k1_d_gpio0_cyc, wb_m2s_or1k1_d_i2c0_cyc, wb_m2s_or1k1_d_clkgen_cyc, wb_m2s_or1k1_d_vga0_slave_cyc, wb_m2s_or1k1_d_ipi_cyc, wb_m2s_or1k1_d_tc_cyc}),
    .wbs_stb_o ({wb_m2s_or1k1_d_hps_ddr3_stb, wb_m2s_or1k1_d_fpga_ddr3_stb, wb_m2s_or1k1_d_sram0_stb, wb_m2s_or1k1_d_uart0_stb, wb_m2s_or1k1_d_gpio0_stb, wb_m2s_or1k1_d_i2c0_stb, wb_m2s_or1k1_d_clkgen_stb, wb_m2s_or1k1_d_vga0_slave_stb, wb_m2s_or1k1_d_ipi_stb, wb_m2s_or1k1_d_tc_stb}),
    .wbs_cti_o ({wb_m2s_or1k1_d_hps_ddr3_cti, wb_m2s_or1k1_d_fpga_ddr3_cti, wb_m2s_or1k1_d_sram0_cti, wb_m2s_or1k1_d_uart0_cti, wb_m2s_or1k1_d_gpio0_cti, wb_m2s_or1k1_d_i2c0_cti, wb_m2s_or1k1_d_clkgen_cti, wb_m2s_or1k1_d_vga0_slave_cti, wb_m2s_or1k1_d_ipi_cti, wb_m2s_or1k1_d_tc_cti}),
    .wbs_bte_o ({wb_m2s_or1k1_d_hps_ddr3_bte, wb_m2s_or1k1_d_fpga_ddr3_bte, wb_m2s_or1k1_d_sram0_bte, wb_m2s_or1k1_d_uart0_bte, wb_m2s_or1k1_d_gpio0_bte, wb_m2s_or1k1_d_i2c0_bte, wb_m2s_or1k1_d_clkgen_bte, wb_m2s_or1k1_d_vga0_slave_bte, wb_m2s_or1k1_d_ipi_bte, wb_m2s_or1k1_d_tc_bte}),
    .wbs_dat_i ({wb_s2m_or1k1_d_hps_ddr3_dat, wb_s2m_or1k1_d_fpga_ddr3_dat, wb_s2m_or1k1_d_sram0_dat, wb_s2m_or1k1_d_uart0_dat, wb_s2m_or1k1_d_gpio0_dat, wb_s2m_or1k1_d_i2c0_dat, wb_s2m_or1k1_d_clkgen_dat, wb_s2m_or1k1_d_vga0_slave_dat, wb_s2m_or1k1_d_ipi_dat, wb_s2m_or1k1_d_tc_dat}),
    .wbs_ack_i ({wb_s2m_or1k1_d_hps_ddr3_ack, wb_s2m_or1k1_d_fpga_ddr3_ack, wb_s2m_or1k1_d_sram0_ack, wb_s2m_or1k1_d_uart0_ack, wb_s2m_or1k1_d_gpio0_ack, wb_s2m_or1k1_d_i2c0_ack, wb_s2m_or1k1_d_clkgen_ack, wb_s2m_or1k1_d_vga0_slave_ack, wb_s2m_or1k1_d_ipi_ack, wb_s2m_or1k1_d_tc_ack}),
    .wbs_err_i ({wb_s2m_or1k1_d_hps_ddr3_err, wb_s2m_or1k1_d_fpga_ddr3_err, wb_s2m_or1k1_d_sram0_err, wb_s2m_or1k1_d_uart0_err, wb_s2m_or1k1_d_gpio0_err, wb_s2m_or1k1_d_i2c0_err, wb_s2m_or1k1_d_clkgen_err, wb_s2m_or1k1_d_vga0_slave_err, wb_s2m_or1k1_d_ipi_err, wb_s2m_or1k1_d_tc_err}),
    .wbs_rty_i ({wb_s2m_or1k1_d_hps_ddr3_rty, wb_s2m_or1k1_d_fpga_ddr3_rty, wb_s2m_or1k1_d_sram0_rty, wb_s2m_or1k1_d_uart0_rty, wb_s2m_or1k1_d_gpio0_rty, wb_s2m_or1k1_d_i2c0_rty, wb_s2m_or1k1_d_clkgen_rty, wb_s2m_or1k1_d_vga0_slave_rty, wb_s2m_or1k1_d_ipi_rty, wb_s2m_or1k1_d_tc_rty}));

wb_mux
  #(.num_slaves (2),
    .MATCH_ADDR ({32'h40000000, 32'h00000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000}))
 wb_mux_vga0_master
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_vga0_master_adr_i),
    .wbm_dat_i (wb_vga0_master_dat_i),
    .wbm_sel_i (wb_vga0_master_sel_i),
    .wbm_we_i  (wb_vga0_master_we_i),
    .wbm_cyc_i (wb_vga0_master_cyc_i),
    .wbm_stb_i (wb_vga0_master_stb_i),
    .wbm_cti_i (wb_vga0_master_cti_i),
    .wbm_bte_i (wb_vga0_master_bte_i),
    .wbm_dat_o (wb_vga0_master_dat_o),
    .wbm_ack_o (wb_vga0_master_ack_o),
    .wbm_err_o (wb_vga0_master_err_o),
    .wbm_rty_o (wb_vga0_master_rty_o),
    .wbs_adr_o ({wb_m2s_vga0_master_hps_ddr3_adr, wb_vga0_ddr3_adr_o}),
    .wbs_dat_o ({wb_m2s_vga0_master_hps_ddr3_dat, wb_vga0_ddr3_dat_o}),
    .wbs_sel_o ({wb_m2s_vga0_master_hps_ddr3_sel, wb_vga0_ddr3_sel_o}),
    .wbs_we_o  ({wb_m2s_vga0_master_hps_ddr3_we, wb_vga0_ddr3_we_o}),
    .wbs_cyc_o ({wb_m2s_vga0_master_hps_ddr3_cyc, wb_vga0_ddr3_cyc_o}),
    .wbs_stb_o ({wb_m2s_vga0_master_hps_ddr3_stb, wb_vga0_ddr3_stb_o}),
    .wbs_cti_o ({wb_m2s_vga0_master_hps_ddr3_cti, wb_vga0_ddr3_cti_o}),
    .wbs_bte_o ({wb_m2s_vga0_master_hps_ddr3_bte, wb_vga0_ddr3_bte_o}),
    .wbs_dat_i ({wb_s2m_vga0_master_hps_ddr3_dat, wb_vga0_ddr3_dat_i}),
    .wbs_ack_i ({wb_s2m_vga0_master_hps_ddr3_ack, wb_vga0_ddr3_ack_i}),
    .wbs_err_i ({wb_s2m_vga0_master_hps_ddr3_err, wb_vga0_ddr3_err_i}),
    .wbs_rty_i ({wb_s2m_vga0_master_hps_ddr3_rty, wb_vga0_ddr3_rty_i}));

wb_mux
  #(.num_slaves (9),
    .MATCH_ADDR ({32'h40000000, 32'h00000000, 32'h80000000, 32'h90000000, 32'h91000000, 32'ha0000000, 32'h96000000, 32'h91000100, 32'h97000000}),
    .MATCH_MASK ({32'hc0000000, 32'hc0000000, 32'hffffe000, 32'hffffffe0, 32'hfffffffe, 32'hfffffff8, 32'hffb00000, 32'hffffff00, 32'hfffff000}))
 wb_mux_dbg
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_dbg_adr_i),
    .wbm_dat_i (wb_dbg_dat_i),
    .wbm_sel_i (wb_dbg_sel_i),
    .wbm_we_i  (wb_dbg_we_i),
    .wbm_cyc_i (wb_dbg_cyc_i),
    .wbm_stb_i (wb_dbg_stb_i),
    .wbm_cti_i (wb_dbg_cti_i),
    .wbm_bte_i (wb_dbg_bte_i),
    .wbm_dat_o (wb_dbg_dat_o),
    .wbm_ack_o (wb_dbg_ack_o),
    .wbm_err_o (wb_dbg_err_o),
    .wbm_rty_o (wb_dbg_rty_o),
    .wbs_adr_o ({wb_m2s_dbg_hps_ddr3_adr, wb_m2s_dbg_fpga_ddr3_adr, wb_m2s_dbg_sram0_adr, wb_m2s_dbg_uart0_adr, wb_m2s_dbg_gpio0_adr, wb_m2s_dbg_i2c0_adr, wb_m2s_dbg_diila_adr, wb_m2s_dbg_clkgen_adr, wb_m2s_dbg_vga0_slave_adr}),
    .wbs_dat_o ({wb_m2s_dbg_hps_ddr3_dat, wb_m2s_dbg_fpga_ddr3_dat, wb_m2s_dbg_sram0_dat, wb_m2s_dbg_uart0_dat, wb_m2s_dbg_gpio0_dat, wb_m2s_dbg_i2c0_dat, wb_m2s_dbg_diila_dat, wb_m2s_dbg_clkgen_dat, wb_m2s_dbg_vga0_slave_dat}),
    .wbs_sel_o ({wb_m2s_dbg_hps_ddr3_sel, wb_m2s_dbg_fpga_ddr3_sel, wb_m2s_dbg_sram0_sel, wb_m2s_dbg_uart0_sel, wb_m2s_dbg_gpio0_sel, wb_m2s_dbg_i2c0_sel, wb_m2s_dbg_diila_sel, wb_m2s_dbg_clkgen_sel, wb_m2s_dbg_vga0_slave_sel}),
    .wbs_we_o  ({wb_m2s_dbg_hps_ddr3_we, wb_m2s_dbg_fpga_ddr3_we, wb_m2s_dbg_sram0_we, wb_m2s_dbg_uart0_we, wb_m2s_dbg_gpio0_we, wb_m2s_dbg_i2c0_we, wb_m2s_dbg_diila_we, wb_m2s_dbg_clkgen_we, wb_m2s_dbg_vga0_slave_we}),
    .wbs_cyc_o ({wb_m2s_dbg_hps_ddr3_cyc, wb_m2s_dbg_fpga_ddr3_cyc, wb_m2s_dbg_sram0_cyc, wb_m2s_dbg_uart0_cyc, wb_m2s_dbg_gpio0_cyc, wb_m2s_dbg_i2c0_cyc, wb_m2s_dbg_diila_cyc, wb_m2s_dbg_clkgen_cyc, wb_m2s_dbg_vga0_slave_cyc}),
    .wbs_stb_o ({wb_m2s_dbg_hps_ddr3_stb, wb_m2s_dbg_fpga_ddr3_stb, wb_m2s_dbg_sram0_stb, wb_m2s_dbg_uart0_stb, wb_m2s_dbg_gpio0_stb, wb_m2s_dbg_i2c0_stb, wb_m2s_dbg_diila_stb, wb_m2s_dbg_clkgen_stb, wb_m2s_dbg_vga0_slave_stb}),
    .wbs_cti_o ({wb_m2s_dbg_hps_ddr3_cti, wb_m2s_dbg_fpga_ddr3_cti, wb_m2s_dbg_sram0_cti, wb_m2s_dbg_uart0_cti, wb_m2s_dbg_gpio0_cti, wb_m2s_dbg_i2c0_cti, wb_m2s_dbg_diila_cti, wb_m2s_dbg_clkgen_cti, wb_m2s_dbg_vga0_slave_cti}),
    .wbs_bte_o ({wb_m2s_dbg_hps_ddr3_bte, wb_m2s_dbg_fpga_ddr3_bte, wb_m2s_dbg_sram0_bte, wb_m2s_dbg_uart0_bte, wb_m2s_dbg_gpio0_bte, wb_m2s_dbg_i2c0_bte, wb_m2s_dbg_diila_bte, wb_m2s_dbg_clkgen_bte, wb_m2s_dbg_vga0_slave_bte}),
    .wbs_dat_i ({wb_s2m_dbg_hps_ddr3_dat, wb_s2m_dbg_fpga_ddr3_dat, wb_s2m_dbg_sram0_dat, wb_s2m_dbg_uart0_dat, wb_s2m_dbg_gpio0_dat, wb_s2m_dbg_i2c0_dat, wb_s2m_dbg_diila_dat, wb_s2m_dbg_clkgen_dat, wb_s2m_dbg_vga0_slave_dat}),
    .wbs_ack_i ({wb_s2m_dbg_hps_ddr3_ack, wb_s2m_dbg_fpga_ddr3_ack, wb_s2m_dbg_sram0_ack, wb_s2m_dbg_uart0_ack, wb_s2m_dbg_gpio0_ack, wb_s2m_dbg_i2c0_ack, wb_s2m_dbg_diila_ack, wb_s2m_dbg_clkgen_ack, wb_s2m_dbg_vga0_slave_ack}),
    .wbs_err_i ({wb_s2m_dbg_hps_ddr3_err, wb_s2m_dbg_fpga_ddr3_err, wb_s2m_dbg_sram0_err, wb_s2m_dbg_uart0_err, wb_s2m_dbg_gpio0_err, wb_s2m_dbg_i2c0_err, wb_s2m_dbg_diila_err, wb_s2m_dbg_clkgen_err, wb_s2m_dbg_vga0_slave_err}),
    .wbs_rty_i ({wb_s2m_dbg_hps_ddr3_rty, wb_s2m_dbg_fpga_ddr3_rty, wb_s2m_dbg_sram0_rty, wb_s2m_dbg_uart0_rty, wb_s2m_dbg_gpio0_rty, wb_s2m_dbg_i2c0_rty, wb_s2m_dbg_diila_rty, wb_s2m_dbg_clkgen_rty, wb_s2m_dbg_vga0_slave_rty}));

wb_mux
  #(.num_slaves (6),
    .MATCH_ADDR ({32'h90000000, 32'h91000000, 32'ha0000000, 32'h91000100, 32'h96000000, 32'h97000000}),
    .MATCH_MASK ({32'hffffffe0, 32'hfffffffe, 32'hfffffff8, 32'hffffff00, 32'hffb00000, 32'hfffff000}))
 wb_mux_h2f_lw
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i (wb_h2f_lw_adr_i),
    .wbm_dat_i (wb_h2f_lw_dat_i),
    .wbm_sel_i (wb_h2f_lw_sel_i),
    .wbm_we_i  (wb_h2f_lw_we_i),
    .wbm_cyc_i (wb_h2f_lw_cyc_i),
    .wbm_stb_i (wb_h2f_lw_stb_i),
    .wbm_cti_i (wb_h2f_lw_cti_i),
    .wbm_bte_i (wb_h2f_lw_bte_i),
    .wbm_dat_o (wb_h2f_lw_dat_o),
    .wbm_ack_o (wb_h2f_lw_ack_o),
    .wbm_err_o (wb_h2f_lw_err_o),
    .wbm_rty_o (wb_h2f_lw_rty_o),
    .wbs_adr_o ({wb_m2s_h2f_lw_uart0_adr, wb_m2s_h2f_lw_gpio0_adr, wb_m2s_h2f_lw_i2c0_adr, wb_m2s_h2f_lw_clkgen_adr, wb_m2s_h2f_lw_diila_adr, wb_m2s_h2f_lw_vga0_slave_adr}),
    .wbs_dat_o ({wb_m2s_h2f_lw_uart0_dat, wb_m2s_h2f_lw_gpio0_dat, wb_m2s_h2f_lw_i2c0_dat, wb_m2s_h2f_lw_clkgen_dat, wb_m2s_h2f_lw_diila_dat, wb_m2s_h2f_lw_vga0_slave_dat}),
    .wbs_sel_o ({wb_m2s_h2f_lw_uart0_sel, wb_m2s_h2f_lw_gpio0_sel, wb_m2s_h2f_lw_i2c0_sel, wb_m2s_h2f_lw_clkgen_sel, wb_m2s_h2f_lw_diila_sel, wb_m2s_h2f_lw_vga0_slave_sel}),
    .wbs_we_o  ({wb_m2s_h2f_lw_uart0_we, wb_m2s_h2f_lw_gpio0_we, wb_m2s_h2f_lw_i2c0_we, wb_m2s_h2f_lw_clkgen_we, wb_m2s_h2f_lw_diila_we, wb_m2s_h2f_lw_vga0_slave_we}),
    .wbs_cyc_o ({wb_m2s_h2f_lw_uart0_cyc, wb_m2s_h2f_lw_gpio0_cyc, wb_m2s_h2f_lw_i2c0_cyc, wb_m2s_h2f_lw_clkgen_cyc, wb_m2s_h2f_lw_diila_cyc, wb_m2s_h2f_lw_vga0_slave_cyc}),
    .wbs_stb_o ({wb_m2s_h2f_lw_uart0_stb, wb_m2s_h2f_lw_gpio0_stb, wb_m2s_h2f_lw_i2c0_stb, wb_m2s_h2f_lw_clkgen_stb, wb_m2s_h2f_lw_diila_stb, wb_m2s_h2f_lw_vga0_slave_stb}),
    .wbs_cti_o ({wb_m2s_h2f_lw_uart0_cti, wb_m2s_h2f_lw_gpio0_cti, wb_m2s_h2f_lw_i2c0_cti, wb_m2s_h2f_lw_clkgen_cti, wb_m2s_h2f_lw_diila_cti, wb_m2s_h2f_lw_vga0_slave_cti}),
    .wbs_bte_o ({wb_m2s_h2f_lw_uart0_bte, wb_m2s_h2f_lw_gpio0_bte, wb_m2s_h2f_lw_i2c0_bte, wb_m2s_h2f_lw_clkgen_bte, wb_m2s_h2f_lw_diila_bte, wb_m2s_h2f_lw_vga0_slave_bte}),
    .wbs_dat_i ({wb_s2m_h2f_lw_uart0_dat, wb_s2m_h2f_lw_gpio0_dat, wb_s2m_h2f_lw_i2c0_dat, wb_s2m_h2f_lw_clkgen_dat, wb_s2m_h2f_lw_diila_dat, wb_s2m_h2f_lw_vga0_slave_dat}),
    .wbs_ack_i ({wb_s2m_h2f_lw_uart0_ack, wb_s2m_h2f_lw_gpio0_ack, wb_s2m_h2f_lw_i2c0_ack, wb_s2m_h2f_lw_clkgen_ack, wb_s2m_h2f_lw_diila_ack, wb_s2m_h2f_lw_vga0_slave_ack}),
    .wbs_err_i ({wb_s2m_h2f_lw_uart0_err, wb_s2m_h2f_lw_gpio0_err, wb_s2m_h2f_lw_i2c0_err, wb_s2m_h2f_lw_clkgen_err, wb_s2m_h2f_lw_diila_err, wb_s2m_h2f_lw_vga0_slave_err}),
    .wbs_rty_i ({wb_s2m_h2f_lw_uart0_rty, wb_s2m_h2f_lw_gpio0_rty, wb_s2m_h2f_lw_i2c0_rty, wb_s2m_h2f_lw_clkgen_rty, wb_s2m_h2f_lw_diila_rty, wb_s2m_h2f_lw_vga0_slave_rty}));

wb_arbiter
  #(.num_masters (5))
 wb_arbiter_fpga_ddr3
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_fpga_ddr3_adr, wb_m2s_dbg_fpga_ddr3_adr, wb_m2s_or1k1_i_fpga_ddr3_adr, wb_m2s_or1k0_i_fpga_ddr3_adr, wb_m2s_or1k0_d_fpga_ddr3_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_fpga_ddr3_dat, wb_m2s_dbg_fpga_ddr3_dat, wb_m2s_or1k1_i_fpga_ddr3_dat, wb_m2s_or1k0_i_fpga_ddr3_dat, wb_m2s_or1k0_d_fpga_ddr3_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_fpga_ddr3_sel, wb_m2s_dbg_fpga_ddr3_sel, wb_m2s_or1k1_i_fpga_ddr3_sel, wb_m2s_or1k0_i_fpga_ddr3_sel, wb_m2s_or1k0_d_fpga_ddr3_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_fpga_ddr3_we, wb_m2s_dbg_fpga_ddr3_we, wb_m2s_or1k1_i_fpga_ddr3_we, wb_m2s_or1k0_i_fpga_ddr3_we, wb_m2s_or1k0_d_fpga_ddr3_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_fpga_ddr3_cyc, wb_m2s_dbg_fpga_ddr3_cyc, wb_m2s_or1k1_i_fpga_ddr3_cyc, wb_m2s_or1k0_i_fpga_ddr3_cyc, wb_m2s_or1k0_d_fpga_ddr3_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_fpga_ddr3_stb, wb_m2s_dbg_fpga_ddr3_stb, wb_m2s_or1k1_i_fpga_ddr3_stb, wb_m2s_or1k0_i_fpga_ddr3_stb, wb_m2s_or1k0_d_fpga_ddr3_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_fpga_ddr3_cti, wb_m2s_dbg_fpga_ddr3_cti, wb_m2s_or1k1_i_fpga_ddr3_cti, wb_m2s_or1k0_i_fpga_ddr3_cti, wb_m2s_or1k0_d_fpga_ddr3_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_fpga_ddr3_bte, wb_m2s_dbg_fpga_ddr3_bte, wb_m2s_or1k1_i_fpga_ddr3_bte, wb_m2s_or1k0_i_fpga_ddr3_bte, wb_m2s_or1k0_d_fpga_ddr3_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_fpga_ddr3_dat, wb_s2m_dbg_fpga_ddr3_dat, wb_s2m_or1k1_i_fpga_ddr3_dat, wb_s2m_or1k0_i_fpga_ddr3_dat, wb_s2m_or1k0_d_fpga_ddr3_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_fpga_ddr3_ack, wb_s2m_dbg_fpga_ddr3_ack, wb_s2m_or1k1_i_fpga_ddr3_ack, wb_s2m_or1k0_i_fpga_ddr3_ack, wb_s2m_or1k0_d_fpga_ddr3_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_fpga_ddr3_err, wb_s2m_dbg_fpga_ddr3_err, wb_s2m_or1k1_i_fpga_ddr3_err, wb_s2m_or1k0_i_fpga_ddr3_err, wb_s2m_or1k0_d_fpga_ddr3_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_fpga_ddr3_rty, wb_s2m_dbg_fpga_ddr3_rty, wb_s2m_or1k1_i_fpga_ddr3_rty, wb_s2m_or1k0_i_fpga_ddr3_rty, wb_s2m_or1k0_d_fpga_ddr3_rty}),
    .wbs_adr_o (wb_fpga_ddr3_adr_o),
    .wbs_dat_o (wb_fpga_ddr3_dat_o),
    .wbs_sel_o (wb_fpga_ddr3_sel_o),
    .wbs_we_o  (wb_fpga_ddr3_we_o),
    .wbs_cyc_o (wb_fpga_ddr3_cyc_o),
    .wbs_stb_o (wb_fpga_ddr3_stb_o),
    .wbs_cti_o (wb_fpga_ddr3_cti_o),
    .wbs_bte_o (wb_fpga_ddr3_bte_o),
    .wbs_dat_i (wb_fpga_ddr3_dat_i),
    .wbs_ack_i (wb_fpga_ddr3_ack_i),
    .wbs_err_i (wb_fpga_ddr3_err_i),
    .wbs_rty_i (wb_fpga_ddr3_rty_i));

wb_arbiter
  #(.num_masters (4))
 wb_arbiter_gpio0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_gpio0_adr, wb_m2s_h2f_lw_gpio0_adr, wb_m2s_dbg_gpio0_adr, wb_m2s_or1k0_d_gpio0_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_gpio0_dat, wb_m2s_h2f_lw_gpio0_dat, wb_m2s_dbg_gpio0_dat, wb_m2s_or1k0_d_gpio0_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_gpio0_sel, wb_m2s_h2f_lw_gpio0_sel, wb_m2s_dbg_gpio0_sel, wb_m2s_or1k0_d_gpio0_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_gpio0_we, wb_m2s_h2f_lw_gpio0_we, wb_m2s_dbg_gpio0_we, wb_m2s_or1k0_d_gpio0_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_gpio0_cyc, wb_m2s_h2f_lw_gpio0_cyc, wb_m2s_dbg_gpio0_cyc, wb_m2s_or1k0_d_gpio0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_gpio0_stb, wb_m2s_h2f_lw_gpio0_stb, wb_m2s_dbg_gpio0_stb, wb_m2s_or1k0_d_gpio0_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_gpio0_cti, wb_m2s_h2f_lw_gpio0_cti, wb_m2s_dbg_gpio0_cti, wb_m2s_or1k0_d_gpio0_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_gpio0_bte, wb_m2s_h2f_lw_gpio0_bte, wb_m2s_dbg_gpio0_bte, wb_m2s_or1k0_d_gpio0_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_gpio0_dat, wb_s2m_h2f_lw_gpio0_dat, wb_s2m_dbg_gpio0_dat, wb_s2m_or1k0_d_gpio0_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_gpio0_ack, wb_s2m_h2f_lw_gpio0_ack, wb_s2m_dbg_gpio0_ack, wb_s2m_or1k0_d_gpio0_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_gpio0_err, wb_s2m_h2f_lw_gpio0_err, wb_s2m_dbg_gpio0_err, wb_s2m_or1k0_d_gpio0_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_gpio0_rty, wb_s2m_h2f_lw_gpio0_rty, wb_s2m_dbg_gpio0_rty, wb_s2m_or1k0_d_gpio0_rty}),
    .wbs_adr_o (wb_m2s_resize_gpio0_adr),
    .wbs_dat_o (wb_m2s_resize_gpio0_dat),
    .wbs_sel_o (wb_m2s_resize_gpio0_sel),
    .wbs_we_o  (wb_m2s_resize_gpio0_we),
    .wbs_cyc_o (wb_m2s_resize_gpio0_cyc),
    .wbs_stb_o (wb_m2s_resize_gpio0_stb),
    .wbs_cti_o (wb_m2s_resize_gpio0_cti),
    .wbs_bte_o (wb_m2s_resize_gpio0_bte),
    .wbs_dat_i (wb_s2m_resize_gpio0_dat),
    .wbs_ack_i (wb_s2m_resize_gpio0_ack),
    .wbs_err_i (wb_s2m_resize_gpio0_err),
    .wbs_rty_i (wb_s2m_resize_gpio0_rty));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_gpio0
   (.wbm_adr_i (wb_m2s_resize_gpio0_adr),
    .wbm_dat_i (wb_m2s_resize_gpio0_dat),
    .wbm_sel_i (wb_m2s_resize_gpio0_sel),
    .wbm_we_i  (wb_m2s_resize_gpio0_we),
    .wbm_cyc_i (wb_m2s_resize_gpio0_cyc),
    .wbm_stb_i (wb_m2s_resize_gpio0_stb),
    .wbm_cti_i (wb_m2s_resize_gpio0_cti),
    .wbm_bte_i (wb_m2s_resize_gpio0_bte),
    .wbm_dat_o (wb_s2m_resize_gpio0_dat),
    .wbm_ack_o (wb_s2m_resize_gpio0_ack),
    .wbm_err_o (wb_s2m_resize_gpio0_err),
    .wbm_rty_o (wb_s2m_resize_gpio0_rty),
    .wbs_adr_o (wb_gpio0_adr_o),
    .wbs_dat_o (wb_gpio0_dat_o),
    .wbs_we_o  (wb_gpio0_we_o),
    .wbs_cyc_o (wb_gpio0_cyc_o),
    .wbs_stb_o (wb_gpio0_stb_o),
    .wbs_cti_o (wb_gpio0_cti_o),
    .wbs_bte_o (wb_gpio0_bte_o),
    .wbs_dat_i (wb_gpio0_dat_i),
    .wbs_ack_i (wb_gpio0_ack_i),
    .wbs_err_i (wb_gpio0_err_i),
    .wbs_rty_i (wb_gpio0_rty_i));

wb_arbiter
  #(.num_masters (6))
 wb_arbiter_hps_ddr3
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_vga0_master_hps_ddr3_adr, wb_m2s_or1k1_d_hps_ddr3_adr, wb_m2s_dbg_hps_ddr3_adr, wb_m2s_or1k1_i_hps_ddr3_adr, wb_m2s_or1k0_i_hps_ddr3_adr, wb_m2s_or1k0_d_hps_ddr3_adr}),
    .wbm_dat_i ({wb_m2s_vga0_master_hps_ddr3_dat, wb_m2s_or1k1_d_hps_ddr3_dat, wb_m2s_dbg_hps_ddr3_dat, wb_m2s_or1k1_i_hps_ddr3_dat, wb_m2s_or1k0_i_hps_ddr3_dat, wb_m2s_or1k0_d_hps_ddr3_dat}),
    .wbm_sel_i ({wb_m2s_vga0_master_hps_ddr3_sel, wb_m2s_or1k1_d_hps_ddr3_sel, wb_m2s_dbg_hps_ddr3_sel, wb_m2s_or1k1_i_hps_ddr3_sel, wb_m2s_or1k0_i_hps_ddr3_sel, wb_m2s_or1k0_d_hps_ddr3_sel}),
    .wbm_we_i  ({wb_m2s_vga0_master_hps_ddr3_we, wb_m2s_or1k1_d_hps_ddr3_we, wb_m2s_dbg_hps_ddr3_we, wb_m2s_or1k1_i_hps_ddr3_we, wb_m2s_or1k0_i_hps_ddr3_we, wb_m2s_or1k0_d_hps_ddr3_we}),
    .wbm_cyc_i ({wb_m2s_vga0_master_hps_ddr3_cyc, wb_m2s_or1k1_d_hps_ddr3_cyc, wb_m2s_dbg_hps_ddr3_cyc, wb_m2s_or1k1_i_hps_ddr3_cyc, wb_m2s_or1k0_i_hps_ddr3_cyc, wb_m2s_or1k0_d_hps_ddr3_cyc}),
    .wbm_stb_i ({wb_m2s_vga0_master_hps_ddr3_stb, wb_m2s_or1k1_d_hps_ddr3_stb, wb_m2s_dbg_hps_ddr3_stb, wb_m2s_or1k1_i_hps_ddr3_stb, wb_m2s_or1k0_i_hps_ddr3_stb, wb_m2s_or1k0_d_hps_ddr3_stb}),
    .wbm_cti_i ({wb_m2s_vga0_master_hps_ddr3_cti, wb_m2s_or1k1_d_hps_ddr3_cti, wb_m2s_dbg_hps_ddr3_cti, wb_m2s_or1k1_i_hps_ddr3_cti, wb_m2s_or1k0_i_hps_ddr3_cti, wb_m2s_or1k0_d_hps_ddr3_cti}),
    .wbm_bte_i ({wb_m2s_vga0_master_hps_ddr3_bte, wb_m2s_or1k1_d_hps_ddr3_bte, wb_m2s_dbg_hps_ddr3_bte, wb_m2s_or1k1_i_hps_ddr3_bte, wb_m2s_or1k0_i_hps_ddr3_bte, wb_m2s_or1k0_d_hps_ddr3_bte}),
    .wbm_dat_o ({wb_s2m_vga0_master_hps_ddr3_dat, wb_s2m_or1k1_d_hps_ddr3_dat, wb_s2m_dbg_hps_ddr3_dat, wb_s2m_or1k1_i_hps_ddr3_dat, wb_s2m_or1k0_i_hps_ddr3_dat, wb_s2m_or1k0_d_hps_ddr3_dat}),
    .wbm_ack_o ({wb_s2m_vga0_master_hps_ddr3_ack, wb_s2m_or1k1_d_hps_ddr3_ack, wb_s2m_dbg_hps_ddr3_ack, wb_s2m_or1k1_i_hps_ddr3_ack, wb_s2m_or1k0_i_hps_ddr3_ack, wb_s2m_or1k0_d_hps_ddr3_ack}),
    .wbm_err_o ({wb_s2m_vga0_master_hps_ddr3_err, wb_s2m_or1k1_d_hps_ddr3_err, wb_s2m_dbg_hps_ddr3_err, wb_s2m_or1k1_i_hps_ddr3_err, wb_s2m_or1k0_i_hps_ddr3_err, wb_s2m_or1k0_d_hps_ddr3_err}),
    .wbm_rty_o ({wb_s2m_vga0_master_hps_ddr3_rty, wb_s2m_or1k1_d_hps_ddr3_rty, wb_s2m_dbg_hps_ddr3_rty, wb_s2m_or1k1_i_hps_ddr3_rty, wb_s2m_or1k0_i_hps_ddr3_rty, wb_s2m_or1k0_d_hps_ddr3_rty}),
    .wbs_adr_o (wb_hps_ddr3_adr_o),
    .wbs_dat_o (wb_hps_ddr3_dat_o),
    .wbs_sel_o (wb_hps_ddr3_sel_o),
    .wbs_we_o  (wb_hps_ddr3_we_o),
    .wbs_cyc_o (wb_hps_ddr3_cyc_o),
    .wbs_stb_o (wb_hps_ddr3_stb_o),
    .wbs_cti_o (wb_hps_ddr3_cti_o),
    .wbs_bte_o (wb_hps_ddr3_bte_o),
    .wbs_dat_i (wb_hps_ddr3_dat_i),
    .wbs_ack_i (wb_hps_ddr3_ack_i),
    .wbs_err_i (wb_hps_ddr3_err_i),
    .wbs_rty_i (wb_hps_ddr3_rty_i));

wb_arbiter
  #(.num_masters (4))
 wb_arbiter_vga0_slave
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_vga0_slave_adr, wb_m2s_h2f_lw_vga0_slave_adr, wb_m2s_dbg_vga0_slave_adr, wb_m2s_or1k0_d_vga0_slave_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_vga0_slave_dat, wb_m2s_h2f_lw_vga0_slave_dat, wb_m2s_dbg_vga0_slave_dat, wb_m2s_or1k0_d_vga0_slave_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_vga0_slave_sel, wb_m2s_h2f_lw_vga0_slave_sel, wb_m2s_dbg_vga0_slave_sel, wb_m2s_or1k0_d_vga0_slave_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_vga0_slave_we, wb_m2s_h2f_lw_vga0_slave_we, wb_m2s_dbg_vga0_slave_we, wb_m2s_or1k0_d_vga0_slave_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_vga0_slave_cyc, wb_m2s_h2f_lw_vga0_slave_cyc, wb_m2s_dbg_vga0_slave_cyc, wb_m2s_or1k0_d_vga0_slave_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_vga0_slave_stb, wb_m2s_h2f_lw_vga0_slave_stb, wb_m2s_dbg_vga0_slave_stb, wb_m2s_or1k0_d_vga0_slave_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_vga0_slave_cti, wb_m2s_h2f_lw_vga0_slave_cti, wb_m2s_dbg_vga0_slave_cti, wb_m2s_or1k0_d_vga0_slave_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_vga0_slave_bte, wb_m2s_h2f_lw_vga0_slave_bte, wb_m2s_dbg_vga0_slave_bte, wb_m2s_or1k0_d_vga0_slave_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_vga0_slave_dat, wb_s2m_h2f_lw_vga0_slave_dat, wb_s2m_dbg_vga0_slave_dat, wb_s2m_or1k0_d_vga0_slave_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_vga0_slave_ack, wb_s2m_h2f_lw_vga0_slave_ack, wb_s2m_dbg_vga0_slave_ack, wb_s2m_or1k0_d_vga0_slave_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_vga0_slave_err, wb_s2m_h2f_lw_vga0_slave_err, wb_s2m_dbg_vga0_slave_err, wb_s2m_or1k0_d_vga0_slave_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_vga0_slave_rty, wb_s2m_h2f_lw_vga0_slave_rty, wb_s2m_dbg_vga0_slave_rty, wb_s2m_or1k0_d_vga0_slave_rty}),
    .wbs_adr_o (wb_vga0_slave_adr_o),
    .wbs_dat_o (wb_vga0_slave_dat_o),
    .wbs_sel_o (wb_vga0_slave_sel_o),
    .wbs_we_o  (wb_vga0_slave_we_o),
    .wbs_cyc_o (wb_vga0_slave_cyc_o),
    .wbs_stb_o (wb_vga0_slave_stb_o),
    .wbs_cti_o (wb_vga0_slave_cti_o),
    .wbs_bte_o (wb_vga0_slave_bte_o),
    .wbs_dat_i (wb_vga0_slave_dat_i),
    .wbs_ack_i (wb_vga0_slave_ack_i),
    .wbs_err_i (wb_vga0_slave_err_i),
    .wbs_rty_i (wb_vga0_slave_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_rom0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_i_rom0_adr, wb_m2s_or1k0_i_rom0_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_i_rom0_dat, wb_m2s_or1k0_i_rom0_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_i_rom0_sel, wb_m2s_or1k0_i_rom0_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_i_rom0_we, wb_m2s_or1k0_i_rom0_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_i_rom0_cyc, wb_m2s_or1k0_i_rom0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_i_rom0_stb, wb_m2s_or1k0_i_rom0_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_i_rom0_cti, wb_m2s_or1k0_i_rom0_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_i_rom0_bte, wb_m2s_or1k0_i_rom0_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_i_rom0_dat, wb_s2m_or1k0_i_rom0_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_i_rom0_ack, wb_s2m_or1k0_i_rom0_ack}),
    .wbm_err_o ({wb_s2m_or1k1_i_rom0_err, wb_s2m_or1k0_i_rom0_err}),
    .wbm_rty_o ({wb_s2m_or1k1_i_rom0_rty, wb_s2m_or1k0_i_rom0_rty}),
    .wbs_adr_o (wb_rom0_adr_o),
    .wbs_dat_o (wb_rom0_dat_o),
    .wbs_sel_o (wb_rom0_sel_o),
    .wbs_we_o  (wb_rom0_we_o),
    .wbs_cyc_o (wb_rom0_cyc_o),
    .wbs_stb_o (wb_rom0_stb_o),
    .wbs_cti_o (wb_rom0_cti_o),
    .wbs_bte_o (wb_rom0_bte_o),
    .wbs_dat_i (wb_rom0_dat_i),
    .wbs_ack_i (wb_rom0_ack_i),
    .wbs_err_i (wb_rom0_err_i),
    .wbs_rty_i (wb_rom0_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_ipi
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_ipi_adr, wb_m2s_or1k0_d_ipi_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_ipi_dat, wb_m2s_or1k0_d_ipi_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_ipi_sel, wb_m2s_or1k0_d_ipi_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_ipi_we, wb_m2s_or1k0_d_ipi_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_ipi_cyc, wb_m2s_or1k0_d_ipi_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_ipi_stb, wb_m2s_or1k0_d_ipi_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_ipi_cti, wb_m2s_or1k0_d_ipi_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_ipi_bte, wb_m2s_or1k0_d_ipi_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_ipi_dat, wb_s2m_or1k0_d_ipi_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_ipi_ack, wb_s2m_or1k0_d_ipi_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_ipi_err, wb_s2m_or1k0_d_ipi_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_ipi_rty, wb_s2m_or1k0_d_ipi_rty}),
    .wbs_adr_o (wb_ipi_adr_o),
    .wbs_dat_o (wb_ipi_dat_o),
    .wbs_sel_o (wb_ipi_sel_o),
    .wbs_we_o  (wb_ipi_we_o),
    .wbs_cyc_o (wb_ipi_cyc_o),
    .wbs_stb_o (wb_ipi_stb_o),
    .wbs_cti_o (wb_ipi_cti_o),
    .wbs_bte_o (wb_ipi_bte_o),
    .wbs_dat_i (wb_ipi_dat_i),
    .wbs_ack_i (wb_ipi_ack_i),
    .wbs_err_i (wb_ipi_err_i),
    .wbs_rty_i (wb_ipi_rty_i));

wb_arbiter
  #(.num_masters (4))
 wb_arbiter_uart0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_uart0_adr, wb_m2s_h2f_lw_uart0_adr, wb_m2s_dbg_uart0_adr, wb_m2s_or1k0_d_uart0_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_uart0_dat, wb_m2s_h2f_lw_uart0_dat, wb_m2s_dbg_uart0_dat, wb_m2s_or1k0_d_uart0_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_uart0_sel, wb_m2s_h2f_lw_uart0_sel, wb_m2s_dbg_uart0_sel, wb_m2s_or1k0_d_uart0_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_uart0_we, wb_m2s_h2f_lw_uart0_we, wb_m2s_dbg_uart0_we, wb_m2s_or1k0_d_uart0_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_uart0_cyc, wb_m2s_h2f_lw_uart0_cyc, wb_m2s_dbg_uart0_cyc, wb_m2s_or1k0_d_uart0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_uart0_stb, wb_m2s_h2f_lw_uart0_stb, wb_m2s_dbg_uart0_stb, wb_m2s_or1k0_d_uart0_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_uart0_cti, wb_m2s_h2f_lw_uart0_cti, wb_m2s_dbg_uart0_cti, wb_m2s_or1k0_d_uart0_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_uart0_bte, wb_m2s_h2f_lw_uart0_bte, wb_m2s_dbg_uart0_bte, wb_m2s_or1k0_d_uart0_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_uart0_dat, wb_s2m_h2f_lw_uart0_dat, wb_s2m_dbg_uart0_dat, wb_s2m_or1k0_d_uart0_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_uart0_ack, wb_s2m_h2f_lw_uart0_ack, wb_s2m_dbg_uart0_ack, wb_s2m_or1k0_d_uart0_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_uart0_err, wb_s2m_h2f_lw_uart0_err, wb_s2m_dbg_uart0_err, wb_s2m_or1k0_d_uart0_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_uart0_rty, wb_s2m_h2f_lw_uart0_rty, wb_s2m_dbg_uart0_rty, wb_s2m_or1k0_d_uart0_rty}),
    .wbs_adr_o (wb_m2s_resize_uart0_adr),
    .wbs_dat_o (wb_m2s_resize_uart0_dat),
    .wbs_sel_o (wb_m2s_resize_uart0_sel),
    .wbs_we_o  (wb_m2s_resize_uart0_we),
    .wbs_cyc_o (wb_m2s_resize_uart0_cyc),
    .wbs_stb_o (wb_m2s_resize_uart0_stb),
    .wbs_cti_o (wb_m2s_resize_uart0_cti),
    .wbs_bte_o (wb_m2s_resize_uart0_bte),
    .wbs_dat_i (wb_s2m_resize_uart0_dat),
    .wbs_ack_i (wb_s2m_resize_uart0_ack),
    .wbs_err_i (wb_s2m_resize_uart0_err),
    .wbs_rty_i (wb_s2m_resize_uart0_rty));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_uart0
   (.wbm_adr_i (wb_m2s_resize_uart0_adr),
    .wbm_dat_i (wb_m2s_resize_uart0_dat),
    .wbm_sel_i (wb_m2s_resize_uart0_sel),
    .wbm_we_i  (wb_m2s_resize_uart0_we),
    .wbm_cyc_i (wb_m2s_resize_uart0_cyc),
    .wbm_stb_i (wb_m2s_resize_uart0_stb),
    .wbm_cti_i (wb_m2s_resize_uart0_cti),
    .wbm_bte_i (wb_m2s_resize_uart0_bte),
    .wbm_dat_o (wb_s2m_resize_uart0_dat),
    .wbm_ack_o (wb_s2m_resize_uart0_ack),
    .wbm_err_o (wb_s2m_resize_uart0_err),
    .wbm_rty_o (wb_s2m_resize_uart0_rty),
    .wbs_adr_o (wb_uart0_adr_o),
    .wbs_dat_o (wb_uart0_dat_o),
    .wbs_we_o  (wb_uart0_we_o),
    .wbs_cyc_o (wb_uart0_cyc_o),
    .wbs_stb_o (wb_uart0_stb_o),
    .wbs_cti_o (wb_uart0_cti_o),
    .wbs_bte_o (wb_uart0_bte_o),
    .wbs_dat_i (wb_uart0_dat_i),
    .wbs_ack_i (wb_uart0_ack_i),
    .wbs_err_i (wb_uart0_err_i),
    .wbs_rty_i (wb_uart0_rty_i));

wb_arbiter
  #(.num_masters (5))
 wb_arbiter_sram0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_sram0_adr, wb_m2s_dbg_sram0_adr, wb_m2s_or1k1_i_sram0_adr, wb_m2s_or1k0_i_sram0_adr, wb_m2s_or1k0_d_sram0_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_sram0_dat, wb_m2s_dbg_sram0_dat, wb_m2s_or1k1_i_sram0_dat, wb_m2s_or1k0_i_sram0_dat, wb_m2s_or1k0_d_sram0_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_sram0_sel, wb_m2s_dbg_sram0_sel, wb_m2s_or1k1_i_sram0_sel, wb_m2s_or1k0_i_sram0_sel, wb_m2s_or1k0_d_sram0_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_sram0_we, wb_m2s_dbg_sram0_we, wb_m2s_or1k1_i_sram0_we, wb_m2s_or1k0_i_sram0_we, wb_m2s_or1k0_d_sram0_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_sram0_cyc, wb_m2s_dbg_sram0_cyc, wb_m2s_or1k1_i_sram0_cyc, wb_m2s_or1k0_i_sram0_cyc, wb_m2s_or1k0_d_sram0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_sram0_stb, wb_m2s_dbg_sram0_stb, wb_m2s_or1k1_i_sram0_stb, wb_m2s_or1k0_i_sram0_stb, wb_m2s_or1k0_d_sram0_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_sram0_cti, wb_m2s_dbg_sram0_cti, wb_m2s_or1k1_i_sram0_cti, wb_m2s_or1k0_i_sram0_cti, wb_m2s_or1k0_d_sram0_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_sram0_bte, wb_m2s_dbg_sram0_bte, wb_m2s_or1k1_i_sram0_bte, wb_m2s_or1k0_i_sram0_bte, wb_m2s_or1k0_d_sram0_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_sram0_dat, wb_s2m_dbg_sram0_dat, wb_s2m_or1k1_i_sram0_dat, wb_s2m_or1k0_i_sram0_dat, wb_s2m_or1k0_d_sram0_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_sram0_ack, wb_s2m_dbg_sram0_ack, wb_s2m_or1k1_i_sram0_ack, wb_s2m_or1k0_i_sram0_ack, wb_s2m_or1k0_d_sram0_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_sram0_err, wb_s2m_dbg_sram0_err, wb_s2m_or1k1_i_sram0_err, wb_s2m_or1k0_i_sram0_err, wb_s2m_or1k0_d_sram0_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_sram0_rty, wb_s2m_dbg_sram0_rty, wb_s2m_or1k1_i_sram0_rty, wb_s2m_or1k0_i_sram0_rty, wb_s2m_or1k0_d_sram0_rty}),
    .wbs_adr_o (wb_sram0_adr_o),
    .wbs_dat_o (wb_sram0_dat_o),
    .wbs_sel_o (wb_sram0_sel_o),
    .wbs_we_o  (wb_sram0_we_o),
    .wbs_cyc_o (wb_sram0_cyc_o),
    .wbs_stb_o (wb_sram0_stb_o),
    .wbs_cti_o (wb_sram0_cti_o),
    .wbs_bte_o (wb_sram0_bte_o),
    .wbs_dat_i (wb_sram0_dat_i),
    .wbs_ack_i (wb_sram0_ack_i),
    .wbs_err_i (wb_sram0_err_i),
    .wbs_rty_i (wb_sram0_rty_i));

wb_arbiter
  #(.num_masters (4))
 wb_arbiter_clkgen
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_clkgen_adr, wb_m2s_h2f_lw_clkgen_adr, wb_m2s_dbg_clkgen_adr, wb_m2s_or1k0_d_clkgen_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_clkgen_dat, wb_m2s_h2f_lw_clkgen_dat, wb_m2s_dbg_clkgen_dat, wb_m2s_or1k0_d_clkgen_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_clkgen_sel, wb_m2s_h2f_lw_clkgen_sel, wb_m2s_dbg_clkgen_sel, wb_m2s_or1k0_d_clkgen_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_clkgen_we, wb_m2s_h2f_lw_clkgen_we, wb_m2s_dbg_clkgen_we, wb_m2s_or1k0_d_clkgen_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_clkgen_cyc, wb_m2s_h2f_lw_clkgen_cyc, wb_m2s_dbg_clkgen_cyc, wb_m2s_or1k0_d_clkgen_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_clkgen_stb, wb_m2s_h2f_lw_clkgen_stb, wb_m2s_dbg_clkgen_stb, wb_m2s_or1k0_d_clkgen_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_clkgen_cti, wb_m2s_h2f_lw_clkgen_cti, wb_m2s_dbg_clkgen_cti, wb_m2s_or1k0_d_clkgen_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_clkgen_bte, wb_m2s_h2f_lw_clkgen_bte, wb_m2s_dbg_clkgen_bte, wb_m2s_or1k0_d_clkgen_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_clkgen_dat, wb_s2m_h2f_lw_clkgen_dat, wb_s2m_dbg_clkgen_dat, wb_s2m_or1k0_d_clkgen_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_clkgen_ack, wb_s2m_h2f_lw_clkgen_ack, wb_s2m_dbg_clkgen_ack, wb_s2m_or1k0_d_clkgen_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_clkgen_err, wb_s2m_h2f_lw_clkgen_err, wb_s2m_dbg_clkgen_err, wb_s2m_or1k0_d_clkgen_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_clkgen_rty, wb_s2m_h2f_lw_clkgen_rty, wb_s2m_dbg_clkgen_rty, wb_s2m_or1k0_d_clkgen_rty}),
    .wbs_adr_o (wb_clkgen_adr_o),
    .wbs_dat_o (wb_clkgen_dat_o),
    .wbs_sel_o (wb_clkgen_sel_o),
    .wbs_we_o  (wb_clkgen_we_o),
    .wbs_cyc_o (wb_clkgen_cyc_o),
    .wbs_stb_o (wb_clkgen_stb_o),
    .wbs_cti_o (wb_clkgen_cti_o),
    .wbs_bte_o (wb_clkgen_bte_o),
    .wbs_dat_i (wb_clkgen_dat_i),
    .wbs_ack_i (wb_clkgen_ack_i),
    .wbs_err_i (wb_clkgen_err_i),
    .wbs_rty_i (wb_clkgen_rty_i));

wb_arbiter
  #(.num_masters (4))
 wb_arbiter_i2c0
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_i2c0_adr, wb_m2s_h2f_lw_i2c0_adr, wb_m2s_dbg_i2c0_adr, wb_m2s_or1k0_d_i2c0_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_i2c0_dat, wb_m2s_h2f_lw_i2c0_dat, wb_m2s_dbg_i2c0_dat, wb_m2s_or1k0_d_i2c0_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_i2c0_sel, wb_m2s_h2f_lw_i2c0_sel, wb_m2s_dbg_i2c0_sel, wb_m2s_or1k0_d_i2c0_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_i2c0_we, wb_m2s_h2f_lw_i2c0_we, wb_m2s_dbg_i2c0_we, wb_m2s_or1k0_d_i2c0_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_i2c0_cyc, wb_m2s_h2f_lw_i2c0_cyc, wb_m2s_dbg_i2c0_cyc, wb_m2s_or1k0_d_i2c0_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_i2c0_stb, wb_m2s_h2f_lw_i2c0_stb, wb_m2s_dbg_i2c0_stb, wb_m2s_or1k0_d_i2c0_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_i2c0_cti, wb_m2s_h2f_lw_i2c0_cti, wb_m2s_dbg_i2c0_cti, wb_m2s_or1k0_d_i2c0_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_i2c0_bte, wb_m2s_h2f_lw_i2c0_bte, wb_m2s_dbg_i2c0_bte, wb_m2s_or1k0_d_i2c0_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_i2c0_dat, wb_s2m_h2f_lw_i2c0_dat, wb_s2m_dbg_i2c0_dat, wb_s2m_or1k0_d_i2c0_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_i2c0_ack, wb_s2m_h2f_lw_i2c0_ack, wb_s2m_dbg_i2c0_ack, wb_s2m_or1k0_d_i2c0_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_i2c0_err, wb_s2m_h2f_lw_i2c0_err, wb_s2m_dbg_i2c0_err, wb_s2m_or1k0_d_i2c0_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_i2c0_rty, wb_s2m_h2f_lw_i2c0_rty, wb_s2m_dbg_i2c0_rty, wb_s2m_or1k0_d_i2c0_rty}),
    .wbs_adr_o (wb_m2s_resize_i2c0_adr),
    .wbs_dat_o (wb_m2s_resize_i2c0_dat),
    .wbs_sel_o (wb_m2s_resize_i2c0_sel),
    .wbs_we_o  (wb_m2s_resize_i2c0_we),
    .wbs_cyc_o (wb_m2s_resize_i2c0_cyc),
    .wbs_stb_o (wb_m2s_resize_i2c0_stb),
    .wbs_cti_o (wb_m2s_resize_i2c0_cti),
    .wbs_bte_o (wb_m2s_resize_i2c0_bte),
    .wbs_dat_i (wb_s2m_resize_i2c0_dat),
    .wbs_ack_i (wb_s2m_resize_i2c0_ack),
    .wbs_err_i (wb_s2m_resize_i2c0_err),
    .wbs_rty_i (wb_s2m_resize_i2c0_rty));

wb_data_resize
  #(.aw  (32),
    .mdw (32),
    .sdw (8))
 wb_data_resize_i2c0
   (.wbm_adr_i (wb_m2s_resize_i2c0_adr),
    .wbm_dat_i (wb_m2s_resize_i2c0_dat),
    .wbm_sel_i (wb_m2s_resize_i2c0_sel),
    .wbm_we_i  (wb_m2s_resize_i2c0_we),
    .wbm_cyc_i (wb_m2s_resize_i2c0_cyc),
    .wbm_stb_i (wb_m2s_resize_i2c0_stb),
    .wbm_cti_i (wb_m2s_resize_i2c0_cti),
    .wbm_bte_i (wb_m2s_resize_i2c0_bte),
    .wbm_dat_o (wb_s2m_resize_i2c0_dat),
    .wbm_ack_o (wb_s2m_resize_i2c0_ack),
    .wbm_err_o (wb_s2m_resize_i2c0_err),
    .wbm_rty_o (wb_s2m_resize_i2c0_rty),
    .wbs_adr_o (wb_i2c0_adr_o),
    .wbs_dat_o (wb_i2c0_dat_o),
    .wbs_we_o  (wb_i2c0_we_o),
    .wbs_cyc_o (wb_i2c0_cyc_o),
    .wbs_stb_o (wb_i2c0_stb_o),
    .wbs_cti_o (wb_i2c0_cti_o),
    .wbs_bte_o (wb_i2c0_bte_o),
    .wbs_dat_i (wb_i2c0_dat_i),
    .wbs_ack_i (wb_i2c0_ack_i),
    .wbs_err_i (wb_i2c0_err_i),
    .wbs_rty_i (wb_i2c0_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_tc
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_or1k1_d_tc_adr, wb_m2s_or1k0_d_tc_adr}),
    .wbm_dat_i ({wb_m2s_or1k1_d_tc_dat, wb_m2s_or1k0_d_tc_dat}),
    .wbm_sel_i ({wb_m2s_or1k1_d_tc_sel, wb_m2s_or1k0_d_tc_sel}),
    .wbm_we_i  ({wb_m2s_or1k1_d_tc_we, wb_m2s_or1k0_d_tc_we}),
    .wbm_cyc_i ({wb_m2s_or1k1_d_tc_cyc, wb_m2s_or1k0_d_tc_cyc}),
    .wbm_stb_i ({wb_m2s_or1k1_d_tc_stb, wb_m2s_or1k0_d_tc_stb}),
    .wbm_cti_i ({wb_m2s_or1k1_d_tc_cti, wb_m2s_or1k0_d_tc_cti}),
    .wbm_bte_i ({wb_m2s_or1k1_d_tc_bte, wb_m2s_or1k0_d_tc_bte}),
    .wbm_dat_o ({wb_s2m_or1k1_d_tc_dat, wb_s2m_or1k0_d_tc_dat}),
    .wbm_ack_o ({wb_s2m_or1k1_d_tc_ack, wb_s2m_or1k0_d_tc_ack}),
    .wbm_err_o ({wb_s2m_or1k1_d_tc_err, wb_s2m_or1k0_d_tc_err}),
    .wbm_rty_o ({wb_s2m_or1k1_d_tc_rty, wb_s2m_or1k0_d_tc_rty}),
    .wbs_adr_o (wb_tc_adr_o),
    .wbs_dat_o (wb_tc_dat_o),
    .wbs_sel_o (wb_tc_sel_o),
    .wbs_we_o  (wb_tc_we_o),
    .wbs_cyc_o (wb_tc_cyc_o),
    .wbs_stb_o (wb_tc_stb_o),
    .wbs_cti_o (wb_tc_cti_o),
    .wbs_bte_o (wb_tc_bte_o),
    .wbs_dat_i (wb_tc_dat_i),
    .wbs_ack_i (wb_tc_ack_i),
    .wbs_err_i (wb_tc_err_i),
    .wbs_rty_i (wb_tc_rty_i));

wb_arbiter
  #(.num_masters (2))
 wb_arbiter_diila
   (.wb_clk_i  (wb_clk_i),
    .wb_rst_i  (wb_rst_i),
    .wbm_adr_i ({wb_m2s_h2f_lw_diila_adr, wb_m2s_dbg_diila_adr}),
    .wbm_dat_i ({wb_m2s_h2f_lw_diila_dat, wb_m2s_dbg_diila_dat}),
    .wbm_sel_i ({wb_m2s_h2f_lw_diila_sel, wb_m2s_dbg_diila_sel}),
    .wbm_we_i  ({wb_m2s_h2f_lw_diila_we, wb_m2s_dbg_diila_we}),
    .wbm_cyc_i ({wb_m2s_h2f_lw_diila_cyc, wb_m2s_dbg_diila_cyc}),
    .wbm_stb_i ({wb_m2s_h2f_lw_diila_stb, wb_m2s_dbg_diila_stb}),
    .wbm_cti_i ({wb_m2s_h2f_lw_diila_cti, wb_m2s_dbg_diila_cti}),
    .wbm_bte_i ({wb_m2s_h2f_lw_diila_bte, wb_m2s_dbg_diila_bte}),
    .wbm_dat_o ({wb_s2m_h2f_lw_diila_dat, wb_s2m_dbg_diila_dat}),
    .wbm_ack_o ({wb_s2m_h2f_lw_diila_ack, wb_s2m_dbg_diila_ack}),
    .wbm_err_o ({wb_s2m_h2f_lw_diila_err, wb_s2m_dbg_diila_err}),
    .wbm_rty_o ({wb_s2m_h2f_lw_diila_rty, wb_s2m_dbg_diila_rty}),
    .wbs_adr_o (wb_diila_adr_o),
    .wbs_dat_o (wb_diila_dat_o),
    .wbs_sel_o (wb_diila_sel_o),
    .wbs_we_o  (wb_diila_we_o),
    .wbs_cyc_o (wb_diila_cyc_o),
    .wbs_stb_o (wb_diila_stb_o),
    .wbs_cti_o (wb_diila_cti_o),
    .wbs_bte_o (wb_diila_bte_o),
    .wbs_dat_i (wb_diila_dat_i),
    .wbs_ack_i (wb_diila_ack_i),
    .wbs_err_i (wb_diila_err_i),
    .wbs_rty_i (wb_diila_rty_i));

endmodule
