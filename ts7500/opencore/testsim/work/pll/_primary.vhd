library verilog;
use verilog.vl_types.all;
entity pll is
    port(
        CLK             : in     vl_logic;
        WRDEL           : in     vl_logic;
        DPHASE0         : in     vl_logic;
        DPHASE1         : in     vl_logic;
        DPHASE2         : in     vl_logic;
        DPHASE3         : in     vl_logic;
        CLKOP           : out    vl_logic;
        CLKOS           : out    vl_logic;
        LOCK            : out    vl_logic
    );
end pll;
