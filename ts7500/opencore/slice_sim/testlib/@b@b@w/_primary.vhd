library verilog;
use verilog.vl_types.all;
entity BBW is
    port(
        I               : in     vl_logic;
        T               : in     vl_logic;
        O               : out    vl_logic;
        B               : inout  vl_logic
    );
end BBW;
