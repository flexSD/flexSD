library verilog;
use verilog.vl_types.all;
entity first_order_sigdel is
    generic(
        input_bitwidth  : integer := 24;
        full_neg        : vl_notype;
        full_pos        : vl_notype
    );
    port(
        mod_clock       : in     vl_logic;
        input_sig       : in     vl_logic_vector;
        output_sig      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of full_neg : constant is 3;
    attribute mti_svvh_generic_type of full_pos : constant is 3;
end first_order_sigdel;
