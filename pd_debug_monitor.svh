class pd_debug_monitor extends uvm_monitor;
    `uvm_component_utils(pd_debug_monitor)

    virtual pd_debug_if PD_vif;
    pd_debug_seq_item seq_item;
    pd_debug_config_agt pd_debug_agt_cfg;

    uvm_analysis_port #(pd_debug_seq_item) mon_ap;


    function new(string name = "pd_debug_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction 


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        mon_ap = new ("mon_ap", this);

        if (!uvm_config_db #(pd_debug_config_agt)::get(this, "", "pd_debug_agt_cfg", pd_debug_agt_cfg))
            `uvm_fatal(get_type_name(), "Failed to get config from uvm_config_db")
        PD_vif = pd_debug_agt_cfg.PD_vif;
    endfunction 


    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            repeat(3)begin 
                @(negedge PD_vif.clk);
            end
            PD_vif.get(seq_item);

            `uvm_info("INPUTS", seq_item.convert2string_in(), pd_debug_agt_cfg.monitor_verbosity);
            `uvm_info("OUTPUTS", seq_item.convert2string_out(), pd_debug_agt_cfg.monitor_verbosity);


            mon_ap.write(seq_item);


        end
    endtask
endclass 