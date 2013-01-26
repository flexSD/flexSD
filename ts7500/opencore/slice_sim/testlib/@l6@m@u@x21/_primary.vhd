library verilog;
use verilog.vl_types.all;
entity L6MUX21 is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        SD              : in     vl_logic;
        Z               : out    vl_logic
    );
end L6MUX21;
