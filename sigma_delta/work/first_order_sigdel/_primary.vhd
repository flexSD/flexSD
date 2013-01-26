library verilog;
use verilog.vl_types.all;
entity first_order_sigdel is
    generic(
        input_bitwidth  : integer := 24
    );
    port(
        mod_clock       : in     vl_logic;
        input_sig       : in     vl_logic_vector;
        output_sig      : out    vl_logic;
        feedback_out    : out    vl_logic_vector
    );
end first_order_sigdel;
