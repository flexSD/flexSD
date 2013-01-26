library verilog;
use verilog.vl_types.all;
entity EHXPLLE is
    generic(
        FIN             : string  := "100.0000";
        CLKFB_DIV       : integer := 1;
        CLKI_DIV        : integer := 1;
        CLKOP_DIV       : integer := 8;
        CLKOK_DIV       : integer := 2;
        PHASE_CNTL      : string  := "STATIC";
        PHASEADJ        : string  := "0.0";
        DUTY            : integer := 8;
        CLKOP_BYPASS    : string  := "DISABLED";
        CLKOS_BYPASS    : string  := "DISABLED";
        CLKOK_BYPASS    : string  := "DISABLED";
        CLKOP_TRIM_POL  : string  := "FALLING";
        CLKOP_TRIM_DELAY: integer := 6;
        CLKOS_TRIM_POL  : string  := "RISING";
        CLKOS_TRIM_DELAY: integer := 0;
        LOCK_DELAY      : integer := 100
    );
    port(
        RST             : in     vl_logic;
        RSTK            : in     vl_logic;
        CLKI            : in     vl_logic;
        CLKFB           : in     vl_logic;
        WRDEL           : in     vl_logic;
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
        CLKOK2          : out    vl_logic;
        CLKOS           : out    vl_logic;
        LOCK            : out    vl_logic;
        CLKINTFB        : out    vl_logic
    );
end EHXPLLE;
