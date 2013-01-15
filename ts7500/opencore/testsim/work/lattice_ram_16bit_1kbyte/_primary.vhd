library verilog;
use verilog.vl_types.all;
entity lattice_ram_16bit_1kbyte is
    port(
        DataInA         : in     vl_logic_vector(15 downto 0);
        DataInB         : in     vl_logic_vector(15 downto 0);
        AddressA        : in     vl_logic_vector(9 downto 0);
        AddressB        : in     vl_logic_vector(9 downto 0);
        ClockA          : in     vl_logic;
        ClockB          : in     vl_logic;
        ClockEnA        : in     vl_logic;
        ClockEnB        : in     vl_logic;
        WrA             : in     vl_logic;
        WrB             : in     vl_logic;
        ResetA          : in     vl_logic;
        ResetB          : in     vl_logic;
        QA              : out    vl_logic_vector(15 downto 0);
        QB              : out    vl_logic_vector(15 downto 0)
    );
end lattice_ram_16bit_1kbyte;
