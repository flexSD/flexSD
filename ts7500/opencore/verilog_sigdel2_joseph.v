module second_order_sig_del(v, clk, state);

parameter in_bw = 5;
parameter internal_bw = 8;
parameter alpha = 2;

input clk;
input signed [in_bw-1:0] v; //input derivative term
output state;
wire signed [in_bw-1:0] feedback;
reg signed [internal_bw-1:0] integrator1;
reg signed [internal_bw-1:0] integrator2;
reg signed [in_bw-1:0] u; //input to sig del

assign feedback = (integrator2 >= 0) ? 2**(in_bw-1)-1 : -2**(in_bw-1);

`define MAX_INTEGRATOR ((2**(internal_bw-1))-1)
`define MIN_INTEGRATOR (-(2**(internal_bw-1)))

assign state = !((integrator2 < `MAX_INTEGRATOR -1) && (integrator2 > `MIN_INTEGRATOR + 1));

always@ (posedge clk)
begin
      u <= (u>>alpha) + v;
      integrator1 <= integrator1 + u - feedback;
      integrator2 <= integrator2 + integrator1 + u - feedback - feedback;
end

endmodule
