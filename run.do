vlog -f run.f

vopt +acc TOP -o TOP_final
vsim TOP_final +UVM_TESTNAME=pd_debug_capture_test -do "run -all;"

