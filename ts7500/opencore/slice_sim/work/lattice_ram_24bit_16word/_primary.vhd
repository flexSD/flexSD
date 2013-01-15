library verilog;
use verilog.vl_types.all;
entity lattice_ram_24bit_16word is
    port(
        WrAddress       : in     vl_logic_vector(3 downto 0);
        Data            : in     vl_logic_vector(23 downto 0);
        WrClock         : in     vl_logic;
        WE              : in     vl_logic;
        WrClockEn       : in     vl_logic;
        RdAddress       : in     vl_logic_vector(3 downto 0);
        Q               : out    vl_logic_vector(23 downto 0)
    );
end lattice_ram_24bit_16word;
