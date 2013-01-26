library verilog;
use verilog.vl_types.all;
entity FSUB2B is
    port(
        A0              : in     vl_logic;
        A1              : in     vl_logic;
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        BI              : in     vl_logic;
        BOUT            : out    vl_logic;
        S0              : out    vl_logic;
        S1              : out    vl_logic
    );
end FSUB2B;
