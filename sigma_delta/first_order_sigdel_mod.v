`timescale 100ps/1ps
module first_order_sigdel(
  
  mod_clock,
  input_sig,
  output_sig
  
);

parameter input_bitwidth = 24;
parameter full_neg = {1'b1, {(input_bitwidth-1){1'b0}}};
parameter full_pos = {1'b0, {(input_bitwidth-1){1'b1}}};

input   signed [input_bitwidth - 1:0]   input_sig;
input                                   mod_clock;
output                                  output_sig;

wire    signed [input_bitwidth - 1:0]   fb;
wire    signed [input_bitwidth :0]   error;
reg     signed [input_bitwidth :0]   integrator_out = 0;
wire                                    comp_out;


always@(posedge mod_clock) begin

    integrator_out <= integrator_out + error;          //Create delay block

end

assign fb = comp_out ? full_pos : full_neg ;    //Full scale gain
assign comp_out = integrator_out[input_bitwidth];
assign error = input_sig - fb;
assign output_sig = comp_out;

endmodule