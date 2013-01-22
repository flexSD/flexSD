library verilog;
use verilog.vl_types.all;
entity EPLLD is
    generic(
        FIN             : string  := "100.0000";
        CLKFB_DIV       : integer := 1;
        CLKI_DIV        : integer := 1;
        CLKOP_DIV       : integer := 8;
        CLKOK_DIV       : integer := 2;
        PHASE_CNTL      : string  := "STATIC";
        PLLCAP          : string  := "DISABLED";
        PHASEADJ        : string  := "0.0";
        DUTY            : integer := 8;
        CLKOP_BYPASS    : string  := "DISABLED";
        CLKOS_BYPASS    : string  := "DISABLED";
        CLKOK_BYPASS    : string  := "DISABLED";
        PLLTYPE         : string  := "AUTO";
        LOCK_DELAY      : integer := 100
    );
    port(
        RST             : in     vl_logic;
        RSTK            : in     vl_logic;
        CLKI            : in     vl_logic;
        CLKFB           : in     vl_logic;
        DPAMODE         : in     vl_logic;
        DRPAI3          : in     vl_logic;
        DRPAI2          : in     vl_logic;
        DRPAI1          : in     vl_logic;
        DRPAI0          : in     vl_logic;
        DFPAI3          : in     vl_logic;
        DFPAI2          : in     vl_logic;
        DFPAI1          : in     vl_logic;
        DFPAI0          : in     vl_logic;
        CLKOP           : out    vl_logic;
        CLKOK           : out    vl_logic;
        CLKOS           : out    vl_logic;
        LOCK            : out    vl_logic;
        CLKINTFB        : out    vl_logic
    );
end EPLLD;
