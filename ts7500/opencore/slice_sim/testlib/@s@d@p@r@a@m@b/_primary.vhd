library verilog;
use verilog.vl_types.all;
entity SDPRAMB is
    generic(
        GSR             : string  := "ENABLED";
        SRMODE          : string  := "LSR_OVER_CE";
        M1MUX           : string  := "VLO";
        M0MUX           : string  := "VLO";
        LSRMUX          : string  := "VLO";
        CEMUX           : string  := "VLO";
        CLKMUX          : string  := "VLO";
        REG1_SD         : string  := "VLO";
        REG0_SD         : string  := "VLO";
        REG1_REGSET     : string  := "RESET";
        REG0_REGSET     : string  := "RESET";
        LSRONMUX        : string  := "LSRMUX";
        XON             : vl_logic := Hi0;
        CHECK_RAD0      : vl_logic := Hi0;
        CHECK_RAD1      : vl_logic := Hi0;
        CHECK_RAD2      : vl_logic := Hi0;
        CHECK_RAD3      : vl_logic := Hi0;
        CHECK_WD1       : vl_logic := Hi0;
        CHECK_WD0       : vl_logic := Hi0;
        CHECK_WAD0      : vl_logic := Hi0;
        CHECK_WAD1      : vl_logic := Hi0;
        CHECK_WAD2      : vl_logic := Hi0;
        CHECK_WAD3      : vl_logic := Hi0;
        CHECK_WRE       : vl_logic := Hi0;
        CHECK_CE        : vl_logic := Hi0;
        CHECK_LSR       : vl_logic := Hi0;
        CHECK_M1        : vl_logic := Hi0;
        CHECK_DI1       : vl_logic := Hi0;
        CHECK_DI0       : vl_logic := Hi0;
        CHECK_M0        : vl_logic := Hi0
    );
    port(
        M1              : in     vl_logic;
        RAD0            : in     vl_logic;
        RAD1            : in     vl_logic;
        RAD2            : in     vl_logic;
        RAD3            : in     vl_logic;
        WD1             : in     vl_logic;
        WD0             : in     vl_logic;
        WAD0            : in     vl_logic;
        WAD1            : in     vl_logic;
        WAD2            : in     vl_logic;
        WAD3            : in     vl_logic;
        WRE             : in     vl_logic;
        WCK             : in     vl_logic;
        M0              : in     vl_logic;
        DI1             : in     vl_logic;
        DI0             : in     vl_logic;
        CE              : in     vl_logic;
        CLK             : in     vl_logic;
        LSR             : in     vl_logic;
        F0              : out    vl_logic;
        Q0              : out    vl_logic;
        F1              : out    vl_logic;
        Q1              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GSR : constant is 1;
    attribute mti_svvh_generic_type of SRMODE : constant is 1;
    attribute mti_svvh_generic_type of M1MUX : constant is 1;
    attribute mti_svvh_generic_type of M0MUX : constant is 1;
    attribute mti_svvh_generic_type of LSRMUX : constant is 1;
    attribute mti_svvh_generic_type of CEMUX : constant is 1;
    attribute mti_svvh_generic_type of CLKMUX : constant is 1;
    attribute mti_svvh_generic_type of REG1_SD : constant is 1;
    attribute mti_svvh_generic_type of REG0_SD : constant is 1;
    attribute mti_svvh_generic_type of REG1_REGSET : constant is 1;
    attribute mti_svvh_generic_type of REG0_REGSET : constant is 1;
    attribute mti_svvh_generic_type of LSRONMUX : constant is 1;
    attribute mti_svvh_generic_type of XON : constant is 1;
    attribute mti_svvh_generic_type of CHECK_RAD0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_RAD1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_RAD2 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_RAD3 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WD1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WD0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WAD0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WAD1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WAD2 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WAD3 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_WRE : constant is 1;
    attribute mti_svvh_generic_type of CHECK_CE : constant is 1;
    attribute mti_svvh_generic_type of CHECK_LSR : constant is 1;
    attribute mti_svvh_generic_type of CHECK_M1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_DI1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_DI0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_M0 : constant is 1;
end SDPRAMB;
