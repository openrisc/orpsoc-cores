module orpsoc_top #(
		parameter UART_SIM = 0
)(
		input wb_clk_i,
		input wb_rst_i
);

localparam wb_aw = 32;
localparam wb_dw = 32;

localparam MEM_SIZE_BITS = 23;

////////////////////////////////////////////////////////////////////////
//
// Wishbone interconnect
//
////////////////////////////////////////////////////////////////////////
wire wb_clk = wb_clk_i;
wire wb_rst = wb_rst_i;

`include "wb_intercon.vh"

////////////////////////////////////////////////////////////////////////
//
// mor1kx cpu
//
////////////////////////////////////////////////////////////////////////

wire [31:0]	or1k_irq;
wire		or1k_clk;
wire		or1k_rst;

assign or1k_clk = wb_clk;
assign or1k_rst = wb_rst;

mor1kx #(
	.FEATURE_DEBUGUNIT		("ENABLED"),
	.FEATURE_CMOV			("ENABLED"),
	.FEATURE_INSTRUCTIONCACHE	("ENABLED"),
	.OPTION_ICACHE_BLOCK_WIDTH	(5),
	.OPTION_ICACHE_SET_WIDTH	(8),
	.OPTION_ICACHE_WAYS		(2),
	.OPTION_ICACHE_LIMIT_WIDTH	(32),
	.FEATURE_IMMU			("ENABLED"),
	.FEATURE_DATACACHE		("ENABLED"),
	.OPTION_DCACHE_BLOCK_WIDTH	(5),
	.OPTION_DCACHE_SET_WIDTH	(8),
	.OPTION_DCACHE_WAYS		(2),
	.OPTION_DCACHE_LIMIT_WIDTH	(31),
	.FEATURE_DMMU			("ENABLED"),
	.OPTION_PIC_TRIGGER		("LATCHED_LEVEL"),

	.IBUS_WB_TYPE			("B3_REGISTERED_FEEDBACK"),
	.DBUS_WB_TYPE			("B3_REGISTERED_FEEDBACK"),
	.OPTION_CPU0			("CAPPUCCINO"),
	.OPTION_RESET_PC		(32'h00000100)
) mor1kx0 (
	.iwbm_adr_o			(wb_m2s_or1k_i_adr),
	.iwbm_stb_o			(wb_m2s_or1k_i_stb),
	.iwbm_cyc_o			(wb_m2s_or1k_i_cyc),
	.iwbm_sel_o			(wb_m2s_or1k_i_sel),
	.iwbm_we_o			(wb_m2s_or1k_i_we),
	.iwbm_cti_o			(wb_m2s_or1k_i_cti),
	.iwbm_bte_o			(wb_m2s_or1k_i_bte),
	.iwbm_dat_o			(wb_m2s_or1k_i_dat),

	.dwbm_adr_o			(wb_m2s_or1k_d_adr),
	.dwbm_stb_o			(wb_m2s_or1k_d_stb),
	.dwbm_cyc_o			(wb_m2s_or1k_d_cyc),
	.dwbm_sel_o			(wb_m2s_or1k_d_sel),
	.dwbm_we_o			(wb_m2s_or1k_d_we ),
	.dwbm_cti_o			(wb_m2s_or1k_d_cti),
	.dwbm_bte_o			(wb_m2s_or1k_d_bte),
	.dwbm_dat_o			(wb_m2s_or1k_d_dat),

	.clk				(or1k_clk),
	.rst				(or1k_rst),

	.iwbm_err_i			(wb_s2m_or1k_i_err),
	.iwbm_ack_i			(wb_s2m_or1k_i_ack),
	.iwbm_dat_i			(wb_s2m_or1k_i_dat),
	.iwbm_rty_i			(wb_s2m_or1k_i_rty),

	.dwbm_err_i			(wb_s2m_or1k_d_err),
	.dwbm_ack_i			(wb_s2m_or1k_d_ack),
	.dwbm_dat_i			(wb_s2m_or1k_d_dat),
	.dwbm_rty_i			(wb_s2m_or1k_d_rty),

	.irq_i				(or1k_irq),

	.du_addr_i			(16'b0),
	.du_stb_i			(1'b0),
	.du_dat_i			(32'b0),
	.du_we_i			(1'b0),
	.du_dat_o			(),
	.du_ack_o			(),
	.du_stall_i			(1'b0),
	.du_stall_o			()
);

////////////////////////////////////////////////////////////////////////
//
// Generic main RAM
//
////////////////////////////////////////////////////////////////////////
ram_wb_b3 #(
	.mem_size_bytes	(2**MEM_SIZE_BITS*(wb_dw/8)),
	.mem_adr_width	(MEM_SIZE_BITS)
) wb_bfm_memory0 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
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
	.wb_err_o	(wb_s2m_mem_err),
	.wb_rty_o	(wb_s2m_mem_rty)
);

wb_uart_wrapper #(
	.DEBUG	(0),
	.SIM	(UART_SIM)
) wb_uart_wrapper0 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
	.rx		(1'b0),
	.tx		(uart),
	.wb_adr_i	(wb_m2s_uart_adr),
	.wb_dat_i	(wb_m2s_uart_dat),
	.wb_we_i	(wb_m2s_uart_we),
	.wb_cyc_i	(wb_m2s_uart_cyc),
	.wb_stb_i	(wb_m2s_uart_stb),
	.wb_cti_i	(wb_m2s_uart_cti),
	.wb_bte_i	(wb_m2s_uart_bte),
	.wb_dat_o	(wb_s2m_uart_dat),
	.wb_ack_o	(wb_s2m_uart_ack),
	.wb_err_o	(wb_s2m_uart_err),
	.wb_rty_o	(wb_s2m_uart_rty)
);

`ifdef VERILATOR
wire [7:0]	uart_rx_data;
wire		uart_rx_done;

uart_transceiver uart_transceiver0 (
	.sys_rst	(wb_rst_i),
	.sys_clk	(wb_clk_i),

	.uart_rx	(uart),
	.uart_tx	(),

	.divisor	(16'd26),

	.rx_data	(uart_rx_data),
	.rx_done	(uart_rx_done),

	.tx_data	(8'h00),
	.tx_wr		(1'b0),
	.tx_done	(),

	.rx_break	()
);

always @(posedge wb_clk_i)
	if(uart_rx_done)
		$write("%c", uart_rx_data);

`endif

////////////////////////////////////////////////////////////////////////
//
// CPU Interrupt assignments
//
////////////////////////////////////////////////////////////////////////
assign or1k_irq[0] = 0; // Non-maskable inside OR1K
assign or1k_irq[1] = 0; // Non-maskable inside OR1K
assign or1k_irq[2] = 0;
assign or1k_irq[3] = 0;
assign or1k_irq[4] = 0;
assign or1k_irq[5] = 0;
assign or1k_irq[6] = 0;
assign or1k_irq[7] = 0;
assign or1k_irq[8] = 0;
assign or1k_irq[9] = 0;
assign or1k_irq[10] = 0;
assign or1k_irq[11] = 0;
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
assign or1k_irq[24] = 0;
assign or1k_irq[25] = 0;
assign or1k_irq[26] = 0;
assign or1k_irq[27] = 0;
assign or1k_irq[28] = 0;
assign or1k_irq[29] = 0;
assign or1k_irq[30] = 0;

endmodule
