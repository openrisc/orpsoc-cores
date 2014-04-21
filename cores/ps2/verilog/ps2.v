/*
-------------------------------------------------------------------------------
-- Title      : PS/2 interface
-- Project    :
-------------------------------------------------------------------------------
-- File       : ps2.v
-- Author(s)  : Daniel Quintero <danielqg@infonegocio.com>
--            : Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
-- Created    : 2003-04-14
-- Last update: 2011-05-24
-- Platform   : verilog 2001
-------------------------------------------------------------------------------
-- Description: PS/2 generic UART for mice/keyboard
-------------------------------------------------------------------------------
--  This code is distributed under the terms and conditions of the
--  GNU General Public License
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2003-04-14  1.0      daniel  Created
-- 2011-05-24  x.0      Stefan  Bugfixes/improvements and conversion to verilog
-------------------------------------------------------------------------------
*/

module ps2(
    input  wire       clk_i,        // Global clk
    input  wire       rst_i,        // Global Asinchronous reset

    output wire [7:0] data_o,       // Data in
    input  wire [7:0] data_i,       // Data out
    input  wire       ibf_clr_i,    // Ifb flag clear input
    input  wire       obf_set_i,    // Obf flag set input
    output wire       ibf_o,        // Received data available
    output wire       obf_o,        // Data ready to sent

    output wire       frame_err_o,  // Error receiving data
    output wire       parity_err_o, // Error in received data parity
    output wire       busy_o,       // uart busy
    inout  wire       err_clr_i,    // Clear error flags

    output wire       wdt_o,        // Watchdog timer out every 400uS

    inout  wire       ps2_clk_io,   // PS2 Clock line
    inout  wire       ps2_data_io   // PS2 Data line
);

    parameter [2:0]
        idle          = 3'd1,
        write_request = 3'd2,
        start         = 3'd3,
        data          = 3'd4,
        parity        = 3'd5, 
        stop          = 3'd6;
    
    parameter [2:0]
        stable        = 3'd1, 
        rise          = 3'd2,
        fall          = 3'd3, 
        wait_stable   = 3'd4;

     
    //parameter DEBOUNCE_TIMEOUT = 200;  // clks to debounce the ps2_clk signal
    parameter DEBOUNCE_BITS = 8;
    //parameter WATCHDOG_TIMEOUT = 19200 / DEBOUNCE_TIMEOUT;  // clks to wait 400uS
    parameter WATCHDOG_BITS = 8;

    reg  [2:0]               state;
    reg  [2:0]               debounce_state;
    reg  [DEBOUNCE_BITS-1:0] debounce_cnt;
    wire                     debounce_cao;
    reg  [1:0]               ps2_clk_r;         // PS2 clock input registered
    wire                     ps2_clk_syn;       // PS2 clock input syncronized
    reg                      ps2_clk_clean;     // PS2 clock debounced and clean
    wire                     ps2_clk_fall;      // PS2 clock fall edge
    wire                     ps2_clk_rise;      // PS2 clock rise edge
    reg  [1:0]               ps2_data_r;        // PS2 data input registered
    wire                     ps2_data_syn;      // PS2 data  input syncronized
    reg                      ps2_clk_out;       // PS2 clock output
    reg                      ps2_data_out;      // PS2 clock output
    reg                      writing;           // read / write cycle flag
    reg  [2:0]               shift_cnt;
    wire                     shift_cao;         // Shift counter carry out
    reg  [8:0]               shift_reg;
    wire                     shift_in_read;     // Shift register to right
    wire                     shift_in_write;    // Shift register to right
    wire                     shift_load;        // Shift register parallel load
    wire                     shift_calc_parity; // Shift register set parity
    reg  [WATCHDOG_BITS-1:0] wdt_cnt;
    wire                     wdt_rst;           // watchdog reset
    wire                     wdt_cao;           // watchdog carry out
    wire                     shift_parity;      // Current parity of shift_reg
    reg                      ibf;               // IBF, In Buffer Full
    wire                     obf;               // OBF, Out Buffer Full
    reg                      parity_err;        // Parity error
    reg                      frame_err;         // Frame error
    reg  [7:0]               data_i_reg;
    reg  [7:0]               data_o_reg;
    reg                      obf_set;

    // Syncronize input signals
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin     // asynchronous reset (active low)
            ps2_clk_r  <= 0;
            ps2_data_r <= 0;
        end else begin
            ps2_clk_r  <= {ps2_clk_io, ps2_clk_r[1]};
            ps2_data_r <= {ps2_data_io, ps2_data_r[1]};
        end
    end
    assign ps2_clk_syn = ps2_clk_r[0];
    assign ps2_data_syn = ps2_data_r[0];

    // clk debounce timer
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i)     // asynchronous reset (active low)
            debounce_cnt <= 0;
        else 
            if (ps2_clk_fall | ps2_clk_rise | debounce_cao)
                debounce_cnt <= 0;
            else
                debounce_cnt <= debounce_cnt + 1;

    assign debounce_cao = debounce_cnt[DEBOUNCE_BITS-1];

    // PS2 clock debounce and edge detector
    always @(posedge clk_i or negedge rst_i) begin
        if (!rst_i) begin
                debounce_state <= stable;
                ps2_clk_clean  <= 1'b0;
        end else begin
            case (debounce_state)
                stable: begin
                    if (ps2_clk_clean != ps2_clk_syn) begin
                        if (ps2_clk_syn)
                            debounce_state <= rise;
                        else
                            debounce_state <= fall;
                    end
                end

                wait_stable: begin
                    if (debounce_cao)
                        debounce_state <= stable;
                end

                rise: begin
                    debounce_state <= wait_stable;
                    ps2_clk_clean  <= 1'b1;
                end

                fall: begin
                    debounce_state <= wait_stable;
                    ps2_clk_clean  <= 1'b0;
                end

                //default:
            endcase
        end
    end

    assign ps2_clk_fall = (debounce_state == fall);
    assign ps2_clk_rise = (debounce_state == rise);

    // PS2 watchdog
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) // asynchronous reset (active low)
            wdt_cnt <= 0;
        else
            if (wdt_rst | wdt_cao)
                wdt_cnt <= 0;
            else if (debounce_cao)
                wdt_cnt <= wdt_cnt + 1;

    assign wdt_cao = wdt_cnt[WATCHDOG_BITS-1];
    assign wdt_rst = ps2_clk_fall;

    // Shift register
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) // asynchronous reset (active low)
            shift_reg <= 0;
        else
            if (shift_load) begin
                shift_reg[7:0] <= data_i_reg;
                shift_reg[8]   <= 1'b0;
            end else if (shift_calc_parity) begin
                shift_reg[8] <= ~shift_parity;
            end else if (!writing) begin
                if (shift_in_read) begin
                    shift_reg[7:0] <= shift_reg[8:1];
                    shift_reg[8]   <= ps2_data_syn;
                end
            end else if (writing) begin
                if (shift_in_write) begin
                    shift_reg[7:0] <= shift_reg[8:1];
                    shift_reg[8]   <= 1'b1;
                end
            end

    // Shift counter
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) // asynchronous reset (active low)
            shift_cnt <= 0;
        else
            if (state == start)
                shift_cnt <= 0;
            else if (ps2_clk_fall & (state == data))
                shift_cnt <= shift_cnt + 1;

    assign shift_cao = (&shift_cnt);

    // Odd Parity generator
    assign shift_parity = (shift_reg[0] ^
                           shift_reg[1] ^
                           shift_reg[2] ^
                           shift_reg[3] ^
                           shift_reg[4] ^
                           shift_reg[5] ^
                           shift_reg[6] ^
                           shift_reg[7]);

    // Main State Machine
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) begin // asynchronous reset (active low)
            state   <= idle;
            writing <= 1'b0;
        end else
            case (state)
                // Waiting for clk
                idle: begin
                    if (obf_set & !writing) begin
                        state   <= write_request;
                        writing <= 1'b1;
                    end else if (ps2_clk_fall)
                        state <= start;
                end

                // Write request, clk low
                write_request: begin
                    if (wdt_cao)
                        state <= start;
                end

                // Clock 1, start bit
                start: begin
                    if (wdt_cao) begin
                        writing <= 1'b0;
                        state   <= idle;
                    end else if (ps2_clk_fall)
                        state <= data;
                end

                // Clocks 2-9, Data bits (LSB first)
                data: begin
                    if (wdt_cao) begin
                        writing <= 1'b0;
                        state   <= idle;
                    end else if (ps2_clk_fall & shift_cao)
                        state <= parity;
                end

                // Clock 10, Parity bit
                parity: begin
                    if (wdt_cao) begin
                        writing <= 1'b0;
                        state   <= idle;
                    end else if (ps2_clk_fall)
                        state <= stop;
                end

                // Clock 11, Stop bit
                stop: begin
                    if (writing) begin
                        // ack
                        if ((ps2_clk_fall & !ps2_data_syn) | wdt_cao) begin
                            state   <= idle;
                            writing <= 1'b0;
                        end
                    end else begin
                        data_o_reg <= shift_reg[7:0];
                        state <= idle;
                    end
                end
                //default:
            endcase

    // State flags
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) begin // asynchronous reset (active low)
            ibf <= 1'b0;
            parity_err <= 1'b0;
            frame_err  <= 1'b0;
        end else begin
            // Parity error flag
            if (err_clr_i)
                parity_err <= 1'b0;
            else if (!writing & state == stop) begin
                if (shift_reg[8] != ~shift_parity)
                    parity_err <= 1'b1;
            end

            // Frame error flag
            if (err_clr_i)
                frame_err <= 1'b0;
            else if ((state == start | state == data  | state == parity) & 
                      wdt_cao)
                frame_err <= 1'b1;

            // Input Buffer full flag
            if (ibf_clr_i)
                ibf <= 1'b0;
            else if (!writing & state == stop)
                if (shift_reg[8] == ~shift_parity)
                    ibf <= 1'b1;
        end

    assign obf = writing;

    // Shift register control
    assign shift_load        = (obf_set & state == write_request);
    assign shift_calc_parity = (state == start & writing);
    assign shift_in_read     = (state == data | state == start)  ? ps2_clk_fall : 1'b0;
    assign shift_in_write    = (state == data | state == parity) ? ps2_clk_fall : 1'b0;

    // PS2 Registered outputs
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) begin // asynchronous reset (active low)
            ps2_data_out <= 1'b1;
            ps2_clk_out  <= 1'b1;
        end else begin
            // PS2 Data out
            if (writing) begin
                if (state == write_request | state == start)
                    ps2_data_out <= 1'b0;
                else if (state == data | state == parity)
                    ps2_data_out <= shift_reg[0];
                else
                    ps2_data_out <= 1'b1;
            end
            // PS2 Clk out
            if (state == write_request)
                ps2_clk_out <= 1'b0;
            else
                ps2_clk_out <= 1'b1;
        end
        
    always @(posedge clk_i or negedge rst_i)
        if (!rst_i) begin
            data_i_reg <= 0;
            obf_set    <= 1'b0;
        end else if (obf_set_i) begin
            data_i_reg <= data_i;
            obf_set    <= 1'b1;
        end else if (state == write_request)
            obf_set    <= 1'b0;
        
    assign data_o       = data_o_reg;
    assign ibf_o        = ibf;
    assign obf_o        = obf;
    assign busy_o       = !(state == idle & !writing);
    assign parity_err_o = parity_err;
    assign frame_err_o  = frame_err;
    assign wdt_o        = wdt_cao;

    assign ps2_clk_io   = (!ps2_clk_out)  ? 1'b0 : 1'bz;
    assign ps2_data_io  = (!ps2_data_out) ? 1'b0 : 1'bz;

endmodule
