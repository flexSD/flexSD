`timescale 1ns/1ps

module second_order_sigdel_virtualized_tb;
  
`define full_neg {{1{1'b1}}, 23'b0}

/* MODIFY BITWIDTHS HERE */
parameter input_data_bitwidth = 24;
parameter accumulator_bitwidth = 28;
  
reg signed [23:0]    sigma_delta_input_signal;
reg                  modulator_clock;
reg                  reset;
wire                 sigdel_out;

always #1 modulator_clock = ~modulator_clock;
always #1 sigma_delta_input_signal = sigma_delta_input_signal + {17{1'b1}};   //Generate a fast ramp

initial begin
  
  sigma_delta_input_signal = `full_neg;    // Start input ramp at the full negative value
  modulator_clock = 1'b0;
  reset = 1;
  
  #10 reset = 0;
  
end

second_order_sigdel_virtualized #(input_data_bitwidth, accumulator_bitwidth) sigdel_24b(

  .clock(modulator_clock),
  .reset(reset),
  
  .input_data(sigma_delta_input_signal),
  .output_bitstream(sigdel_out)
  
);

endmodule
