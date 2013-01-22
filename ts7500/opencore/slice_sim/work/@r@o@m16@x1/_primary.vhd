library verilog;
use verilog.vl_types.all;
entity ROM16X1 is
    generic(
        initval         : integer := 0
    );
    port(
        AD0             : in     vl_logic;
        AD1             : in     vl_logic;
        AD2             : in     vl_logic;
        AD3             : in     vl_logic;
        DO0             : out    vl_logic
    );
end ROM16X1;
