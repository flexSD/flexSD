library verilog;
use verilog.vl_types.all;
entity tagmem is
    port(
        CLK             : in     vl_logic;
        SI              : in     vl_logic;
        CS              : in     vl_logic;
        SO              : out    vl_logic
    );
end tagmem;
