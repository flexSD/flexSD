module SDFPMux(select, in0, in1, out);

   parameter BW=24;

   input select;
   input [BW-1:0] in0;
   input [BW-1:0] in1;
   output [BW-1:0] out;

   assign out = ({BW{~select}} & in0) | ({BW{select}} & in1);

endmodule

module SDFPFlipFlop(clk, rst, d, q);

   parameter BW=24;

   input clk;
   input rst;

   input [BW-1:0] d;
   output [BW-1:0] q;
   reg [BW-1:0] q;

   always@(posedge clk) begin
      if( rst )
         q <= 0;
      else
         q <= d;
   end

endmodule

module SDFPAdder4(in0,in1,in2,in3,out);

   parameter BW=24;
   input [BW-1:0] in0;
   input [BW-1:0] in1; 
   input [BW-1:0] in2; 
   input [BW-1:0] in3;
   output [BW-1:0] out;

   assign out = in0+in1+in2+in3;

endmodule

module SDFPAdder3(in0,in1,in2,out);

   parameter BW=24;
   input [BW-1:0] in0;
   input [BW-1:0] in1; 
   input [BW-1:0] in2; 
   output [BW-1:0] out;

   assign out = in0+in1+in2;

endmodule

module SDFPAdder2(in0,in1,out);

   parameter BW=24;
   input [BW-1:0] in0;
   input [BW-1:0] in1; 
   output [BW-1:0] out;

   assign out = in0+in1;

endmodule

