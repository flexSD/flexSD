library verilog;
use verilog.vl_types.all;
entity logging_memwindow is
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        sbus_wb_cyc_i   : in     vl_logic;
        sbus_wb_stb_i   : in     vl_logic;
        sbus_wb_we_i    : in     vl_logic;
        sbus_wb_adr_i   : in     vl_logic_vector(15 downto 0);
        sbus_wb_sel_i   : in     vl_logic_vector(1 downto 0);
        sbus_wb_dat_i   : in     vl_logic_vector(15 downto 0);
        sbus_wb_dat_o   : out    vl_logic_vector(15 downto 0);
        sbus_wb_ack_o   : out    vl_logic;
        lbram_wb_cyc_o  : out    vl_logic;
        lbram_wb_stb_o  : out    vl_logic;
        lbram_wb_adr_o  : out    vl_logic_vector(11 downto 0);
        lbram_wb_dat_i  : in     vl_logic_vector(15 downto 0);
        lbram_wb_ack_i  : in     vl_logic
    );
end logging_memwindow;
