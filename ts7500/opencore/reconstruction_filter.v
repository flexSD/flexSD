`timescale 100ps/1ps
// Reconstruction filter module for sigma delta ouput.

module reconstruction_filter(clock, reset, bitstream_in, out);

// Internal parameters
parameter in_bw = 24;	      // Input bitwidth
parameter filter_bw = 48;	  // Filter/accumulator bitwidth
parameter alpha = 7;	       // Alpha gain (bit shift)
parameter three_alpha = 21; // Alpha times 3, for output scaling

// Scaling values for input bitstream conversion
`define full_neg { 1'b1, {(in_bw - 1){1'b0}}}
`define full_pos { 1'b0, {(in_bw - 1){1'b1}}}

input clock;	         // Clock input
input reset;	         // Reset input
input bitstream_in;   // 1 bit data input

output signed [in_bw-1:0] out;      // Only grabbing the bottom 24 bits of the 2nd accumulator 

wire signed [filter_bw-1:0] feedback1;
wire signed [filter_bw-1:0] feedback2;
wire signed [filter_bw-1:0] feedback3;

wire signed [in_bw - 1:0]   scaled_bitstream;

wire signed [filter_bw-1:0] out_48;         // Full bitwidth output of the third accumulator, properly shifted

// Scaling one bit data input to input bitwidth length full scale signed value
assign scaled_bitstream = bitstream_in ? `full_pos : `full_neg ;

// Accumulator declarations

reg signed [filter_bw-1:0] acc1;
reg signed [filter_bw-1:0] acc2;
reg signed [filter_bw-1:0] acc3;

/* 
 * Assignments here are such that the feedback is (1-2^-7)*acc 
 * in order to achieve a gain of .9922 (alpha) which sets the 
 * corner frequency at 100kHz with a sampling frequency of 20MHz. 
 */
assign feedback1 = acc1 - { {(alpha){acc1[filter_bw - 1]}}, acc1[filter_bw-1:alpha] }; //{ {(alpha){acc1[filter_bw - 1]}}, acc1[filter_bw:alpha] };//(acc1 >>> alpha);
assign feedback2 = acc2 - { {(alpha){acc2[filter_bw - 1]}}, acc2[filter_bw-1:alpha] }; //(acc2 >>> alpha);
assign feedback3 = acc3 - { {(alpha){acc3[filter_bw - 1]}}, acc3[filter_bw-1:alpha] }; //(acc3 >>> alpha);

// Apply triple shift to output wire
assign out_48 = { {(three_alpha){acc3[filter_bw - 1]}}, acc3[filter_bw-1:three_alpha] }; //filt_out >>> 21; //rescaling the output after the the filter by shifting to the right by 3*alpha
assign out = { out_48[47], out_48[22:0] };    //Truncate upper bits and return signed 24 bit number


// Integrators
always@(posedge clock) begin
	if (reset) begin
	  
		acc1 <= {filter_bw{1'b0}};
		acc2 <= {filter_bw{1'b0}};
		acc3 <= {filter_bw{1'b0}};
		
	end else begin

		acc1 <= feedback1 + scaled_bitstream;//in;
		acc2 <= feedback2 + acc1;
		acc3 <= feedback3 + acc2;
		
	end
end

endmodule