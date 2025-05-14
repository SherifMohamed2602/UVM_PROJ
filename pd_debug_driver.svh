class pd_debug_driver extends uvm_driver #(pd_debug_seq_item);
    `uvm_component_utils(pd_debug_driver)

    virtual pd_debug_if PD_vif;
    pd_debug_seq_item seq_item;
    pd_debug_config_agt pd_debug_agt_cfg;



    function new(string name = "pd_debug_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        if (!uvm_config_db #(pd_debug_config_agt)::get(this, "", "pd_debug_agt_cfg", pd_debug_agt_cfg))
            `uvm_fatal(get_type_name(), "Failed to get config from uvm_config_db")
        PD_vif = pd_debug_agt_cfg.PD_vif;
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            seq_item_port.get_next_item(seq_item);
            PD_vif.send(seq_item);
            seq_item_port.item_done();
            `uvm_info("run_phase", "Seq item sent form driver", UVM_HIGH);

            `uvm_info("run_phase", seq_item.convert2string(), UVM_LOW);

            repeat(pd_debug_agt_cfg.driving_cycles)begin 
                @(negedge PD_vif.clk);
            end

        end
    endtask
endclass 

