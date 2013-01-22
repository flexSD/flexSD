library verilog;
use verilog.vl_types.all;
entity OLVDS is
    port(
        A               : in     vl_logic;
        Z               : out    vl_logic;
        ZN              : out    vl_logic
    );
end OLVDS;
