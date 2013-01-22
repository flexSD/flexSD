library verilog;
use verilog.vl_types.all;
entity OSCE is
    generic(
        NOM_FREQ        : string  := "2.5"
    );
    port(
        OSC             : out    vl_logic
    );
end OSCE;
