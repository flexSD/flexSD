`timescale 10ns / 100ps

//This testbench is for testing the biquad wishbone interface

module biquad_wb_testbench;
	
//Master clock and reset
reg 			clock;
reg 			reset;

//Logging bram wishbone interface (unused so far)
wire			log_wbm_cyc_i;
wire			log_wbm_stb_i;
wire			log_wbm_we_i;
wire	[11:0]	log_wbm_adr_i;
wire	[15:0]	log_wbm_dat_i;
reg				log_wbm_ack_o;

//Coefficient bram wishbone interface
wire			coeff_wbm_cyc_i;
wire			coeff_wbm_stb_i;
wire	[8:0]	coeff_wbm_adr_i;
reg		[63:0]	coeff_wbm_dat_o;
wire			coeff_wbm_ack_o;

reg				load_new_coefficients;
wire			done_loading;

//Sigma delta output
wire			sd_out;

wb_biquad_interface biquad(

	.wb_clk_i(clock),
	.wb_rst_i(reset),
	
	.log_wbm_cyc_o(log_wbm_cyc_i),
	.log_wbm_stb_o(log_wbm_stb_i),
	.log_wbm_we_o(log_wbm_we_i),
	.log_wbm_adr_o(log_wbm_adr_i),
	.log_wbm_dat_o(log_wbm_dat_i),
	.log_wbm_ack_i(log_wbm_ack_o),
	
	.coeff_wbm_cyc_o(coeff_wbm_cyc_i),
	.coeff_wbm_stb_o(coeff_wbm_stb_i),
	.coeff_wbm_adr_o(coeff_wbm_adr_i),
	.coeff_wbm_dat_i(coeff_wbm_dat_o),
	.coeff_wbm_ack_i(coeff_wbm_ack_o),
	
	.load_new_coefficients(load_new_coefficients),
	.done_loading(done_loading),
	
	.sigmaDeltaInput(clock),
	.sigmaDeltaOutput(sd_out)

);
  
initial begin

	clock = 1;
	reset = 0;
   
	log_wbm_ack_o = 1'b0;
	
	coeff_wbm_dat_o = 64'hDDDDDDDDEEEEEEEE;	//Test data to load into coefficients
	//coeff_wbm_ack_o = 1'b0;
      
	//Reset everything
	#20 reset = 1'b1;	
	#20 reset = 1'b0;
	
	#20 load_new_coefficients = 1'b1;		//High for one clock cycle
	#10 load_new_coefficients = 1'b0;
	
	#510 coeff_wbm_dat_o = 64'hBBBBBBBBCCCCCCCC;
	#20 load_new_coefficients = 1'b1;		//High for one clock cycle
	#10 load_new_coefficients = 1'b0;
	
end

assign coeff_wbm_ack_o = coeff_wbm_cyc_i && coeff_wbm_stb_i;		//Auto ack on cycle/strobe assert

always

	#5 clock = !clock;
     
endmodule