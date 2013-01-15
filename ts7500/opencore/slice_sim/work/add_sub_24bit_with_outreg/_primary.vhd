library verilog;
use verilog.vl_types.all;
entity add_sub_24bit_with_outreg is
    port(
        DataA           : in     vl_logic_vector(23 downto 0);
        DataB           : in     vl_logic_vector(23 downto 0);
        Add_Sub         : in     vl_logic;
        Clock           : in     vl_logic;
        Reset           : in     vl_logic;
        ClockEn         : in     vl_logic;
        Result          : out    vl_logic_vector(23 downto 0);
        Overflow        : out    vl_logic
    );
end add_sub_24bit_with_outreg;
