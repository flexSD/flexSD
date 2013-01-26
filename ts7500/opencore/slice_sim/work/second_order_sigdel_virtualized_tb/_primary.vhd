library verilog;
use verilog.vl_types.all;
entity second_order_sigdel_virtualized_tb is
    generic(
        input_data_bitwidth: integer := 24;
        accumulator_bitwidth: integer := 28
    );
end second_order_sigdel_virtualized_tb;
