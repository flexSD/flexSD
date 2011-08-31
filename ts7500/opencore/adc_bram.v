/****************************************************************************
* Creator: Dan Kouba
* Version: 1.0
* Date: August 30, 2011
* Module Name: bram_logging.v
* 
* Description: module provides interface to internal blockram to write data 
* coming from registers or wires internal to the FPGA to the 8kB blockram
* in the FPGA defined in blockram_8kbyte.v.  This allows the linux 
* installation on the TS7500 to be able to access and log this data through
* wb_memwindow.v.  The blockram is written 32 bits at a time, although it is
* read back through wb_memwindow.v 16 bits at a time.  This is done to
* minimize the number of writes to the blockram while maintaining high
* throughput.
* 
****************************************************************************/

module bram_logging(
  reset,
  
  adc_a,
  adc_b,
  adc_c,
  adc_d,
  adc_clk,
  
  wb_clk_i,

  wb_cyc_o,
  wb_stb_o,
  wb_we_o,
  wb_sel_o,
  wb_adr_o,
  wb_dat_o,
  wb_dat_i,
  wb_ack_i,
  
  buf_a,
  buf_b,
  buf_c,
  buf_d
);

/****************************************************************************
* Inputs, Outputs, Registers
* 
* Notes:
* 1) ADC inputs come directly from the dio_pad register in the top module
* 2) Wishbone bus connections occur in the definition of the blockram in 
*    the top module
* 3) Wishbone clock is provided to the blockram module from the top module
* 
****************************************************************************/

//Reset signal

input			reset;

//Physical ADC inputs
input 			adc_a;
input 			adc_b;
input 			adc_c;
input 			adc_d;
input 			adc_clk;

//Wishbone bus to blockram_8kbyte.v module
input 			wb_clk_i;	//Main 75Mhz wb clock

input 			wb_ack_i;
input 	[31:0] 	wb_dat_i;	//This input is unused, since the module gets its data 

output 			wb_cyc_o;
output 			wb_stb_o;
output 			wb_we_o;
output 	[3:0] 	wb_sel_o;
output 	[31:0] 	wb_adr_o;
output 	[31:0] 	wb_dat_o;

//debugging

output 	[31:0]	buf_a, buf_b, buf_c, buf_d;

//Internal registers

reg  			r_wb_cyc_o;
reg  			r_wb_stb_o;
reg  			r_wb_we_o;
reg		[3:0]	r_wb_sel_o;
reg  	[31:0]	r_wb_adr_o;
reg  	[31:0]	r_wb_dat_o;
reg  	[31:0]	r_wb_dat_i;
reg  			r_wb_ack_i;


/**********************
* ADC data processing *
**********************/

reg [31:0] buf32a, buf32b, buf32c, buf32d;
reg [4:0] ctr_32;

