module sigma_delta_buffer_filter(

	decimation_clk,
	dac_clk,
	adc_clk,
	reset,
	
	sigmaDeltaIn,
	
	dac_sdo,
	dac_cs	

);

//Clocks and reset signal
input decimation_clk;
input dac_clk;
input adc_clk;
input reset;

//Sigma delta stream input
input sigmaDeltaIn;

//Dac serial interface
output dac_sdo;
output dac_cs;

//parameter add_subtract = 1;

//Accumulators
reg		[23:0]	accum1;
reg		[23:0]	accum2;
reg		[23:0]	accum3;

//reg		[23:0]	accum_in;

//Allows for testing of different integration types
/*
always@(*) begin
	
	if (add_subtract) begin
		accum_in = sigmaDeltaIn ? 24'd1 : -24'd1;		//Add one if high, subtract one if low
	end	else begin
		accum_in = sigmaDeltaIn ? 24'd1 : 24'd0;		//Add one if high, do nothing if low (add zero)
	end

end
*/

//3 stage accumulator
always@(posedge adc_clk or posedge reset) begin
	
	if(reset) begin
		accum1 <= 24'b0;
		accum2 <= 24'b0;
		accum3 <= 24'd0;
	end else begin
		
		//Integrate sigma delta stream
		if(sigmaDeltaIn) begin
			accum1 <= accum1 + 1'b1;
		end else begin
			accum1 <= accum1 - 1'b1;
		end
		
		accum2 <= accum2 + accum1;
		accum3 <= accum3 + accum2;
	end

end

wire	[23:0]	accumulator_out;

assign accumulator_out = accum3;

//3 stage differentiator clocked at the decimation rate
reg   	[23:0] 	decimation_reg;

reg		[23:0]	ff_delay1_out;
reg		[23:0]	ff_delay2_out;
reg		[23:0]	ff_delay3_out;

wire	[23:0]	adder1_out;
wire	[23:0]	adder2_out;
wire	[23:0]	adder3_out;

//Adders
assign adder1_out = decimation_reg - ff_delay1_out;
assign adder2_out = adder1_out - ff_delay2_out;
assign adder3_out = adder2_out - ff_delay3_out;

//Decimation register and feedforward delays/adders for differentiator
always@(posedge decimation_clk or posedge reset) begin
	
	if(reset) begin
		decimation_reg <= 24'b0;
		ff_delay1_out <= 24'b0;
		ff_delay2_out <= 24'b0;
		ff_delay3_out <= 24'b0;
	end else begin
		decimation_reg <= accumulator_out;				//Decimate outputs from integrators at decimation clock rate
		ff_delay1_out <= decimation_reg;
		ff_delay2_out <= adder1_out;
		ff_delay3_out <= adder2_out;
	end
	
end

reg				load_dac_reg;
wire			load_dac;
/*
always@(posedge dac_clk or posedge reset) begin
	if(reset) begin
		load_dac_reg <= 1'b0;
	end else begin
		load_dac_reg <= 1'b0;
		if(decimation_clk && !load_dac) begin		//Load dac only high for one clock, prevents multiple dac loads of same value
			load_dac_reg <= 1'b1;
		end
	end
end
*/


//DAC module instantiation
assign load_dac = decimation_clk;

wire	[3:0]	dac_command;
wire	[3:0]	dac_address;
wire	[15:0]	dac_value;

assign dac_value = adder3_out[23:8]; 			//Truncate lower 8 bits
assign dac_command = 4'b0010;					//Turn on and update all DACs
assign dac_address = 4'b1111;					//Address all DACs

dac_spi_module dac(

	.clk25(dac_clk),
	.reset(reset),
	
	.cmd(dac_command),
	.addr(dac_address),
	.value(dac_value),
	
	.send_data(load_dac),

	.sdo(dac_sdo),
	.cs(dac_cs)

);


endmodule