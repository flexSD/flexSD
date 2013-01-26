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
end DCS;