wire buff_full = (ctr == 5'b11111);			//Signals that the buffer is full of 32 bits of new data

//32 bit SIPO shift registers to buffer incoming ADC bitstreams
always@(posedge adc_clk) begin
	
	buf32a <= {adc_a, buf32a[31:1]};	//Output A
	buf32b <= {adc_b, buf32b[31:1]};	//Output B
	buf32c <= {adc_c, buf32c[31:1]};	//Output C
	buf32d <= {adc_d, buf32d[31:1]};	//Output D
	
	ctr_32 <= ctr_32 + 1'd1;			//Increment load counter by 1
	
	if (buff_full) begin				//If buffer is full of new data (counter is full), load blockram with new data
		ctr_32 <= 0;					//Reset counter
	end

end

assign buf_a = buf32a;
assign buf_b = buf32b;
assign buf_c = buf32c;
assign buf_d = buf32d;

/***********************************
* Blockram interface state machine *, doesn't matter its state as long as cycle is unasserted
***********************************/

parameter STATE_WAIT_FOR_DATA  		= 2'b00;	//Waiting for buffer to fill
parameter STATE_WRITE_BRAM			= 2'b01;	//Write buffer data to blockram
parameter STATE_WAIT_FOR_WB_ACK		= 2'b10;	//Waits for wishbone ack signal from blockram module
parameter STATE_WAIT_FOR_UNASSERT	= 2'b11;	//Wait for buff_full signal to unassert (synchronizes clock domains)

parameter test_value 				= 32'hABCDEF01;	//Test value (hex): ABCD and EF01 (16 bits returned at a time in linux)

reg		[1:0]	state;
reg 	[10:0]	adr_ctr;	//Address counter 

wire			all_written;

assign all_written = (&adr_ctr);

always @(posedge wb_clk_i) begin
	
	//Reset condition
	//if (reset) begin
	//	state <= STATE_WAIT_FOR_DATA;
//	end
	
	//Main state machine
	case(state)
		
		STATE_WAIT_FOR_DATA: begin
			
			if (buff_full) begin		//Checks for full buffer
				//Checks if all the ram has been written to (for testing), does nothing if it has all been written to
				if (!all_written) state <= STATE_WRITE_BRAM;	
			end
			
			//Wishbone bus in inactive mode
			r_wb_cyc_o <= 1'b0;	//Cycle signal unasserted - bus is inactive
			r_wb_stb_o <= 1'bx;	//Strobe is dont care as long as cycle is unasserted
			
		end
		
		STATE_WRITE_BRAM: begin
			
			//Signal valid bus transmission, cycle and strobe asserted
			
			r_wb_cyc_o <= 1'b1;
			r_wb_stb_o <= 1'b1;
			
			//Signal blockram write by asserting the wishbone write_enable signal
			
			r_wb_we_o <= 1'b1;
			
			//Set data, select, and address lanes to appropriate values
			
			r_wb_dat_o <= test_value;			//Testing
			r_wb_sel_o <= 4'b1111;			//32 bit write (writes all 4 brams at once)
			
			/*
			Addressing scheme:
			
			1) 11 bit base address (2048 bytes per bram block)
			2) Convert to 13 bits (4 bram blocks, so multiply by 4)
				- Done by adding 2 bits of don't cares as the LSBs
				- These bits are thrown away by a right bit shift by 2 in the blockram module
			3) Make 13 bit result the 13 LSBs of a 32 bit address register
				- Adds 19 bits of don't cares as the MSBs
				- These bits are thrown away by the blockram module
			
			*/
			
			//wb_adr_o <= {16'dx, 3'dx, adr_ctr, 2'dx};
			r_wb_adr_o <= {16'd0, 3'd0, adr_ctr, 2'd0};		//Testing with zeros instead of don't cares for debugging purposes
			
			//Data sent, now wait for receiving module's ack
			
			state <= STATE_WAIT_FOR_WB_ACK;
			
		end
		
		STATE_WAIT_FOR_WB_ACK: begin
			
			//Check for ack assertion by bram module
			
			if (wb_ack_i) begin
			
				//Unassert cycle and strobe signals, ends wishbone transmission
				
				r_wb_cyc_o <= 1'b0;
				r_wb_stb_o <= 1'bx;
				
				//Data was successfully received, so increment address counter
				
				adr_ctr <= adr_ctr + 1;
				
				//Now wait for buff_full signal to be unasserted
			
				state <= STATE_WAIT_FOR_UNASSERT;

			end
			
		end
		
		STATE_WAIT_FOR_UNASSERT: begin
			
			//Syncronize clock domains with modulator clock
			
			if (!buff_full) begin
				state <= STATE_WAIT_FOR_DATA;
			end
			
		end
	
	endcase
	
end

//Assign statements

assign  wb_cyc_o = r_wb_cyc_o;
assign  wb_stb_o = r_wb_stb_o;
assign  wb_we_o  = r_wb_we_o;
assign  wb_sel_o = r_wb_sel_o;
assign  wb_adr_o = r_wb_adr_o;
assign  wb_dat_o = r_wb_dat_o;
assign  wb_dat_i = r_wb_dat_i;
assign  wb_ack_i = r_wb_ack_i;

endmodule