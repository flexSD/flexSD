library verilog;
use verilog.vl_types.all;
entity resync_fifo is
    port(
        wrclk_i         : in     vl_logic;
        wrreq_i         : in     vl_logic;
        data_i          : in     vl_logic_vector(255 downto 0);
        full_wrclk_o    : out    vl_logic;
        rdclk_i         : in     vl_logic;
        rdreq_i         : in     vl_logic;
        q_o             : out    vl_logic_vector(255 downto 0);
        full_rdclk_o    : out    vl_logic;
        rst_i           : in     vl_logic
    );
end resync_fifo;
