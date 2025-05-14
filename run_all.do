vlog gen_multicycle_debug_data_mux.sv control_pd_debug_with_capture_v3_updated.sv pd_debug_wrapper.sv +cover


vlog pd_depug_pkg.sv pd_depug_if.sv  TOP.sv

vopt +acc TOP -o TOP_final
vsim TOP_final +UVM_TESTNAME=pd_debug_count_test -cover -do "coverage save -onexit count_test.ucdb; run -all; quit -sim"
vsim TOP_final +UVM_TESTNAME=pd_debug_capture_test -cover -do "coverage save -onexit capture_test.ucdb; run -all; quit -sim"
vsim TOP_final +UVM_TESTNAME=pd_debug_capture_first_test -cover -do "coverage save -onexit capture_first_test.ucdb; run -all; quit -sim"
vsim TOP_final +UVM_TESTNAME=pd_debug_cascade_test -cover -do "coverage save -onexit cascade_test.ucdb; run -all; quit -sim"


vcover merge total.ucdb count_test.ucdb capture_test.ucdb capture_first_test.ucdb cascade_test.ucdb


vcover report total.ucdb -details -annotate -all -output total.txt

