library verilog;
use verilog.vl_types.all;
entity sigdel_virtual_tb is
    generic(
        delay           : integer := 4;
        input_bitwidth  : integer := 24;
        full_neg        : vl_notype;
        full_pos        : vl_notype
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of delay : constant is 1;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of full_neg : constant is 3;
    attribute mti_svvh_generic_type of full_pos : constant is 3;
end sigdel_virtual_tb;
