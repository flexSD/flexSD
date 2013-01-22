library verilog;
use verilog.vl_types.all;
entity spi_module is
    port(
        clk25           : in     vl_logic;
        reset           : in     vl_logic;
        led_en          : in     vl_logic_vector(1 downto 0);
        led_val         : in     vl_logic_vector(1 downto 0);
        cal_mux         : in     vl_logic_vector(3 downto 0);
        pga_cs          : in     vl_logic_vector(3 downto 0);
        shiftreg_update : in     vl_logic;
        dac_packet      : in     vl_logic_vector(23 downto 0);
        dac_send        : in     vl_logic;
        spi_dat_o       : out    vl_logic;
        dac_cs_o        : out    vl_logic;
        shiftreg_clr_o  : out    vl_logic;
        shiftreg_outputreg_clk_o: out    vl_logic
    );
end spi_module;
