`include "orpsoc-defines.v"

module orpsoc_top#(
	parameter	uart0_aw = 3,
	parameter	rom0_aw = 6,
        parameter       i2c_wb_adr_width = 3,
	parameter       HV1_SADR = 8'h45

  )(input wb_clk_i,
   input wb_rst_i

`ifdef UART0
,    output uart0_stx_pad_o,
    input uart0_srx_pad_i
`endif

`ifdef GPIO
,	inout	[7:0]	gpio_io
`endif

`ifdef JTAG_DEBUG
,   output          tdo_pad_o,
   input           tms_pad_i,
   input           tck_pad_i,
   input           tdi_pad_i
`endif
);

   localparam wb_dw = 32;

   localparam MEM_SIZE_BITS = 23;
   
   ////////////////////////////////////////////////////////////////////////
   //
   // Clock and reset generation
   // 
   ////////////////////////////////////////////////////////////////////////
   

   ////////////////////////////////////////////////////////////////////////
   //
   // Wishbone interconnect
   //
   ////////////////////////////////////////////////////////////////////////
   wire wb_clk = wb_clk_i;
   wire wb_rst = wb_rst_i;
`ifdef I2C
   wire		i2c_sda_io;
   wire		i2c_scl_io;
`endif

   `include "wb_intercon.vh"

`ifdef JTAG_DEBUG
////////////////////////////////////////////////////////////////////////
//
// GENERIC JTAG TAP
//
////////////////////////////////////////////////////////////////////////

wire	dbg_if_select;
wire	dbg_if_tdo;
wire	jtag_tap_tdo;
wire	jtag_tap_shift_dr;
wire	jtag_tap_pause_dr;
wire	jtag_tap_update_dr;
wire	jtag_tap_capture_dr;

tap_top jtag_tap0 (
	.tdo_pad_o			(tdo_pad_o),
	.tms_pad_i			(tms_pad_i),
	.tck_pad_i			(tck_pad_i),
	.trst_pad_i			(wb_rst),
	.tdi_pad_i			(tdi_pad_i),

	.tdo_padoe_o			(tdo_padoe_o),

	.tdo_o				(jtag_tap_tdo),

	.shift_dr_o			(jtag_tap_shift_dr),
	.pause_dr_o			(jtag_tap_pause_dr),
	.update_dr_o			(jtag_tap_update_dr),
	.capture_dr_o			(jtag_tap_capture_dr),

	.extest_select_o		(),
	.sample_preload_select_o	(),
	.mbist_select_o			(),
	.debug_select_o			(dbg_if_select),


	.bs_chain_tdi_i			(1'b0),
	.mbist_tdi_i			(1'b0),
	.debug_tdi_i			(dbg_if_tdo)
);
`endif

   ////////////////////////////////////////////////////////////////////////
   //
   // or1200
   // 
   ////////////////////////////////////////////////////////////////////////

   wire [19:0] 				  or1200_pic_ints;


   wire [31:0] 				  or1k_irq;
   wire	[31:0]	or1k_dbg_dat_i;  
   wire	[31:0]	or1k_dbg_adr_i;
   wire		or1k_dbg_we_i;
   wire		or1k_dbg_stb_i;
   wire		or1k_dbg_ack_o;
   wire	[31:0]	or1k_dbg_dat_o;

   wire		or1k_dbg_stall_i;
   wire		or1k_dbg_ewt_i;
   wire	[3:0]	or1k_dbg_lss_o;
   wire	[1:0]	or1k_dbg_is_o;
   wire	[10:0]	or1k_dbg_wp_o;
   wire		or1k_dbg_bp_o;
   wire		or1k_dbg_rst;


