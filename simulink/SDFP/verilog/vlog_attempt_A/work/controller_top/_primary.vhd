library verilog;
use verilog.vl_types.all;
entity controller_top is
    generic(
        P0_WIDTH        : integer := 14;
        P1_WIDTH        : integer := 14;
        P2_WIDTH        : integer := 14;
        P3_WIDTH        : integer := 14;
        Q0_WIDTH        : integer := 14;
        Q1_WIDTH        : integer := 14;
        Q2_WIDTH        : integer := 14;
        MID_STAGE1_WIDTH: integer := 14;
        MID_STAGE2_WIDTH: integer := 14;
        MID_STAGE3_WIDTH: integer := 14;
        OUT_WIDTH       : integer := 16
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        in_P0           : in     vl_logic_vector;
        in_P1           : in     vl_logic_vector;
        in_P2           : in     vl_logic_vector;
        in_P3           : in     vl_logic_vector;
        in_Q0           : in     vl_logic_vector;
        in_Q1           : in     vl_logic_vector;
        in_Q2           : in     vl_logic_vector;
        system_out      : out    vl_logic_vector
    );
end controller_top;
