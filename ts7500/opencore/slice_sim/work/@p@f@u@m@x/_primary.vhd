library verilog;
use verilog.vl_types.all;
entity PFUMX is
    port(
        ALUT            : in     vl_logic;
        BLUT            : in     vl_logic;
        C0              : in     vl_logic;
        Z               : out    vl_logic
    );
end PFUMX;
