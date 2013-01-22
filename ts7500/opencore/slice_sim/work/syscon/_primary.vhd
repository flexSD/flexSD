library verilog;
use verilog.vl_types.all;
entity syscon is
    generic(
        wdog_default    : integer := 2
    );
    port(
        wb_clk_i        : in     vl_logic;
        wb_rst_i        : in     vl_logic;
        wb_cyc_i        : in     vl_logic;
        wb_stb_i        : in     vl_logic;
        wb_we_i         : in     vl_logic;
        wb_adr_i        : in     vl_logic_vector(31 downto 0);
        wb_dat_i        : in     vl_logic_vector(15 downto 0);
        wb_sel_i        : in     vl_logic_vector(1 downto 0);
        wb_dat_o        : out    vl_logic_vector(15 downto 0);
        wb_ack_o        : out    vl_logic;
        rtc_sda_o       : out    vl_logic;
        rtc_sda_i       : in     vl_logic;
        rtc_sda_oe_o    : out    vl_logic;
        rtc_scl_o       : out    vl_logic;
        rtc_scl_i       : in     vl_logic;
        rtc_scl_oe_o    : out    vl_logic;
        cpu_uart_rxd_o  : out    vl_logic;
        cpu_uart_txd_i  : in     vl_logic;
        internal_osc_o  : out    vl_logic;
        clk_100mhz_i    : in     vl_logic;
        reboot_o        : out    vl_logic;
        led_grn_o       : out    vl_logic;
        led_red_o       : out    vl_logic;
        mode1_i         : in     vl_logic;
        mode2_i         : in     vl_logic;
        mode3_i         : in     vl_logic;
        pllphase_o      : out    vl_logic_vector(4 downto 0)
    );
end syscon;
