create_project rr_lite . -part xc7a35ticsg324-1L -force
set_property target_language Verilog [current_project]
add_files ../rtl/rr_arbiter.v
update_compile_order -fileset sources_1
create_clock -period 4 [current_fileset]    ;# target 250 MHz
launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -to_step report_timing_summary -jobs 4
wait_on_run impl_1
report_utilization    -file util_report.txt
report_timing_summary -file timing_report.txt
quit
