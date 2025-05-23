class pd_debug_capture_first_sequence extends uvm_sequence #(pd_debug_seq_item);
    `uvm_object_utils(pd_debug_capture_first_sequence)
    pd_debug_seq_item seq_item ;

    function new(string name = "pd_debug_capture_first_sequence");
        super.new(name);
    endfunction 

    virtual task init_start(input uvm_sequencer #(pd_debug_seq_item) pd_debug_sqr);
        this.start(pd_debug_sqr);
    endtask

    virtual task body;

        `uvm_info(get_type_name(), "\n    Capture only first for field1 \n", UVM_LOW);

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

        repeat(5) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_capture_only_first_f1_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end

        repeat(5) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_capture_only_first_f2_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end

        seq_item = pd_debug_seq_item::type_id::create("seq_item");
        start_item(seq_item);
        seq_item.constraint_mode(0);
        if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
        seq_item.rstn = 1;
        seq_item.cif2dbg_c_debug_pd_en_reg_3 = 4'b0000;
        finish_item(seq_item);

        
        repeat(5) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_capture_only_first_f1_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end

        repeat(5) begin
            seq_item = pd_debug_seq_item::type_id::create("seq_item");
            start_item(seq_item);
            seq_item.constraint_mode(0);
            seq_item.pd_debug_capture_only_first_f2_c.constraint_mode(1);
            if(!seq_item.randomize()) `uvm_fatal(get_type_name(), "seq_item::randomize() failed");
            finish_item(seq_item);
        end

        
    endtask
endclass 