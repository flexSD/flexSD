library verilog;
use verilog.vl_types.all;
entity IFS1P3JX is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        SP              : in     vl_logic;
        SCLK            : in     vl_logic;
        PD              : in     vl_logic;
        Q               : out    vl_logic
    );
end IFS1P3JX;
