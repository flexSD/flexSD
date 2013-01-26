library verilog;
use verilog.vl_types.all;
entity BUFBA is
    port(
        Z               : out    vl_logic;
        A               : in     vl_logic
    );
end BUFBA;
