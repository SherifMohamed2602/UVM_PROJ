class pd_debug_capture_first_test extends pd_debug_base_test;
    `uvm_component_utils(pd_debug_capture_first_test)

    pd_debug_capture_first_sequence capture_first_seq;

    function new(string name = "pd_debug_capture_first_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction 


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        pd_debug_agt_cfg.driving_cycles = 2;

    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        capture_first_seq = pd_debug_capture_first_sequence::type_id::create("capture_first_seq");

        phase.raise_objection(this, get_type_name());

        //main_sequence
        `uvm_info(get_type_name(), "Stimulus Generation Started", UVM_LOW);

        //Match Sequence
        `uvm_info(get_type_name(), "Capture Sequence Started \n", UVM_LOW);
        capture_first_seq.init_start(pd_debug_agt_cfg.pd_debug_sqr);
        `uvm_info(get_type_name(), "Capture Sequence Ended \n", UVM_LOW);

        `uvm_info(get_type_name(), "Stimulus Generation Ended", UVM_LOW);

        phase.drop_objection(this, get_type_name());
        
    endtask
endclass