library verilog;
use verilog.vl_types.all;
entity ND5 is
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        D               : in     vl_logic;
        E               : in     vl_logic;
        Z               : out    vl_logic
    );
end ND5;
