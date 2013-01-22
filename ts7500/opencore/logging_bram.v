`timescale 10ns / 100ps
/***********************************************************************
* Module Name: Coefficient Blockram
* 
* Function:
* 
***********************************************************************/

module logging_blockram(

  wb_clk_i,
  wb_rst_i,
  
  lmemwin_wb_cyc_i,
  lmemwin_wb_stb_i,
  lmemwin_wb_adr_i,
  lmemwin_wb_dat_o,
  lmemwin_wb_ack_o,
  
  biquad_wb_cyc_i,
  biquad_wb_stb_i,
  biquad_wb_adr_i,
  biquad_wb_we_i,
  biquad_wb_dat_i,
  biquad_wb_ack_o
  
);

/*********************
* Inputs and Outputs *
*********************/

//Master clock and reset

input			wb_clk_i, wb_rst_i;

//Wishbone from memory window, unidirectional - read only

input			lmemwin_wb_cyc_i;
input			lmemwin_wb_stb_i;
input	[10:0]	lmemwin_wb_adr_i;
output	[15:0]	lmemwin_wb_dat_o;		//Only data in is used, unidirectional communication
output			lmemwin_wb_ack_o;

//Wishbone from biquad, unidirectional - write only

input			biquad_wb_cyc_i;
input			biquad_wb_stb_i;
input			biquad_wb_we_i;
input	[10:0]	biquad_wb_adr_i;
input	[15:0]	biquad_wb_dat_i;	//Only data out is used, unidirectional communication
output			biquad_wb_ack_o;

/*************************
* Blockram Instantiation *
*************************/

wire 	[11:0] 	blockram_rdadr_i;
wire	[11:0]	blockram_wradr_i;

wire	[15:0] 	blockram_data_i;
wire 	[15:0] 	blockram_data_o;

wire write_en = biquad_wb_we_i;

lattice_ram_16bit_8kbyte biquad_logging (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[15:0]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(write_en),
  .WE(1'b1),
  .Q(blockram_data_o[15:0])
);

/********************
* Wishbone Bus Code *
********************/

//Wishbone address lines hooked directly to blockram
assign blockram_wradr_i = 	biquad_wb_adr_i;		//Biquad writes data
assign blockram_rdadr_i = 	lmemwin_wb_adr_i;		//Memory window reads data

//Wishbone data lines hooked directly to blockram
assign blockram_data_i = 	biquad_wb_dat_i;
assign lmemwin_wb_dat_o = 	blockram_data_o;

//Ack handler
reg biquad_wb_ack;
reg lmemwin_wb_ack;

always @(posedge wb_clk_i) begin
	
	biquad_wb_ack <= 1'b0;
	lmemwin_wb_ack <= 1'b0;
  
	if (biquad_wb_cyc_i && biquad_wb_stb_i && biquad_wb_we_i && !biquad_wb_ack) begin
		biquad_wb_ack <= 1'b1;
	end else if (lmemwin_wb_cyc_i && lmemwin_wb_stb_i && !lmemwin_wb_ack) begin
		lmemwin_wb_ack <= 1'b1;
	end
  
end

assign biquad_wb_ack_o = 	biquad_wb_ack;
assign lmemwin_wb_ack_o = 	lmemwin_wb_ack;

endmodule