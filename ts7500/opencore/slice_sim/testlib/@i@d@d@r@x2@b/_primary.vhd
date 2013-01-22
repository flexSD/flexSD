library verilog;
use verilog.vl_types.all;
entity IDDRX2B is
    port(
        D               : in     vl_logic;
        ECLK            : in     vl_logic;
        SCLK            : in     vl_logic;
        CE              : in     vl_logic;
        RST             : in     vl_logic;
        QA0             : out    vl_logic;
        QA1             : out    vl_logic;
        QB0             : out    vl_logic;
        QB1             : out    vl_logic
    );
end IDDRX2B;
