library verilog;
use verilog.vl_types.all;
entity AND2 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        Z               : out    vl_logic
    );
end AND2;
