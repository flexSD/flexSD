library verilog;
use verilog.vl_types.all;
entity recon_sigdel_tb is
    generic(
        input_bitwidth  : integer := 24;
        full_neg        : vl_notype;
        full_pos        : vl_notype;
        ramp_bits_add   : integer := 10;
        delay           : integer := 4
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of full_neg : constant is 3;
    attribute mti_svvh_generic_type of full_pos : constant is 3;
    attribute mti_svvh_generic_type of ramp_bits_add : constant is 1;
    attribute mti_svvh_generic_type of delay : constant is 1;
end recon_sigdel_tb;
