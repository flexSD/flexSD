library verilog;
use verilog.vl_types.all;
entity wb_biquad_interface_128 is
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        log_wbm_cyc_o   : out    vl_logic;
        log_wbm_stb_o   : out    vl_logic;
        log_wbm_we_o    : out    vl_logic;
        log_wbm_adr_o   : out    vl_logic_vector(11 downto 0);
        log_wbm_dat_o   : out    vl_logic_vector(15 downto 0);
        log_wbm_ack_i   : in     vl_logic;
        coeff_wbm_cyc_o : out    vl_logic;
        coeff_wbm_stb_o : out    vl_logic;
        coeff_wbm_adr_o : out    vl_logic_vector(7 downto 0);
        coeff_wbm_dat_i : in     vl_logic_vector(127 downto 0);
        coeff_wbm_ack_i : in     vl_logic;
        load_new_coefficients: in     vl_logic;
        done_loading    : out    vl_logic;
        sigmaDeltaInput : in     vl_logic;
        sigmaDeltaOutput: out    vl_logic;
        filter_clk_i    : in     vl_logic
    );
end wb_biquad_interface_128;
