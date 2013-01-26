library verilog;
use verilog.vl_types.all;
entity SCCU2B is
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
        INIT0_INITVAL   : integer := 0;
        INIT1_INITVAL   : integer := 0;
        CCU2_INJECT1_0  : string  := "YES";
        CCU2_INJECT1_1  : string  := "YES";
        XON             : integer := 0;
        CHECK_M1        : integer := 0;
        CHECK_DI1       : integer := 0;
        CHECK_DI0       : integer := 0;
        CHECK_M0        : integer := 0;
        CHECK_CE        : integer := 0;
        CHECK_LSR       : integer := 0
    );
    port(
        M1              : in     vl_logic;
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
        FCI             : in     vl_logic;
        M0              : in     vl_logic;
        CE              : in     vl_logic;
        CLK             : in     vl_logic;
        LSR             : in     vl_logic;
        FCO             : out    vl_logic;
        F1              : out    vl_logic;
        Q1              : out    vl_logic;
        F0              : out    vl_logic;
        Q0              : out    vl_logic
    );
end SCCU2B;
