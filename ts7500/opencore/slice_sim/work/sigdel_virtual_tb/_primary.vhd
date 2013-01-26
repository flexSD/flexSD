library verilog;
use verilog.vl_types.all;
entity sigdel_virtual_tb is
    generic(
        delay           : integer := 4;
        input_bitwidth  : integer := 24
    );
end sigdel_virtual_tb;
