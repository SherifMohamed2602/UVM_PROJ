
class pd_debug_config_agt extends uvm_object;
    `uvm_object_utils(pd_debug_config_agt)

    virtual pd_debug_if         PD_vif;
    uvm_active_passive_enum     pd_debug_agent_state;

    int monitor_verbosity = UVM_FULL;
    uvm_sequencer #(pd_debug_seq_item) pd_debug_sqr;
    int driving_cycles = 3;

    function new(string name = "pd_debug_config_agt");
        super.new(name);
    endfunction

endclass 

