library verilog;
use verilog.vl_types.all;
entity ORCALUT4 is
    generic(
        init            : integer := 0
    );
    port(
        A               : in     vl_logic;
        B               : in     vl_logic;
        C               : in     vl_logic;
        D               : in     vl_logic;
        Z               : out    vl_logic
    );
end ORCALUT4;
