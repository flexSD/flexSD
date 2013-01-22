library verilog;
use verilog.vl_types.all;
entity VLIW_sim is
    generic(
        slice_en_delay  : integer := 3;
        sr_adr_delay    : integer := 3;
        cr_adr_delay    : integer := 3;
        sw_adr_delay    : integer := 5;
        sdw_adr_delay   : integer := 5;
        sd_store_delay  : integer := 5;
        log_trig_delay  : integer := 5
    );
    port(
        clock_200       : in     vl_logic;
        reset           : in     vl_logic;
        write_enable    : in     vl_logic;
        vliw_start      : in     vl_logic;
        slice_enable    : out    vl_logic;
        write_address   : in     vl_logic_vector(8 downto 0);
        write_data      : in     vl_logic_vector(71 downto 0);
        coefficient_read_address_1: out    vl_logic_vector(8 downto 0);
        coefficient_read_address_2: out    vl_logic_vector(8 downto 0);
        state_read_address_1: out    vl_logic_vector(3 downto 0);
        state_read_address_2: out    vl_logic_vector(3 downto 0);
        state_write_address_1: out    vl_logic_vector(3 downto 0);
        state_write_address_2: out    vl_logic_vector(3 downto 0);
        sigma_delta_read_address_1: out    vl_logic_vector(3 downto 0);
        sigma_delta_read_address_2: out    vl_logic_vector(3 downto 0);
        sigma_delta_write_address_1: out    vl_logic_vector(3 downto 0);
        sigma_delta_write_address_2: out    vl_logic_vector(3 downto 0);
        logging_trigger_1: out    vl_logic;
        logging_trigger_2: out    vl_logic;
        sigma_delta_storage_trigger_1: out    vl_logic;
        sigma_delta_storage_trigger_2: out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of slice_en_delay : constant is 1;
    attribute mti_svvh_generic_type of sr_adr_delay : constant is 1;
    attribute mti_svvh_generic_type of cr_adr_delay : constant is 1;
    attribute mti_svvh_generic_type of sw_adr_delay : constant is 1;
    attribute mti_svvh_generic_type of sdw_adr_delay : constant is 1;
    attribute mti_svvh_generic_type of sd_store_delay : constant is 1;
    attribute mti_svvh_generic_type of log_trig_delay : constant is 1;
end VLIW_sim;
