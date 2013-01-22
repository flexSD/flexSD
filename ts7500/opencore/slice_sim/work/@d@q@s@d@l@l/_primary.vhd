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
end DQSDLL;
