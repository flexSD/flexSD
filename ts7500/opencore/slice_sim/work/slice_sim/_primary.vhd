library verilog;
use verilog.vl_types.all;
entity slice_sim is
    port(
        read_back       : in     vl_logic;
        read_back_adr   : in     vl_logic_vector(3 downto 0);
        clock_200       : in     vl_logic;
        reset           : in     vl_logic;
        slice_enable    : in     vl_logic;
        coefficient_read_adr: in     vl_logic_vector(8 downto 0);
        coefficient_write_adr: in     vl_logic_vector(8 downto 0);
        coefficient_write_data: in     vl_logic_vector(35 downto 0);
        coefficient_write_en: in     vl_logic;
        state_write_adr : in     vl_logic_vector(3 downto 0);
        state_read_adr  : in     vl_logic_vector(3 downto 0);
        sigma_delta_stream_A: in     vl_logic;
        sigma_delta_stream_B: in     vl_logic;
        log_trigger     : in     vl_logic;
        sigma_delta_out_trigger: in     vl_logic;
        sigma_delta_out_adr: in     vl_logic_vector(3 downto 0);
        overflow_stage_1: out    vl_logic;
        overflow_stage_2: out    vl_logic;
        log_value_out   : out    vl_logic_vector(23 downto 0);
        sigma_delta_out : out    vl_logic_vector(23 downto 0)
    );
end slice_sim;
