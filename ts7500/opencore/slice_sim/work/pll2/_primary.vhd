library verilog;
use verilog.vl_types.all;
entity pll2 is
    port(
        CLK             : in     vl_logic;
        CLKOP           : out    vl_logic;
        CLKOK           : out    vl_logic;
        LOCK            : out    vl_logic
    );
end pll2;
