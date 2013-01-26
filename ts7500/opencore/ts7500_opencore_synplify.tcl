#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology LATTICE-XP2
set_option -part LFXP2_5E
set_option -package TN144C
set_option -speed_grade -5

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency auto
set_option -fanout_limit 100
set_option -auto_constrain_io true
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe false
set_option -force_gsr false
set_option -compiler_compatible true
set_option -dup false


set_option -default_enum_encoding default

#simulation options
set_option -write_verilog true
set_option -write_vhdl true

#timing analysis options
set_option -num_critical_paths 3
set_option -num_startend_points 0

#automatic place and route (vendor) options
set_option -write_apr_constraint 0

#synplifyPro options
set_option -fixgatedclocks 0
set_option -fixgeneratedclocks 0
set_option -update_models_cp 0
set_option -resolve_multiple_driver 1

#-- add_file options
set_option -include_path {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore}
add_file -verilog {/usr/local/diamond/1.2/cae_library/synthesis/verilog/xp2.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/wb_resync.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/syscon.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/wb_spi.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/wb_arbiter.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/wb_writebuffer.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/spi_sbus.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/ts7500_top.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/tagmem.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/pll2.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/pll.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/coefficient_blockram.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/lattice_ram_16bit_4kbyte.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/coefficient_memwindow.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/logging_bram.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/lattice_ram_16bit_8kbyte.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/logging_memwindow.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/adc_buffer.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/biquad_filter_32bit.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/wb_biquad_interface_128.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/sigma_delta_buffer_filter.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/spi_module.v}
add_file -verilog {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/pga_control.v}

#-- top module name
set_option -top_module ts7500_top

#-- set result format/file last
project -result_file {/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore/ts7500_opencore.edi}

#-- error message log file
project -log_file {ts7500_opencore.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run
