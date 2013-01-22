library verilog;
use verilog.vl_types.all;
entity add_sub_16bit is
    port(
        DataA           : in     vl_logic_vector(15 downto 0);
        DataB           : in     vl_logic_vector(15 downto 0);
        Add_Sub         : in     vl_logic;
        Result          : out    vl_logic_vector(15 downto 0)
    );
end add_sub_16bit;
