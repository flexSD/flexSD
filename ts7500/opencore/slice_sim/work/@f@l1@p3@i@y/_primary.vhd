library verilog;
use verilog.vl_types.all;
entity FL1P3IY is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        SP              : in     vl_logic;
        CK              : in     vl_logic;
        SD              : in     vl_logic;
        CD              : in     vl_logic;
        Q               : out    vl_logic
    );
end FL1P3IY;
