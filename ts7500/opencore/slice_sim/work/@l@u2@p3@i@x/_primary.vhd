library verilog;
use verilog.vl_types.all;
entity LU2P3IX is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        CI              : in     vl_logic;
        SP              : in     vl_logic;
        CK              : in     vl_logic;
        SD              : in     vl_logic;
        CD              : in     vl_logic;
        CO              : out    vl_logic;
        Q0              : out    vl_logic;
        Q1              : out    vl_logic
    );
end LU2P3IX;
