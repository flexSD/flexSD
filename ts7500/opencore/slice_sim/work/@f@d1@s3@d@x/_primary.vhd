library verilog;
use verilog.vl_types.all;
entity FD1S3DX is
    generic(
        GSR             : string  := "ENABLED"
    );
    port(
        D               : in     vl_logic;
        CK              : in     vl_logic;
        CD              : in     vl_logic;
        Q               : out    vl_logic
    );
end FD1S3DX;
