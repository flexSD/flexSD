module controller_top(
   clk, reset,
   in_P0, in_P1, in_P2, in_P3,
   in_Q0, in_Q1, in_Q2,
   system_out
);

   parameter P_WIDTH = 14;
   parameter Q_WIDTH = 14;

   parameter MID_STAGE1_WIDTH = 14;
   parameter MID_STAGE2_WIDTH = 14;
   parameter MID_STAGE3_WIDTH = 14;

   parameter OUT_WIDTH = 16;

   parameter GAIN_TS = 17;
   parameter GAIN_K  = 13;

   input   clk, reset; 

   input [P_WIDTH-1:0] in_P;
   input [Q_WIDTH-1:0] in_Q;

   output [OUT_WIDTH-1:0] system_out;

   wire [MID_STAGE1_WIDTH-1:0] stage1_out;
   wire [MID_STAGE2_WIDTH-1:0] stage2_out;
   wire [MID_STAGE3_WIDTH-1:0] stage3_out;

   BiQuad #(
      .GAIN_FWD(),
      .GAIN_BCK(),
      .GAIN_K(GAIN_K), .GAIN_TS(GAIN_TS),
   ) stage1 (
      .clk          ( clk        ),
      .reset        ( reset      ),
      .in_prev_stage( 0          ),
      .in_fwd       ( in_P       ),
      .in_bck       ( in_Q       ),
      .out_s        ( stage1_out )
   );

   BiQuad #(
      .GAIN_FWD(),
      .GAIN_BCK(),
      .GAIN_K(GAIN_K), .GAIN_TS(GAIN_TS),
   ) stage2 (
      .clk          ( clk        ),
      .reset        ( reset      ),
      .in_prev_stage( stage1_out ),
      .in_fwd       ( in_P       ),
      .in_bck       ( in_Q       ),
      .out_s        ( stage2_out )
   );

   BiQuad #(
      .GAIN_FWD(),
      .GAIN_BCK(),
      .GAIN_K(GAIN_K), .GAIN_TS(GAIN_TS),
   ) stage3 (
      .clk          ( clk        ),
      .reset        ( reset      ),
      .in_prev_stage( stage2_out ),
      .in_fwd       ( in_P       ),
      .in_bck       ( in_Q       ),
      .out_s        ( stage3_out )
   );

   assign system_out = stage3_out + in_P;

endmodule

module BiQuad(clk, reset, in_prev_stage, in_fwd, in_bck, out_s);

   parameter GAIN_FWD = 1,
             GAIN_BCK = 1,
             GAIN_TS = 1,
             GAIN_K = 1;

   parameter FWD_WIDTH = 12;
   parameter BCK_WIDTH = 12;
   parameter STG_WIDTH = 12;
   parameter OUT_WIDTH = 12;

   input clk, reset;
   input [FWD_WIDTH-1:0] in_fwd;
   input [BCK_WIDTH-1:0] in_bck;
   input [STG_WIDTH-1:0] in_prev_stage;
   output [OUT_WIDTH-1:0] out_s;

   // *** All GAIN_* parameters are SHIFT AMOUNTS ***
   //
   //                  in_fwd
   //                    |
   //               [GAIN_FWD]
   //                    |
   //                    V
   // in_prev_stage --> (+) ------->[GAIN_K]---->[GAIN_TS]---> out_s
   //                    ^ ^                  |
   //                    | |                  V
   //                    | `-------[Z^-1]-----'
   //                    |
   //               [GAIN_BCK]
   //                    |
   //                  in_bck
   //
   

   reg [OUT_WIDTH-1:0] delay;
   wire [OUT_WIDTH-1:0] adder_out;
   wire [OUT_WIDTH-1:0] pre_ts_gain;

   assign adder_out = (in_fwd ? GAIN_FWD : 0) +
               (in_bck ? GAIN_BCK : 0) +
               in_prev_stage +
               delay;
   assign pre_ts_gain = adder_out << GAIN_K;
   assign out_s = (pre_ts_gain << GAIN_TS);

   always @(posedge clk) begin
      if(reset)
         delay <= 0;
      else
         delay <= pre_ts_gain;
   end

endmodule
