module vscale_top #(
    parameter       BOOTROM_FILE = "../src/vscale-generic/sw/bootrom.vh"
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
wb_ram #(
	.depth	(2**MEM_SIZE_BITS)
) mem (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),
	.wb_adr_i	(wb_m2s_mem_adr[MEM_SIZE_BITS-1:0]),
	.wb_dat_i	(wb_m2s_mem_dat),
	.wb_sel_i	(wb_m2s_mem_sel),
	.wb_we_i	(wb_m2s_mem_we),
	.wb_cyc_i	(wb_m2s_mem_cyc),
	.wb_stb_i	(wb_m2s_mem_stb),
	.wb_cti_i	(wb_m2s_mem_cti),
	.wb_bte_i	(wb_m2s_mem_bte),
	.wb_dat_o	(wb_s2m_mem_dat),
	.wb_ack_o	(wb_s2m_mem_ack),
	.wb_err_o	(wb_s2m_mem_err)
);
   assign wb_s2m_mem_rty = 1'b0;

wire uart_irq;

uart_top #(
	.debug	(0),
	.SIM	(1)
) uart16550 (
	//Wishbone Master interface
	.wb_clk_i	(wb_clk_i),
	.wb_rst_i	(wb_rst_i),

	.wb_adr_i	(wb_m2s_uart0_adr[2:0]),
	.wb_dat_i	(wb_m2s_uart0_dat),
	.wb_sel_i	(4'h0),
	.wb_we_i	(wb_m2s_uart0_we),
	.wb_cyc_i	(wb_m2s_uart0_cyc),
	.wb_stb_i	(wb_m2s_uart0_stb),
	.wb_dat_o	(wb_s2m_uart0_dat),
	.wb_ack_o	(wb_s2m_uart0_ack),
	.int_o		(uart_irq),
	.srx_pad_i	(1'b0),
	.stx_pad_o	(),
	.rts_pad_o	(),
	.cts_pad_i	(1'b0),
	.dtr_pad_o	(),
	.dsr_pad_i	(1'b0),
	.ri_pad_i	(1'b0),
	.dcd_pad_i	(1'b0)
);

assign wb_s2m_uart0_err = 1'b0;
assign wb_s2m_uart0_rty = 1'b0;

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
assign riscv_irq[31] = 0;

endmodule
