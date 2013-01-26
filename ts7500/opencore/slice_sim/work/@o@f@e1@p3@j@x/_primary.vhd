library verilog;
use verilog.vl_types.all;
entity OFE1P3JX is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        SP              : in     vl_logic;
        ECLK            : in     vl_logic;
        PD              : in     vl_logic;
        Q               : out    vl_logic
    );
end OFE1P3JX;
