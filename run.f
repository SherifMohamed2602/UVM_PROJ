-lint -suppress 2181,2286

//
// DUT Source Files
RTL/gen_multicycle_debug_data_mux.v
RTL/control_pd_debug_with_capture_v3.v
RTL/pd_debug_wrapper.v

//
// UVM Testbench Source Files
UVM/pd_depug_pkg.sv
UVM/pd_depug_if.sv
UVM/TOP.sv

//
// UVM run-time command-line options

//+UVM_TESTNAME=pd_debug_count_test


//+UVM_VERBOSITY=UVM_LOW
//+UVM_VERBOSITY=UVM_MEDIUM
//+UVM_VERBOSITY=UVM_HIGH