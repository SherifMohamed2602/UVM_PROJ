vlog -f run.f

vsim -c work.TOP +UVM_TESTNAME=pd_debug_count_test -do "run -all;"