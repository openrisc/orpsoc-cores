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

   wire [31:0] wb_m2s_mem_adr;
   wire [31:0] wb_m2s_mem_dat;
   wire [3:0]  wb_m2s_mem_sel;
   wire        wb_m2s_mem_we;
   wire        wb_m2s_mem_cyc;
   wire        wb_m2s_mem_stb;
   wire [2:0]  wb_m2s_mem_cti;
   wire [1:0]  wb_m2s_mem_bte;
   wire [31:0] wb_s2m_mem_dat;
   wire        wb_s2m_mem_ack;
   wire        wb_s2m_mem_err;
   wire        wb_s2m_mem_rty;
   
   wire [31:0] wb_m2s_uart_adr;
   wire [31:0] wb_m2s_uart_dat;
   wire [3:0]  wb_m2s_uart_sel;
   wire        wb_m2s_uart_we;
   wire        wb_m2s_uart_cyc;
   wire        wb_m2s_uart_stb;
   wire [2:0]  wb_m2s_uart_cti;
   wire [1:0]  wb_m2s_uart_bte;
   wire [31:0] wb_s2m_uart_dat;
   wire        wb_s2m_uart_ack;
   wire        wb_s2m_uart_err;
   wire        wb_s2m_uart_rty;

////////////////////////////////////////////////////////////////////////
//
// Bus
//
////////////////////////////////////////////////////////////////////////

   wire [31:0] snoop_adr;
   wire        snoop_en;
   
   /* wb_bus_b3 AUTO_TEMPLATE (
    .clk_i (wb_clk),
    .rst_i (wb_rst),
    .m_\(.*\)_i ({wbm_\1_o[3], wbm_\1_o[2], wbm_\1_o[1], wbm_\1_o[0]}),
    .m_\(.*\)_o ({wbm_\1_i[3], wbm_\1_i[2], wbm_\1_i[1], wbm_\1_i[0]}),
    .s_\(.*\)_i ({wb_s2m_uart_\1, wb_s2m_mem_\1}),
    .s_\(.*\)_o ({wb_m2s_uart_\1, wb_m2s_mem_\1}),
    .bus_hold (1'b0),
    .bus_hold_ack (),
    .snoop_adr_o (snoop_adr),
    .snopp_en_o  (snoop_en)
    );*/
   wb_bus_b3
     #(.MASTERS (4),
       .SLAVES  (2),
       .S1_RANGE_WIDTH (29),
       .S1_RANGE_MATCH (29'hff800000))
       .S0_RANGE_WIDTH (7),
       .S0_RANGE_MATCH (7'h0),
   u_bus (/*AUTOINST*/
          // Outputs
          .m_dat_o                      ({wbm_dat_i[3], wbm_dat_i[2], wbm_dat_i[1], wbm_dat_i[0]}), // Templated
          .m_ack_o                      ({wbm_ack_i[3], wbm_ack_i[2], wbm_ack_i[1], wbm_ack_i[0]}), // Templated
          .m_err_o                      ({wbm_err_i[3], wbm_err_i[2], wbm_err_i[1], wbm_err_i[0]}), // Templated
          .m_rty_o                      ({wbm_rty_i[3], wbm_rty_i[2], wbm_rty_i[1], wbm_rty_i[0]}), // Templated
          .s_adr_o                      ({wb_m2s_uart_adr, wb_m2s_mem_adr}), // Templated
          .s_dat_o                      ({wb_m2s_uart_dat, wb_m2s_mem_dat}), // Templated
          .s_cyc_o                      ({wb_m2s_uart_cyc, wb_m2s_mem_cyc}), // Templated
          .s_stb_o                      ({wb_m2s_uart_stb, wb_m2s_mem_stb}), // Templated
          .s_sel_o                      ({wb_m2s_uart_sel, wb_m2s_mem_sel}), // Templated
          .s_we_o                       ({wb_m2s_uart_we, wb_m2s_mem_we}), // Templated
          .s_cti_o                      ({wb_m2s_uart_cti, wb_m2s_mem_cti}), // Templated
          .s_bte_o                      ({wb_m2s_uart_bte, wb_m2s_mem_bte}), // Templated
          .snoop_adr_o                  (snoop_adr),                      // Templated
          .snoop_en_o                   (snoop_en),                      // Templated
          .bus_hold_ack                 (),                      // Templated
          // Inputs
          .clk_i                        (wb_clk),                // Templated
          .rst_i                        (wb_rst),                // Templated
          .m_adr_i                      ({wbm_adr_o[3], wbm_adr_o[2], wbm_adr_o[1], wbm_adr_o[0]}), // Templated
          .m_dat_i                      ({wbm_dat_o[3], wbm_dat_o[2], wbm_dat_o[1], wbm_dat_o[0]}), // Templated
          .m_cyc_i                      ({wbm_cyc_o[3], wbm_cyc_o[2], wbm_cyc_o[1], wbm_cyc_o[0]}), // Templated
          .m_stb_i                      ({wbm_stb_o[3], wbm_stb_o[2], wbm_stb_o[1], wbm_stb_o[0]}), // Templated
          .m_sel_i                      ({wbm_sel_o[3], wbm_sel_o[2], wbm_sel_o[1], wbm_sel_o[0]}), // Templated
          .m_we_i                       ({wbm_we_o[3], wbm_we_o[2], wbm_we_o[1], wbm_we_o[0]}), // Templated
          .m_cti_i                      ({wbm_cti_o[3], wbm_cti_o[2], wbm_cti_o[1], wbm_cti_o[0]}), // Templated
          .m_bte_i                      ({wbm_bte_o[3], wbm_bte_o[2], wbm_bte_o[1], wbm_bte_o[0]}), // Templated
          .s_dat_i                      ({wb_s2m_uart_dat, wb_s2m_mem_dat}), // Templated
          .s_ack_i                      ({wb_s2m_uart_ack, wb_s2m_mem_ack}), // Templated
          .s_err_i                      ({wb_s2m_uart_err, wb_s2m_mem_err}), // Templated
          .s_rty_i                      ({wb_s2m_uart_rty, wb_s2m_mem_rty}), // Templated
          .bus_hold                     (1'b0));                         // Templated
   
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
 //      .FEATURE_INSTRUCTIONCACHE       ("ENABLED"),
       .FEATURE_MULTICORE              ("ENABLED"),
       .FEATURE_TRACEPORT_EXEC         ("ENABLED"),
       .OPTION_ICACHE_BLOCK_WIDTH      (5),
       .OPTION_ICACHE_SET_WIDTH        (8),
       .OPTION_ICACHE_WAYS             (4),
       .OPTION_ICACHE_LIMIT_WIDTH      (32),
       .FEATURE_IMMU                   ("ENABLED"),
//       .FEATURE_DATACACHE              ("ENABLED"),
       .OPTION_DCACHE_BLOCK_WIDTH      (5),
       .OPTION_DCACHE_SET_WIDTH        (8),
       .OPTION_DCACHE_WAYS             (8),
       .OPTION_DCACHE_LIMIT_WIDTH      (31),
       .FEATURE_DMMU                   ("ENABLED"),
       .OPTION_PIC_TRIGGER             ("LATCHED_LEVEL"),
       
       .IBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .DBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .OPTION_CPU0                    ("CAPPUCCINO"),
       .OPTION_RESET_PC                (32'h00000100))
   mor1kx0 (
        .iwbm_adr_o                     (wbm_adr_o[0]),
        .iwbm_stb_o                     (wbm_stb_o[0]),
        .iwbm_cyc_o                     (wbm_cyc_o[0]),
        .iwbm_sel_o                     (wbm_sel_o[0]),
        .iwbm_we_o                      (wbm_we_o[0]),
        .iwbm_cti_o                     (wbm_cti_o[0]),
        .iwbm_bte_o                     (wbm_bte_o[0]),
        .iwbm_dat_o                     (wbm_dat_o[0]),

        .dwbm_adr_o                     (wbm_adr_o[1]),
        .dwbm_stb_o                     (wbm_stb_o[1]),
        .dwbm_cyc_o                     (wbm_cyc_o[1]),
        .dwbm_sel_o                     (wbm_sel_o[1]),
        .dwbm_we_o                      (wbm_we_o[1]),
        .dwbm_cti_o                     (wbm_cti_o[1]),
        .dwbm_bte_o                     (wbm_bte_o[1]),
        .dwbm_dat_o                     (wbm_dat_o[1]),

        .clk                            (or1k_clk),
        .rst                            (or1k_rst),

        .iwbm_err_i                     (wbm_err_i[0]),
        .iwbm_ack_i                     (wbm_ack_i[0]),
        .iwbm_dat_i                     (wbm_dat_i[0]),
        .iwbm_rty_i                     (wbm_rty_i[0]),

        .dwbm_err_i                     (wbm_err_i[1]),
        .dwbm_ack_i                     (wbm_ack_i[1]),
        .dwbm_dat_i                     (wbm_dat_i[1]),
        .dwbm_rty_i                     (wbm_rty_i[1]),

        .irq_i                          (or1k_irq[0]),

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
//       .FEATURE_INSTRUCTIONCACHE       ("ENABLED"),
       .FEATURE_MULTICORE              ("ENABLED"),
       .FEATURE_TRACEPORT_EXEC         ("ENABLED"),
       .OPTION_ICACHE_BLOCK_WIDTH      (5),
       .OPTION_ICACHE_SET_WIDTH        (8),
       .OPTION_ICACHE_WAYS             (4),
       .OPTION_ICACHE_LIMIT_WIDTH      (32),
       .FEATURE_IMMU                   ("ENABLED"),
//       .FEATURE_DATACACHE              ("ENABLED"),
       .OPTION_DCACHE_BLOCK_WIDTH      (5),
       .OPTION_DCACHE_SET_WIDTH        (8),
       .OPTION_DCACHE_WAYS             (8),
       .OPTION_DCACHE_LIMIT_WIDTH      (31),
       .FEATURE_DMMU                   ("ENABLED"),
       .OPTION_PIC_TRIGGER             ("LATCHED_LEVEL"),
       
       .IBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .DBUS_WB_TYPE                   ("B3_REGISTERED_FEEDBACK"),
       .OPTION_CPU0                    ("CAPPUCCINO"),
       .OPTION_RESET_PC                (32'h00000100))
   mor1kx1 (
        .iwbm_adr_o                     (wbm_adr_o[2]),
        .iwbm_stb_o                     (wbm_stb_o[2]),
        .iwbm_cyc_o                     (wbm_cyc_o[2]),
        .iwbm_sel_o                     (wbm_sel_o[2]),
        .iwbm_we_o                      (wbm_we_o[2]),
        .iwbm_cti_o                     (wbm_cti_o[2]),
        .iwbm_bte_o                     (wbm_bte_o[2]),
        .iwbm_dat_o                     (wbm_dat_o[2]),

        .dwbm_adr_o                     (wbm_adr_o[3]),
        .dwbm_stb_o                     (wbm_stb_o[3]),
        .dwbm_cyc_o                     (wbm_cyc_o[3]),
        .dwbm_sel_o                     (wbm_sel_o[3]),
        .dwbm_we_o                      (wbm_we_o[3]),
        .dwbm_cti_o                     (wbm_cti_o[3]),
        .dwbm_bte_o                     (wbm_bte_o[3]),
        .dwbm_dat_o                     (wbm_dat_o[3]),

        .clk                            (or1k_clk),
        .rst                            (or1k_rst),

        .iwbm_err_i                     (wbm_err_i[2]),
        .iwbm_ack_i                     (wbm_ack_i[2]),
        .iwbm_dat_i                     (wbm_dat_i[2]),
        .iwbm_rty_i                     (wbm_rty_i[2]),

        .dwbm_err_i                     (wbm_err_i[3]),
        .dwbm_ack_i                     (wbm_ack_i[3]),
        .dwbm_dat_i                     (wbm_dat_i[3]),
        .dwbm_rty_i                     (wbm_rty_i[3]),

        .irq_i                          (or1k_irq[1]),

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

wb_uart_wrapper #(
        .DEBUG  (0),
        .SIM    (UART_SIM)
) wb_uart_wrapper0 (
        //Wishbone Master interface
        .wb_clk_i       (wb_clk_i),
        .wb_rst_i       (wb_rst_i),
        .rx             (1'b0),
        .tx             (uart),
        .wb_adr_i       (wb_m2s_uart_adr),
        .wb_dat_i       (wb_m2s_uart_dat),
        .wb_we_i        (wb_m2s_uart_we),
        .wb_cyc_i       (wb_m2s_uart_cyc),
        .wb_stb_i       (wb_m2s_uart_stb),
        .wb_cti_i       (wb_m2s_uart_cti),
        .wb_bte_i       (wb_m2s_uart_bte),
        .wb_dat_o       (wb_s2m_uart_dat),
        .wb_ack_o       (wb_s2m_uart_ack),
        .wb_err_o       (wb_s2m_uart_err),
        .wb_rty_o       (wb_s2m_uart_rty)
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

////////////////////////////////////////////////////////////////////////
//
// CPU Interrupt assignments
//
////////////////////////////////////////////////////////////////////////
assign or1k_irq[0] = 0;
assign or1k_irq[1] = 0;

endmodule
