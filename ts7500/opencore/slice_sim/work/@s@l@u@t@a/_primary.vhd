library verilog;
use verilog.vl_types.all;
entity SLUTA is
    generic(
        M1MUX           : string  := "VLO";
        M0MUX           : string  := "VLO";
        LUT1_INITVAL    : integer := 0;
        LUT0_INITVAL    : integer := 0;
        XON             : integer := 0
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
end SLUTA;
