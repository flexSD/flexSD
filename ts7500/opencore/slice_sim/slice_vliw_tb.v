`timescale 100ps/1ps

module slice_vliw_tb;
  
// Sigma delta parameters  
parameter               input_bitwidth = 24;
parameter               full_neg = {1'b1, {(input_bitwidth-1){1'b0}}};
parameter               full_pos = {1'b0, {(input_bitwidth-1){1'b1}}};
  
reg                     read_back;
reg         [3:0]       read_back_adr;
  
reg                     clock_200, reset;
reg         [8:0]       coefficient_write_adr;
reg         [35:0]      coefficient_write_data;
reg                     coefficient_write_en;

wire        [3:0]       state_write_adr, state_read_adr;

wire                    overflow_stage_1, overflow_stage_2;
wire signed [23:0]      log_value_out, sigma_delta_out;

// For sigma delta
reg                     clock_20;
reg  signed [23:0]      input_signal_A, input_signal_B;
wire                    sigdel_output_A, sigdel_output_B;

// For VLIW
reg                     write_enable, vliw_start;
reg         [8:0]       write_address;
reg         [71:0]      write_data;
wire                    slice_enable;
wire        [8:0]       coefficient_read_address_1, coefficient_read_address_2;
wire        [3:0]       state_read_address_1, state_read_address_2;
wire        [3:0]       state_write_address_1, state_write_address_2;
wire                    logging_trigger_1, logging_trigger_2;
wire                    sigma_delta_storage_trigger_1, sigma_delta_storage_trigger_2;
wire        [3:0]       sigma_delta_write_address_1, sigma_delta_write_address_2;
wire        [3:0]       sigma_delta_read_address_1, sigma_delta_read_address_2;
  
// The GSR and PUR are needed for the flip flop primitives from Lattice
GSR GSR_INST(~reset);   // Global Set/Reset signal (active low)
PUR PUR_INST(~reset);   // Power up reset signal (active low)
 
VLIW_sim vliw(
  
  .clock_200(clock_200),
  .reset(reset),
  
  .write_enable(write_enable),
  .vliw_start(vliw_start),
  .slice_enable(slice_enable),
  
  .write_address(write_address),
  .write_data(write_data),
  
  .coefficient_read_address_1(coefficient_read_address_1),
  .coefficient_read_address_2(coefficient_read_address_2),

  .state_read_address_1(state_read_address_1),  
  .state_read_address_2(state_read_address_2),
  
  .state_write_address_1(state_write_address_1),
  .state_write_address_2(state_write_address_2),
  
  .sigma_delta_read_address_1(sigma_delta_read_address_1),
  .sigma_delta_read_address_2(sigma_delta_read_address_2),

  .sigma_delta_write_address_1(sigma_delta_write_address_1),
  .sigma_delta_write_address_2(sigma_delta_write_address_2),
  
  .logging_trigger_1(logging_trigger_1),
  .logging_trigger_2(logging_trigger_2),
  
  .sigma_delta_storage_trigger_1(sigma_delta_storage_trigger_1),
  .sigma_delta_storage_trigger_2(sigma_delta_storage_trigger_2)
  
);

slice_sim slice1(

  .read_back(read_back),
  .read_back_adr(read_back_adr),

  .clock_200(clock_200),
  .reset(reset),
  .slice_enable(slice_enable),

  .coefficient_read_adr(coefficient_read_address_1),
  .coefficient_write_adr(coefficient_write_adr),
  .coefficient_write_data(coefficient_write_data),
  .coefficient_write_en(coefficient_write_en),

  .state_write_adr(state_write_address_1),
  .state_read_adr(state_read_address_1),

  .sigma_delta_stream_A(sigdel_output_A),
  .sigma_delta_stream_B(sigdel_output_B),

  .log_trigger(logging_trigger_1),
  .sigma_delta_out_trigger(sigma_delta_storage_trigger_1),

  .overflow_stage_1(overflow_stage_1),
  .overflow_stage_2(overflow_stage_2),

  .log_value_out(log_value_out),
  .sigma_delta_out(sigma_delta_out)

);

// Feed forward modulator stream generator
first_order_sigdel sigdel1(

  .mod_clock(clock_20),
  .input_sig(input_signal_A),
  .output_sig(sigdel_output_A)

);

// Feedback modulator stream generator
first_order_sigdel sigdel2(

  .mod_clock(clock_20),
  .input_sig(input_signal_B),
  .output_sig(sigdel_output_B)

);

integer counter;

initial begin
  
  /* Initial Conditions */
  
  // VLIW  
  vliw_start = 0;
  write_enable = 0;
  write_address = 9'b0;
  write_data = 72'b0;
  
  // Slice
  read_back = 0;
  read_back_adr = 0;
  
  clock_200 = 0;
  reset = 1;
  coefficient_write_adr = 0;
  coefficient_write_data = 0;
  coefficient_write_en = 0;
  //sigma_delta_stream_A = 0;
  //sigma_delta_stream_B = 0;
  
  // Address counter
  counter = 0;
  
  // Sigma deltas
  clock_20 = 1;
  input_signal_A = 0;
  input_signal_B = 0;
  
  // Initial reset
  #100 reset = 0;
  
// Write program to VLIW
#100 write_enable = 1;
    //{Store SD, LOG, SD write adr, SD read adr, State write adr, State read adr, Coeff read adr}
    write_data[26:0] = {1'b1, 1'b1, 4'd0, 4'd0, 4'd0, 4'd0, 9'd0};
    write_address = 0;
#50 write_data[26:0] = {1'b0, 1'b0, 4'd0, 4'd1, 4'd0, 4'd1, 9'd1};
    write_address = 1;
#50 write_data[26:0] = {1'b1, 1'b0, 4'd1, 4'd2, 4'd1, 4'd2, 9'd2};
    write_address = 2;
#50 write_data[26:0] = {1'b0, 1'b0, 4'd2, 4'd3, 4'd2, 4'd3, 9'd3};
    write_address = 3;
#50 write_data[26:0] = {1'b0, 1'b1, 4'd3, 4'd4, 4'd3, 4'd4, 9'd4};
    write_address = 4;
#50 write_data[26:0] = {1'b1, 1'b0, 4'd4, 4'd5, 4'd4, 4'd5, 9'd5};
    write_address = 5;
#50 write_data[26:0] = {1'b1, 1'b1, 4'd5, 4'd6, 4'd5, 4'd6, 9'd6};
    write_address = 6;
#50 write_data[26:0] = {1'b0, 1'b0, 4'd6, 4'd7, 4'd6, 4'd7, 9'd7};
    write_address = 7;
#50 write_data[26:0] = {1'b0, 1'b0, 4'd7, 4'd8, 4'd7, 4'd8, 9'd8};
    write_address = 8;
#50 write_data[26:0] = {1'b0, 1'b1, 4'd8, 4'd9, 4'd8, 4'd9, 9'd9};
    write_address = 9;
#50 write_enable = 0;
  
  // Write 10 sets of coefficients to coeffcient RAM
  #25 coefficient_write_en = 1;
  
  #25 coefficient_write_adr = 0;
  coefficient_write_data = {18'sd100, 18'sd100};
  #50 coefficient_write_adr = 1;
  coefficient_write_data = {18'sd200, 18'sd200};
  #50 coefficient_write_adr = 2;
  coefficient_write_data = {18'sd300, 18'd300};
  #50 coefficient_write_adr = 3;
  coefficient_write_data = {18'sd400, 18'sd400};
  #50 coefficient_write_adr = 4;
  coefficient_write_data = {18'sd500, 18'sd500};
  #50 coefficient_write_adr = 5;
  coefficient_write_data = {18'sd600, 18'sd600};
  #50 coefficient_write_adr = 6;
  coefficient_write_data = {18'sd700, 18'sd700};
  #50 coefficient_write_adr = 7;
  coefficient_write_data = {18'sd800, 18'sd800};
  #50 coefficient_write_adr = 8;
  coefficient_write_data = {18'sd900, 18'sd900};
  #50 coefficient_write_adr = 9;
  coefficient_write_data = {18'sd1000, 18'sd1000};
  #50 coefficient_write_en = 0;
  
  #100 vliw_start = 1;//slice_enable = 1;
  #500 vliw_start = 0;//slice_enable = 0;
  #500 read_back = 1;
  repeat (9) begin

    #50 read_back_adr = read_back_adr + 1;
    
  end

end

always #25 clock_200 = ~clock_200;    // 200MHz - for slice
always #250 clock_20 = ~clock_20;     // 20MHz - for modulator
  
endmodule

