library verilog;
use verilog.vl_types.all;
entity FD1S3AX is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        CK              : in     vl_logic;
        Q               : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of GSR : constant is 1;
end FD1S3AX;
