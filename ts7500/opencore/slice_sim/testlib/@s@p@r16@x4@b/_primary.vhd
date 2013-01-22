library verilog;
use verilog.vl_types.all;
entity SPR16X4B is
    generic(
        initval         : vl_logic_vector(63 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        DI0             : in     vl_logic;
        DI1             : in     vl_logic;
        DI2             : in     vl_logic;
        DI3             : in     vl_logic;
        AD0             : in     vl_logic;
        AD1             : in     vl_logic;
        AD2             : in     vl_logic;
        AD3             : in     vl_logic;
        WRE             : in     vl_logic;
        CK              : in     vl_logic;
        DO0             : out    vl_logic;
        DO1             : out    vl_logic;
        DO2             : out    vl_logic;
        DO3             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of initval : constant is 2;
end SPR16X4B;
