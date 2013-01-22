library verilog;
use verilog.vl_types.all;
entity logging_blockram is
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        lmemwin_wb_cyc_i: in     vl_logic;
        lmemwin_wb_stb_i: in     vl_logic;
        lmemwin_wb_adr_i: in     vl_logic_vector(10 downto 0);
        lmemwin_wb_dat_o: out    vl_logic_vector(15 downto 0);
        lmemwin_wb_ack_o: out    vl_logic;
        biquad_wb_cyc_i : in     vl_logic;
        biquad_wb_stb_i : in     vl_logic;
        biquad_wb_adr_i : in     vl_logic_vector(10 downto 0);
        biquad_wb_we_i  : in     vl_logic;
        biquad_wb_dat_i : in     vl_logic_vector(15 downto 0);
        biquad_wb_ack_o : out    vl_logic
    );
end logging_blockram;
