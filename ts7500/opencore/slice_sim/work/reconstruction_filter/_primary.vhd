library verilog;
use verilog.vl_types.all;
entity reconstruction_filter is
    generic(
        in_bw           : integer := 24;
        filter_bw       : integer := 48;
        alpha           : integer := 7;
        three_alpha     : integer := 21
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        bitstream_in    : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
end reconstruction_filter;
