library verilog;
use verilog.vl_types.all;
entity DQSDLL is
    generic(
        DEL_ADJ         : string  := "PLUS";
        DEL_VAL         : string  := "0";
        LOCK_SENSITIVITY: string  := "LOW";
        LOCK_CYC        : integer := 2
    );
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        UDDCNTL         : in     vl_logic;
        DQSDEL          : out    vl_logic;
        LOCK            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DEL_ADJ : constant is 1;
    attribute mti_svvh_generic_type of DEL_VAL : constant is 1;
    attribute mti_svvh_generic_type of LOCK_SENSITIVITY : constant is 1;
    attribute mti_svvh_generic_type of LOCK_CYC : constant is 1;
end DQSDLL;
