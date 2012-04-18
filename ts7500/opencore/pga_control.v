module pga_control(
  
    clk50,
    wb_rst,
    
    set_vos,
    set_gain,
    set_measure,
    
    offset,
    gain,
    
    op_complete,
    
    pga_dat,
    pga_clk
  
);

/* I/O Definitions */

input 			clk50;
input 			wb_rst;

input 			set_vos;          // Set Vos of a PGA
input 			set_gain;         // Set gain of a PGA
input 			set_measure;      // Put PGA in Vos measure mode

input 	[4:0] 	offset;     // 5 bit offset value
input 	[3:0] 	gain;       // 4 bit gain value

output 			op_complete;     // Signals to parent module that transaction has completed

// Hardware pins
output 			pga_dat;
output 			pga_clk;

/* Internal Registers and Wires */

reg 	[1:0]	state;
reg 	[3:0]	clk_accumulator;   // For generating the pga clk

reg 			pga_dat_o;
reg 			pga_clk_o;

reg				op_complete_o;

reg		[2:0]	bitindex;
reg		[7:0]	packet;

assign pga_clk = pga_clk_o;
assign pga_dat = pga_dat_o;
assign op_complete = op_complete_o;

/* State Definitions */

localparam STATE_IDLE 				= 	2'b00;
localparam STATE_SET_MEASURE_MODE 	=	2'b01;
localparam STATE_SET_VOS			= 	2'b10;
localparam STATE_SET_GAIN			=	2'b11;

/* Clock generation */

always@(posedge clk50) begin
	
	if(wb_rst) begin
		
		clk_accumulator <= 5'b0;
		pga_clk_o <= 1'b0;
		
	end else begin
		clk_accumulator <= clk_accumulator + 1'b1;
	
		if(clk_accumulator == 4'd4) begin
			
			pga_clk_o <= ~pga_clk_o;
			clk_accumulator <= 4'b0;
			
		end
	end

end

/* State Machine */

always@(negedge pga_clk) begin
  
  if(wb_rst) begin
    
    state <= 2'b0;
		
	pga_dat_o <= 1'b0;
	
	op_complete_o <= 1'b0;
    
  end else begin
    
    case(state)
      
		STATE_IDLE: begin
		
			if(set_measure) begin
				state <= STATE_SET_MEASURE_MODE;
				
			end
			
			else if(set_vos) begin
				state <= STATE_SET_VOS;
			
			end
			
			else if(set_gain) begin
				state <= STATE_SET_GAIN;
			
			end

		end
		
		STATE_SET_MEASURE_MODE: begin
		
			state <= STATE_IDLE;

		end
			
		STATE_SET_VOS: begin
		
			state <= STATE_IDLE;

		end
			
		STATE_SET_GAIN: begin
			
			state <= STATE_IDLE;
			
		end
		
	endcase
    
  end
  
end

endmodule