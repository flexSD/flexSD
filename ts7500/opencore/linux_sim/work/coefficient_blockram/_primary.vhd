library verilog;
use verilog.vl_types.all;
entity coefficient_blockram is
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        cmemwin_wb_adr_i: in     vl_logic_vector(10 downto 0);
        cmemwin_wb_dat_i: in     vl_logic_vector(15 downto 0);
        cmemwin_wb_cyc_i: in     vl_logic;
        cmemwin_wb_stb_i: in     vl_logic;
        cmemwin_wb_ack_o: out    vl_logic;
        cmemwin_wb_we_i : in     vl_logic;
        biquad_wb_cyc_i : in     vl_logic;
        biquad_wb_stb_i : in     vl_logic;
        biquad_wb_adr_i : in     vl_logic_vector(8 downto 0);
        biquad_wb_dat_o : out    vl_logic_vector(63 downto 0);
        biquad_wb_ack_o : out    vl_logic
    );
end coefficient_blockram;
