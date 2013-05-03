library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        BW              : integer := 24
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \in\            : in     vl_logic;
        fbin            : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
end controller;
