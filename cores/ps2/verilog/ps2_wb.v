/*
-------------------------------------------------------------------------------
-- Title      : PS/2 Wishbone Interface
-- Project    :
-------------------------------------------------------------------------------
-- File       : ps2_wishbone.v
-- Author(s)  : Daniel Quinter <danielqg@infonegocio.com>
--            : Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
-- Created    : 2003-05-08
-- Last update: 2011-05-19
-- Platform   : Verilog 2001
-------------------------------------------------------------------------------
-- Description: PS/2 mice/keyboard wishbone interface
-------------------------------------------------------------------------------
--  This code is distributed under the terms and conditions of the
--  GNU General Public License
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2003-05-08  1.0      daniel  Created
-- 2011-05-19  x.x      Stefan  Conversion to verilog  
-------------------------------------------------------------------------------
*/

module ps2_wb(                          // Wishbone interface
    input  wire       wb_clk_i,
    input  wire       wb_rst_i,
    input  wire [7:0] wb_dat_i,
    output wire [7:0] wb_dat_o,
    input  wire [0:0] wb_adr_i,
    input  wire       wb_stb_i,
    input  wire       wb_we_i,
    output wire       wb_ack_o,

    // IRQ output
    output wire       irq_o,

    // PS2 signals
    inout wire ps2_clk,
    inout wire ps2_dat
);

    wire       nrst;
    wire [7:0] ps2_data_o;
    wire [7:0] ps2_data_i;
    wire       ibf_clr;
    wire       obf_set;
    wire       ibf;
    wire       obf;
    wire       frame_err;
    wire       parity_err;
    wire       busy;
    wire       err_clr;
    wire       wdt;

    wire [7:0] status_reg;
    reg  [7:0] control_reg;

    wire irq_rx_enb;
    wire irq_tx_enb;

    ps2 ps2_uart(
        .clk_i        (wb_clk_i),
        .rst_i        (nrst),
        .data_o       (ps2_data_o),
        .data_i       (ps2_data_i),
        .ibf_clr_i    (ibf_clr),
        .obf_set_i    (obf_set),
        .ibf_o        (ibf),
        .obf_o        (obf),
        .frame_err_o  (frame_err),
        .parity_err_o (parity_err),
        .busy_o       (busy),
        .err_clr_i    (err_clr),
        .wdt_o        (wdt),
        .ps2_clk_io   (ps2_clk),
        .ps2_data_io  (ps2_dat)
    );

    assign nrst = !wb_rst_i;

    // clear error flags when clear it's
    assign err_clr = wb_stb_i & wb_we_i & wb_adr_i & !wb_dat_i[3];

    // clear In Buffer Full (IBF) flag when clear it
    assign ibf_clr = wb_stb_i & wb_we_i & wb_adr_i & !wb_dat_i[0];

    // set Out Buffer Full when write to data register
    assign obf_set = wb_stb_i & wb_we_i & !wb_adr_i[0];

    // Status register
    assign status_reg[7]   = irq_tx_enb;
    assign status_reg[6]   = irq_rx_enb;
    assign status_reg[5:4] = 2'b0;
    assign status_reg[3]   = parity_err | frame_err;
    assign status_reg[2]   = obf;
    assign status_reg[1]   = ibf;
    assign status_reg[0]   = busy;

    // Control register
    assign irq_rx_enb = control_reg[6];
    assign irq_tx_enb = control_reg[7];

    // purpose: Control register latch
    always @(posedge wb_clk_i)
        if (wb_rst_i)
            control_reg[7:6] <= 0;
        else if (wb_stb_i & wb_we_i & wb_adr_i) // control_write
            control_reg[7:6] <= wb_dat_i[7:6];
        
    // output data/status
    assign wb_dat_o   = wb_adr_i[0] ? status_reg : ps2_data_o;
    assign ps2_data_i = wb_dat_i;

    // Irq generation
    assign irq_o = (ibf & irq_rx_enb) | (!obf & irq_tx_enb);

    // no wait states for all acceses
    assign wb_ack_o = wb_stb_i;

endmodule
