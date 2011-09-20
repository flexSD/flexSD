 `timescale 10ns / 100ps
 /************************************************************************ 
 * Datalogging Memory Window											 *
 * 																		 *
 * This module allows the sbus (via wishbone) to address 4Kb of blockram *
 * space (2048 by 16 bits memory) via 2 16-bit registers of address		 *
 * space.  This module is addressed at 0x??.  The module is read only    *
 * from the sbus, except for the address value.							 *
 * 																		 *
 * When the data register is written, the address automatically			 *
 * increments by 1, so the subsequent read is at the next address		 *
 * automatically.														 *
 * 																		 * 
 * Register map:														 *
 * base + 0x0: Address reg (RW)											 *	
 * base + 0x2: Data reg (W)												 *
 *																		 *
 ************************************************************************/

module logging_memwindow(
	
  wb_clk_i,
  wb_rst_i,
  
  //From sbus (read only)
  sbus_wb_cyc_i,
  sbus_wb_stb_i,
  sbus_wb_we_i,
  sbus_wb_adr_i,
  sbus_wb_sel_i,
  sbus_wb_dat_i,
  sbus_wb_dat_o,
  sbus_wb_ack_o,

  //To blockram module
  lbram_wb_cyc_o,
  lbram_wb_stb_o,
  lbram_wb_adr_o,
  lbram_wb_dat_i,
  lbram_wb_ack_i
  
);

//Master clock and reset
input 			wb_clk_i, wb_rst_i;

//SBUS wishbone connections
input 			sbus_wb_cyc_i, sbus_wb_stb_i, sbus_wb_we_i;
output 			sbus_wb_ack_o;
output	[15:0]	sbus_wb_dat_o;
input	[15:0]	sbus_wb_dat_i, sbus_wb_adr_i;
input	[1:0]	sbus_wb_sel_i;

//Bram wishbone connections
output 			lbram_wb_cyc_o, lbram_wb_stb_o;
output	[11:0] 	lbram_wb_adr_o;	//Size? - based on blockram size
input	[15:0]	lbram_wb_dat_i;
input			lbram_wb_ack_i;

//Internal registers
reg		[11:0]	adr;
reg		[15:0]	wb_dat;
reg 			wbm_cyc, wbm_stb, wb_ack;

always @(posedge wb_clk_i or posedge wb_rst_i) begin
	
	if (wb_rst_i) begin
		
		adr <= 12'd0;		//Set address to zero on wishbone reset
		
	end else begin
		
		//Write new address value from sbus data input
		if (sbus_wb_cyc_i && sbus_wb_stb_i && sbus_wb_we_i && !sbus_wb_adr_i[1]) begin
			adr <= sbus_wb_dat_i[11:0];	//Size?? - depends on bram size
		end
		
		//Increment address if ack from blockram is rx'ed
		if (wbm_cyc && wbm_stb && lbram_wb_ack_i) begin
			adr <= adr + 1'b1;
		end
		
	end
	
end

//Constant assigns
assign lbram_wb_cyc_o = wbm_cyc;
assign lbram_wb_stb_o = wbm_stb;
assign sbus_wb_ack_o = wb_ack;
assign sbus_wb_dat_o = wb_dat;
assign lbram_wb_adr_o = adr[11:0];

always @(*) begin
  
  //Address is 0x02, read from bram
	if (sbus_wb_adr_i[1]) begin
	  
	   //Read from bram
		wbm_cyc = sbus_wb_cyc_i;
		wbm_stb = sbus_wb_stb_i;
		
		//Route bram ack and data to sbus
		wb_ack = lbram_wb_ack_i;
		wb_dat = lbram_wb_dat_i;
  
	//Address is 0x00, send back current address pointer location
	end else begin
	    
		//Don't address bram
		wbm_cyc = 1'b0;
		wbm_stb = 1'b0;
		
		//Return current address to sbus
		wb_ack = sbus_wb_cyc_i && sbus_wb_stb_i;   //Ack automatically on cycle/stobe assert
		wb_dat = {4'b0, adr};
	
	end
	
end

endmodule