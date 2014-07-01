module orpsoc_top #(
                parameter UART_SIM = 0
)(
                input                             wb_clk_i,
                input                             wb_rst_i
);

localparam wb_aw = 32;
localparam wb_dw = 32;

localparam MEM_SIZE_BITS = 25;


   wire        traceport_exec_valid[0:1] /* verilator public */;
   wire [31:0] traceport_exec_pc[0:1] /* verilator public */;
   wire [31:0] traceport_exec_insn[0:1] /* verilator public */;
   wire [31:0] traceport_exec_wbdata[0:1] /* verilator public */;
   wire [4:0]  traceport_exec_wbreg[0:1] /* verilator public */;
   wire        traceport_exec_wben[0:1] /*verilator public*/;
   

////////////////////////////////////////////////////////////////////////
//
// Wishbone interconnect
//
////////////////////////////////////////////////////////////////////////
wire wb_clk = wb_clk_i;
wire wb_rst = wb_rst_i;
`include "wb_intercon.vh"

   wire [31:0] wbm_adr_o [0:3];
   wire [31:0] wbm_dat_o [0:3];
   wire [3:0]  wbm_sel_o [0:3];
   wire        wbm_we_o [0:3];
   wire        wbm_cyc_o [0:3];
   wire        wbm_stb_o [0:3];
   wire [2:0]  wbm_cti_o [0:3];
   wire [1:0]  wbm_bte_o [0:3];

   wire [31:0] wbm_dat_i [0:3];
   wire        wbm_ack_i [0:3];
   wire        wbm_err_i [0:3];
   wire        wbm_rty_i [0:3];


////////////////////////////////////////////////////////////////////////
//
// Bus
//
////////////////////////////////////////////////////////////////////////

wire [31:0] snoop_adr;
wire        snoop_en;


////////////////////////////////////////////////////////////////////////
//
// mor1kx cpu
//
////////////////////////////////////////////////////////////////////////

   wire [31:0] or1k_irq [0:1];
   wire        or1k_clk;
   wire        or1k_rst;

   assign or1k_clk = wb_clk;
   assign or1k_rst = wb_rst;
   
mor1kx
     #(.FEATURE_DEBUGUNIT              ("ENABLED"),
       .FEATURE_CMOV                   ("ENABLED"),
       .FEATURE_INSTRUCTIONCACHE       ("ENABLED"),
       .FEATURE_MULTICORE              ("ENABLED"),
       .FEATURE_TRACEPORT_EXEC         ("ENABLED"),
       .OPTION_ICACHE_BLOCK_WIDTH      (5),
       .OPTION_ICACHE_SET_WIDTH        (8),
       .OPTION_ICACHE_WAYS             (2),
       .OPTION_ICACHE_LIMIT_WIDTH      (32),
       .FEATURE_IMMU                   ("ENABLED"),
       .FEATURE_DATACACHE              ("ENABLED"),
       .OPTION_DCACHE_BLOCK_WIDTH      (5),
       .OPTION_DCACHE_SET_WIDTH        (8),
       .OPTION_DCACHE_WAYS             (2),
       .OPTION_DCACHE_LIMIT_WIDTH      (31),
       .FEATURE_DMMU                   ("ENABLED"),
       .OPTION_PIC_TRIGGER             ("LATCHED_LEVEL"),

       .IBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .DBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .OPTION_CPU0                    ("CAPPUCCINO"),
       .OPTION_RESET_PC                (32'h00000100)
) mor1kx0 (
	.iwbm_adr_o			(wb_m2s_or1k0_i_adr),
	.iwbm_stb_o			(wb_m2s_or1k0_i_stb),
	.iwbm_cyc_o			(wb_m2s_or1k0_i_cyc),
	.iwbm_sel_o			(wb_m2s_or1k0_i_sel),
	.iwbm_we_o			(wb_m2s_or1k0_i_we),
	.iwbm_cti_o			(wb_m2s_or1k0_i_cti),
	.iwbm_bte_o			(wb_m2s_or1k0_i_bte),
	.iwbm_dat_o			(wb_m2s_or1k0_i_dat),

	.dwbm_adr_o			(wb_m2s_or1k0_d_adr),
	.dwbm_stb_o			(wb_m2s_or1k0_d_stb),
	.dwbm_cyc_o			(wb_m2s_or1k0_d_cyc),
	.dwbm_sel_o			(wb_m2s_or1k0_d_sel),
	.dwbm_we_o			(wb_m2s_or1k0_d_we ),
	.dwbm_cti_o			(wb_m2s_or1k0_d_cti),
	.dwbm_bte_o			(wb_m2s_or1k0_d_bte),
	.dwbm_dat_o			(wb_m2s_or1k0_d_dat),

	.clk				(or1k_clk),
	.rst				(or1k_rst),

	.iwbm_err_i			(wb_s2m_or1k0_i_err),
	.iwbm_ack_i			(wb_s2m_or1k0_i_ack),
	.iwbm_dat_i			(wb_s2m_or1k0_i_dat),
	.iwbm_rty_i			(wb_s2m_or1k0_i_rty),

	.dwbm_err_i			(wb_s2m_or1k0_d_err),
	.dwbm_ack_i			(wb_s2m_or1k0_d_ack),
	.dwbm_dat_i			(wb_s2m_or1k0_d_dat),
	.dwbm_rty_i			(wb_s2m_or1k0_d_rty),

	.irq_i				(or1k_irq[0]),

        .du_addr_i                      (16'b0),
        .du_stb_i                       (1'b0),
        .du_dat_i                       (32'b0),
        .du_we_i                        (1'b0),
        .du_dat_o                       (),
        .du_ack_o                       (),
        .du_stall_i                     (1'b0),
        .du_stall_o                     (),

        .multicore_coreid_i             (0),
        .multicore_numcores_i           (2),

            .snoop_adr_i             (snoop_adr),
            .snoop_en_i              (snoop_en),
         
            .traceport_exec_valid_o  (traceport_exec_valid[0]),
            .traceport_exec_pc_o     (traceport_exec_pc[0]),
            .traceport_exec_insn_o   (traceport_exec_insn[0]),
            .traceport_exec_wbdata_o (traceport_exec_wbdata[0]),
            .traceport_exec_wbreg_o  (traceport_exec_wbreg[0]),
            .traceport_exec_wben_o   (traceport_exec_wben[0])
            );

      mor1kx
     #(.FEATURE_DEBUGUNIT              ("ENABLED"),
       .FEATURE_CMOV                   ("ENABLED"),
       .FEATURE_INSTRUCTIONCACHE       ("ENABLED"),
       .FEATURE_MULTICORE              ("ENABLED"),
       .FEATURE_TRACEPORT_EXEC         ("ENABLED"),
       .OPTION_ICACHE_BLOCK_WIDTH      (5),
       .OPTION_ICACHE_SET_WIDTH        (8),
       .OPTION_ICACHE_WAYS             (2),
       .OPTION_ICACHE_LIMIT_WIDTH      (32),
       .FEATURE_IMMU                   ("ENABLED"),
       .FEATURE_DATACACHE              ("ENABLED"),
       .OPTION_DCACHE_BLOCK_WIDTH      (5),
       .OPTION_DCACHE_SET_WIDTH        (8),
       .OPTION_DCACHE_WAYS             (2),
       .OPTION_DCACHE_LIMIT_WIDTH      (31),
       .FEATURE_DMMU                   ("ENABLED"),
       .OPTION_PIC_TRIGGER             ("LATCHED_LEVEL"),
       
       .IBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .DBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .OPTION_CPU0                    ("CAPPUCCINO"),
       .OPTION_RESET_PC                (32'h00000100))
   mor1kx1 (
	.iwbm_adr_o			(wb_m2s_or1k1_i_adr),
	.iwbm_stb_o			(wb_m2s_or1k1_i_stb),
	.iwbm_cyc_o			(wb_m2s_or1k1_i_cyc),
	.iwbm_sel_o			(wb_m2s_or1k1_i_sel),
	.iwbm_we_o			(wb_m2s_or1k1_i_we),
	.iwbm_cti_o			(wb_m2s_or1k1_i_cti),
	.iwbm_bte_o			(wb_m2s_or1k1_i_bte),
	.iwbm_dat_o			(wb_m2s_or1k1_i_dat),

	.dwbm_adr_o			(wb_m2s_or1k1_d_adr),
	.dwbm_stb_o			(wb_m2s_or1k1_d_stb),
	.dwbm_cyc_o			(wb_m2s_or1k1_d_cyc),
	.dwbm_sel_o			(wb_m2s_or1k1_d_sel),
	.dwbm_we_o			(wb_m2s_or1k1_d_we ),
	.dwbm_cti_o			(wb_m2s_or1k1_d_cti),
	.dwbm_bte_o			(wb_m2s_or1k1_d_bte),
	.dwbm_dat_o			(wb_m2s_or1k1_d_dat),

	.clk				(or1k_clk),
	.rst				(or1k_rst),

	.iwbm_err_i			(wb_s2m_or1k1_i_err),
	.iwbm_ack_i			(wb_s2m_or1k1_i_ack),
	.iwbm_dat_i			(wb_s2m_or1k1_i_dat),
	.iwbm_rty_i			(wb_s2m_or1k1_i_rty),

	.dwbm_err_i			(wb_s2m_or1k1_d_err),
	.dwbm_ack_i			(wb_s2m_or1k1_d_ack),
	.dwbm_dat_i			(wb_s2m_or1k1_d_dat),
	.dwbm_rty_i			(wb_s2m_or1k1_d_rty),

	.irq_i				(or1k_irq[1]),

        .du_addr_i                      (16'b0),
        .du_stb_i                       (1'b0),
        .du_dat_i                       (32'b0),
        .du_we_i                        (1'b0),
        .du_dat_o                       (),
        .du_ack_o                       (),
        .du_stall_i                     (1'b0),
        .du_stall_o                     (),

        .multicore_coreid_i             (1),
        .multicore_numcores_i           (2),

            .snoop_adr_i             (snoop_adr),
            .snoop_en_i              (snoop_en),
            
            .traceport_exec_valid_o  (traceport_exec_valid[1]),
            .traceport_exec_pc_o     (traceport_exec_pc[1]),
            .traceport_exec_insn_o   (traceport_exec_insn[1]),
            .traceport_exec_wbdata_o (traceport_exec_wbdata[1]),
            .traceport_exec_wbreg_o  (traceport_exec_wbreg[1]),
            .traceport_exec_wben_o   (traceport_exec_wben[1])
            );

   
////////////////////////////////////////////////////////////////////////
//
// Generic main RAM
//
////////////////////////////////////////////////////////////////////////

assign snoop_adr = wb_m2s_mem_adr;
assign snoop_en = wb_s2m_mem_ack & wb_m2s_mem_we;

ram_wb_b3 #(
        .mem_size_bytes (2**MEM_SIZE_BITS*(wb_dw/8)),
        .mem_adr_width  (MEM_SIZE_BITS)
) wb_bfm_memory0 (
        //Wishbone Master interface
        .wb_clk_i       (wb_clk_i),
        .wb_rst_i       (wb_rst_i),
        .wb_adr_i       (wb_m2s_mem_adr & (2**MEM_SIZE_BITS-1)),
        .wb_dat_i       (wb_m2s_mem_dat),
        .wb_sel_i       (wb_m2s_mem_sel),
        .wb_we_i        (wb_m2s_mem_we),
        .wb_cyc_i       (wb_m2s_mem_cyc),
        .wb_stb_i       (wb_m2s_mem_stb),
        .wb_cti_i       (wb_m2s_mem_cti),
        .wb_bte_i       (wb_m2s_mem_bte),
        .wb_dat_o       (wb_s2m_mem_dat),
        .wb_ack_o       (wb_s2m_mem_ack),
        .wb_err_o       (wb_s2m_mem_err),
        .wb_rty_o       (wb_s2m_mem_rty)
);

wire uart_irq;

wb_uart_wrapper #(
        .DEBUG  (0),
        .SIM    (UART_SIM)
) wb_uart_wrapper0 (
        //Wishbone Master interface
        .wb_clk_i       (wb_clk_i),
        .wb_rst_i       (wb_rst_i),
        .rx             (1'b0),
        .tx             (uart),
        .int_o          (uart_irq),
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
wire [7:0]      uart_rx_data;
wire            uart_rx_done;

uart_transceiver uart_transceiver0 (
        .sys_rst        (wb_rst_i),
        .sys_clk        (wb_clk_i),

        .uart_rx        (uart),
        .uart_tx        (),

        .divisor        (16'd26),

        .rx_data        (uart_rx_data),
        .rx_done        (uart_rx_done),

        .tx_data        (8'h00),
        .tx_wr          (1'b0),
        .tx_done        (),

        .rx_break       ()
);

always @(posedge wb_clk_i)
        if(uart_rx_done)
                $write("%c", uart_rx_data);

`endif

