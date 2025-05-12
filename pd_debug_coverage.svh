
class pd_debug_coverage extends uvm_subscriber #(pd_debug_seq_item);
        `uvm_component_utils(pd_debug_coverage)

        // uvm_analysis_export #(pd_debug_seq_item) cov_export;
        // uvm_tlm_analysis_fifo #(pd_debug_seq_item) cov_fifo;
        pd_debug_seq_item seq_item;


    covergroup pd_debug_cvg;

        reset_cv : coverpoint seq_item.rstn;

        count_seq_cv   : coverpoint seq_item.e_valid iff (seq_item.rstn);

        count_en1   : coverpoint seq_item.cif2dbg_c_debug_pd_en_reg_1[0] iff (seq_item.rstn);


        // count_seq_cv   : coverpoint seq_item. iff (seq_item.rstn){
        //     bins   =;
        // }


    endgroup

    function new(string name = "pd_debug_coverage", uvm_component parent = null);
        super.new(name, parent);
        pd_debug_cvg = new();
    endfunction


    // virtual function void build_phase(uvm_phase phase);
    //     super.build_phase(phase);
    //     cov_export = new("cov_export", this);
    //     cov_fifo = new("cov_fifo", this);
    // endfunction 

    // virtual function void connect_phase(uvm_phase phase);
    //     super.connect_phase(phase);
    //     cov_export.connect(cov_fifo.analysis_export);
    // endfunction

    // virtual task run_phase(uvm_phase phase);
    //     super.run_phase(phase);

    //     forever begin
    //         cov_fifo.get(seq_item);
    //         pd_debug_cvg.sample();
    //     end
    // endtask


    virtual function void write(input pd_debug_seq_item t);
        seq_item = t;		
        pd_debug_cvg.sample();
    endfunction


  virtual function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE", $sformatf("\n\n\t Functional coverage = %5.2f%%\n",
                                         pd_debug_cvg.get_coverage()), UVM_NONE)
  endfunction

endclass 
    