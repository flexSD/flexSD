library verilog;
use verilog.vl_types.all;
entity slice_sim is
    generic(
        input_bitwidth  : integer := 24;
        full_neg        : vl_notype;
        full_pos        : vl_notype;
        bit_shift       : integer := 6
    );
    port(
        read_back       : in     vl_logic;
        read_back_adr   : in     vl_logic_vector(3 downto 0);
        clock_200       : in     vl_logic;
        clock_20        : in     vl_logic;
        reset           : in     vl_logic;
        slice_enable    : in     vl_logic;
        coefficient_read_adr: in     vl_logic_vector(8 downto 0);
        coefficient_write_adr: in     vl_logic_vector(8 downto 0);
        coefficient_write_data: in     vl_logic_vector(35 downto 0);
        coefficient_write_en: in     vl_logic;
        state_write_adr : in     vl_logic_vector(3 downto 0);
        state_read_adr  : in     vl_logic_vector(3 downto 0);
        log_address     : in     vl_logic_vector(3 downto 0);
        sigma_delta_storage_trigger: in     vl_logic;
        sigma_delta_storage_adr: in     vl_logic_vector(3 downto 0);
        external_sigma_delta_streams: in     vl_logic_vector(3 downto 0);
        external_bitstream_read_address: in     vl_logic_vector(1 downto 0);
        overflow_stage_1: out    vl_logic;
        overflow_stage_2: out    vl_logic;
        log_value_reconstructed: out    vl_logic_vector(23 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of input_bitwidth : constant is 1;
    attribute mti_svvh_generic_type of full_neg : constant is 3;
    attribute mti_svvh_generic_type of full_pos : constant is 3;
    attribute mti_svvh_generic_type of bit_shift : constant is 1;
end slice_sim;
