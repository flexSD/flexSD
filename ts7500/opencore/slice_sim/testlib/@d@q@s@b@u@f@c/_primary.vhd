library verilog;
use verilog.vl_types.all;
entity DQSBUFC is
    generic(
        DQS_LI_DEL_ADJ  : string  := "PLUS";
        DQS_LI_DEL_VAL  : string  := "4";
        DQS_LO_DEL_ADJ  : string  := "PLUS";
        DQS_LO_DEL_VAL  : string  := "4"
    );
    port(
        DQSI            : in     vl_logic;
        CLK             : in     vl_logic;
        XCLK            : in     vl_logic;
        READ            : in     vl_logic;
        DQSDEL          : in     vl_logic;
        DQSO            : out    vl_logic;
        DDRCLKPOL       : out    vl_logic;
        DQSC            : out    vl_logic;
        PRMBDET         : out    vl_logic;
        DQSXFER         : out    vl_logic;
        DATAVALID       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DQS_LI_DEL_ADJ : constant is 1;
    attribute mti_svvh_generic_type of DQS_LI_DEL_VAL : constant is 1;
    attribute mti_svvh_generic_type of DQS_LO_DEL_ADJ : constant is 1;
    attribute mti_svvh_generic_type of DQS_LO_DEL_VAL : constant is 1;
end DQSBUFC;
