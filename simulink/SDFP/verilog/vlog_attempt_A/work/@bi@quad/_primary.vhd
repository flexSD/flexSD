library verilog;
use verilog.vl_types.all;
entity BiQuad is
    generic(
        GAIN_FWD        : integer := 1;
        GAIN_BCK        : integer := 1;
        GAIN_TS         : integer := 1;
        GAIN_K          : integer := 1;
        FWD_WIDTH       : integer := 12;
        BCK_WIDTH       : integer := 12;
        STG_WIDTH       : integer := 12;
        OUT_WIDTH       : integer := 12
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        in_prev_stage   : in     vl_logic_vector;
        in_fwd          : in     vl_logic_vector;
        in_bck          : in     vl_logic_vector;
        out_s           : out    vl_logic_vector
    );
end BiQuad;
