library verilog;
use verilog.vl_types.all;
entity FL1P3IY_FUNC is
    port(
        D0              : in     vl_logic;
        D1              : in     vl_logic;
        SP              : in     vl_logic;
        CK              : in     vl_logic;
        SD              : in     vl_logic;
        CD              : in     vl_logic;
        SR              : in     vl_logic;
        notifier        : in     vl_logic;
        Q               : out    vl_logic
    );
end FL1P3IY_FUNC;
