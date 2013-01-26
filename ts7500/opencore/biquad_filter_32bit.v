/**********************************************************************
* 32 bit Biquad Filter
*
* This module implements a physical biquad filter with a bit depth of 32
*
************************************************************************/

module biquad_filter_32bit(

	filter_clock,
	reset,

	mainIn,
	mainOut,
	
	ffGain1,
	ffGain2,
	ffGain3,
	ffGain4,
	ffGain5,
	
	fbGain1,
	fbGain2,
	fbGain3,
	fbGain4,
	
	delay1_ivalue,
	delay2_ivalue,
	delay3_ivalue,
	delay4_ivalue,
	sdDelay_ivalue

);

/*********************
* Inputs and Outputs *
*********************/

//Clock and Reset input
input 			filter_clock;
input			reset;

//Main input and output
input 			mainIn;
output   		mainOut;

//Feed forward gain coefficients
input 	[31:0] 	ffGain1, ffGain2, ffGain3, ffGain4, ffGain5;

//Feedback gain coefficients
input 	[31:0] 	fbGain1, fbGain2, fbGain3, fbGain4;

//Initial values to set delay registers to on reset
input	[31:0]	delay1_ivalue, delay2_ivalue, delay3_ivalue, delay4_ivalue, sdDelay_ivalue;

//Bit shift parameter - constant
parameter 		bit_shift = 3'b111;

/*****************
* Biquad stage 1 *
*****************/

wire 	[31:0] 	gainAdder1_ninv, gainAdder1_inv, gainAdder1_out;
wire	[31:0]	delay1_in;
reg		[31:0]	delay1_out;
wire	[31:0]	stage1_out;

//Gain adder 1
assign gainAdder1_ninv = mainIn ? ffGain1 : -ffGain1;		//Noninverting input with feed forward gain
assign gainAdder1_inv = mainOut ? fbGain1 : -fbGain1;		//Inverting input with feedback gain
assign gainAdder1_out = gainAdder1_ninv - gainAdder1_inv;	//Adder output

//Delay 1
always@(posedge filter_clock) begin		//Creates a register
	if(reset) begin
		delay1_out <= delay1_ivalue;
	end else begin
		delay1_out <= delay1_in;
	end
end

//Feedback adder 1
assign delay1_in = gainAdder1_out - delay1_out;				//Feedback for register for delay

//Inline gain 1
assign stage1_out = delay1_out >> bit_shift;				//constant bit shift on the output

/*****************
* Biquad stage 2 *
*****************/

wire 	[31:0] 	gainAdder2_ninv, gainAdder2_inv, gainAdder2_out;
wire	[31:0]	delay2_in;
reg		[31:0]	delay2_out;
wire	[31:0]	stage2_out;

//Gain adder 2
assign gainAdder2_ninv = mainIn ? ffGain2 : -ffGain2;		//Noninverting input with feed forward gain
assign gainAdder2_inv = mainOut ? fbGain2 : -fbGain2;		//Inverting input with feedback gain
assign gainAdder2_out = gainAdder2_ninv - gainAdder2_inv + stage1_out;	//Adder output

//Delay 2
always@(posedge filter_clock) begin		//Creates a register
	if(reset) begin					//Reset condition
		delay2_out <= delay2_ivalue;
	end else begin					//1 clock delay
		delay2_out <= delay2_in;
	end
end

//Feedback adder 2
assign delay2_in = gainAdder2_out - delay2_out;				//Feedback for register for delay

//Inline gain 2
assign stage2_out = delay2_out >> bit_shift;				//constant bit shift on the output

/*****************
* Biquad stage 3 *
*****************/

wire 	[31:0] 	gainAdder3_ninv, gainAdder3_inv, gainAdder3_out;
wire	[31:0]	delay3_in;
reg		[31:0]	delay3_out;
wire	[31:0]	stage3_out;

//Gain adder 3
assign gainAdder3_ninv = mainIn ? ffGain3 : -ffGain3;		//Noninverting input with feed forward gain
assign gainAdder3_inv = mainOut ? fbGain3 : -fbGain3;		//Inverting input with feedback gain
assign gainAdder3_out = gainAdder3_ninv - gainAdder3_inv + stage2_out;	//Adder output

//Delay 3
always@(posedge filter_clock) begin		//Creates a register
	if(reset) begin					//Reset condition
		delay3_out <= delay3_ivalue;
	end else begin					//1 clock delay
		delay3_out <= delay3_in;
	end
end

//Feedback adder 3
assign delay3_in = gainAdder3_out - delay3_out;				//Feedback for register for delay

//Inline gain 3
assign stage3_out = delay3_out >> bit_shift;				//constant bit shift on the output

/*****************
* Biquad stage 4 *
*****************/

wire 	[31:0] 	gainAdder4_ninv, gainAdder4_inv, gainAdder4_out;
wire	[31:0]	delay4_in;
reg		[31:0]	delay4_out;
wire	[31:0]	stage4_out;

//Gain adder 4
assign gainAdder4_ninv = mainIn ? ffGain4 : -ffGain4;		//Noninverting input with feed forward gain
assign gainAdder4_inv = mainOut ? fbGain4 : -fbGain4;		//Inverting input with feedback gain
assign gainAdder4_out = gainAdder4_ninv - gainAdder4_inv + stage3_out;	//Adder output

//Delay 4
always@(posedge filter_clock) begin		//Creates a register for delay
	if(reset) begin					//Reset condition
		delay4_out <= delay4_ivalue;
	end else begin					//1 clock delay
		delay4_out <= delay4_in;
	end
end

//Feedback adder 4
assign delay4_in = gainAdder4_out - delay4_out;				//Feedback for register

//Inline gain 4
assign stage4_out = delay4_out >> bit_shift;				//constant bit shift on the output

/***************
* Output Adder *
***************/

wire 	[31:0]	sigDelInput;
wire	[31:0]	outAdder_ninv1, outAdder_ninv2;

assign outAdder_ninv1 = mainIn ? ffGain5 : -ffGain5;		//Feed forward gain for final output
assign outAdder_ninv2 = stage4_out;							//For readability
assign sigDelInput = outAdder_ninv1 + outAdder_ninv2;		//Output of the final adder

/***************************
* Output Sigma Delta Block *
***************************/

wire 	[31:0]	sdAdder1_out;
wire	[31:0]	sdDelay_in;
reg 	[31:0]	sdDelay_out;

/* 1st adder (main output feedback):
 *
 * This feeds back the output as either the largest or smallest value of the input range.
 * 
 * To implement this, the inverting input of the adder's sign bit is set to the inverse of
 * the main output (if the output is 1, the sign bit is 0, as it is representing a positive
 * number), and the remaining 31 bits are set to the ouptut value.
 */
assign sdAdder1_out = sigDelInput - {!mainOut, {31{mainOut}}};

//Delay
always@(posedge filter_clock) begin
	if(reset) begin					//Reset condition
		sdDelay_out <= sdDelay_ivalue;
	end else begin					//1 clock delay
		sdDelay_out <= sdDelay_in;
	end
end

//2nd adder (delay feedback)
assign sdDelay_in = sdAdder1_out - sdDelay_out;

//Compare to zero block
assign mainOut = !sdDelay_out[31];			//Output is the inverse of the sign bit (1 if number is positive, 0 if negative)

endmodule
