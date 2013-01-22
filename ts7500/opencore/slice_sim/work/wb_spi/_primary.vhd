library verilog;
use verilog.vl_types.all;
entity wb_spi is
    generic(
        hispeed_opt     : integer := 1;
        lospeed_opt     : integer := 1
    );
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        wb_cyc_i        : in     vl_logic;
        wb_stb_i        : in     vl_logic;
        wb_we_i         : in     vl_logic;
        wb_adr_i        : in     vl_logic_vector(31 downto 0);
        wb_dat_i        : in     vl_logic_vector(15 downto 0);
        wb_sel_i        : in     vl_logic_vector(1 downto 0);
        wb_dat_o        : out    vl_logic_vector(15 downto 0);
        wb_ack_o        : out    vl_logic;
        sck_i           : in     vl_logic;
        sck_o           : out    vl_logic;
        scken_o         : out    vl_logic;
        so_o            : out    vl_logic;
        si_i            : in     vl_logic_vector(3 downto 0);
        csn_o           : out    vl_logic_vector(3 downto 0);
        hispeed_o       : out    vl_logic
    );
end wb_spi;
