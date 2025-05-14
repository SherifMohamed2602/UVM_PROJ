vlog -f run.f
vopt +acc TOP -o TOP_final
vsim +UVM_TESTNAME=pd_debug_count_test -do "run -all;" TOP_final