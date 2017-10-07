module mac2mac_bridge #(
	parameter	A_PHY_ADDR = 0,
	parameter	B_PHY_ADDR = 0
)(
	input		txrx_clk,

	// port a
	input [3:0]	a_txd,
	input		a_txen,
	input		a_txerr,

	output [3:0]	a_rxd,
	output		a_rxdv,
	output		a_rxerr,
	output		a_coll,
	output reg	a_crs,

	input		a_mdio_clk,
	input		a_mdio_i,
	input		a_mdio_ie,
	output		a_mdio_o,
	output		a_mdio_oe,

	// port b
	input [3:0]	b_txd,
	input		b_txen,
	input		b_txerr,

	output [3:0]	b_rxd,
	output		b_rxdv,
	output		b_rxerr,
	output		b_coll,
	output reg	b_crs,

	input		b_mdio_clk,
	input		b_mdio_i,
	input		b_mdio_ie,
	output		b_mdio_o,
	output		b_mdio_oe
);

// port a
assign a_rxd = b_txd;
assign a_rxdv = b_txen;
assign a_rxerr = b_txerr;
assign a_coll = 0;

always @(posedge txrx_clk)
	a_crs <= a_txen;

mac2mac_mdio #(
	.PHY_ADDR	(A_PHY_ADDR)
) mac2mac_mdio_a (
	.mdio_clk	(a_mdio_clk),
	.mdio_i		(a_mdio_i),
	.mdio_ie	(a_mdio_ie),
	.mdio_o		(a_mdio_o),
	.mdio_oe	(a_mdio_oe)
);

// port b
assign b_rxd = a_txd;
assign b_rxdv = a_txen;
assign b_rxerr = a_txerr;
assign b_coll = 0;

always @(posedge txrx_clk)
	b_crs <= b_txen;

mac2mac_mdio #(
	.PHY_ADDR	(B_PHY_ADDR)
) mac2mac_mdio_b (
	.mdio_clk	(b_mdio_clk),
	.mdio_i		(b_mdio_i),
	.mdio_ie	(b_mdio_ie),
	.mdio_o		(b_mdio_o),
	.mdio_oe	(b_mdio_oe)
);
endmodule
