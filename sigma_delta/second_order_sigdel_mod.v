`timescale 100ps/1ps

/* Second-Order Sigma Delta Modulator
*  Dan Kouba, 2012
*/

module second_order_sigdel_mod(
  
  mod_clock,
  input_sig,
  output_sig
  
);

parameter input_bitwidth = 24;
parameter full_neg = {1'b1, {(input_bitwidth-1){1'b0}}};
parameter full_pos = {1'b0, {(input_bitwidth-1){1'b1}}};

input   signed [input_bitwidth - 1:0]   input_sig /*verilator public*/;		
input                                   mod_clock /*verilator public*/;		
output                                  output_sig /*verilator public*/;

wire    signed [input_bitwidth - 1:0]   fb;
wire    signed [input_bitwidth :0]   error;
wire    signed [input_bitwidth :0]   error_2;
wire	  signed [input_bitwidth :0]	 non_delaying_integrator_in;

reg     signed [input_bitwidth :0]   non_delaying_integrator_out = 0;
reg     signed [input_bitwidth :0]   delaying_integrator_out = 0;

wire                                    comp_out;

always@(posedge mod_clock) begin

    non_delaying_integrator_out <= non_delaying_integrator_in;		// non-delaying integrator block          
    delaying_integrator_out <= delaying_integrator_out + error_2;   // delaying integrator block

end

// adder for non-delaying integrator
assign non_delaying_integrator_in = non_delaying_integrator_out + error;

// sign bit extractor for compare to zero block
assign comp_out = delaying_integrator_out[input_bitwidth];

// compare to zero block with full scale gain
assign fb = comp_out ? full_pos : full_neg ;

// error adder
assign error = input_sig - fb;

// second error adder
assign error_2 = non_delaying_integrator_in - fb;

// output bit assign
assign output_sig = comp_out;

endmodule
