library verilog;
use verilog.vl_types.all;
entity recon_filt is
    generic(
        in_bw           : integer := 24;
        filter_bw       : integer := 48;
        alpha           : integer := 7
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        \in\            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
end recon_filt;
