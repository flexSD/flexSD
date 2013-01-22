library verilog;
use verilog.vl_types.all;
entity AGEB2 is
    port(
        A0              : in     vl_logic;
        A1              : in     vl_logic;
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        CI              : in     vl_logic;
        GE              : out    vl_logic
    );
end AGEB2;
