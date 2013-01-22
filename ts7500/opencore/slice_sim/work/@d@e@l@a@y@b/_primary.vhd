library verilog;
use verilog.vl_types.all;
entity DELAYB is
    port(
        A               : in     vl_logic;
        DEL0            : in     vl_logic;
        DEL1            : in     vl_logic;
        DEL2            : in     vl_logic;
        DEL3            : in     vl_logic;
        Z               : out    vl_logic
    );
end DELAYB;
