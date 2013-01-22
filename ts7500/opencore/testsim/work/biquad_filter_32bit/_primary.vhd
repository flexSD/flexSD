library verilog;
use verilog.vl_types.all;
entity biquad_filter_32bit is
    generic(
        bit_shift       : integer := 7
    );
    port(
        filter_clock    : in     vl_logic;
        reset           : in     vl_logic;
        mainIn          : in     vl_logic;
        mainOut         : out    vl_logic;
        ffGain1         : in     vl_logic_vector(31 downto 0);
        ffGain2         : in     vl_logic_vector(31 downto 0);
        ffGain3         : in     vl_logic_vector(31 downto 0);
        ffGain4         : in     vl_logic_vector(31 downto 0);
        ffGain5         : in     vl_logic_vector(31 downto 0);
        fbGain1         : in     vl_logic_vector(31 downto 0);
        fbGain2         : in     vl_logic_vector(31 downto 0);
        fbGain3         : in     vl_logic_vector(31 downto 0);
        fbGain4         : in     vl_logic_vector(31 downto 0);
        delay1_ivalue   : in     vl_logic_vector(31 downto 0);
        delay2_ivalue   : in     vl_logic_vector(31 downto 0);
        delay3_ivalue   : in     vl_logic_vector(31 downto 0);
        delay4_ivalue   : in     vl_logic_vector(31 downto 0);
        sdDelay_ivalue  : in     vl_logic_vector(31 downto 0)
    );
end biquad_filter_32bit;
