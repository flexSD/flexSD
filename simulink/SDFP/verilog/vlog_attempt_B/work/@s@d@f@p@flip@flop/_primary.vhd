library verilog;
use verilog.vl_types.all;
entity SDFPFlipFlop is
    generic(
        BW              : integer := 24
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        d               : in     vl_logic_vector;
        q               : out    vl_logic_vector
    );
end SDFPFlipFlop;
