library verilog;
use verilog.vl_types.all;
entity SRAMWA is
    generic(
        LSRMUX          : string  := "VLO";
        CLKMUX          : string  := "VLO";
        XON             : vl_logic := Hi0;
        CHECK_LSR       : vl_logic := Hi0
    );
    port(
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        D1              : in     vl_logic;
        A0              : in     vl_logic;
        B0              : in     vl_logic;
        C0              : in     vl_logic;
        D0              : in     vl_logic;
        CLK             : in     vl_logic;
        LSR             : in     vl_logic;
        WDO0            : out    vl_logic;
        WDO1            : out    vl_logic;
        WDO2            : out    vl_logic;
        WDO3            : out    vl_logic;
        WADO0           : out    vl_logic;
        WADO1           : out    vl_logic;
        WADO2           : out    vl_logic;
        WADO3           : out    vl_logic;
        WCKO            : out    vl_logic;
        WREO            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of LSRMUX : constant is 1;
    attribute mti_svvh_generic_type of CLKMUX : constant is 1;
    attribute mti_svvh_generic_type of XON : constant is 1;
    attribute mti_svvh_generic_type of CHECK_LSR : constant is 1;
end SRAMWA;
