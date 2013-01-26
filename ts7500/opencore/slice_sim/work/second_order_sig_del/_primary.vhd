library verilog;
use verilog.vl_types.all;
entity second_order_sig_del is
    generic(
        in_bw           : integer := 5;
        internal_bw     : integer := 8;
        alpha           : integer := 2
    );
    port(
        v               : in     vl_logic_vector;
        clk             : in     vl_logic;
        state           : out    vl_logic
    );
end second_order_sig_del;
