library verilog;
use verilog.vl_types.all;
entity ILVDS is
    port(
        A               : in     vl_logic;
        AN              : in     vl_logic;
        Z               : out    vl_logic
    );
end ILVDS;
