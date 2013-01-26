`timescale 100ps/1ps

/* 24 bit virtualized first order Sigma Delta modulator 
 * Sigma delta clock = 20MHz, system clock = 200MHz
 * 10x virtualization  
 */
module first_order_sigdel_virtualized(
  
  clock,
  reset,
  
  input_data,
  output_bitstream,

);
parameter input_bitwidth = 24;
parameter accumulator_bitwidth = 28;
`define full_neg {{(accumulator_bitwidth - input_bitwidth + 1){1'b1}}, {(input_bitwidth-1){1'b0}}}
`define full_pos {{(accumulator_bitwidth - input_bitwidth + 1){1'b0}}, {(input_bitwidth-1){1'b1}}}


input                                   clock;
input                                   reset;

input   signed [23:0]                   input_data;
output                                  output_bitstream;

wire    signed [accumulator_bitwidth - 1 :0]   fb;
wire    signed [accumulator_bitwidth - 1 :0]   error;
reg     signed [accumulator_bitwidth - 1 :0]   integrator_out = 0;
wire                                           comp_out;

always@(posedge clock) begin
  
  if(reset) begin
    integrator_out <= {accumulator_bitwidth{1'b0}};
  end else begin
    integrator_out <= integrator_out + error;          //Create delay block
  end

end

assign fb = comp_out ? `full_pos : `full_neg ;    //Full scale gain
assign comp_out = !integrator_out[accumulator_bitwidth - 1];
assign error = input_data - fb;
assign output_bitstream = comp_out;

endmodule