library verilog;
use verilog.vl_types.all;
entity OBCO is
    port(
        I               : in     vl_logic;
        OT              : out    vl_logic;
        OC              : out    vl_logic
    );
end OBCO;
