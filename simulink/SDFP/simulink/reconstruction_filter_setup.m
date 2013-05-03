w=24; % word width
d=16; % decimal width

% parameters for SDFP (Sigma Delta Fixed Point) blocks 
fixpt_adder_in_bitwidth=w;
fixpt_adder_in_position=d;
fixpt_adder_out_bitwidth=w;
fixpt_adder_out_position=d;

fixpt_gain_bitwidth=w;
fixpt_gain_position=d;

alpha = -7;
threealpha = 3*alpha;
