library verilog;
use verilog.vl_types.all;
entity SDFPMux is
    generic(
        BW              : integer := 24
    );
    port(
        \select\        : in     vl_logic;
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
end SDFPMux;
