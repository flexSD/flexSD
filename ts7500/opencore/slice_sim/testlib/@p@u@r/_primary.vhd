library verilog;
use verilog.vl_types.all;
entity PUR is
    generic(
        RST_PULSE       : integer := 1
    );
    port(
        PUR             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of RST_PULSE : constant is 1;
end PUR;
