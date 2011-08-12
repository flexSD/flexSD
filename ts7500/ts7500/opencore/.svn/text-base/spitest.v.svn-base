`timescale 1ns / 1ps


//////////////////////////////////////////////////////////////////////////////////
// Company: UCSB	
// Engineer: Alec Dibble
// 
// Create Date:    12:17:02 06/21/2011 
// Design Name: Top
// Module Name:    main 
// Project Name: SPI
// Target Devices: Spartan 3e500
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module spitest(
clk, reset,
ld,
sdi
);

parameter ALL_POWER_UP = 4'b0010;
parameter WRITE_DATA = 4'b0000;
parameter ALL_DACS = 4'b1111;

input clk, reset;

reg [2:0] counter_2_bit;
reg [4:0] counter_4_bit;
reg [2:0] state;
reg [1:0] sub_state;
reg [3:0] command;
reg [3:0] address;
reg [15:0] out_16_bit;
reg [15:0] data_counter;

reg startup_sequence;

//output sck;
output reg ld;
output reg sdi;


//assign sck = clk;




always @ (negedge clk) begin
	if(reset) begin
		data_counter <= 16'd0;
		state <= 3'd0;
		startup_sequence <= 0;
		address <= ALL_DACS;
		ld <= 1;

		
		//Enable ld so that the SPI slave knows to start reading sdi
		ld <= 1;
	end else begin
		
		
	
	case(state)
		
		
			
/////////////////////////////////////////////////////////////////////////////////


		
		3'b000: begin
			// Checks to see if it has started up before
			// 
			if(!startup_sequence) begin
				startup_sequence <= 1;
				sub_state <= 2'd0;
				state <= 3'b001;
			end else begin
				state <= 3'b010;
			end
		end
		
			
/////////////////////////////////////////////////////////////////////////////////	
		
		
		3'b001: begin
			
			// Sub state that processes and sends
			// 24 bits of data over SPI.
			// This stage:
			// Power up state turns on devices
			

			
			case(sub_state)
				
					
	/////////////////////////////////////////////////////////////////////////////////
				2'b00: begin
					counter_2_bit <= 3'd0;
					counter_4_bit <= 5'd0;
					sub_state <= 2'b01;
					command <= ALL_POWER_UP;
					out_16_bit <= 16'd0;
					address <= ALL_DACS;
					ld <= 0;
				end
				
				//Sends turn-on command set
				
				
	/////////////////////////////////////////////////////////////////////////////////
				2'b01: begin
					if(counter_2_bit < 5) begin
						counter_2_bit <= counter_2_bit + 1;
						sdi <= command[3];
						command <= command << 1;
					end
					else begin
						sub_state <= 2'b10;
						counter_2_bit <= 3'd0;
					end
				end
				
				
				
	/////////////////////////////////////////////////////////////////////////////////
				//Don't care
				2'b10: begin
					if(counter_2_bit < 5) begin
						counter_2_bit <= counter_2_bit + 1;
						sdi <= address[3];
						address <= address << 1;
					end else begin
						sub_state <= 2'b11;
						counter_2_bit <= 3'd0;
						ld <= 1;
					end
				end
				
				
			
	/////////////////////////////////////////////////////////////////////////////////
				//Don't Care
				2'b11: begin
					if(counter_4_bit < 17) begin
						counter_4_bit <= counter_4_bit + 1;
						sdi <= 0;
					end else begin
						sub_state <= 2'b00;
						counter_4_bit <= 5'd0;
						state <= 3'b010;
						
					end
				end
			endcase
		end
		
		
			
/////////////////////////////////////////////////////////////////////////////////


			
		3'b010: begin
			

			// Sub state that processes and sends
			// 24 bits of data over SPI.
			// This stage:
			// Transmits counter data
			
			



			
			case(sub_state)
				
							
	/////////////////////////////////////////////////////////////////////////////////
	
	
				2'b00: begin
					counter_2_bit <= 3'd0;
					counter_4_bit <= 5'd0;
					sub_state <= 2'b01;
					command <= ALL_POWER_UP;
					address <= ALL_DACS;
					data_counter <= data_counter + 1;
					out_16_bit <= data_counter;
					ld <= 0;
				end
			

			
	/////////////////////////////////////////////////////////////////////////////////


				//Sends turn-on command set
				2'b01: begin
					if(counter_2_bit < 5) begin
						counter_2_bit <= counter_2_bit + 1;
						sdi <= command[3];
						command <= command << 1;
					end
					else begin
						sub_state <= 2'b10;
						counter_2_bit <= 3'd0;
					end
				end
				
			
	/////////////////////////////////////////////////////////////////////////////////
				
				
				//Sends out DAC address
				2'b10: begin
					if(counter_2_bit < 5) begin
						counter_2_bit <= counter_2_bit + 1;
						sdi <= address[3];
						address <= address << 1;
					end else begin
						sub_state <= 2'b11;
						counter_2_bit <= 3'd0;
					end
				end
				
				
			
	/////////////////////////////////////////////////////////////////////////////////


				//Sends out data
				2'b11: begin
					if(counter_4_bit < 17) begin
						counter_4_bit <= counter_4_bit + 1;
						sdi <= out_16_bit[3];
						out_16_bit <= out_16_bit << 1;
					end else begin
						sub_state <= 2'b00;
						counter_4_bit <= 5'd0;
						ld <= 1;
						
						
						
					end
				end
				
							
	/////////////////////////////////////////////////////////////////////////////////
				
			endcase	
			
						
	/////////////////////////////////////////////////////////////////////////////////
		end
	endcase

	end

end
	
endmodule






			
