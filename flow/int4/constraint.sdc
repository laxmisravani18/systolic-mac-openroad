current_design systolic
set clk_period 3.0
set clk_port [get_ports clk]
create_clock -name core_clock -period $clk_period $clk_port
set io_ports [lsearch -inline -all -not -exact [all_inputs] $clk_port]
set_input_delay  [expr $clk_period * 0.2] -clock core_clock $io_ports
set_output_delay [expr $clk_period * 0.2] -clock core_clock [all_outputs]