wire [0:1] ipi_irq;
ipi #(
	.NUM_CORES	(2)
) ipi  (
	.clk		(wb_clk_i),
	.rst		(wb_rst_i),
	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_ipi_adr[16:0]),
	.wb_dat_i	(wb_m2s_ipi_dat),
	.wb_sel_i	(wb_m2s_ipi_sel),
	.wb_we_i	(wb_m2s_ipi_we),
	.wb_cyc_i	(wb_m2s_ipi_cyc),
	.wb_stb_i	(wb_m2s_ipi_stb),
	.wb_cti_i	(wb_m2s_ipi_cti),
	.wb_bte_i	(wb_m2s_ipi_bte),
	.wb_dat_o	(wb_s2m_ipi_dat),
	.wb_ack_o	(wb_s2m_ipi_ack),
	.wb_err_o	(wb_s2m_ipi_err),
	.wb_rty_o	(wb_s2m_ipi_rty),

	// Per-core Interrupt output
	.irq		(ipi_irq)
);

tc tc  (
	.clk		(wb_clk_i),
	.rst		(wb_rst_i),
	// Wishbone slave interface
	.wb_adr_i	(wb_m2s_tc_adr),
	.wb_dat_i	(wb_m2s_tc_dat),
	.wb_sel_i	(wb_m2s_tc_sel),
	.wb_we_i	(wb_m2s_tc_we),
	.wb_cyc_i	(wb_m2s_tc_cyc),
	.wb_stb_i	(wb_m2s_tc_stb),
	.wb_cti_i	(wb_m2s_tc_cti),
	.wb_bte_i	(wb_m2s_tc_bte),
	.wb_dat_o	(wb_s2m_tc_dat),
	.wb_ack_o	(wb_s2m_tc_ack),
	.wb_err_o	(wb_s2m_tc_err),
	.wb_rty_o	(wb_s2m_tc_rty)
);

////////////////////////////////////////////////////////////////////////
//
// CPU Interrupt assignments
//
////////////////////////////////////////////////////////////////////////
assign or1k_irq[0][31] = 0;
assign or1k_irq[0][30:3] = 0;
assign or1k_irq[0][2] = uart_irq;
assign or1k_irq[0][1] = ipi_irq[0];
assign or1k_irq[0][0] = 0;

assign or1k_irq[1][31] = 0;
assign or1k_irq[1][30:3] = 0;
assign or1k_irq[1][2] = uart_irq;
assign or1k_irq[1][1] = ipi_irq[1];
assign or1k_irq[1][0] = 0;

endmodule
