library verilog;
use verilog.vl_types.all;
entity IDDRXC is
    port(
        D               : in     vl_logic;
        CLK             : in     vl_logic;
        CE              : in     vl_logic;
        RST             : in     vl_logic;
        QA              : out    vl_logic;
        QB              : out    vl_logic
    );
end IDDRXC;
