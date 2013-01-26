library verilog;
use verilog.vl_types.all;
entity CLKDIVB is
    generic(
        GSR             : string  := "DISABLED"
    );
    port(
        CLKI            : in     vl_logic;
        RST             : in     vl_logic;
        RELEASE         : in     vl_logic;
        CDIV1           : out    vl_logic;
        CDIV2           : out    vl_logic;
        CDIV4           : out    vl_logic;
        CDIV8           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GSR : constant is 1;
end CLKDIVB;
