`timescale 10ns / 100ps

//This testbench is for testing the load_coefficients and done_loading signals in the coefficient memorywindow

module dac_testbench;
	
//Master clock and reset
reg 			decimation_clock;
reg				dac_clk;
reg				adc_clk;
reg 			reset;
reg				stream;

wire			sdo;
wire			cs;

sigma_delta_buffer_filter sdbf(

	.decimation_clk(decimation_clock),
	.dac_clk(dac_clk),
	.adc_clk(adc_clk),
	.reset(reset),
	
	.sigmaDeltaIn(stream),
	
	.dac_sdo(sdo),
	.dac_cs(cs)

);
  
initial begin

	decimation_clock = 0;
	dac_clk = 0;
	adc_clk = 0;
	stream = 0;
	reset = 0;
	
	//Reset everything
	#20 reset = 1'b1;
	#20 reset = 1'b0;
	
end

always

	#5  dac_clk = !dac_clk;
	
always

	#125 decimation_clock = !decimation_clock;
	
always
	
	#1500 stream = !stream;
	
always
	
	#10 adc_clk = !adc_clk;


endmodule