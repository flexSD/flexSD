library verilog;
use verilog.vl_types.all;
entity SDFPAdder3 is
    generic(
        BW              : integer := 24
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
end SDFPAdder3;
