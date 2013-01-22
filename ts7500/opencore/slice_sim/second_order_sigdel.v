/* 24 bit second order Sigma Delta modulator 
 * 
 * flexSD project
 * Dan Kouba, 2012
 */
 
module second_order_sigdel(
  
  clock,
  reset,
  
  input_data,
  output_bitstream
  
);

/* Internal prameters */
parameter input_bitwidth = 24;
parameter accumulator_bitwidth = 36;

`define full_neg {{(accumulator_bitwidth - input_bitwidth + 1){1'b1}}, {(input_bitwidth-1){1'b0}}}
`define full_pos {{(accumulator_bitwidth - input_bitwidth + 1){1'b0}}, {(input_bitwidth-1){1'b1}}}

/* Module inputs and outputs */
input                      clock;
input                      reset;

input   signed [23:0]      input_data;
output                     output_bitstream;

/* Internal wires and registers */
wire    signed [accumulator_bitwidth - 1:0]      fb;                // Feedback signal, 28 bits, but only holds a 24 bit full scale number as defined by the parameters above
wire    signed [accumulator_bitwidth - 1:0]      error_1;           // First error signal, equals input minus the feedback signal
wire    signed [accumulator_bitwidth - 1:0]      error_2;           // Second error signal, equals the output of the nondelaying integrator minus the feedback signal
wire    signed [accumulator_bitwidth - 1:0]      adder_1_out;       // Adder that creates the nondelaying integrator
reg     signed [accumulator_bitwidth - 1:0]      integrator_1_out;  // Nondelaying integrator's z^-1 block
reg     signed [accumulator_bitwidth - 1:0]      integrator_2_out;  // Delaying integrator's z^-1 block
wire                                             comp_out;          // Output of the comparator, also the output bitstream


always@(posedge clock) begin
  
  if(reset) begin
    
    integrator_1_out <= 28'b0;                // Initialize accumulator states
    integrator_2_out <= 28'b0;
    
  end else begin
    
    integrator_1_out <= adder_1_out;                 //Create delay block 1 - nondelaying integrator
    integrator_2_out <= integrator_2_out + error_2;  //Create delay block 2 - delaying integrator
    
  end

end

/* Adders, comparator and signal routing */
assign adder_1_out = integrator_1_out + error_1;
assign comp_out = !integrator_2_out[accumulator_bitwidth - 1];  // To do comparison, grab sign bit and invert (due to 2's complement)

assign error_1 = input_data - fb;
assign error_2 = adder_1_out - fb;

assign fb = comp_out ? `full_pos : `full_neg;          //Comparator, 24 bit full scale output
assign output_bitstream = comp_out;

endmodule
