library verilog;
use verilog.vl_types.all;
entity MULT2 is
    port(
        P0              : out    vl_logic;
        P1              : out    vl_logic;
        CO              : out    vl_logic;
        A0              : in     vl_logic;
        A1              : in     vl_logic;
        A2              : in     vl_logic;
        A3              : in     vl_logic;
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        B2              : in     vl_logic;
        B3              : in     vl_logic;
        CI              : in     vl_logic
    );
end MULT2;
