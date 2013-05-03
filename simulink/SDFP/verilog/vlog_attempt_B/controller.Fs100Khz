module controller(clk, rst, in, fbin, out);

   parameter BW=24;

   input clk;
   input rst;
   input in;
   input fbin;
   output [BW-1:0] out;

   wire [BW-1:0] p0out;
   wire [BW-1:0] p1out;
   wire [BW-1:0] p2out;

   wire [BW-1:0] p3out;
   wire [BW-1:0] q0out;
   wire [BW-1:0] q1out;
   wire [BW-1:0] q2out;

   wire [BW-1:0] ff0out;
   wire [BW-1:0] ff1out;
   wire [BW-1:0] ff2out;

   wire [BW-1:0] adder0out;
   wire [BW-1:0] adder1out;
   wire [BW-1:0] adder2out;
   wire [BW-1:0] adder3out;
   
   wire [BW-1:0] stage0out;
   wire [BW-1:0] stage1out;
   wire [BW-1:0] stage2out;

   /* Parameters for Fs = ~100KHz */
   wire [BW-1:0] constp0gain  = 24'h000A5C;
   wire [BW-1:0] constp0gain_ = 24'hFFF5A4;
   wire [BW-1:0] constp1gain  = 24'h092D40;
   wire [BW-1:0] constp1gain_ = 24'hF6D2C0;
   wire [BW-1:0] constp2gain  = 24'h083266;
   wire [BW-1:0] constp2gain_ = 24'hF7CD9A;
   wire [BW-1:0] constp3gain  = 24'h10A666;
   wire [BW-1:0] constp3gain_ = 24'hEF599A;

   wire [BW-1:0] constq0gain  = 24'h000000;
   wire [BW-1:0] constq0gain_ = 24'h000000;
   wire [BW-1:0] constq1gain  = 24'hFF9BCD;
   wire [BW-1:0] constq1gain_ = 24'h006433;
   wire [BW-1:0] constq2gain  = 24'hFEF667;
   wire [BW-1:0] constq2gain_ = 24'h010999;

   SDFPMux p0gain(in, constp0gain, constp0gain_, p0out);
   SDFPMux q0gain(fbin, constq0gain, constq0gain_, q0out);
   SDFPAdder3 adder0(p0out, q0out, ff0out, adder0out);
   SDFPFlipFlop ff0(clk, rst, adder0out, ff0out);

   assign stage0out[0 ] = adder0out[12];
   assign stage0out[1 ] = adder0out[13];
   assign stage0out[2 ] = adder0out[14];
   assign stage0out[3 ] = adder0out[15];
   assign stage0out[4 ] = adder0out[16];
   assign stage0out[5 ] = adder0out[17];
   assign stage0out[6 ] = adder0out[18];
   assign stage0out[7 ] = adder0out[19];
   assign stage0out[8 ] = adder0out[20];
   assign stage0out[9 ] = adder0out[21];
   assign stage0out[10] = adder0out[22];
   assign stage0out[11] = adder0out[23];
   assign stage0out[12] = 0;
   assign stage0out[13] = 0;
   assign stage0out[14] = 0;
   assign stage0out[15] = 0;
   assign stage0out[16] = 0;
   assign stage0out[17] = 0;
   assign stage0out[18] = 0;
   assign stage0out[19] = 0;
   assign stage0out[20] = 0;
   assign stage0out[21] = 0;
   assign stage0out[22] = 0;
   assign stage0out[23] = 0;

   SDFPMux p1gain(in, constp1gain, constp1gain_, p1out);
   SDFPMux q1gain(fbin, constq1gain, constq1gain_, q1out);
   SDFPAdder4 adder1(p1out, q1out, ff1out, stage0out, adder1out);
   SDFPFlipFlop ff1(clk, rst, adder1out, ff1out);
   
   assign stage1out[0 ] = adder1out[12];
   assign stage1out[1 ] = adder1out[13];
   assign stage1out[2 ] = adder1out[14];
   assign stage1out[3 ] = adder1out[15];
   assign stage1out[4 ] = adder1out[16];
   assign stage1out[5 ] = adder1out[17];
   assign stage1out[6 ] = adder1out[18];
   assign stage1out[7 ] = adder1out[19];
   assign stage1out[8 ] = adder1out[20];
   assign stage1out[9 ] = adder1out[21];
   assign stage1out[10] = adder1out[22];
   assign stage1out[11] = adder1out[23];
   assign stage1out[12] = 0;
   assign stage1out[13] = 0;
   assign stage1out[14] = 0;
   assign stage1out[15] = 0;
   assign stage1out[16] = 0;
   assign stage1out[17] = 0;
   assign stage1out[18] = 0;
   assign stage1out[19] = 0;
   assign stage1out[20] = 0;
   assign stage1out[21] = 0;
   assign stage1out[22] = 0;
   assign stage1out[23] = 0;

   SDFPMux p2gain(in, constp2gain, constp2gain_, p2out);
   SDFPMux q2gain(fbin, constq2gain, constq2gain_, q2out);
   SDFPAdder4 adder2(p2out, q2out, ff2out, stage1out, adder2out);
   SDFPFlipFlop ff2(clk, rst, adder2out, ff2out);

   assign stage2out[0 ] = adder2out[12];
   assign stage2out[1 ] = adder2out[13];
   assign stage2out[2 ] = adder2out[14];
   assign stage2out[3 ] = adder2out[15];
   assign stage2out[4 ] = adder2out[16];
   assign stage2out[5 ] = adder2out[17];
   assign stage2out[6 ] = adder2out[18];
   assign stage2out[7 ] = adder2out[19];
   assign stage2out[8 ] = adder2out[20];
   assign stage2out[9 ] = adder2out[21];
   assign stage2out[10] = adder2out[22];
   assign stage2out[11] = adder2out[23];
   assign stage2out[12] = 0;
   assign stage2out[13] = 0;
   assign stage2out[14] = 0;
   assign stage2out[15] = 0;
   assign stage2out[16] = 0;
   assign stage2out[17] = 0;
   assign stage2out[18] = 0;
   assign stage2out[19] = 0;
   assign stage2out[20] = 0;
   assign stage2out[21] = 0;
   assign stage2out[22] = 0;
   assign stage2out[23] = 0;

   SDFPMux p3gain(in, constp3gain, constp3gain_, p3out);
   SDFPAdder2 adder3(p3out, stage2out, adder3out);

   assign out = adder3out;

endmodule
