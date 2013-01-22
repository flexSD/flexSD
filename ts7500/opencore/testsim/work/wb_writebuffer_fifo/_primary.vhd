library verilog;
use verilog.vl_types.all;
entity wb_writebuffer_fifo is
    port(
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(67 downto 0);
        q               : out    vl_logic_vector(67 downto 0);
        wrreq           : in     vl_logic;
        rdreq           : in     vl_logic;
        empty           : out    vl_logic;
        full            : out    vl_logic;
        sclr            : in     vl_logic
    );
end wb_writebuffer_fifo;
