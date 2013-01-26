library verilog;
use verilog.vl_types.all;
entity CCU2B is
    generic(
        INIT0           : vl_logic_vector(15 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        INIT1           : vl_logic_vector(15 downto 0) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        INJECT1_0       : string  := "YES";
        INJECT1_1       : string  := "YES"
    );
    port(
        CIN             : in     vl_logic;
        A0              : in     vl_logic;
        B0              : in     vl_logic;
        C0              : in     vl_logic;
        D0              : in     vl_logic;
        A1              : in     vl_logic;
        B1              : in     vl_logic;
        C1              : in     vl_logic;
        D1              : in     vl_logic;
        S0              : out    vl_logic;
        S1              : out    vl_logic;
        COUT            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INIT0 : constant is 2;
    attribute mti_svvh_generic_type of INIT1 : constant is 2;
    attribute mti_svvh_generic_type of INJECT1_0 : constant is 1;
    attribute mti_svvh_generic_type of INJECT1_1 : constant is 1;
end CCU2B;
