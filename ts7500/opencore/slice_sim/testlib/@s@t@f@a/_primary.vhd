library verilog;
use verilog.vl_types.all;
entity STFA is
    port(
        STOREN          : in     vl_logic;
        UFMFAIL         : out    vl_logic;
        UFMBUSYN        : out    vl_logic
    );
end STFA;
