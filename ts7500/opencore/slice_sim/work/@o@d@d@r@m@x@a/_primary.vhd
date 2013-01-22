library verilog;
use verilog.vl_types.all;
entity ODDRMXA is
    port(
        DA              : in     vl_logic;
        DB              : in     vl_logic;
        RST             : in     vl_logic;
        CLK             : in     vl_logic;
        DQSXFER         : in     vl_logic;
        Q               : out    vl_logic
    );
end ODDRMXA;
