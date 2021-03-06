library verilog;
use verilog.vl_types.all;
entity SLOGICB is
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
        LUT1_INITVAL    : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        LUT0_INITVAL    : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        REG1_REGSET     : string  := "RESET";
        REG0_REGSET     : string  := "RESET";
        LSRONMUX        : string  := "LSRMUX";
        XON             : vl_logic := Hi0;
        CHECK_M1        : vl_logic := Hi0;
        CHECK_DI1       : vl_logic := Hi0;
        CHECK_DI0       : vl_logic := Hi0;
        CHECK_M0        : vl_logic := Hi0;
        CHECK_CE        : vl_logic := Hi0;
        CHECK_LSR       : vl_logic := Hi0
    );
    port(
        M1              : in     vl_logic;
        FXA             : in     vl_logic;
        FXB             : in     vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        D1              : in     vl_logic;
        DI1             : in     vl_logic;
        DI0             : in     vl_logic;
        A0              : in     vl_logic;
        B0              : in     vl_logic;
        C0              : in     vl_logic;
        D0              : in     vl_logic;
        M0              : in     vl_logic;
        CE              : in     vl_logic;
        CLK             : in     vl_logic;
        LSR             : in     vl_logic;
        OFX1            : out    vl_logic;
        F1              : out    vl_logic;
        Q1              : out    vl_logic;
        OFX0            : out    vl_logic;
        F0              : out    vl_logic;
        Q0              : out    vl_logic
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
    attribute mti_svvh_generic_type of LUT1_INITVAL : constant is 1;
    attribute mti_svvh_generic_type of LUT0_INITVAL : constant is 1;
    attribute mti_svvh_generic_type of REG1_REGSET : constant is 1;
    attribute mti_svvh_generic_type of REG0_REGSET : constant is 1;
    attribute mti_svvh_generic_type of LSRONMUX : constant is 1;
    attribute mti_svvh_generic_type of XON : constant is 1;
    attribute mti_svvh_generic_type of CHECK_M1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_DI1 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_DI0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_M0 : constant is 1;
    attribute mti_svvh_generic_type of CHECK_CE : constant is 1;
    attribute mti_svvh_generic_type of CHECK_LSR : constant is 1;
end SLOGICB;
