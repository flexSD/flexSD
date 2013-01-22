library verilog;
use verilog.vl_types.all;
entity EPLLD1 is
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
        PWD             : in     vl_logic;
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
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of FIN : constant is 1;
    attribute mti_svvh_generic_type of CLKFB_DIV : constant is 1;
    attribute mti_svvh_generic_type of CLKI_DIV : constant is 1;
    attribute mti_svvh_generic_type of CLKOP_DIV : constant is 1;
    attribute mti_svvh_generic_type of CLKOK_DIV : constant is 1;
    attribute mti_svvh_generic_type of PHASE_CNTL : constant is 1;
    attribute mti_svvh_generic_type of PLLCAP : constant is 1;
    attribute mti_svvh_generic_type of PHASEADJ : constant is 1;
    attribute mti_svvh_generic_type of DUTY : constant is 1;
    attribute mti_svvh_generic_type of CLKOP_BYPASS : constant is 1;
    attribute mti_svvh_generic_type of CLKOS_BYPASS : constant is 1;
    attribute mti_svvh_generic_type of CLKOK_BYPASS : constant is 1;
    attribute mti_svvh_generic_type of PLLTYPE : constant is 1;
    attribute mti_svvh_generic_type of LOCK_DELAY : constant is 1;
end EPLLD1;
