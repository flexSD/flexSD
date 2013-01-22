`timescale 10ns / 100ps
module testbench;
   
//Master clock and reset
reg 			clock;
reg 			reset;

//Interconnects between memory window and bram
wire	[10:0] 	bram_adr;
wire	[15:0] 	bram_dat;
wire			bram_cyc;
wire 			bram_stb;
wire 			bram_ack;
wire 			bram_we;

//SBUS wishbone input
reg 	[15:0] 	sbusin_adr;
wire 	[15:0] 	sbusin_dat_o;
reg 	[15:0] 	sbusin_dat_i;
reg 			sbusin_cyc;
reg 			sbusin_stb;
wire 			sbusin_ack;
reg 			sbusin_we;
reg 	[1:0] 	sbusin_sel;

//SBUS wishbone output
reg 	[15:0] 	sbusout_adr;
wire 	[15:0] 	sbusout_dat_o;
reg 	[15:0] 	sbusout_dat_i;
reg 			sbusout_cyc;
reg 			sbusout_stb;
wire 			sbusout_ack;
reg 			sbusout_we;
reg 	[1:0] 	sbusout_sel;

//Biquad interface
wire 	[10:0] 	bq_adr;
wire 	[15:0] 	bq_dat;
wire 			bq_cyc;
wire 			bq_stb;
wire 			bq_ack;

coefficient_blockram blockram(

  .wb_clk_i(clock),
  .wb_rst_i(reset),

  .sbus_wb_adr_i(bram_adr),
  .sbus_wb_dat_i(bram_dat),
  .sbus_wb_cyc_i(bram_cyc),
  .sbus_wb_stb_i(bram_stb),
  .sbus_wb_ack_o(bram_ack),
  .sbus_wb_we_i(bram_we),

  .biquad_wb_adr_i(bq_adr),
  .biquad_wb_dat_o(bq_dat),
  .biquad_wb_cyc_i(bq_cyc),
  .biquad_wb_stb_i(bq_stb),
  .biquad_wb_ack_o(bq_ack)
  
);

coefficient_memwindow coeff_memorywindow(

  .wb_clk_i(clock),
  .wb_rst_i(reset),
  
  //From sbus
  .sbus_wb_cyc_i(sbusin_cyc),
  .sbus_wb_stb_i(sbusin_stb),
  .sbus_wb_we_i(sbusin_we),
  .sbus_wb_adr_i(sbusin_adr),
  .sbus_wb_sel_i(sbusin_sel),
  .sbus_wb_dat_i(sbusin_dat_i),
  .sbus_wb_dat_o(sbusin_dat_o),
  .sbus_wb_ack_o(sbusin_ack),

  //To blockram
  .bram_wb_cyc_o(bram_cyc),
  .bram_wb_stb_o(bram_stb),
  .bram_wb_adr_o(bram_adr),
  .bram_wb_dat_o(bram_dat),
  .bram_wb_we_o(bram_we),
  .bram_wb_ack_i(bram_ack)

);

logging_memwindow logging_memorywindow(

  .wb_clk_i(clock),
  .wb_rst_i(reset),
  
  //From sbus (read only)
  .sbus_wb_cyc_i(sbusout_cyc),
  .sbus_wb_stb_i(sbusout_stb),
  .sbus_wb_we_i(sbusout_we),
  .sbus_wb_adr_i(sbusout_adr),
  .sbus_wb_sel_i(sbusout_sel),
  .sbus_wb_dat_i(sbusout_dat_i),
  .sbus_wb_dat_o(sbusout_dat_o),
  .sbus_wb_ack_o(sbusout_ack),

  //To blockram module
  .bram_wb_cyc_o(bq_cyc),
  .bram_wb_stb_o(bq_stb),
  .bram_wb_adr_o(bq_adr),
  .bram_wb_dat_i(bq_dat),
  .bram_wb_ack_i(bq_ack)

);
  
initial begin

   clock = 1;
   reset = 0;
   
   sbusin_adr = 16'b0;
   sbusin_dat_i = 16'b0;
   sbusin_cyc = 1'b0;
   sbusin_stb = 1'b0;
   sbusin_we = 1'b0;
   sbusin_sel = 2'b0;
   
   sbusout_adr = 16'b0;
   sbusout_dat_i = 16'b0;
   sbusout_cyc = 1'b0;
   sbusout_stb = 1'b0;
   sbusout_we = 1'b0;
   sbusout_sel = 2'b0;
   
   //Reset everything
   #20 reset = 1'b1;
   #20 reset = 1'b0;
   
   /*****************************
   * Coefficient Memwindow Test *
   *****************************/
   
   //Write address from coefficient memorywindow
   #20 sbusin_cyc = 1'b1;
   sbusin_stb = 1'b1;
   sbusin_we = 1'b1;
   sbusin_dat_i = 16'h5555;
   sbusin_adr = 16'h003C;
   
   #20 sbusin_cyc = 1'b0;
   sbusin_stb = 1'b0;
   sbusin_we = 1'b0;
   sbusin_adr = 16'b0;
   sbusin_dat_i = 16'b0;
   
   //Read address from coefficient memorywindow
   #20 sbusin_cyc = 1'b1;
   sbusin_stb = 1'b1;
   sbusin_adr = 16'h003C;
   
   #20 sbusin_cyc = 1'b0;
   sbusin_stb = 1'b0;
   
   //Begin sbus cycle - write to bram
   #20 sbusin_cyc = 1'b1;
   sbusin_stb = 1'b1;
   sbusin_we = 1'b1;
   sbusin_adr = 16'h003E;
   sbusin_dat_i = 16'hAAAA;
   
   #20 sbusin_cyc = 1'b0;
   sbusin_stb = 1'b0;
   sbusin_we = 1'b0;
   sbusin_adr = 16'b0;
   sbusin_dat_i = 16'b0;
   
   //Begin sbus cycle - write to bram again, test address increment
   #20 sbusin_cyc = 1'b1;
   sbusin_stb = 1'b1;
   sbusin_we = 1'b1;
   sbusin_adr = 16'h003E;
   sbusin_dat_i = 16'hBBBB;
   
   #20 sbusin_cyc = 1'b0;
   sbusin_stb = 1'b0;
   sbusin_we = 1'b0;
   sbusin_adr = 16'b0;
   sbusin_dat_i = 16'b0;
   
   /*************************
   * Logging Memwindow Test *
   *************************/
   
   //Write address from logging memorywindow
   #20 sbusout_cyc = 1'b1;
   sbusout_stb = 1'b1;
   sbusout_we = 1'b1;
   sbusout_dat_i = 16'h5555;
   sbusout_adr = 16'h003C;
   
   #20 sbusout_cyc = 1'b0;
   sbusout_stb = 1'b0;
   sbusout_we = 1'b0;
   sbusout_adr = 16'b0;
   sbusout_dat_i = 16'b0;
   
   //Read address from logging memorywindow
   #20 sbusout_cyc = 1'b1;
   sbusout_stb = 1'b1;
   sbusout_adr = 16'h003C;
   
   #20 sbusout_cyc = 1'b0;
   sbusout_stb = 1'b0;
   
   //Begin logging memorywindow read
   #20 sbusout_cyc = 1'b1;
   sbusout_stb = 1'b1;
   sbusout_we = 1'b0;
   sbusout_adr = 16'h003E;
   
   #20 sbusout_cyc = 1'b0;
   sbusout_stb = 1'b0;
   sbusout_adr = 16'b0;
   
   //Begin 2nd read
   #20 sbusout_cyc = 1'b1;
   sbusout_stb = 1'b1;
   sbusout_we = 1'b0;
   sbusout_adr = 16'h003E;
    
   #20 sbusout_cyc = 1'b0;
   sbusout_stb = 1'b0;
   sbusout_adr = 16'b0;

end

always

   #5 clock = !clock;
     
endmodule