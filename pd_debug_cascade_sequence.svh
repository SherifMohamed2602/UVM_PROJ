class pd_debug_cascade_sequence extends uvm_sequence #(pd_debug_seq_item);
    `uvm_object_utils(pd_debug_cascade_sequence)
    pd_debug_seq_item seq_item ;

    function new(string name = "pd_debug_cascade_sequence");
        super.new(name);
    endfunction 

    virtual task init_start(input uvm_sequencer #(pd_debug_seq_item) pd_debug_sqr);
        this.start(pd_debug_sqr);
    endtask

    virtual task body;

        `uvm_info(get_type_name(), "\n    Cascade Test \n", UVM_LOW);

        seq_item = pd_debug_seq_item::type_id::create("seq_item");
        start_item(seq_item);
        seq_item.constraint_mode(0);
        if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
        seq_item.rstn = 0;
        finish_item(seq_item);

        seq_item = pd_debug_seq_item::type_id::create("seq_item");
        start_item(seq_item);
        seq_item.constraint_mode(0);
        seq_item.pd_debug_reset_c.constraint_mode(1);
        if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
        finish_item(seq_item);

        repeat(20) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_cascade_match1_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end

        repeat(20) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_cascade_match2_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end


        repeat(20) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_cascade_trigger_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end



    endtask
endclass 