`ifdef OR1200
   
   wire		or1k_rst;

   assign	or1k_rst= wb_rst | or1k_dbg_rst;


   or1200_top #(.boot_adr(32'hf0000100)) or1200_top0
       (
	// Instruction bus, clocks, reset
	.iwb_clk_i			(wb_clk_i),
	.iwb_rst_i			(wb_rst_i),
	.iwb_adr_o			(wb_m2s_or1200_i_adr),
	.iwb_dat_o			(wb_m2s_or1200_i_dat),
	.iwb_sel_o			(wb_m2s_or1200_i_sel),
	.iwb_we_o			(wb_m2s_or1200_i_we ),
	.iwb_cyc_o			(wb_m2s_or1200_i_cyc),
	.iwb_stb_o			(wb_m2s_or1200_i_stb),
	.iwb_cti_o			(wb_m2s_or1200_i_cti),
	.iwb_bte_o			(wb_m2s_or1200_i_bte),
	.iwb_dat_i			(wb_s2m_or1200_i_dat),
	.iwb_ack_i			(wb_s2m_or1200_i_ack),
	.iwb_err_i			(wb_s2m_or1200_i_err),
	.iwb_rty_i			(wb_s2m_or1200_i_rty),
	// Data bus, clocks, reset            
	.dwb_clk_i			(wb_clk_i),
	.dwb_rst_i			(wb_rst_i),
	.dwb_adr_o			(wb_m2s_or1200_d_adr),
	.dwb_dat_o			(wb_m2s_or1200_d_dat),
	.dwb_sel_o			(wb_m2s_or1200_d_sel),
	.dwb_we_o			(wb_m2s_or1200_d_we),
	.dwb_cyc_o			(wb_m2s_or1200_d_cyc),
	.dwb_stb_o			(wb_m2s_or1200_d_stb),
	.dwb_cti_o			(wb_m2s_or1200_d_cti),
	.dwb_bte_o			(wb_m2s_or1200_d_bte),
	.dwb_dat_i			(wb_s2m_or1200_d_dat),
	.dwb_ack_i			(wb_s2m_or1200_d_ack),
	.dwb_err_i			(wb_s2m_or1200_d_err),
	.dwb_rty_i			(wb_s2m_or1200_d_rty),

	// Debug interface ports
	.dbg_stall_i			(or1k_dbg_stall_i),
	.dbg_ewt_i			(1'b0),
	.dbg_lss_o			(or1k_dbg_lss_o),
	.dbg_is_o			(or1k_dbg_is_o),
	.dbg_wp_o			(or1k_dbg_wp_o),
	.dbg_bp_o			(or1k_dbg_bp_o),

	.dbg_adr_i			(or1k_dbg_adr_i),
	.dbg_we_i			(or1k_dbg_we_i),
	.dbg_stb_i			(or1k_dbg_stb_i),
	.dbg_dat_i			(or1k_dbg_dat_i),
	.dbg_dat_o			(or1k_dbg_dat_o),
	.dbg_ack_o			(or1k_dbg_ack_o),
	
	.pm_clksd_o			(),
	.pm_dc_gate_o			(),
	.pm_ic_gate_o			(),
	.pm_dmmu_gate_o			(),
	.pm_immu_gate_o			(),
	.pm_tt_gate_o			(),
	.pm_cpu_gate_o			(),
	.pm_wakeup_o			(),
	.pm_lvolt_o			(),

	// Core clocks, resets
	.clk_i				(wb_clk_i),
	.rst_i				(or1k_rst),
	
	.clmode_i			(2'b00),
	// Interrupts      
	.pic_ints_i			(or1200_pic_ints),
	.sig_tick(),

	.pm_cpustall_i			(1'b0));
`endif



