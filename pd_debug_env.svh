
class pd_debug_env extends uvm_env;
    `uvm_component_utils(pd_debug_env)

    pd_debug_agent pd_debug_agt;
    pd_debug_scoreboard pd_debug_scb;
    pd_debug_coverage pd_debug_cov;
    pd_debug_config_env pd_debug_env_cfg;

    function new(string name = "pd_debug_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        pd_debug_agt = pd_debug_agent::type_id::create("pd_debug_agt", this);

        if(!uvm_config_db #(pd_debug_config_env)::get(this, "", "pd_debug_env_cfg", pd_debug_env_cfg))
            `uvm_fatal("build_phase", "TEST - unable to get the configuration object from the uvm_config_db");

        if(pd_debug_env_cfg.enable_scoreboard) begin 
            pd_debug_scb = pd_debug_scoreboard::type_id::create("pd_debug_scb", this);
        end
        if(pd_debug_env_cfg.enable_coverage) begin 
            pd_debug_cov = pd_debug_coverage::type_id::create("pd_debug_cov", this);
        end 

        uvm_config_db #(pd_debug_config_agt)::set(this, "pd_debug_agt*", "pd_debug_agt_cfg", pd_debug_env_cfg.pd_debug_agt_cfg);

    endfunction 

    virtual function void connect_phase(uvm_phase phase);

        if(pd_debug_env_cfg.enable_scoreboard) begin 
            pd_debug_agt.agt_ap.connect(pd_debug_scb.scb_export);
        end
        if(pd_debug_env_cfg.enable_coverage) begin 
            pd_debug_agt.agt_ap.connect(pd_debug_cov.analysis_export);
        end
    endfunction

endclass 

