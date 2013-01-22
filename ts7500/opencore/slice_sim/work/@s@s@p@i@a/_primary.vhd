library verilog;
use verilog.vl_types.all;
entity SSPIA is
    generic(
        TAG_INITSIZE    : integer := 2184;
        TAG_INITVAL_00  : integer := 0;
        TAG_INITVAL_01  : integer := 0;
        TAG_INITVAL_02  : integer := 0;
        TAG_INITVAL_03  : integer := 0;
        TAG_INITVAL_04  : integer := 0;
        TAG_INITVAL_05  : integer := 0;
        TAG_INITVAL_06  : integer := 0;
        TAG_INITVAL_07  : integer := 0;
        TAG_INITVAL_08  : integer := 0;
        TAG_INITVAL_09  : integer := 0;
        TAG_INITVAL_0A  : integer := 0;
        TAG_INITVAL_0B  : integer := 0;
        TAG_INITVAL_0C  : integer := 0
    );
    port(
        SI              : in     vl_logic;
        CLK             : in     vl_logic;
        CS              : in     vl_logic;
        SO              : out    vl_logic
    );
end SSPIA;
