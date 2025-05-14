
class pd_debug_coverage extends uvm_subscriber #(pd_debug_seq_item);
        `uvm_component_utils(pd_debug_coverage)

        // uvm_analysis_export #(pd_debug_seq_item) cov_export;
        // uvm_tlm_analysis_fifo #(pd_debug_seq_item) cov_fifo;
        pd_debug_seq_item seq_item;


    covergroup pd_debug_cvg;

        reset_cv : coverpoint seq_item.rstn;

        count_seq_cv : coverpoint seq_item.e_valid iff (seq_item.rstn);

        count_en : coverpoint (seq_item.cif2dbg_c_debug_pd_en_reg_1[0] && seq_item.e_valid)  iff (seq_item.rstn);

        match_field1 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3))  iff (seq_item.rstn);

        match_field2 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 & seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3))  iff (seq_item.rstn);

        count_field1 : cross count_en, match_field1;

        count_field2 : cross count_en, match_field2;





    endgroup

    function new(string name = "pd_debug_coverage", uvm_component parent = null);
        super.new(name, parent);
        pd_debug_cvg = new();
    endfunction



    virtual function void write(input pd_debug_seq_item t);
        seq_item = t;		
        pd_debug_cvg.sample();
    endfunction


  virtual function void report_phase(uvm_phase phase);
    `uvm_info("COVERAGE", $sformatf("\n\n\t Functional coverage = %5.2f%%\n",
                                         pd_debug_cvg.get_coverage()), UVM_NONE)
  endfunction

endclass 
    