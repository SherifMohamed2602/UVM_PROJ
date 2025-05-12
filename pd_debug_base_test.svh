class pd_debug_base_test extends uvm_test;
    `uvm_component_utils(pd_debug_base_test)

    pd_debug_env pd_env;
    pd_debug_config_env pd_debug_env_cfg;
    pd_debug_config_agt pd_debug_agt_cfg;


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


        if(!uvm_config_db #(virtual pd_debug_if)::get(this, "", "PD_vif", pd_debug_agt_cfg.PD_vif))
            `uvm_fatal("build_phase", "TEST - unable to get the interface from the uvm_config_db");

        uvm_config_db #(pd_debug_config_env)::set(this, "pd_env", "pd_debug_env_cfg", pd_debug_env_cfg);
        
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology(); 
    endfunction

endclass