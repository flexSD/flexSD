library verilog;
use verilog.vl_types.all;
entity DPR16X4A is
    port(
        DI0             : in     vl_logic;
        DI1             : in     vl_logic;
        DI2             : in     vl_logic;
        DI3             : in     vl_logic;
        WAD0            : in     vl_logic;
        WAD1            : in     vl_logic;
        WAD2            : in     vl_logic;
        WAD3            : in     vl_logic;
        WRE             : in     vl_logic;
        WCK             : in     vl_logic;
        RAD0            : in     vl_logic;
        RAD1            : in     vl_logic;
        RAD2            : in     vl_logic;
        RAD3            : in     vl_logic;
        DO0             : out    vl_logic;
        DO1             : out    vl_logic;
        DO2             : out    vl_logic;
        DO3             : out    vl_logic
    );
end DPR16X4A;
