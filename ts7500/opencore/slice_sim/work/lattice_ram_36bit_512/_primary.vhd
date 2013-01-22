library verilog;
use verilog.vl_types.all;
entity lattice_ram_36bit_512 is
    port(
        WrAddress       : in     vl_logic_vector(8 downto 0);
        RdAddress       : in     vl_logic_vector(8 downto 0);
        Data            : in     vl_logic_vector(35 downto 0);
        WE              : in     vl_logic;
        RdClock         : in     vl_logic;
        RdClockEn       : in     vl_logic;
        Reset           : in     vl_logic;
        WrClock         : in     vl_logic;
        WrClockEn       : in     vl_logic;
        Q               : out    vl_logic_vector(35 downto 0)
    );
end lattice_ram_36bit_512;
