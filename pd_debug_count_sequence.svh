class pd_debug_count_sequence extends uvm_sequence #(pd_debug_seq_item);
    `uvm_object_utils(pd_debug_count_sequence)
    pd_debug_seq_item seq_item ;

    function new(string name = "pd_debug_count_sequence");
        super.new(name);
    endfunction 

    virtual task init_start(input uvm_sequencer #(pd_debug_seq_item) pd_debug_sqr);
        this.start(pd_debug_sqr);
    endtask

    virtual task body;
        repeat(10) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_count_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            seq_item.rstn = 1;
            finish_item(seq_item);
        end
    endtask
endclass 