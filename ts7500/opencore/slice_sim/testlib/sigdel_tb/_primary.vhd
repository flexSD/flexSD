library verilog;
use verilog.vl_types.all;
entity sigdel_tb is
    generic(
        signal_bitwidth : integer := 24;
        ramp_bits_add   : integer := 16
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of signal_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of ramp_bits_add : constant is 1;
end sigdel_tb;
