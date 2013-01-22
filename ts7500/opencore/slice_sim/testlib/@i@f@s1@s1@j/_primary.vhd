library verilog;
use verilog.vl_types.all;
entity IFS1S1J is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        SCLK            : in     vl_logic;
        PD              : in     vl_logic;
        Q               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GSR : constant is 1;
end IFS1S1J;
