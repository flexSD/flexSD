library verilog;
use verilog.vl_types.all;
entity VLIW_sim is
    generic(
        slice_en_delay  : integer := 3;
        sr_adr_delay    : integer := 3;
        cr_adr_delay    : integer := 3;
        ext_bit_adr_delay: integer := 3;
        sw_adr_delay    : integer := 5;
        sdw_adr_delay   : integer := 5;
        sd_store_delay  : integer := 5;
        log_adr_delay   : integer := 5
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
        ext_bitstream_read_address_1: out    vl_logic_vector(1 downto 0);
        ext_bitstream_read_address_2: out    vl_logic_vector(1 downto 0);
        sigma_delta_write_address_1: out    vl_logic_vector(3 downto 0);
        sigma_delta_write_address_2: out    vl_logic_vector(3 downto 0);
        sigma_delta_storage_trigger_1: out    vl_logic;
        sigma_delta_storage_trigger_2: out    vl_logic;
        logging_trigger_1: out    vl_logic;
        logging_trigger_2: out    vl_logic;
        logging_address_1: out    vl_logic_vector(3 downto 0);
        logging_address_2: out    vl_logic_vector(3 downto 0)
    );
end VLIW_sim;
