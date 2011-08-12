`timescale 1ns / 1ps

/********************************************************************************* 
 * Module communicates with the LT2604 16 bit DAC
 *
 * I/O Mapping:
 *
 * clk25: 		25MHz SPI clock
 * reset: 		global reset
 * tx_data: 	when high, module transmits data to dac
 * value:		16 bit value to be written to DAC(s)
 * cmd: 		4 bit command
 * addr:		4 bit DAC address
 * dac_data:	Serial data output, physically route to DAC SDI pin
 * dac_cs:		Chip select output, physically route to DAC chip select pin
 * 
 * NOTE: this module assumes that the clk25 clock input is routed to the DAC's
 * SPI clock pin OUTSIDE of the module.
 * 
 ********************************************************************************/

module dac_spi_module(
	input clk25,
	input reset,
	input tx_data,
	input [15:0] value,
	input [3:0] cmd,
	input [3:0] addr,
	output dac_data,
	output dac_cs
	);

//State definitions

`define STATE_IDLE 			2'b0
`define STATE_SET_BIT		2'b1

//Register definitions

reg 			state;

reg [23:0] 		data;
reg [23:0]	  	data_r;
reg [4:0]	 	bitindex;

reg 		  	serial_data_out;
reg 			chip_select;

integer i;

/*
 * Data to the DAC must be sent MSB first, in the order Command, Address, Data Value.
 * The following block takes the data register which is filled with the appropriate bits
 * and loads a new register with the data reversed, so that the MSB of the original register
 * is the LSB of the new dara_r register
 */
 
always @(data) begin
	for(i=0 ; i<24 ; i=i+1) begin	
		data_r[i] = data[23-i];
	end
end

//State machine to load the DAC register

always @(negedge clk25) begin
	
	if(reset) begin
	   state <= `STATE_IDLE;					//Reset condition
	end else begin
		
		case(state)
			
			`STATE_IDLE: begin					//System waiting for tx_data signal
				
				if(tx_data) begin
					
					state <= `STATE_SET_BIT;	//Move to accumulator state
									
					data[23:20] <= cmd;			//Load data register with command, address, and value bits
					data[19:16] <= addr;
					data[15:0] <= value;
					
					bitindex <= 0;				//Reset bit index
					
				end
				
			end
			
			`STATE_SET_BIT: begin				//Set new bit to be clocked into device on each clock
			
			    if(bitindex == 0) begin      	//Beginning of tx, chip select low
					chip_select <= 0;
			    end
			   
				if(bitindex == 24) begin     	//End of tx, chip select high
					chip_select <= 1;
					state <= `STATE_IDLE;
				end
				
				serial_data_out <= data_r[bitindex];	//Load bit into serial output line
				bitindex <= bitindex + 1;				//Increment bit index
			
			end
		
		endcase
	
	end
	
end		

//Output assignments

assign dac_data = serial_data_out;
assign dac_cs = chip_select;

endmodule			
