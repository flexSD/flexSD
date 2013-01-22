`timescale 10ns / 100ps
/***********************************************************************
* Module Name: Coefficient Blockram
* 
* Function: Provides internal storage space for biquad coeffients.
* Coefficients are written to by the ARM SBUS, and read by the biquad
* module.  One way communication only in order to remove the requirement
* of a wishbone arbiter.
* 
***********************************************************************/

module coefficient_blockram(

  wb_clk_i,
  wb_rst_i,

  cmemwin_wb_adr_i,
  cmemwin_wb_dat_i,
  cmemwin_wb_cyc_i,
  cmemwin_wb_stb_i,
  cmemwin_wb_ack_o,
  cmemwin_wb_we_i,

  biquad_wb_cyc_i,
  biquad_wb_stb_i,
  biquad_wb_adr_i,
  biquad_wb_dat_o,
  biquad_wb_ack_o
  
);

/*********************
* Inputs and Outputs *
*********************/

//Master clock and reset

input			wb_clk_i, wb_rst_i;

//Wishbone from coefficient memory window, unidirectional - write only

input	[10:0]	cmemwin_wb_adr_i;		//2048 addresses, each is a 16 bit value
input	[15:0]	cmemwin_wb_dat_i;		//16 bit write port
input			cmemwin_wb_cyc_i;
input			cmemwin_wb_stb_i;
output			cmemwin_wb_ack_o;
input			cmemwin_wb_we_i;

//Wishbone from biquad, unidirectional - read only

input	[8:0]	biquad_wb_adr_i;	//512 addresses, as each represents a 64 bit value
output	[63:0]	biquad_wb_dat_o;	//64 bit read port
input			biquad_wb_cyc_i;
input			biquad_wb_stb_i;
output			biquad_wb_ack_o;

/*************************
* Blockram Instantiation *
*************************/

wire 	[8:0] 	blockram_rdadr_i;
wire	[10:0]	blockram_wradr_i;

wire	[15:0] 	blockram_data_i;
wire 	[63:0] 	blockram_data_o;

wire write_en = cmemwin_wb_we_i;		//BRAM Write enable is triggered by the wishbone bus's write enable signal

lattice_ram_16bit_4kbyte biquad_coefficients (
  .WrAddress(blockram_wradr_i),
  .RdAddress(blockram_rdadr_i),
  .Data(blockram_data_i[15:0]),
  .RdClock(wb_clk_i),
  .RdClockEn(1'b1),
  .Reset(1'b0),
  .WrClock(wb_clk_i),
  .WrClockEn(write_en),
  .WE(1'b1),
  .Q(blockram_data_o[63:0])
);


/********************
* Wishbone Bus Code *
********************/

//Wishbone address lines hooked directly to blockram
assign blockram_wradr_i = 	cmemwin_wb_adr_i;
assign blockram_rdadr_i = 	biquad_wb_adr_i;

//Wishbone data lines hooked directly to blockram
assign blockram_data_i = 	cmemwin_wb_dat_i;
assign biquad_wb_dat_o = 	blockram_data_o;

//Ack handler
reg biquad_wb_ack;
reg cmemwin_wb_ack;

always @(posedge wb_clk_i) begin
	
	biquad_wb_ack <= 1'b0;
	cmemwin_wb_ack <= 1'b0;
	  
	if (biquad_wb_cyc_i && biquad_wb_stb_i && !biquad_wb_ack) begin
		biquad_wb_ack <= 1'b1;
	end else if (cmemwin_wb_cyc_i && cmemwin_wb_stb_i && cmemwin_wb_we_i && !cmemwin_wb_ack) begin
		cmemwin_wb_ack <= 1'b1;
	end
  
end

assign biquad_wb_ack_o = 	biquad_wb_ack;
assign cmemwin_wb_ack_o = 	cmemwin_wb_ack;

endmodule