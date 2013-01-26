library verilog;
use verilog.vl_types.all;
entity MUX81 is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        D2              : in     vl_logic;
        D3              : in     vl_logic;
        D4              : in     vl_logic;
        D5              : in     vl_logic;
        D6              : in     vl_logic;
        D7              : in     vl_logic;
        SD1             : in     vl_logic;
        SD2             : in     vl_logic;
        SD3             : in     vl_logic;
        Z               : out    vl_logic
    );
end MUX81;
