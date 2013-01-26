library verilog;
use verilog.vl_types.all;
entity spi_sbus is
    port(
        wbm_clk_o       : out    vl_logic;
        wbm_adr_o       : out    vl_logic_vector(31 downto 0);
        wbm_cyc_o       : out    vl_logic;
        wbm_stb_o       : out    vl_logic;
        wbm_we_o        : out    vl_logic;
        wbm_sel_o       : out    vl_logic_vector(1 downto 0);
        wbm_dat_o       : out    vl_logic_vector(15 downto 0);
        wbm_dat_i       : in     vl_logic_vector(15 downto 0);
        wbm_ack_i       : in     vl_logic;
        sck_i           : in     vl_logic;
        so_o            : out    vl_logic;
        si_i            : in     vl_logic;
        csn_i           : in     vl_logic;
        sel_i           : in     vl_logic_vector(1 downto 0);
        rst_i           : in     vl_logic
    );
end spi_sbus;
