library verilog;
use verilog.vl_types.all;
entity fist_order_sigdel is
    generic(
        input_bitwidth  : integer := 12
    );
    port(
        mod_clock       : in     vl_logic;
        input_sig       : in     vl_logic_vector;
        output_sig      : out    vl_logic
    );
end fist_order_sigdel;
