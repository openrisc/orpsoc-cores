module vscale_top #(
    parameter       BOOTROM_FILE = "../src/vscale-generic/sw/bootrom.vh",
		parameter UART_SIM = 0,
    parameter rom0_aw = 8
)(
		input wb_clk_i,
		input wb_rst_i
);

localparam wb_aw = 32;
localparam wb_dw = 32;

localparam MEM_SIZE_BITS = 25;

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
// VScale/RISC-V cpu
//
////////////////////////////////////////////////////////////////////////

wire [31:0]	riscv_irq;
wire		riscv_clk;
wire		riscv_rst;

assign riscv_clk = wb_clk;
assign riscv_rst = wb_rst;

wb_vscale wb_vscale
( 
  .iwbm_adr_o     (wb_m2s_riscv_i_adr),
  .iwbm_stb_o     (wb_m2s_riscv_i_stb),
  .iwbm_cyc_o     (wb_m2s_riscv_i_cyc),
  .iwbm_sel_o     (wb_m2s_riscv_i_sel),
  .iwbm_we_o      (wb_m2s_riscv_i_we),
  .iwbm_cti_o     (wb_m2s_riscv_i_cti),
  .iwbm_bte_o     (wb_m2s_riscv_i_bte),
  .iwbm_dat_o     (wb_m2s_riscv_i_dat),

  .dwbm_adr_o     (wb_m2s_riscv_d_adr),
  .dwbm_stb_o     (wb_m2s_riscv_d_stb),
  .dwbm_cyc_o     (wb_m2s_riscv_d_cyc),
  .dwbm_sel_o     (wb_m2s_riscv_d_sel),
  .dwbm_we_o      (wb_m2s_riscv_d_we ),
  .dwbm_cti_o     (wb_m2s_riscv_d_cti),
  .dwbm_bte_o     (wb_m2s_riscv_d_bte),
  .dwbm_dat_o     (wb_m2s_riscv_d_dat),

  .clk        (riscv_clk),
  .rst        (riscv_rst),

  .iwbm_err_i     (wb_s2m_riscv_i_err),
  .iwbm_ack_i     (wb_s2m_riscv_i_ack),
  .iwbm_dat_i     (wb_s2m_riscv_i_dat),
  .iwbm_rty_i     (wb_s2m_riscv_i_rty),

  .dwbm_err_i     (wb_s2m_riscv_d_err),
  .dwbm_ack_i     (wb_s2m_riscv_d_ack),
  .dwbm_dat_i     (wb_s2m_riscv_d_dat),
  .dwbm_rty_i     (wb_s2m_riscv_d_rty)

);
////////////////////////////////////////////////////////////////////////
//
// ROM
//
////////////////////////////////////////////////////////////////////////
   localparam WB_BOOTROM_MEM_DEPTH = 1024;
   
wb_bootrom
  #(.DEPTH (WB_BOOTROM_MEM_DEPTH),
    .MEMFILE (BOOTROM_FILE))
   rom0
     (//Wishbone Master interface
      .wb_clk_i (wb_clk),
      .wb_rst_i (wb_rst),
      .wb_adr_i	(wb_m2s_rom0_adr),
      .wb_cyc_i	(wb_m2s_rom0_cyc),
      .wb_stb_i	(wb_m2s_rom0_stb),
      .wb_dat_o	(wb_s2m_rom0_dat),
      .wb_ack_o (wb_s2m_rom0_ack));

   assign wb_s2m_rom0_err = 1'b0;
   assign wb_s2m_rom0_rty = 1'b0;

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

wire uart_irq;

wb_uart_wrapper #(
	.DEBUG	(0),
	.SIM	(UART_SIM)
) wb_uart_wrapper0 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
	.rx		(1'b0),
	.tx		(uart),
        .int_o		(uart_irq),
	.wb_adr_i	(wb_m2s_uart0_adr),
	.wb_dat_i	(wb_m2s_uart0_dat),
	.wb_we_i	(wb_m2s_uart0_we),
	.wb_cyc_i	(wb_m2s_uart0_cyc),
	.wb_stb_i	(wb_m2s_uart0_stb),
	.wb_cti_i	(wb_m2s_uart0_cti),
	.wb_bte_i	(wb_m2s_uart0_bte),
	.wb_dat_o	(wb_s2m_uart0_dat),
	.wb_ack_o	(wb_s2m_uart0_ack),
	.wb_err_o	(wb_s2m_uart0_err),
	.wb_rty_o	(wb_s2m_uart0_rty)
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
assign riscv_irq[0] = 0;
assign riscv_irq[1] = 0;
assign riscv_irq[2] = uart_irq;
assign riscv_irq[3] = 0;
assign riscv_irq[4] = 0;
assign riscv_irq[5] = 0;
assign riscv_irq[6] = 0;
assign riscv_irq[7] = 0;
assign riscv_irq[8] = 0;
assign riscv_irq[9] = 0;
assign riscv_irq[10] = 0;
assign riscv_irq[11] = 0;
assign riscv_irq[12] = 0;
assign riscv_irq[13] = 0;
assign riscv_irq[14] = 0;
assign riscv_irq[15] = 0;
assign riscv_irq[16] = 0;
assign riscv_irq[17] = 0;
assign riscv_irq[18] = 0;
assign riscv_irq[19] = 0;
assign riscv_irq[20] = 0;
assign riscv_irq[21] = 0;
assign riscv_irq[22] = 0;
assign riscv_irq[23] = 0;
assign riscv_irq[24] = 0;
assign riscv_irq[25] = 0;
assign riscv_irq[26] = 0;
assign riscv_irq[27] = 0;
assign riscv_irq[28] = 0;
assign riscv_irq[29] = 0;
assign riscv_irq[30] = 0;

endmodule
