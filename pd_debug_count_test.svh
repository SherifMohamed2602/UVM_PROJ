class pd_debug_count_test extends pd_debug_base_test;
    `uvm_component_utils(pd_debug_count_test)

    pd_debug_reset_sequence reset_seq;
    pd_debug_count_sequence count_seq;


    function new(string name = "pd_debug_count_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction 


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        reset_seq = pd_debug_reset_sequence::type_id::create("reset_seq");
        count_seq = pd_debug_count_sequence::type_id::create("count_seq");

        phase.phase_done.set_drain_time(this, 10);

        phase.raise_objection(this, get_type_name());
        //reset_sequence
        `uvm_info(get_type_name(), "Reset Sequence Started \n", UVM_LOW);
        reset_seq.init_start(pd_debug_agt_cfg.pd_debug_sqr);
        `uvm_info(get_type_name(), "Reset Sequence Ended \n", UVM_LOW);
        
        //main_sequence
        `uvm_info(get_type_name(), "Stimulus Generation Started", UVM_LOW);

        //Count Sequence
        `uvm_info(get_type_name(), "Count Sequence Started \n", UVM_LOW);
        count_seq.init_start(pd_debug_agt_cfg.pd_debug_sqr);
        `uvm_info(get_type_name(), "Count Sequence Ended \n", UVM_LOW);

        `uvm_info(get_type_name(), "Stimulus Generation Ended", UVM_LOW);

        phase.drop_objection(this, get_type_name());
        
    endtask
endclass