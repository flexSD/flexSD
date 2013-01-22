library verilog;
use verilog.vl_types.all;
entity SEDBB is
    port(
        SEDERR          : out    vl_logic;
        SEDDONE         : out    vl_logic;
        SEDINPROG       : out    vl_logic
    );
end SEDBB;
