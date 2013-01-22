library verilog;
use verilog.vl_types.all;
entity SEDBA is
    generic(
        OSC_DIV         : integer := 1;
        CHECKALWAYS     : string  := "DISABLED";
        AUTORECONFIG    : string  := "OFF";
        MCCLK_FREQ      : string  := "2.5";
        DEV_DENSITY     : string  := "17K";
        BOOT_OPTION     : string  := "INTERNAL"
    );
    port(
        SEDENABLE       : in     vl_logic;
        SEDSTART        : in     vl_logic;
        SEDFRCERRN      : in     vl_logic;
        SEDERR          : out    vl_logic;
        SEDDONE         : out    vl_logic;
        SEDINPROG       : out    vl_logic;
        SEDCLKOUT       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of OSC_DIV : constant is 1;
    attribute mti_svvh_generic_type of CHECKALWAYS : constant is 1;
    attribute mti_svvh_generic_type of AUTORECONFIG : constant is 1;
    attribute mti_svvh_generic_type of MCCLK_FREQ : constant is 1;
    attribute mti_svvh_generic_type of DEV_DENSITY : constant is 1;
    attribute mti_svvh_generic_type of BOOT_OPTION : constant is 1;
end SEDBA;
