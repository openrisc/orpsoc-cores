/*
 *
 * Clock, reset generation unit for Atlys board
 *
 * Implements clock generation according to design defines
 *
 */
`include "orpsoc-defines.v"

module clkgen
       (
	// Main clocks in, depending on board
	input  sys_clk_pad_i,
	// Asynchronous, active low reset in
	input  rst_n_pad_i,
	// Input reset - through a buffer, asynchronous
	output async_rst_o,

	// Wishbone clock and reset out
	output wb_clk_o,
	output wb_rst_o,

	// JTAG clock
	input  tck_pad_i,
	output dbg_tck_o,

	// VGA CLK
	output dvi_clk_o,

	// Main memory clocks
	output ddr2_if_clk_o,
	output ddr2_if_rst_o,
	output clk100_o
);

// First, deal with the asychronous reset
wire	async_rst_n;

assign async_rst_n = rst_n_pad_i;

// Everyone likes active-high reset signals...
assign async_rst_o = ~async_rst_n;

assign dbg_tck_o = tck_pad_i;

//
// Declare synchronous reset wires here
//

// An active-low synchronous reset signal (usually a PLL lock signal)
wire	sync_wb_rst_n;
wire	sync_ddr2_rst_n;

// An active-low synchronous reset from ethernet PLL
wire	sync_eth_rst_n;


wire	sys_clk_pad_ibufg;
/* DCM0 wires */
wire	dcm0_clk0_prebufg, dcm0_clk0;
wire	dcm0_clk90_prebufg, dcm0_clk90;
wire	dcm0_clkfx_prebufg, dcm0_clkfx;
wire	dcm0_clkdv_prebufg, dcm0_clkdv;
wire	dcm0_clk2x_prebufg, dcm0_clk2x;
wire	dcm0_locked;

wire	pll0_clkfb;
wire	pll0_locked;
wire	pll0_clk1_prebufg, pll0_clk1;

IBUFG sys_clk_in_ibufg (
	.I	(sys_clk_pad_i),
	.O	(sys_clk_pad_ibufg)
);


// DCM providing main system/Wishbone clock
DCM_SP #(
	// Generate 266 MHz from CLKFX
	.CLKFX_MULTIPLY	(8),
	.CLKFX_DIVIDE	(3),

	// Generate 50 MHz from CLKDV
	.CLKDV_DIVIDE	(2.0)
) dcm0 (
	// Outputs
	.CLK0		(dcm0_clk0_prebufg),
	.CLK180		(),
	.CLK270		(),
	.CLK2X180	(),
	.CLK2X		(dcm0_clk2x_prebufg),
	.CLK90		(dcm0_clk90_prebufg),
	.CLKDV		(dcm0_clkdv_prebufg),
	.CLKFX180	(dcm0_clkfx_prebufg),
	.CLKFX		(),
	.LOCKED		(dcm0_locked),
	// Inputs
	.CLKFB		(dcm0_clk0),
	.CLKIN		(sys_clk_pad_ibufg),
	.PSEN		(1'b0),
	.RST		(async_rst_o)
);

// Daisy chain DCM-PLL to reduce jitter
PLL_BASE #(
	.BANDWIDTH("OPTIMIZED"),
	// .CLKFBOUT_MULT(8), // 80 MHz
	.CLKFBOUT_MULT(5), // 50 MHz
	.CLKFBOUT_PHASE(0.0),
	.CLKIN_PERIOD(10),
	.CLKOUT1_DIVIDE(10),
	.CLKOUT2_DIVIDE(1),
	.CLKOUT3_DIVIDE(1),
	.CLKOUT4_DIVIDE(1),
	.CLKOUT5_DIVIDE(1),
	.CLKOUT1_DUTY_CYCLE(0.5),
	.CLKOUT2_DUTY_CYCLE(0.5),
	.CLKOUT3_DUTY_CYCLE(0.5),
	.CLKOUT4_DUTY_CYCLE(0.5),
	.CLKOUT5_DUTY_CYCLE(0.5),
	.CLKOUT1_PHASE(0.0),
	.CLKOUT2_PHASE(0.0),
	.CLKOUT3_PHASE(0.0),
	.CLKOUT4_PHASE(0.0),
	.CLKOUT5_PHASE(0.0),
	.CLK_FEEDBACK("CLKFBOUT"),
	.COMPENSATION("DCM2PLL"),
	.DIVCLK_DIVIDE(1),
	.REF_JITTER(0.1),
	.RESET_ON_LOSS_OF_LOCK("FALSE")
) pll0 (
	.CLKFBOUT	(pll0_clkfb),
	.CLKOUT1	(pll0_clk1_prebufg),
	.CLKOUT2	(),
	.CLKOUT3	(CLKOUT3),
	.CLKOUT4	(CLKOUT4),
	.CLKOUT5	(CLKOUT5),
	.LOCKED		(pll0_locked),
	.CLKFBIN	(pll0_clkfb),
	.CLKIN		(dcm0_clk90_prebufg),
	.RST		(async_rst_o)
);

BUFG dcm0_clk0_bufg
       (// Outputs
	.O	(dcm0_clk0),
	// Inputs
	.I	(dcm0_clk0_prebufg)
);

BUFG dcm0_clk2x_bufg
       (// Outputs
	.O	(dcm0_clk2x),
	// Inputs
	.I	(dcm0_clk2x_prebufg)
);

BUFG dcm0_clkfx_bufg
       (// Outputs
	.O	(dcm0_clkfx),
	// Inputs
	.I	(dcm0_clkfx_prebufg)
);

/* This is buffered in dvi_gen
BUFG dcm0_clkdv_bufg
       (// Outputs
	.O	(dcm0_clkdv),
	// Inputs
	.I	(dcm0_clkdv_prebufg)
);
*/

BUFG pll0_clk1_bufg
       (// Outputs
	.O	(pll0_clk1),
	// Inputs
	.I	(pll0_clk1_prebufg));

assign wb_clk_o = pll0_clk1;
assign sync_wb_rst_n = pll0_locked;
assign sync_ddr2_rst_n = dcm0_locked;

assign ddr2_if_clk_o = dcm0_clkfx; // 266MHz
assign clk100_o = dcm0_clk0; // 100MHz

assign dvi_clk_o = dcm0_clkdv_prebufg;

//
// Reset generation
//
//

// Reset generation for wishbone
reg [15:0] 	   wb_rst_shr;
always @(posedge wb_clk_o or posedge async_rst_o)
	if (async_rst_o)
		wb_rst_shr <= 16'hffff;
	else
		wb_rst_shr <= {wb_rst_shr[14:0], ~(sync_wb_rst_n)};

assign wb_rst_o = wb_rst_shr[15];

assign ddr2_if_rst_o = async_rst_o;

endmodule // clkgen