`ifdef MOR1KX
mor1kx #(
	.FEATURE_DEBUGUNIT("ENABLED"),
	.FEATURE_CMOV("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH(5),
	.OPTION_ICACHE_SET_WIDTH(8),
	.OPTION_ICACHE_WAYS(2),
	.OPTION_ICACHE_LIMIT_WIDTH(32),
	.FEATURE_IMMU("ENABLED"),
	.FEATURE_DATACACHE("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH(5),
	.OPTION_DCACHE_SET_WIDTH(8),
	.OPTION_DCACHE_WAYS(2),
	.OPTION_DCACHE_LIMIT_WIDTH(31),
	.FEATURE_DMMU("ENABLED"),
	.OPTION_PIC_TRIGGER("LATCHED_LEVEL"),

	.IBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0("CAPPUCCINO"),
	.OPTION_RESET_PC(32'hf0000100)
) mor1kx0 (
	.iwbm_adr_o(wb_m2s_or1200_i_adr),
	.iwbm_stb_o(wb_m2s_or1200_i_stb),
	.iwbm_we_o (wb_m2s_or1200_i_we),
	.iwbm_cyc_o(wb_m2s_or1200_i_cyc),
	.iwbm_sel_o(wb_m2s_or1200_i_sel),
	.iwbm_cti_o(wb_m2s_or1200_i_cti),
	.iwbm_bte_o(wb_m2s_or1200_i_bte),
	.iwbm_dat_o(wb_m2s_or1200_i_dat),
	.iwbm_dat_i(wb_s2m_or1200_i_dat),
	.iwbm_ack_i(wb_s2m_or1200_i_ack),
	.iwbm_err_i(wb_s2m_or1200_i_err),
	.iwbm_rty_i(wb_s2m_or1200_i_rty),
	   
	.dwbm_adr_o(wb_m2s_or1200_d_adr),
	.dwbm_stb_o(wb_m2s_or1200_d_stb),
	.dwbm_cyc_o(wb_m2s_or1200_d_cyc),
	.dwbm_sel_o(wb_m2s_or1200_d_sel),
	.dwbm_we_o (wb_m2s_or1200_d_we ),
	.dwbm_cti_o(wb_m2s_or1200_d_cti),
	.dwbm_bte_o(wb_m2s_or1200_d_bte),
	.dwbm_dat_o(wb_m2s_or1200_d_dat),

	.clk(wb_clk),
	.rst(wb_rst),

	.dwbm_err_i(wb_s2m_or1200_d_err),
	.dwbm_ack_i(wb_s2m_or1200_d_ack),
	.dwbm_dat_i(wb_s2m_or1200_d_dat),
	.dwbm_rty_i(wb_s2m_or1200_d_rty),

	.irq_i(or1k_irq),

	.du_addr_i(or1k_dbg_adr_i[15:0]),
	.du_stb_i(or1k_dbg_stb_i),
	.du_dat_i(or1k_dbg_dat_i),
	.du_we_i(or1k_dbg_we_i),
	.du_dat_o(or1k_dbg_dat_o),
	.du_ack_o(or1k_dbg_ack_o),
	.du_stall_i(or1k_dbg_stall_i),
	.du_stall_o(or1k_dbg_bp_o)
);
`endif

   
   ////////////////////////////////////////////////////////////////////////
   //
   // BOOTROM
   // 
   ////////////////////////////////////////////////////////////////////////
assign	wb_s2m_rom_err = 1'b0;
assign	wb_s2m_rom_rty = 1'b0;

