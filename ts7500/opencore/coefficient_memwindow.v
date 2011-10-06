 `timescale 10ns / 100ps
 /*********************************************************************** 
 * 																		*
 * This module allows the sbus (via wishbone) to address 4Kb of BRAM	*
 * space (2048 by 16 bits memory) via 2 16-bit registers of address		*
 * space.  This module is addressed at 0x3C.  The module is write only  *
 * from the sbus, except for the address value.							*
 * 																		*
 * When the data register is written, the address automatically			*
 * increments by 1, so the subsequent read is at the next address		*
 * automatically.														*
 * 																		*
 * The coefficient load trigger register is normally set to zero, but	*
 * when any other value is written to it, it triggers the biquad 		*
 * module to re-load its coefficients from the BRAM.  When the load is	*
 * completed, the register resets to zero.								*
 * 																		* 
 * Register map:														*
 * base + 0x00: Data reg (WO)											*	
 * base + 0x02: Address reg (RW)										*
 * base + 0x04: Coefficient load trigger reg (RW)						* 
 *																		*
 ***********************************************************************/

module coefficient_memwindow(

	
  wb_clk_i,
  wb_rst_i,
  
  //From sbus
  sbus_wb_cyc_i,
  sbus_wb_stb_i,
  sbus_wb_we_i,
  sbus_wb_adr_i,
  sbus_wb_sel_i,
  sbus_wb_dat_i,
  sbus_wb_dat_o,
  sbus_wb_ack_o,
  
  //To blockram
  cbram_wb_we_o,
  cbram_wb_cyc_o,
  cbram_wb_stb_o,
  cbram_wb_adr_o,
  cbram_wb_dat_o,
  cbram_wb_ack_i,
  
  load_new_coefficients,
  done_loading
  
);

//Master clock and reset
input 			wb_clk_i, wb_rst_i;

//SBUS wishbone connections
input 			sbus_wb_cyc_i, sbus_wb_stb_i, sbus_wb_we_i;
output 			sbus_wb_ack_o;
output 	[15:0] 	sbus_wb_dat_o;
input 	[15:0] 	sbus_wb_dat_i, sbus_wb_adr_i;
input 	[1:0] 	sbus_wb_sel_i;

//Bram wishbone connections
output 			cbram_wb_cyc_o;
output 			cbram_wb_stb_o; 
output 			cbram_wb_we_o;
output 	[15:0] 	cbram_wb_dat_o;
output 	[10:0] 	cbram_wb_adr_o;
input 			cbram_wb_ack_i;

output			load_new_coefficients;
input			done_loading;

//Internal registers
reg 	[10:0] 	adr;
reg 	[15:0] 	wb_dat;
reg 			wbm_cyc, wbm_stb, wb_ack;
reg				load_coefficients;
reg				state;

/* 
 * Address wires:
 * 
 * These wires are only 4 bits because this module is externally arbitrated
 * to be within a 4 bit address window -- only these bits matter to this module
 */
wire			data_reg, adr_reg, load_reg;

assign data_reg = (sbus_wb_adr_i[3:0] == 4'h0);
assign adr_reg = (sbus_wb_adr_i[3:0] == 4'h2);
assign load_reg = (sbus_wb_adr_i[3:0] == 4'h4);

//Write controller
always @(posedge wb_clk_i or posedge wb_rst_i) begin
	
	//Set address and load register to zero on wishbone reset, reset state machine
	if (wb_rst_i) begin
		
		adr <= 11'd0;		
		load_coefficients <= 1'b0;
		state <= 1'b0;
		
	end else begin
		
		//Write new address value from sbus data input
		if (sbus_wb_cyc_i && sbus_wb_stb_i && sbus_wb_we_i && adr_reg) begin
			adr <= sbus_wb_dat_i[10:0];
		end
		
		//Increment address if ack from blockram is rx'ed
		if (wbm_cyc && wbm_stb && cbram_wb_ack_i) begin
			adr <= adr + 1'b1;
		end
		
		//State machine for triggering coefficient load and telling processor when load has completed
		case (state)
				
			//Idle state - load_coefficients = 0, done loading = 1
			1'b0: begin
				
				if (sbus_wb_cyc_i && sbus_wb_stb_i && sbus_wb_we_i && load_reg) begin
					load_coefficients <= 1'b1;		//Trigger coefficient load
					state <= 1'b1;
				end
				
			end
			
			//Loading state - load_coefficients = high for 1 clock, done loading = 0
			1'b1: begin
				
				load_coefficients <= 1'b0;		//Signal only high for one clock cycle, so load only is triggered once
				
				if (done_loading) begin
					state <= 1'b0;
				end
				
			end
			
		endcase
		
	end
	
end

//Constant assigns
assign cbram_wb_cyc_o = wbm_cyc;
assign cbram_wb_stb_o = wbm_stb;
assign sbus_wb_ack_o = wb_ack;
assign sbus_wb_dat_o = wb_dat;
assign cbram_wb_adr_o = adr[10:0];
assign cbram_wb_we_o = sbus_wb_we_i;
assign cbram_wb_dat_o[15:0] = sbus_wb_dat_i[15:0];
assign load_new_coefficients = load_coefficients;

//Read controller
always @(*) begin
  
  //Address is 0x00, write to bram
	if (sbus_wb_we_i && data_reg) begin
	  
		wbm_cyc = sbus_wb_cyc_i;
		wbm_stb = sbus_wb_stb_i;
		wb_ack = cbram_wb_ack_i;
		wb_dat = 16'bx;
		  
	//Address is 0x02 or 0x04, send back appropriate value
	end else begin
	    
		//Don't address bram
		wbm_cyc = 1'b0;
		wbm_stb = 1'b0;
		wb_ack = sbus_wb_cyc_i && sbus_wb_stb_i;	//Ack automatically on cycle/stobe assert
		
		if (adr_reg) wb_dat = {5'b0, adr};					//Send back address value if addressed
		if (load_reg) wb_dat = {15'b0, done_loading};		//Send back done loading (from biquad) value if addressed
	
	end
	
end

endmodule