library verilog;
use verilog.vl_types.all;
entity coefficient_memwindow is
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
        cbram_wb_we_o   : out    vl_logic;
        cbram_wb_cyc_o  : out    vl_logic;
        cbram_wb_stb_o  : out    vl_logic;
        cbram_wb_adr_o  : out    vl_logic_vector(10 downto 0);
        cbram_wb_dat_o  : out    vl_logic_vector(15 downto 0);
        cbram_wb_ack_i  : in     vl_logic;
        load_new_coefficients: out    vl_logic;
        done_loading    : in     vl_logic
    );
end coefficient_memwindow;
