library verilog;
use verilog.vl_types.all;
entity IDDRFXA is
    port(
        D               : in     vl_logic;
        CLK1            : in     vl_logic;
        CLK2            : in     vl_logic;
        CE              : in     vl_logic;
        RST             : in     vl_logic;
        QA              : out    vl_logic;
        QB              : out    vl_logic
    );
end IDDRFXA;
