-lint -suppress 2181,2286

//
// DUT Source Files
gen_multicycle_debug_data_mux.v
control_pd_debug_with_capture_v3.sv
pd_debug_wrapper.sv

//
// UVM Testbench Source Files
pd_depug_pkg.sv
pd_depug_if.sv
TOP.sv

//
// UVM run-time command-line options

//+UVM_TESTNAME=pd_debug_count_test


//+UVM_VERBOSITY=UVM_LOW
//+UVM_VERBOSITY=UVM_MEDIUM
//+UVM_VERBOSITY=UVM_HIGH