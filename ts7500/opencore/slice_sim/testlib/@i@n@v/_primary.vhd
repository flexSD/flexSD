library verilog;
use verilog.vl_types.all;
entity INV is
    port(
        A               : in     vl_logic;
        Z               : out    vl_logic
    );
end INV;
