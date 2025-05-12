
class pd_debug_agent extends uvm_agent;
    `uvm_component_utils(pd_debug_agent)

    uvm_analysis_port #(pd_debug_seq_item) agt_ap;

    pd_debug_driver pd_debug_drv;
    //pd_debug_sequencer pd_debug_sqr;
    uvm_sequencer #(pd_debug_seq_item) pd_debug_sqr;
    pd_debug_monitor pd_debug_mon;
    pd_debug_config_agt pd_debug_agt_cfg;


    function new(string name = "pd_debug_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction 

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        pd_debug_mon = pd_debug_monitor::type_id::create("pd_debug_mon", this);

        agt_ap = new ("agt_ap", this);

        if(!uvm_config_db #(pd_debug_config_agt)::get(this, "", "pd_debug_agt_cfg", pd_debug_agt_cfg))
            `uvm_fatal("build_phase", "TEST - unable to get the configuration object from the uvm_config_db");
        
        if (pd_debug_agt_cfg.pd_debug_agent_state == UVM_ACTIVE) begin
            pd_debug_drv = pd_debug_driver::type_id::create("pd_debug_drv", this);
            pd_debug_sqr = new("pd_debug_sqr", this);
        end

        pd_debug_agt_cfg.pd_debug_sqr = this.pd_debug_sqr;
    endfunction 

    virtual function void connect_phase(uvm_phase phase);
        if (pd_debug_agt_cfg.pd_debug_agent_state == UVM_ACTIVE) begin
            pd_debug_drv.seq_item_port.connect(pd_debug_sqr.seq_item_export);
        end
        pd_debug_mon.mon_ap.connect(agt_ap);


    endfunction

endclass 
