module dac_spi_module(
	input clk25,
	input reset,
	input [3:0] cmd,
	input [3:0] addr,
	input [15:0] value,
	input send_data,
	output sdo,
	output spi_clk,
	output cs
	);


`DEFINE STATE_IDLE 			2'b00
`DEFINE STATE_SET_BIT		2'b01
`DEFINE STATE_WAIT_1		2'b10

reg [1:0] 	state;
reg [23:0] 	data;
reg [4:0]	bitindex;
reg [15:0]	value_r;
reg 		serial_data_out;
reg			spi_clock;
reg 		chip_select;

integer i;

always @(value) begin						//Reverse value register so MSB is first
	for(i=0, i=i+1, i<16) begin	

		value_r[i] = value[15-i];
	end
end

always @(negedge clk25) begin
	
	if(reset) state <= 2'b00;				//Reset condition
	
	end else begin
		
		case(state)
			
			`STATE_IDLE: begin				//System waiting for send_data signal
				
				if(send_data) begin
					
					state <= `STATE_SET_BIT;		//Move to accumulator state
					
					chip_select <= 0		//Activate DAC by setting CS low
					
					data[0:3] <= cmd;		//Load data register with command, address, and value bits
					data[4:7] <= addr;
					data[8:23] <= value;
					
					bitindex <= 0;			//Reset bit index
					
				end
				
			end
			
			`STATE_SET_BIT: begin			//Set new bit to be clocked into device
				
				serial_data_out <= data[bitindex];	//Load next bit into serial output line
				bitindex <= bitindex + 1;			//Increment bit index
				
				if(bitindex == 24) begin
					state <= `STATE_WAIT_1;			//Back to the accumulator
				end
			
			end
			
			`STATE_WAIT_1: begin			//Wait an extra clock cycle before setting CS high

				chip_select <= 1;			//Have to wait an extra clock cycle so last bit is clocked in before CS goes high
				state <= `STATE_IDLE;
			end
			
		
		endcase
	
	end
	
end		
		
assign sdo = serial_data_out;
assign spi_clk = clk25;
assign cs = chip_select;

endmodule			
