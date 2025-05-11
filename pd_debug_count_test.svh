class pd_debug_count_test extends uvm_test;
    `uvm_component_utils(pd_debug_count_test)

    pd_debug_env pd_env;
    pd_debug_config_env pd_debug_env_cfg;
    pd_debug_config_agt pd_debug_agt_cfg;
    pd_debug_reset_sequence reset_seq;
    pd_debug_count_sequence count_seq;


    function new(string name = "pd_debug_count_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction 

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        pd_env = pd_debug_env::type_id::create("pd_env", this);
        pd_debug_env_cfg = pd_debug_config_env::type_id::create("pd_debug_env_cfg");
        pd_debug_agt_cfg = pd_debug_config_agt::type_id::create("pd_debug_agt_cfg");
        
        pd_debug_env_cfg.pd_debug_agt_cfg = pd_debug_agt_cfg;
        pd_debug_agt_cfg.pd_debug_agent_state = UVM_ACTIVE;

        reset_seq = pd_debug_reset_sequence::type_id::create("reset_seq");
        count_seq = pd_debug_count_sequence::type_id::create("count_seq");

        if(!uvm_config_db #(virtual PD_if)::get(this, "", "PD_if", pd_debug_agt_cfg.PD_vif))
            `uvm_fatal("build_phase", "TEST - unable to get the interface from the uvm_config_db");

        uvm_config_db #(pd_debug_config_env)::set(this, "pd_env", "pd_debug_env_cfg", pd_debug_env_cfg);
        
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology(); 
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);

        phase.phase_done.set_drain_time(this, 10);

        phase.raise_objection(this);
        //reset_sequence
        `uvm_info("run_phase", "Reset Sequence Started", UVM_LOW);
        reset_seq.init_start(pd_debug_agt_cfg.pd_debug_sqr);
        `uvm_info("run_phase", "Reset Sequence Started", UVM_LOW);
        
        //main_sequence
        `uvm_info("run_phase", "Stimulus Generation Started", UVM_LOW);

        //Count Sequence
        `uvm_info("run_phase", "Count Sequence Started", UVM_LOW);
        count_seq.init_start(pd_debug_agt_cfg.pd_debug_sqr);
        `uvm_info("run_phase", "Count Sequence Ended", UVM_LOW);

        `uvm_info("run_phase", "Stimulus Generation Ended", UVM_LOW);


        phase.drop_objection(this);
    endtask
endclass