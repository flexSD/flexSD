library verilog;
use verilog.vl_types.all;
entity CU2 is
    port(
        CI              : in     vl_logic;
        PC0             : in     vl_logic;
        PC1             : in     vl_logic;
        CO              : out    vl_logic;
        NC0             : out    vl_logic;
        NC1             : out    vl_logic
    );
end CU2;
