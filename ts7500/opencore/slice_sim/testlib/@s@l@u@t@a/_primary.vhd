library verilog;
use verilog.vl_types.all;
entity SLUTA is
    generic(
        M1MUX           : string  := "VLO";
        M0MUX           : string  := "VLO";
        LUT1_INITVAL    : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        LUT0_INITVAL    : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        XON             : vl_logic := Hi0
    );
    port(
        M1              : in     vl_logic;
        FXA             : in     vl_logic;
        FXB             : in     vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        D1              : in     vl_logic;
        A0              : in     vl_logic;
        B0              : in     vl_logic;
        C0              : in     vl_logic;
        D0              : in     vl_logic;
        M0              : in     vl_logic;
        OFX1            : out    vl_logic;
        F1              : out    vl_logic;
        OFX0            : out    vl_logic;
        F0              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of M1MUX : constant is 1;
    attribute mti_svvh_generic_type of M0MUX : constant is 1;
    attribute mti_svvh_generic_type of LUT1_INITVAL : constant is 1;
    attribute mti_svvh_generic_type of LUT0_INITVAL : constant is 1;
    attribute mti_svvh_generic_type of XON : constant is 1;
end SLUTA;
