`timescale 100ps/1ps

module state_ram_tb;
  
reg clock_200;
reg [3:0] state_write_adr, state_read_adr;
reg state_write_en, state_read_en;
reg reset;
reg [23:0] add_sub_result_B;

wire [23:0] state_value;

GSR GSR_INST(~reset);   // Global Set/Reset signal (active low)
PUR PUR_INST(~reset);   // Power up reset signal (active low)

lattice_ram_24bit_16word state_ram(

.WrAddress(state_write_adr[3:0]), 
.Data(add_sub_result_B[23:0]), 
.WrClock(clock_200), 
.WE(state_write_en), 
.WrClockEn(state_write_en), 
.RdAddress(state_read_adr[3:0]),
.RdClock(clock_200),
.RdClockEn(state_read_en),
.Reset(reset),
.Q(state_value[23:0])

);

initial begin
  
  clock_200 = 0;
  state_write_adr = 0;
  state_read_adr = 0;
  state_write_en = 0;
  state_read_en = 0;
  reset = 1;
  add_sub_result_B = 24'bx;
  
  #100 reset = 0;
  
  #100 state_write_en = 1;
       state_read_en = 1;
  #25 add_sub_result_B = 0;
  repeat (10) begin
    #25 state_write_adr = state_write_adr + 1;
    state_read_adr = state_write_adr - 1;
    #25 add_sub_result_B = add_sub_result_B + 24'd1000;
  end
  
  state_write_en = 0;
  state_read_en = 0;
  
  #200 state_read_en = 1;
  repeat (10) #50 state_read_adr = state_read_adr + 1;
  
end
  
always #25 clock_200 = ~clock_200;    // 200MHz - for slice

endmodule