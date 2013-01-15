lappend auto_path "/usr/local/diamond/1.2/data/script"
package require simulation_generation
set ::bali::simulation::Para(PROJECT) slice_sim
set ::bali::simulation::Para(PROJECTPATH) "/usr7/research/dkouba/project_development/verilog/controlsystem/ts7500/opencore"
set ::bali::simulation::Para(FILELIST) {"wb_resync.v" "syscon.v" "wb_spi.v" "wb_arbiter.v" "wb_writebuffer.v" "spi_sbus.v" "ts7500_top.v" "tagmem.v" "pll2.v" "pll.v" "coefficient_blockram.v" "coefficient_memwindow.v" "logging_bram.v" "logging_memwindow.v" "adc_buffer.v" "biquad_filter_32bit.v" "wb_biquad_interface_128.v" "sigma_delta_buffer_filter.v" "spi_module.v" "pga_control.v" "lattice_ram_36bit_512.v" "lattice_ram_24bit_16word.v" }
set ::bali::simulation::Para(GLBINCLIST) {}
set ::bali::simulation::Para(INCLIST) {"none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none" "none"}
set ::bali::simulation::Para(WORKLIBLIST) {"" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" }
set ::bali::simulation::Para(COMPLIST) {"VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" "VERILOG" }
set ::bali::simulation::Para(SIMLIBLIST) {pmi_work ovi_xp2}
set ::bali::simulation::Para(MACROLIST) {}
::bali::simulation::ModelSim_Run
