library verilog;
use verilog.vl_types.all;
entity IDDRMX1A is
    port(
        D               : in     vl_logic;
        ECLK            : in     vl_logic;
        SCLK            : in     vl_logic;
        CE              : in     vl_logic;
        RST             : in     vl_logic;
        DDRCLKPOL       : in     vl_logic;
        QA              : out    vl_logic;
        QB              : out    vl_logic
    );
end IDDRMX1A;
