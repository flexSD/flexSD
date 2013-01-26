library verilog;
use verilog.vl_types.all;
entity recon_sigdel_tb is
    generic(
        input_bitwidth  : integer := 24;
        ramp_bits_add   : integer := 10;
        delay           : integer := 4
    );
end recon_sigdel_tb;
