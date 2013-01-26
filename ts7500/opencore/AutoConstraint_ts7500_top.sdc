
#Begin clock constraint
define_clock -name {p:ts7500_top|fpga_25mhz_pad} -period 4.450 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 2.225 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {n:pll|CLKOP_inferred_clock} -period 3.989 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 1.995 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {n:syscon_3s_29952_0_5_Z1|internal_osc_o_inferred_clock} -period 3.042 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 1.521 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {p:ts7500_top|spi_clk_pad} -period 6.586 -clockgroup Autoconstr_clkgroup_3 -rise 0.000 -fall 3.293 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {n:pll2|CLKOP_inferred_clock} -period 1.390 -clockgroup Autoconstr_clkgroup_4 -rise 0.000 -fall 0.695 -route 0.000 
#End clock constraint
