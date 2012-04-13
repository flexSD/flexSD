module pga_control(
  
    clk25,
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

input clk25;
input wb_rst;

input set_vos;          // Set Vos of a PGA
input set_gain;         // Set gain of a PGA
input set_measure;      // Put PGA in Vos measure mode

input [4:0] offset;     // 5 bit offset value
input [3:0] gain;       // 4 bit gain value

output op_complete;     // Signals to parent module that transaction has completed

// Hardware pins
output pga_dat;
output pga_clk;

/* Internal Registers and Wires */

reg state;
reg [] clk_accumulator;   // For generating the pga clk

wire pga_dat_internal;
wire pga_clk_internal;


/* State Machine */

always@(negedge clk25) begin
  
  if(wb_rst) begin
    
    
    
  end else begin
    
    case(state)
      
      
    
  end
  
end

endmodule