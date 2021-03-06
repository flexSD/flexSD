library verilog;
use verilog.vl_types.all;
entity FADSU2 is
    port(
        A0              : in     vl_logic;
        A1              : in     vl_logic;
        B0              : in     vl_logic;
        B1              : in     vl_logic;
        BCI             : in     vl_logic;
        CON             : in     vl_logic;
        BCO             : out    vl_logic;
        S0              : out    vl_logic;
        S1              : out    vl_logic
    );
end FADSU2;
