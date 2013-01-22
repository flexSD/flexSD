library verilog;
use verilog.vl_types.all;
entity second_order_sigdel_virtualized_tb is
    generic(
        input_data_bitwidth: integer := 24;
        accumulator_bitwidth: integer := 28
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_data_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of accumulator_bitwidth : constant is 1;
end second_order_sigdel_virtualized_tb;
