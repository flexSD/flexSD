library verilog;
use verilog.vl_types.all;
entity lattice_sin_cos_table is
    port(
        Clock           : in     vl_logic;
        ClkEn           : in     vl_logic;
        Reset           : in     vl_logic;
        Theta           : in     vl_logic_vector(9 downto 0);
        Sine            : out    vl_logic_vector(23 downto 0)
    );
end lattice_sin_cos_table;
