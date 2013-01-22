library verilog;
use verilog.vl_types.all;
entity second_order_sigdel_virtualized is
    generic(
        input_bitwidth  : integer := 24;
        accumulator_bitwidth: integer := 36
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        mod_enable      : in     vl_logic;
        write_address_in: in     vl_logic_vector(3 downto 0);
        write_enable_in : in     vl_logic;
        output_bitstream_reg: out    vl_logic_vector(9 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of accumulator_bitwidth : constant is 1;
end second_order_sigdel_virtualized;
