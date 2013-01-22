library verilog;
use verilog.vl_types.all;
entity FADD2B is
    port(
        A0              : in     vl_logic;
        A1              : in     vl_logic;
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        CI              : in     vl_logic;
        COUT            : out    vl_logic;
        S0              : out    vl_logic;
        S1              : out    vl_logic
    );
end FADD2B;
