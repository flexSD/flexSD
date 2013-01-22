library verilog;
use verilog.vl_types.all;
entity sigma_delta_buffer_filter is
    port(
        decimation_clk  : in     vl_logic;
        dac_clk         : in     vl_logic;
        adc_clk         : in     vl_logic;
        reset           : in     vl_logic;
        sigmaDeltaIn    : in     vl_logic;
        dac_sdo         : out    vl_logic;
        dac_cs          : out    vl_logic
    );
end sigma_delta_buffer_filter;
