library verilog;
use verilog.vl_types.all;
entity FL1P3AY is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        SP              : in     vl_logic;
        CK              : in     vl_logic;
        SD              : in     vl_logic;
        Q               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GSR : constant is 1;
end FL1P3AY;
