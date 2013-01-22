/****************************************************************************
* ADC Buffer Module
* 
* Module provides 32 bit buffers for incoming ADC bitstreams.  Once buffers
* are full of new data, the 'buffer_full' signal is set high in order to 
* trigger a new filter cycle.
* 
* Notes:
* 1) ADC inputs come directly from the dio_pad register in the top module
* 2) Wishbone bus connections occur in the definition of the blockram in 
*    the top module
* 3) Wishbone clock is provided to the blockram module from the top module
* 
****************************************************************************/

module adc_buffer(

	reset,
	
	adc_a_i,
	adc_b_i,
	adc_c_i,
	adc_d_i,
	adc_clk_i,
	
	buffer_full,
	
	adc_a_buf_o,
	adc_b_buf_o,
	adc_c_buf_o,
	adc_d_buf_o

);

/*****************************
* Inputs, Outputs, Registers *
*****************************/

//Reset signal
input			reset;

//Physical ADC inputs
input 			adc_a_i;
input 			adc_b_i;
input 			adc_c_i;
input 			adc_d_i;
input 			adc_clk_i;

//Signal that buffer is full of new data
output			buffer_full;

//Buffer outputs
output	[31:0]	adc_a_buf_o;
output	[31:0]	adc_b_buf_o;
output	[31:0]	adc_c_buf_o;
output	[31:0]	adc_d_buf_o;

/**********************
* ADC data processing *
**********************/

reg [31:0] buf32a = 32'b0;reg [31:0] buf32b = 32'b0;
reg [31:0] buf32c = 32'b0;
reg [31:0] buf32d = 32'b0;
reg [4:0] ctr_32 = 5'b0;

wire buff_full = (ctr_32 == 5'b11111);			//Signals that the buffer is full of 32 bits of new data

//32 bit SIPO shift registers to buffer incoming ADC bitstreams
always@(posedge adc_clk_i) begin
	
	buf32a <= {adc_a_i, buf32a[31:1]};	//Output A
	buf32b <= {adc_b_i, buf32b[31:1]};	//Output B
	buf32c <= {adc_c_i, buf32c[31:1]};	//Output C
	buf32d <= {adc_d_i, buf32d[31:1]};	//Output D
	
	ctr_32 <= ctr_32 + 1'b1;			//Increment load counter by 1
	
	if (buff_full) begin				//If buffer is full of new data (counter is full), load blockram with new data
		ctr_32 <= 0;					//Reset counter
	end

end

assign buf_a = buf32a;
assign buf_b = buf32b;
assign buf_c = buf32c;
assign buf_d = buf32d;

assign buffer_full = buff_full;

assign adc_a_buf_o = buf32a;
assign adc_b_buf_o = buf32b;
assign adc_c_buf_o = buf32c;
assign adc_d_buf_o = buf32d;

endmodule