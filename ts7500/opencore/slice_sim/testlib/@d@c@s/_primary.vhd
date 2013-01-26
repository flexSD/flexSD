library verilog;
use verilog.vl_types.all;
entity DCS is
    generic(
        DCSMODE         : string  := "NEG"
    );
    port(
        CLK0            : in     vl_logic;
        CLK1            : in     vl_logic;
        SEL             : in     vl_logic;
        DCSOUT          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DCSMODE : constant is 1;
end DCS;
