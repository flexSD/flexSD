library verilog;
use verilog.vl_types.all;
entity pga_control is
    port(
        clk50           : in     vl_logic;
        wb_rst          : in     vl_logic;
        set_vos         : in     vl_logic;
        set_gain        : in     vl_logic;
        offset          : in     vl_logic_vector(4 downto 0);
        gain            : in     vl_logic_vector(3 downto 0);
        shdn            : in     vl_logic;
        meas            : in     vl_logic;
        ready           : out    vl_logic;
        pga_dat         : out    vl_logic;
        pga_clk         : out    vl_logic
    );
end pga_control;
