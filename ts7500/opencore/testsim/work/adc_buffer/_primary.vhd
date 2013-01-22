library verilog;
use verilog.vl_types.all;
entity adc_buffer is
    port(
        reset           : in     vl_logic;
        adc_a_i         : in     vl_logic;
        adc_b_i         : in     vl_logic;
        adc_c_i         : in     vl_logic;
        adc_d_i         : in     vl_logic;
        adc_clk_i       : in     vl_logic;
        buffer_full     : out    vl_logic;
        adc_a_buf_o     : out    vl_logic_vector(31 downto 0);
        adc_b_buf_o     : out    vl_logic_vector(31 downto 0);
        adc_c_buf_o     : out    vl_logic_vector(31 downto 0);
        adc_d_buf_o     : out    vl_logic_vector(31 downto 0)
    );
end adc_buffer;
