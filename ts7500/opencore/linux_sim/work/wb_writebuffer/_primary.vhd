library verilog;
use verilog.vl_types.all;
entity wb_writebuffer is
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        wb_adr_i        : in     vl_logic_vector(31 downto 0);
        wb_dat_i        : in     vl_logic_vector(31 downto 0);
        wb_dat_o        : out    vl_logic_vector(31 downto 0);
        wb_cyc_i        : in     vl_logic;
        wb_stb_i        : in     vl_logic;
        wb_we_i         : in     vl_logic;
        wb_ack_o        : out    vl_logic;
        wb_sel_i        : in     vl_logic_vector(3 downto 0);
        wbm_adr_o       : out    vl_logic_vector(31 downto 0);
        wbm_dat_i       : in     vl_logic_vector(31 downto 0);
        wbm_dat_o       : out    vl_logic_vector(31 downto 0);
        wbm_cyc_o       : out    vl_logic;
        wbm_stb_o       : out    vl_logic;
        wbm_we_o        : out    vl_logic;
        wbm_ack_i       : in     vl_logic;
        wbm_sel_o       : out    vl_logic_vector(3 downto 0);
        flushreq_i      : in     vl_logic;
        flushack_o      : out    vl_logic
    );
end wb_writebuffer;
