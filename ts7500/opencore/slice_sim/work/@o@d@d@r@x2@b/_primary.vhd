library verilog;
use verilog.vl_types.all;
entity ODDRX2B is
    port(
        DA0             : in     vl_logic;
        DB0             : in     vl_logic;
        DA1             : in     vl_logic;
        DB1             : in     vl_logic;
        RST             : in     vl_logic;
        ECLK            : in     vl_logic;
        SCLK            : in     vl_logic;
        Q               : out    vl_logic
    );
end ODDRX2B;
