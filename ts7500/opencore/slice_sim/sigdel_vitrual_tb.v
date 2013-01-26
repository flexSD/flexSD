`timescale 1ns/1ps

module sigdel_virtual_tb;
  
  reg clock, reset, mod_enable, clock_20;
  reg signed [23:0] data_in;

  
// The GSR and PUR are needed for the flip flop primitives from Lattice
GSR GSR_INST(~reset);   // Global Set/Reset signal (active low)
PUR PUR_INST(~reset);   // Power up reset signal (active low)

// For sine generator
reg [9:0] theta;
wire signed [23:0] sine_val;

parameter delay = 4;

always begin
#(delay) if(mod_enable) theta = theta + 1;
end

lattice_sine_table sinegen(

  .Clock(clock),
  .ClkEn(mod_enable),
  .Reset(reset),
  .Theta(theta),
  .Sine(sine_val)

);

reg signed [23:0] mod_input;

reg signed [23:0] sine_out [9:0];

parameter           input_bitwidth = 24;
parameter           full_neg = {1'b1, {(input_bitwidth-1){1'b0}}};
parameter           full_pos = {1'b0, {(input_bitwidth-1){1'b1}}};

wire signed [23:0] output_sig0, output_sig1, output_sig2, output_sig3, output_sig4, output_sig5, output_sig6, output_sig7, output_sig8, output_sig9;

reg [3:0] sigma_delta_write_address;
reg       sigma_delta_write_enable;

wire signed [23:0] log_value_reconstructed;
reg                log_trigger;
reg [3:0]          log_address;
wire               log_bitstream;

reg  [1:0]        external_bitstream_address;
wire [9:0]        virt_bitstream_reg;
wire              ext_bitstream_reg;

second_order_sigdel_virtualized sigdel(
  
  .clock_200(clock),
  .clock_20(clock_20),
  .reset(reset),
  .mod_enable(mod_enable),
  
  .write_address_in(sigma_delta_write_address),
  .write_enable_in(sigma_delta_write_enable),

  .log_address(log_address),
  .log_value_reconstructed(log_value_reconstructed),  
  .log_bitstream(log_bitstream),

  .input_data(mod_input),
  .virtualized_bitstream_reg(virt_bitstream_reg),

  .external_bitstreams_in(4'b1010),         // For testing!!!
  .external_bitstream_address(external_bitstream_address),
  .external_bitstream_reg(ext_bitstream_reg)
  
);

reconstruction_filter filter0(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[0]),
  .out(output_sig0)
  
);

reconstruction_filter filter1(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[1]),
  .out(output_sig1)
  
);

reconstruction_filter filter2(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[2]),
  .out(output_sig2)
  
);

reconstruction_filter filter3(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[3]),
  .out(output_sig3)
  
);

reconstruction_filter filter4(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[4]),
  .out(output_sig4)
  
);

reconstruction_filter filter5(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[5]),
  .out(output_sig5)
  
);

reconstruction_filter filter6(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[6]),
  .out(output_sig6)
  
);

reconstruction_filter filter7(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[7]),
  .out(output_sig7)
  
);

reconstruction_filter filter8(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[8]),
  .out(output_sig8)
  
);

reconstruction_filter filter9(
  .clock(clock_20),
  .reset(reset),
  .bitstream_in(virt_bitstream_reg[9]),
  .out(output_sig9)
  
);

initial begin
  
  clock = 0;
  clock_20 = 0;
  reset = 1;
  mod_enable = 0;
  
  log_trigger = 0;
  log_address = 0;
  
  data_in = 0;        //{ 1'b0, {23{1'b1}} };   //Midscale value for testing
  theta = 0;
  
  mod_input = 0;
  sigma_delta_write_address = 0;
  sigma_delta_write_enable = 0;
  
  #20 reset = 0;
  #2  mod_enable = 1;
      log_address = 7;                // Load address of bitstream 7 into logging function
      log_trigger = 1;
  #2  log_trigger = 0;
  
  #10 external_bitstream_address = 2;
  #10 external_bitstream_address = 1;
  
  #50  sigma_delta_write_enable = 1;
       sigma_delta_write_address = 7;
       mod_input = full_pos;
  #2   sigma_delta_write_enable = 0;
  
end

always #1 clock = ~clock;
always #10 clock_20 = ~clock_20;
  
endmodule