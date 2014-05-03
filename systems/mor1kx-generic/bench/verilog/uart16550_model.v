module wb_uart16550_model
  #(parameter DEBUG = 0)
  (// Clock, reset
   input 	wb_clk_i,
   input 	wb_rst_i,
   // Inputs
   input [2:0] 	wb_adr_i,
   input [7:0] 	wb_dat_i,
   input 	wb_we_i,
   input 	wb_cyc_i,
   input 	wb_stb_i,
   input [2:0] 	wb_cti_i,
   input [1:0] 	wb_bte_i,
   // Outputs
   output [7:0] wb_dat_o,
   output 	wb_ack_o,
   output 	wb_err_o,
   output 	wb_rty_o);
   
`include "wb_bfm_params.v"
   
   wb_bfm_slave
     #(.aw (32),
       .dw (8))
   bfm0
     (.wb_clk   (wb_clk_i),
      .wb_rst   (wb_rst_i),
      .wb_adr_i ({29'd0,wb_adr_i}),
      .wb_dat_i (wb_dat_i),
      .wb_sel_i (4'h0),
      .wb_we_i  (wb_we_i), 
      .wb_cyc_i (wb_cyc_i),
      .wb_stb_i (wb_stb_i),
      .wb_cti_i (wb_cti_i),
      .wb_bte_i (wb_bte_i),
      .wb_dat_o (wb_dat_o),
      .wb_ack_o (wb_ack_o),
      .wb_err_o (wb_err_o),
      .wb_rty_o (wb_rty_o));

   localparam RX_FIFO_DEPTH = 16;
   
   reg [2:0] 	address;
   reg [7:0] 	data;
   reg [1:0] 	UART_LCR_WLEN = 2'b11;
   reg 		UART_LCR_DLAB = 1'b0;
   
   reg [4:0] 	modem_control = 5'd0;
   reg [7:0] 	line_status = 8'b01100000;
   reg [7:0] 	modem_status;

   reg 		en_irq_rx_available;
   reg 		en_irq_tx_empty;
   reg 		en_irq_rx_line_status;
   reg 		en_irq_modem_status;

   reg [2:0] 	irq_status = 3'b000;
   reg 		irq_pending = 1;
       
   reg [7:0] 	rx_fifo [0:RX_FIFO_DEPTH-1];
   
   integer 	i;
   
   always begin
      bfm0.init();
      address = bfm0.address; //Fetch start address

      while(bfm0.has_next) begin
	 //Set error on out of range accesses
	 if(address > 6)
	   bfm0.error_response();
	 else begin
	    if(bfm0.op === WRITE) begin
	       bfm0.write_ack(data);
	       if(DEBUG) $display("%d : UART Write 0x%h = 0x%h %b", $time, address, data, bfm0.mask);
	       case (address)
		  3'b000 : if(!UART_LCR_DLAB) $write("%c", data);
		  3'b001 : begin
		     if(!UART_LCR_DLAB) begin
			en_irq_rx_available   = data[0];
			en_irq_tx_empty       = data[1];
			en_irq_rx_line_status = data[2];
			en_irq_modem_status   = data[3];
		     end
		  end
		 3'b010 : begin
		    for(i=0; i<RX_FIFO_DEPTH; i=i+1)
		      rx_fifo[i] = 8'd0;
		 end
		 3'b011 : begin
		    UART_LCR_DLAB = data[7];
		 end
		 3'b100 : modem_control = data;
		 default : bfm0.err = 1'b1;
	       endcase // case (address)
	    end else begin // if (bfm0.op === WRITE)
	       case(address)
		 3'b000 : data = 8'hde;
		 3'b001 : data = {4'h0, en_irq_modem_status, en_irq_rx_line_status, en_irq_tx_empty, en_irq_rx_available};
		 3'b010 : data = {4'b1100, irq_status, !irq_pending};
		 3'b011 : data = {UART_LCR_DLAB,5'd0, UART_LCR_WLEN};
		 
		 3'b101 : data = line_status;
		 3'b110 : data = modem_status;
		 default : bfm0.err = 1'b1;
	       endcase // case (address)
	       if(DEBUG) $display("%d : UART Read 0x%h = 0x%h %b", $time, address, data, bfm0.mask);
	       bfm0.read_ack(data);
	    end
	    if(bfm0.cycle_type === BURST_CYCLE)
	      address = bfm0.next_addr(address, bfm0.burst_type);
	 end
      end
   end
endmodule
  
