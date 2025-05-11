
class pd_debug_sequencer extends uvm_sequencer #(pd_debug_seq_item);
    `uvm_component_utils(pd_debug_sequencer)

    function new(string name = "pd_debug_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass 