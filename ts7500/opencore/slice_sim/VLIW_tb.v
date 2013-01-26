`timescale 100ps/1ps

module VLIW_tb;
  
  reg               clock_200, reset;
  reg               write_enable, vliw_start;
  reg     [8:0]     write_address;
  reg     [71:0]    write_data;
  wire    [8:0]     coefficient_read_address_1, coefficient_read_address_2;
  wire    [3:0]     state_read_address_1, state_read_address_2;
  wire    [3:0]     state_write_address_1, state_write_address_2;
  wire              logging_trigger_1, logging_trigger_2;
  wire              sigma_delta_storage_trigger_1, sigma_delta_storage_trigger_2;
  wire    [3:0]     sigma_delta_write_address_1, sigma_delta_write_address_2;
  wire    [1:0]     ext_bitstream_read_address_1, ext_bitstream_read_address_2;
  wire    [3:0]     logging_address_1, logging_address_2;
  wire slice_enable;
  
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

  .ext_bitstream_read_address_1(ext_bitstream_read_address_1),
  .ext_bitstream_read_address_2(ext_bitstream_read_address_2),

  .sigma_delta_write_address_1(sigma_delta_write_address_1),
  .sigma_delta_write_address_2(sigma_delta_write_address_2),
  
  .sigma_delta_storage_trigger_1(sigma_delta_storage_trigger_1),
  .sigma_delta_storage_trigger_2(sigma_delta_storage_trigger_2),
  
  .logging_trigger_1(logging_trigger_1),
  .logging_trigger_2(logging_trigger_2),
  
  .logging_address_1(logging_address_1),
  .logging_address_2(logging_address_2)
  
);
/*  
// Slice 1 outputs  
assign coefficient_read_address_1 =     [8:0]
assign state_read_address_1 =           [12:9]
assign state_write_address_1 =          [12:9] - read address delayed two clocks
assign ext_bitstream_read_address_1 =   [14:13]
assign sigma_delta_write_address_1 =    [18:15]
assign sigma_delta_storage_trigger_1 =  [19]
assign logging_trigger_1 =              [20] - DISABLED
assign logging_address_1 =              [24:21]

// Slice 2 outputs
assign coefficient_read_address_2 =     [32:25]
assign state_read_address_2 =           [36:33]
assign state_write_address_2 =          [36:33] - read address delayed two clocks
assign ext_bitstream_read_address_2 =   [38:37]
assign sigma_delta_write_address_2 =    [42:39]
assign sigma_delta_storage_trigger_2 =  [43]
assign logging_trigger_2 =              [44] - DISABLED
assign logging_address_2 =              [48:45]
*/

initial begin

clock_200 = 0;
reset = 1;

vliw_start = 0;
//read_address = 9'b0;

write_enable = 0;
write_address = 9'b0;

write_data = 72'b0;

#100 reset = 0;
#100 write_enable = 1;
    //{Log adr, Log trigger, SD store, SD write adr, Ext bitstream adr, State read/write adr, Coeff read adr}
    write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd0, 9'd0};
    write_address = 0;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd1, 9'd1};
    write_address = 1;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd2, 9'd2};
    write_address = 2;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd3, 9'd3};
    write_address = 3;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b1, 4'd4, 2'd0, 4'd4, 9'd4};
    write_address = 4;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd5, 9'd5};
    write_address = 5;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd6, 9'd6};
    write_address = 6;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd7, 9'd7};
    write_address = 7;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd8, 9'd8};
    write_address = 8;
#50 write_data[26:0] = {4'd4, 1'b0, 1'b0, 4'd0, 2'd0, 4'd9, 9'd9};
    write_address = 9;
#50 write_enable = 0;

#200 vliw_start = 1; 
#1600 vliw_start = 0;
$stop;

end

always #25 clock_200 = ~clock_200;  

  
endmodule