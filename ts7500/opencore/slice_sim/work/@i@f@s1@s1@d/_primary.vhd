library verilog;
use verilog.vl_types.all;
entity IFS1S1D is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        SCLK            : in     vl_logic;
        CD              : in     vl_logic;
        Q               : out    vl_logic
    );
end IFS1S1D;
