module dac_spi_module(

	clk25,
	reset,
	
	cmd,
	addr,
	value,
	
	send_data,
	
	sdo,
	cs
	
);

/*********************
* Inputs and Outputs *
*********************/

//Main clock and reset
input 			clk25;
input 			reset;

//DAC register values
input	[3:0]	cmd;
input	[3:0]	addr;
input	[15:0]	value;

//Wire to trigger a packet transmission to DAC
input			send_data;

//DAC SPI port
output			sdo;
output			cs;

//State variables
localparam STATE_IDLE 			=	1'b0;
localparam STATE_SEND_PACKET	= 	1'b1;

//Internal registers
reg 			state;
reg 	[23:0] 	data;
reg 	[4:0]	bitindex;
reg 			serial_data_out;
reg 			chip_select;

/************
* Main Code *
************/

//State machine to load DAC values
always @(negedge clk25) begin
	
	//Reset condition
	if(reset) begin
		
		state <= STATE_IDLE;
		chip_select <= 1'b1;
		data <= 16'b0;
		bitindex <= 23;
		serial_data_out <= 1'b0;
	
	end else begin
		
		case(state)
			
			STATE_IDLE: begin				//Waiting for send_data signal
				
				chip_select <= 1'b1;
				
				if(send_data) begin
					bitindex <= 23;				//Reset bit index to zero
					data <= {cmd[3:0], addr[3:0], value[15:0]};	//Ensure that changes to value, address, and command registers do not affect current serial transmission
					state <= STATE_SEND_PACKET;
				end
				
			end
			
			STATE_SEND_PACKET: begin				//Set new bit to be clocked into device
				
				chip_select <= 0;					//Activate DAC		
				serial_data_out <= data[bitindex];	//Step through data register
				bitindex <= bitindex - 1;
								
				if(bitindex == 0) begin
					state <= STATE_IDLE;
				end
			
			end			
		
		endcase
	
	end
	
end		
		
assign sdo = serial_data_out;
//assign spi_clk = clk25;
assign cs = chip_select;

endmodule			
