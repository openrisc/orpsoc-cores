module mac2mac_mdio #(
	parameter PHY_ADDR = 8
)(
	input	mdio_clk,
	input	mdio_i,
	input	mdio_ie,
	output	mdio_o,
	output	mdio_oe
);

localparam [3:0]
	MDIO_IDLE = 0,
	MDIO_SOF = 1,
	MDIO_OPC = 2,
	MDIO_ADDR = 3,
	MDIO_READ = 4,
	MDIO_WRITE = 5,
	MDIO_ERROR = 6;

reg [3:0] mdio_state;
reg [3:0] rw_state;

reg mdio_i_r;
wire [1:0] opc;
reg [5:0] bit_cnt;

reg [4:0] phy_addr;
reg [4:0] reg_addr;
reg [15:0] out_dat;
reg [18:0] in_dat;

reg [15:0] regs;

assign mdio_oe = (mdio_state == MDIO_READ) & (phy_addr == PHY_ADDR);
assign mdio_o = mdio_oe ? out_dat[15] : 1'b1;

always @(posedge mdio_clk)
	mdio_i_r <= mdio_i;

//
// mdio frame:
// 32 preamble + 2 sof + 2 opc + 5 phy addr + 5 reg addr + 2 TA + 16 data = 32
//
assign opc = {mdio_i_r, mdio_i};

always @(posedge mdio_clk) begin
	bit_cnt <= bit_cnt + 1;

	case (mdio_state)
	MDIO_IDLE: begin
		if ((opc == 2'b10) & mdio_ie)
			mdio_state <= MDIO_SOF;
	end

	MDIO_SOF: begin
		bit_cnt <= 1;
		if (opc == 2'b01)
			mdio_state <= MDIO_OPC;
		else
			mdio_state <= MDIO_ERROR;
	end

	MDIO_OPC: begin
		if (bit_cnt == 2) begin
			bit_cnt <= 1;
			mdio_state <= MDIO_ADDR;
			if (opc == 2'b10)
				rw_state <= MDIO_READ;
			else if (opc == 2'b01)
				rw_state <= MDIO_WRITE;
			else
				mdio_state <= MDIO_ERROR;
		end
	end

	MDIO_ADDR: begin
		if (bit_cnt <= 5)
			phy_addr <= {phy_addr[3:0], mdio_i};
		else
			reg_addr <= {reg_addr[3:0], mdio_i};

		if (bit_cnt == 10) begin
			bit_cnt <= 1;
			mdio_state <= rw_state;
		end
	end

	MDIO_READ: begin
		if (bit_cnt <= 2) // TA = 2 cyc
			out_dat <= regs;
		else if (bit_cnt < 18) // READ = 16 cyc
			out_dat <= {out_dat[14:0], 1'b0};

		// IDLE = 1 cyc
		if (bit_cnt == 18)
			mdio_state <= MDIO_IDLE;
	end

	MDIO_WRITE: begin
		// TA = 2, WRITE = 16 and IDLE = 1 => 19
		if (bit_cnt == 18)
			mdio_state <= MDIO_IDLE;
	end

	MDIO_ERROR: begin
		if (bit_cnt == 31)
			mdio_state <= MDIO_IDLE;
	end

	default:
		mdio_state <= MDIO_IDLE;
	endcase
end

always @(*)
	case (reg_addr)
	// Basic control
	5'h0: regs = 16'b0011000100000000;
	// Basic status
	5'h1: regs = 16'b0111100001001100;
	// PHY ID 1
	5'h2: regs = 16'h0022;
	// PHY ID 2
	5'h3: regs = 16'b0001010100011111;
	default:
		regs = 0;
	endcase

endmodule
