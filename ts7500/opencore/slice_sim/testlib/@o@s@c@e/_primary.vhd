library verilog;
use verilog.vl_types.all;
entity OSCE is
    generic(
        NOM_FREQ        : string  := "2.5"
    );
    port(
        OSC             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NOM_FREQ : constant is 1;
end OSCE;