`ifdef BOOTROM
rom #(.addr_width(rom0_aw))
    rom (
	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst),
	.wb_adr_i	(wb_m2s_rom_adr[(rom0_aw + 2) - 1 : 2]),
	.wb_cyc_i	(wb_m2s_rom_cyc),
	.wb_stb_i	(wb_m2s_rom_stb),
	.wb_cti_i	(wb_m2s_rom_cti),
	.wb_bte_i	(wb_m2s_rom_bte),
	.wb_dat_o	(wb_s2m_rom_dat),
	.wb_ack_o	(wb_s2m_rom_ack)
);
`else
assign	wb_s2m_rom_dat_o = 0;
assign	wb_s2m_rom_ack_o = 0;
`endif

   ////////////////////////////////////////////////////////////////////////
   //
   // Generic main RAM
   // 
   ////////////////////////////////////////////////////////////////////////
   ram_wb_b3 #(
   //wb_bfm_memory #(.DEBUG (0),
	       .mem_size_bytes (2**MEM_SIZE_BITS*(wb_dw/8)),
	       .mem_adr_width (MEM_SIZE_BITS))
   wb_bfm_memory0
     (
      //Wishbone Master interface
      .wb_clk_i (wb_clk_i),
      .wb_rst_i (wb_rst_i),
      .wb_adr_i	(wb_m2s_mem_adr & (2**MEM_SIZE_BITS-1)),
      .wb_dat_i	(wb_m2s_mem_dat),
      .wb_sel_i	(wb_m2s_mem_sel),
      .wb_we_i	(wb_m2s_mem_we),
      .wb_cyc_i	(wb_m2s_mem_cyc),
      .wb_stb_i	(wb_m2s_mem_stb),
      .wb_cti_i	(wb_m2s_mem_cti),
      .wb_bte_i	(wb_m2s_mem_bte),
      .wb_dat_o	(wb_s2m_mem_dat),
      .wb_ack_o	(wb_s2m_mem_ack),
      .wb_err_o (wb_s2m_mem_err),
      .wb_rty_o (wb_s2m_mem_rty));

`ifdef UART0   
   ////////////////////////////////////////////////////////////////////////
   //
   // UART
   // 
   ////////////////////////////////////////////////////////////////////////

    wire	uart0_irq;

    wire [31:0]	wb_m2s_uart8_adr;
    wire [1:0]	wb_m2s_uart8_bte;
    wire [2:0]	wb_m2s_uart8_cti;
    wire	wb_m2s_uart8_cyc;
    wire [7:0]	wb_m2s_uart8_dat;
    wire	wb_m2s_uart8_stb;
    wire	wb_m2s_uart8_we;
    wire [7:0] 	wb_s2m_uart8_dat;
    wire	wb_s2m_uart8_ack;
    wire	wb_s2m_uart8_err;
    wire	wb_s2m_uart8_rty;

   wb_data_resize wb_data_resize_uart0
   (//Wishbone Master interface
    .wbm_adr_i (wb_m2s_uart_adr),
    .wbm_dat_i (wb_m2s_uart_dat),
    .wbm_sel_i (wb_m2s_uart_sel),
    .wbm_we_i  (wb_m2s_uart_we ),
    .wbm_cyc_i (wb_m2s_uart_cyc),
    .wbm_stb_i (wb_m2s_uart_stb),
    .wbm_cti_i (wb_m2s_uart_cti),
    .wbm_bte_i (wb_m2s_uart_bte),
    .wbm_dat_o (wb_s2m_uart_dat),
    .wbm_ack_o (wb_s2m_uart_ack),
    .wbm_err_o (wb_s2m_uart_err),
    .wbm_rty_o (wb_s2m_uart_rty),
    // Wishbone Slave interface
    .wbs_adr_o (wb_m2s_uart8_adr),
    .wbs_dat_o (wb_m2s_uart8_dat),
    .wbs_we_o  (wb_m2s_uart8_we ),
    .wbs_cyc_o (wb_m2s_uart8_cyc),
    .wbs_stb_o (wb_m2s_uart8_stb),
    .wbs_cti_o (wb_m2s_uart8_cti),
    .wbs_bte_o (wb_m2s_uart8_bte),
    .wbs_dat_i (wb_s2m_uart8_dat),
    .wbs_ack_i (wb_s2m_uart8_ack),
    .wbs_err_i (wb_s2m_uart8_err),
    .wbs_rty_i (wb_s2m_uart8_rty));


    assign	wb_s2m_uart8_err = 0;
    assign	wb_s2m_uart8_rty = 0;

    uart_top uart16550_0 (
	// Wishbone slave interface
	.wb_clk_i	(wb_clk),
	.wb_rst_i	(wb_rst),
	.wb_adr_i	(wb_m2s_uart8_adr[2:0]),
	.wb_dat_i	(wb_m2s_uart8_dat),
	.wb_we_i	(wb_m2s_uart8_we ),
	.wb_stb_i	(wb_m2s_uart8_stb),
	.wb_cyc_i	(wb_m2s_uart8_cyc),
	.wb_sel_i	(4'b0), // Not used in 8-bit mode
	.wb_dat_o	(wb_s2m_uart8_dat),
	.wb_ack_o	(wb_s2m_uart8_ack),

	// Outputs
	.int_o		(uart0_irq),
	.stx_pad_o	(uart0_stx_pad_o),
	.rts_pad_o	(),
	.dtr_pad_o	(),

	// Inputs
	.srx_pad_i	(uart0_srx_pad_i),
	.cts_pad_i	(1'b0),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);

`endif

////////////////////////////////////////////////////////////////////////
//
// Debug Interface
//
////////////////////////////////////////////////////////////////////////

`ifdef JTAG_DEBUG
adbg_top dbg_if0 (
	// OR1K interface
	.cpu0_clk_i	(wb_clk),
	.cpu0_rst_o	(or1k_dbg_rst),
	.cpu0_addr_o	(or1k_dbg_adr_i),
	.cpu0_data_o	(or1k_dbg_dat_i),
	.cpu0_stb_o	(or1k_dbg_stb_i),
	.cpu0_we_o	(or1k_dbg_we_i),
	.cpu0_data_i	(or1k_dbg_dat_o),
	.cpu0_ack_i	(or1k_dbg_ack_o),
	.cpu0_stall_o	(or1k_dbg_stall_i),
	.cpu0_bp_i	(or1k_dbg_bp_o),

	// TAP interface
	.tck_i		(tck_pad_i),
	.tdi_i		(jtag_tap_tdo),
	.tdo_o		(dbg_if_tdo),
	.rst_i		(wb_rst),
	.capture_dr_i	(jtag_tap_capture_dr),
	.shift_dr_i	(jtag_tap_shift_dr),
	.pause_dr_i	(jtag_tap_pause_dr),
	.update_dr_i	(jtag_tap_update_dr),
	.debug_select_i	(dbg_if_select),

	// Wishbone debug master
	.wb_clk_i	(wb_clk),
	.wb_dat_i	(wb_s2m_dbg_dat),
	.wb_ack_i	(wb_s2m_dbg_ack),
	.wb_err_i	(wb_s2m_dbg_err),

	.wb_adr_o	(wb_m2s_dbg_adr),
	.wb_dat_o	(wb_m2s_dbg_dat),
	.wb_cyc_o	(wb_m2s_dbg_cyc),
	.wb_stb_o	(wb_m2s_dbg_stb),
	.wb_sel_o	(wb_m2s_dbg_sel),
	.wb_we_o	(wb_m2s_dbg_we),
	.wb_cti_o	(wb_m2s_dbg_cti),
	.wb_bte_o	(wb_m2s_dbg_bte)
);
`else 
	assign or1k_dbg_rst = 1'b0;
`endif

`ifdef GPIO
////////////////////////////////////////////////////////////////////////
//
// GPIO 0
//
////////////////////////////////////////////////////////////////////////

wire [7:0]	gpio_in;
wire [7:0]	gpio_out;
wire [7:0]	gpio_dir;

wire [31:0]	wb8_m2s_gpio_adr;
wire [1:0]	wb8_m2s_gpio_bte;
wire [2:0]	wb8_m2s_gpio_cti;
wire		wb8_m2s_gpio_cyc;
wire [7:0]	wb8_m2s_gpio_dat;
wire		wb8_m2s_gpio_stb;
wire		wb8_m2s_gpio_we;
wire [7:0] 	wb8_s2m_gpio_dat;
wire		wb8_s2m_gpio_ack;
wire		wb8_s2m_gpio_err;
wire		wb8_s2m_gpio_rty;

// Tristate logic for IO
// 0 = input, 1 = output
genvar                    i;
generate
	for (i = 0; i < 8; i = i+1) begin: gpio0_tris
		assign gpio_io[i] = gpio_dir[i] ? gpio_out[i] : 1'bz;
		assign gpio_in[i] = gpio_dir[i] ? gpio_out[i] : gpio_io[i];
	end
endgenerate

gpio gpio0 (
	// GPIO bus
	.gpio_i		(gpio_in),
	.gpio_o		(gpio_out),
	.gpio_dir_o	(gpio_dir),
	// Wishbone slave interface
	.wb_adr_i	(wb8_m2s_gpio_adr[0]),
	.wb_dat_i	(wb8_m2s_gpio_dat),
	.wb_we_i	(wb8_m2s_gpio_we),
	.wb_cyc_i	(wb8_m2s_gpio_cyc),
	.wb_stb_i	(wb8_m2s_gpio_stb),
	.wb_cti_i	(wb8_m2s_gpio_cti),
	.wb_bte_i	(wb8_m2s_gpio_bte),
	.wb_dat_o	(wb8_s2m_gpio_dat),
	.wb_ack_o	(wb8_s2m_gpio_ack),
	.wb_err_o	(wb8_s2m_gpio_err),
	.wb_rty_o	(wb8_s2m_gpio_rty),

	.wb_clk		(wb_clk),
	.wb_rst		(wb_rst)
);

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_gpio0 (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_gpio_adr),
	.wbm_dat_i	(wb_m2s_gpio_dat),
	.wbm_sel_i	(wb_m2s_gpio_sel),
	.wbm_we_i	(wb_m2s_gpio_we ),
	.wbm_cyc_i	(wb_m2s_gpio_cyc),
	.wbm_stb_i	(wb_m2s_gpio_stb),
	.wbm_cti_i	(wb_m2s_gpio_cti),
	.wbm_bte_i	(wb_m2s_gpio_bte),
	.wbm_dat_o	(wb_s2m_gpio_dat),
	.wbm_ack_o	(wb_s2m_gpio_ack),
	.wbm_err_o	(wb_s2m_gpio_err),
	.wbm_rty_o	(wb_s2m_gpio_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_gpio_adr),
	.wbs_dat_o	(wb8_m2s_gpio_dat),
	.wbs_we_o	(wb8_m2s_gpio_we ),
	.wbs_cyc_o	(wb8_m2s_gpio_cyc),
	.wbs_stb_o	(wb8_m2s_gpio_stb),
	.wbs_cti_o	(wb8_m2s_gpio_cti),
	.wbs_bte_o	(wb8_m2s_gpio_bte),
	.wbs_dat_i	(wb8_s2m_gpio_dat),
	.wbs_ack_i	(wb8_s2m_gpio_ack),
	.wbs_err_i	(wb8_s2m_gpio_err),
	.wbs_rty_i	(wb8_s2m_gpio_rty)
);
`endif //!`ifdef GPIO

`ifdef I2C
////////////////////////////////////////////////////////////////////////
//
// I2C controller MASTER
//
////////////////////////////////////////////////////////////////////////

//
// Wires
//
wire 		i2c_irq;
wire 		i2c_scl_pad_o;
wire 		i2c_scl_padoen_o;
wire 		i2c_sda_pad_o;
wire 		i2c_sda_padoen_o;

wire [31:0]	wb8_m2s_i2c_adr;
wire [1:0]	wb8_m2s_i2c_bte;
wire [2:0]	wb8_m2s_i2c_cti;
wire		wb8_m2s_i2c_cyc;
wire [7:0]	wb8_m2s_i2c_dat;
wire		wb8_m2s_i2c_stb;
wire		wb8_m2s_i2c_we;
wire [7:0] 	wb8_s2m_i2c_dat;
wire		wb8_s2m_i2c_ack;
wire		wb8_s2m_i2c_err;
wire		wb8_s2m_i2c_rty;

i2c_master_top#(.DEFAULT_SLAVE_ADDR(HV1_SADR))i2c_master (
   .wb_clk_i			     (wb_clk),
   .wb_rst_i			     (wb_rst),
   .arst_i			     (wb_rst),
   .wb_adr_i			     (wb8_m2s_i2c_adr[i2c_wb_adr_width-1:0]),
   .wb_dat_i			     (wb8_m2s_i2c_dat	),
   .wb_we_i			     (wb8_m2s_i2c_we	),
   .wb_cyc_i			     (wb8_m2s_i2c_cyc	),
   .wb_stb_i			     (wb8_m2s_i2c_stb	),
   .wb_dat_o			     (wb8_s2m_i2c_dat	),
   .wb_ack_o			     (wb8_s2m_i2c_ack	),
   .scl_pad_i		     	     (i2c_scl_io  	),
   .scl_pad_o			     (i2c_scl_pad_o	),
   .scl_padoen_o		     (i2c_scl_padoen_o	),
   .sda_pad_i			     (i2c_sda_io	),
   .sda_pad_o			     (i2c_sda_pad_o	),
   .sda_padoen_o		     (i2c_sda_padoen_o	),
   // Interrupt
   .wb_inta_o			     (i2c_irq));

   assign wb8_s2m_i2c_err = 0;
   assign wb8_s2m_i2c_rty = 0;

   // i2c phy lines
`ifdef SIM
   assign i2c_scl_io = i2c_scl_padoen_o & i2c_s_scl_padoen_o;
   assign i2c_sda_io = i2c_sda_padoen_o & i2c_s_sda_padoen_o;
`else 
   assign i2c_scl_io = i2c_scl_padoen_o ? 1'bz : i2c_scl_pad_o;
   assign i2c_sda_io = i2c_sda_padoen_o ? 1'bz : i2c_sda_pad_o;
`endif


   // 32-bit to 8-bit wishbone bus resize
   wb_data_resize wb_data_resize_i2c (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_i2c_adr),
	.wbm_dat_i	(wb_m2s_i2c_dat),
	.wbm_sel_i	(wb_m2s_i2c_sel),
	.wbm_we_i	(wb_m2s_i2c_we ),
	.wbm_cyc_i	(wb_m2s_i2c_cyc),
	.wbm_stb_i	(wb_m2s_i2c_stb),
	.wbm_cti_i	(wb_m2s_i2c_cti),
	.wbm_bte_i	(wb_m2s_i2c_bte),
	.wbm_dat_o	(wb_s2m_i2c_dat),
	.wbm_ack_o	(wb_s2m_i2c_ack),
	.wbm_err_o	(wb_s2m_i2c_err),
	.wbm_rty_o	(wb_s2m_i2c_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_i2c_adr),
	.wbs_dat_o	(wb8_m2s_i2c_dat),
	.wbs_we_o 	(wb8_m2s_i2c_we ),
	.wbs_cyc_o	(wb8_m2s_i2c_cyc),
	.wbs_stb_o	(wb8_m2s_i2c_stb),
	.wbs_cti_o	(wb8_m2s_i2c_cti),
	.wbs_bte_o	(wb8_m2s_i2c_bte),
	.wbs_dat_i	(wb8_s2m_i2c_dat),
	.wbs_ack_i	(wb8_s2m_i2c_ack),
	.wbs_err_i	(wb8_s2m_i2c_err),
	.wbs_rty_i	(wb8_s2m_i2c_rty)
   );

   ////////////////////////////////////////////////////////////////////////
   `else // !`ifdef I2C

   assign wb8_s2m_i2c_dat = 0;
   assign wb8_s2m_i2c_ack = 0;
   assign wb8_s2m_i2c_err = 0;
   assign wb8_s2m_i2c_rty = 0;

   ////////////////////////////////////////////////////////////////////////
   `endif // !`ifdef I2C



`ifdef FLASH_I2c
////////////////////////////////////////////////////////////////////////
//
// I2C controller slave
//
////////////////////////////////////////////////////////////////////////
//
// Wires
//
wire 		i2c_s_irq;
wire 		i2c_s_scl_pad_o;
wire 		i2c_s_scl_padoen_o;
wire 		i2c_s_sda_pad_o;
wire 		i2c_s_sda_padoen_o;

memory_i2c Flash_i2c(
   .clk_i		(wb_clk),
   .rst_i		(wb_rst),
   .scl_i		(i2c_scl_io),
   .scl_padoen_o	(i2c_s_scl_padoen_o),
   .scl_pad_o		(i2c_s_scl_pad_o),
   .sda_i		(i2c_sda_io),
   .sda_padoen_o	(i2c_s_sda_padoen_o),
   .sda_pad_o		(i2c_s_sda_pad_o),
   .irq_o		(i2c_s_irq));

   // i2c phy lines
`ifndef SIM
       assign i2c_scl_io = i2c_s_scl_padoen_o ? 1'bz : i2c_s_scl_pad_o;
       assign i2c_sda_io = i2c_s_sda_padoen_o ? 1'bz : i2c_s_sda_pad_o;
`endif


`endif //!FLASH_I2c

`ifdef SPI
////////////////////////////////////////////////////////////////////////
//
// SPI Master
//
////////////////////////////////////////////////////////////////////////

wire            spi_irq;

wire [31:0]	wb8_m2s_spi_adr;
wire [1:0]	wb8_m2s_spi_bte;
wire [2:0]	wb8_m2s_spi_cti;
wire		wb8_m2s_spi_cyc;
wire [7:0]	wb8_m2s_spi_dat;
wire		wb8_m2s_spi_stb;
wire		wb8_m2s_spi_we;
wire [7:0] 	wb8_s2m_spi_dat;
wire		wb8_s2m_spi_ack;
wire		wb8_s2m_spi_err;
wire		wb8_s2m_spi_rty;


//
// wires SPI
//
wire 		spi_sck_o;  //clock 
wire 		spi_ss_o;   //select
wire 		spi_mosi_o; //data master -> slave
wire 		spi_miso_i; //data slave -> master
//
// Assigns
//
assign  wbs_d_spi_err_o = 0;
assign  wbs_d_spi_rty_o = 0;
assign  spi_hold_n_o = 1;
assign  spi_w_n_o = 1;

simple_spi spi_master(
	// Wishbone slave interface
	.clk_i	(wb_clk),
	.rst_i	(wb_rst),
	.adr_i	(wb8_m2s_spi_adr[2:0]),
	.dat_i	(wb8_m2s_spi_dat),
	.we_i	(wb8_m2s_spi_we),
	.stb_i	(wb8_m2s_spi_stb),
	.cyc_i	(wb8_m2s_spi_cyc),
	.dat_o	(wb8_s2m_spi_dat),
	.ack_o	(wb8_s2m_spi_ack),

	// Outputs
	.inta_o		(spi_irq),
	.sck_o		(spi_sck_o),
	.ss_o		(spi_ss_o),
	.mosi_o		(spi_mosi_o),
	// Inputs
	.miso_i		(spi_miso_i));

// 32-bit to 8-bit wishbone bus resize
wb_data_resize wb_data_resize_spi (
	// Wishbone Master interface
	.wbm_adr_i	(wb_m2s_spi_adr),
	.wbm_dat_i	(wb_m2s_spi_dat),
	.wbm_sel_i	(wb_m2s_spi_sel),
	.wbm_we_i	(wb_m2s_spi_we ),
	.wbm_cyc_i	(wb_m2s_spi_cyc),
	.wbm_stb_i	(wb_m2s_spi_stb),
	.wbm_cti_i	(wb_m2s_spi_cti),
	.wbm_bte_i	(wb_m2s_spi_bte),
	.wbm_dat_o	(wb_s2m_spi_dat),
	.wbm_ack_o	(wb_s2m_spi_ack),
	.wbm_err_o	(wb_s2m_spi_err),
	.wbm_rty_o	(wb_s2m_spi_rty),
	// Wishbone Slave interface
	.wbs_adr_o	(wb8_m2s_spi_adr),
	.wbs_dat_o	(wb8_m2s_spi_dat),
	.wbs_we_o 	(wb8_m2s_spi_we ),
	.wbs_cyc_o	(wb8_m2s_spi_cyc),
	.wbs_stb_o	(wb8_m2s_spi_stb),
	.wbs_cti_o	(wb8_m2s_spi_cti),
	.wbs_bte_o	(wb8_m2s_spi_bte),
	.wbs_dat_i	(wb8_s2m_spi_dat),
	.wbs_ack_i	(wb8_s2m_spi_ack),
	.wbs_err_i	(wb8_s2m_spi_err),
	.wbs_rty_i	(wb8_s2m_spi_rty)
);


`endif //!SPI

`ifdef FLASH_SPI

  wire 		flash_miso;

slave_spiTop flash_spi(
	.clk_i		( wb_clk      ),
	.rst_i		( wb_rst      ),
	.sck_i		( spi_sck_o   ),      // serial clock output
	.ss_i		( spi_ss_o ),    	// slave select (active low)
	.mosi_i		( spi_mosi_o  ),     // MasterOut SlaveIN
	.miso_o		( flash_miso  ));      // MasterIn SlaveOut

       assign spi_miso_i = spi_ss_o ? 1'bz : flash_miso;
`endif



   ////////////////////////////////////////////////////////////////////////
   //
   // OR1200 Interrupt assignment
   // 
   ////////////////////////////////////////////////////////////////////////
   assign or1200_pic_ints[0] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[1] = 0; // Non-maskable inside OR1200
   assign or1200_pic_ints[2] = 0;
   assign or1200_pic_ints[3] = 0;
   assign or1200_pic_ints[4] = 0;
   assign or1200_pic_ints[5] = 0;
   assign or1200_pic_ints[6] = 0;
   assign or1200_pic_ints[7] = 0;
   assign or1200_pic_ints[8] = 0;
   assign or1200_pic_ints[9] = 0;
`ifdef I2C
   assign or1200_pic_ints[10] = i2c_irq;
`else
   assign or1200_pic_ints[10] = 0;
`endif
`ifdef FLASH_I2c
   assign or1200_pic_ints[10] = i2c_s_irq;
`else
   assign or1200_pic_ints[10] = 0;
`endif
   assign or1200_pic_ints[12] = 0;
   assign or1200_pic_ints[13] = 0;
   assign or1200_pic_ints[14] = 0;
   assign or1200_pic_ints[15] = 0;
   assign or1200_pic_ints[16] = 0;
   assign or1200_pic_ints[17] = 0;
   assign or1200_pic_ints[18] = 0;
   assign or1200_pic_ints[19] = 0;
   

////////////////////////////////////////////////////////////////////////
//
// Interrupt assignment
//
////////////////////////////////////////////////////////////////////////

assign or1k_irq[0] = 0; // Non-maskable inside OR1K
assign or1k_irq[1] = 0; // Non-maskable inside OR1K
`ifdef UART0
assign or1k_irq[2] = uart0_irq;
`else
assign or1k_irq[2] = 0;
`endif
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
`ifdef SPI0
   assign or1k_irq[6] = spi0_irq;
`else
   assign or1k_irq[6] = 0;
`endif
`ifdef SPI1
   assign or1k_irq[7] = spi1_irq;
`else
   assign or1k_irq[7] = 0;
`endif
`ifdef SPI2
   assign or1k_irq[8] = spi1_irq;
`else
   assign or1k_irq[8] = 0;
`endif
assign or1k_irq[9] = 0;
`ifdef I2C0
   assign or1k_irq[10] = i2c0_irq;
`else
   assign or1k_irq[10] = 0;
`endif
`ifdef I2C1
   assign or1k_irq[11] = i2c1_irq;
`else
   assign or1k_irq[11] = 0;
`endif
assign or1k_irq[12] = 0;
assign or1k_irq[13] = 0;
assign or1k_irq[14] = 0;
assign or1k_irq[15] = 0;
assign or1k_irq[16] = 0;
assign or1k_irq[17] = 0;
assign or1k_irq[18] = 0;
assign or1k_irq[19] = 0;
assign or1k_irq[20] = 0;
assign or1k_irq[21] = 0;
assign or1k_irq[22] = 0;
assign or1k_irq[23] = 0;
`ifdef ACEELEROMETER
assign or1k_irq[24] = accelerometer_irq_i;
`else
assign or1k_irq[24] = 0;
`endif
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;
assign or1k_irq[31] = 0;


endmodule
