library verilog;
use verilog.vl_types.all;
entity first_order_sigdel_virtualized is
    generic(
        input_bitwidth  : integer := 24;
        accumulator_bitwidth: integer := 28
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        input_data      : in     vl_logic_vector(23 downto 0);
        output_bitstream: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of accumulator_bitwidth : constant is 1;
end first_order_sigdel_virtualized;
