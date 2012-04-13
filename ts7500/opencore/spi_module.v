module spi_module(

	clk25,
	reset,
	
	led_en,
	led_val,
	cal_mux,
	pga_cs,
	
	shiftreg_update,
	
	dac_packet,
	dac_send,
			
	// Hardware pins
	spi_dat,
	dac_cs,
	
	shiftreg_cs,
	shiftreg_outputreg_clk
	
);

/*********************
* Inputs and Outputs *
*********************/

// Main clock and reset
input 			clk25;
input 			reset;

// DAC register values
input	[23:0]	dac_packet;

// Wire to trigger a packet transmission to DAC
input			dac_send;

// Wire to trigger shift register data update
input 			shiftreg_update;

/* Shift Register output control wires */

// Front panel bicolor leds
input	[1:0]	led_en;		// Enable turns on LEDs
input	[1:0]	led_val;	// Value sets either red (0) or green (1)
	
// Controls calibrations muxes on front end
// 0 = internal calibration channel
// 1 = external input
input	[3:0]	cal_mux;	
	
// Chip selects for front end PGAs
input	[3:0]	pga_cs;

/* Hardware pins */

// DAC CS pin
output			dac_cs;

// Shift register CS pin 
output			shiftreg_cs;

// Shift register output register update pin
output 			shiftreg_outputreg_clk;

// SPI data output pin
output			spi_dat;

//State variables
localparam STATE_IDLE 			=	2'd0;
localparam STATE_SEND_PACKET	= 	2'd1;
localparam STATE_CLK_SR			= 	2'd2;

//Internal registers
reg 	[1:0]	state;
reg 	[23:0] 	data;
reg 	[4:0]	bitindex;
reg 			serial_data_out;
reg 			chip_select;
reg				sr_outputreg_clk;

// Internal Wires
wire 	[3:0]	leds;
reg				cmd;		// tells state machine whether to signal the DAC's CS line or the shift registers

/************
* Main Code *
************/

//State machine to load DAC values
always @(negedge clk25) begin
	
	//Reset condition
	if(reset) begin
		
		state <= STATE_IDLE;
		chip_select <= 1'b1;
		data <= 24'b0;
		bitindex <= 23;
		serial_data_out <= 1'b0;
		sr_outputreg_clk <= 1'b0;
		cmd <= 1'b0;
	
	end else begin
		
		case(state)
			
			STATE_IDLE: begin					//Waiting for send signal
				
				// Set initial state of wires
				serial_data_out <= 1'b0;
				chip_select <= 1'b1;
				sr_outputreg_clk <= 1'b0;
				
				if(dac_send) begin
					
					bitindex <= 23;				// Reset bit index to 23
					data <= dac_packet;				// Ensure that changes to value, address, and command registers do not affect current serial transmission
					state <= STATE_SEND_PACKET;
					cmd <= 1'b0;
					
				end else if(shiftreg_update) begin
					
					bitindex <= 15;					// Reset bit index to 15
					data <= {12'b0, leds[3:0], pga_cs[3:0], cal_mux[3:0]};	// only send 16 bits to shift registers (bottom 12 bits are all that are set however)
					state <= STATE_SEND_PACKET;
					cmd <= 1'b1;
					//sr_outputreg_clk <= 1'b0;		// Don't shift in new data to output register yet
					
				end
				
				
			end
			
			STATE_SEND_PACKET: begin				//Set new bit to be clocked into device
				
				chip_select <= 1'b0;					
				serial_data_out <= data[bitindex];	//Step through data register
				bitindex <= bitindex - 1;
								
				if(bitindex == 0 && cmd == 0) state <= STATE_IDLE;
				else if(bitindex == 0 && cmd == 1) state <= STATE_CLK_SR;
			
			end			
			
			// Clock in data to SR outputs
			STATE_CLK_SR: begin
			
				sr_outputreg_clk <= 1'b1;
				state <= STATE_IDLE;
			
			end
				
		
		endcase
	
	end
	
end		
		
// Decoding for LED outputs
assign leds[0] = led_en[0] ? led_val[0] : 1'b0;
assign leds[1] = led_en[0] ? ~led_val[0] : 1'b0;		// LEDs are bicolor, so one pin is always the inverted value of the other pin (if they are enabled)
assign leds[2] = led_en[1] ? led_val[1] : 1'b0;
assign leds[3] = led_en[1] ? ~led_val[1] : 1'b0;
		
//Hardware outputs
assign spi_dat = serial_data_out;
assign dac_cs = chip_select | cmd;			// Only address DAC when cmd is 0
assign shiftreg_cs = 1'b1;		// Only address shift register when cmd is 1
assign shiftreg_outputreg_clk = sr_outputreg_clk;

endmodule			
