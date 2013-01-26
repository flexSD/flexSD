library verilog;
use verilog.vl_types.all;
entity JTAGE is
    generic(
        ER1             : string  := "ENABLED";
        ER2             : string  := "ENABLED"
    );
    port(
        TCK             : in     vl_logic;
        TMS             : in     vl_logic;
        TDI             : in     vl_logic;
        JTDO1           : in     vl_logic;
        JTDO2           : in     vl_logic;
        TDO             : out    vl_logic;
        JTCK            : out    vl_logic;
        JTDI            : out    vl_logic;
        JSHIFT          : out    vl_logic;
        JUPDATE         : out    vl_logic;
        JRSTN           : out    vl_logic;
        JCE1            : out    vl_logic;
        JCE2            : out    vl_logic;
        JRTI1           : out    vl_logic;
        JRTI2           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ER1 : constant is 1;
    attribute mti_svvh_generic_type of ER2 : constant is 1;
end JTAGE;
