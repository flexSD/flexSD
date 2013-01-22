library verilog;
use verilog.vl_types.all;
entity PUR is
    generic(
        RST_PULSE       : integer := 1
    );
    port(
        PUR             : in     vl_logic
    );
end PUR;
