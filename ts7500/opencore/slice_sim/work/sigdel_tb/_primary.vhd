library verilog;
use verilog.vl_types.all;
entity sigdel_tb is
    generic(
        signal_bitwidth : integer := 24;
        ramp_bits_add   : integer := 16
    );
end sigdel_tb;
