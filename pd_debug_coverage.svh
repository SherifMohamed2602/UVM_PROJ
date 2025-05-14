
class pd_debug_coverage extends uvm_subscriber #(pd_debug_seq_item);
        `uvm_component_utils(pd_debug_coverage)

        // uvm_analysis_export #(pd_debug_seq_item) cov_export;
        // uvm_tlm_analysis_fifo #(pd_debug_seq_item) cov_fifo;
        pd_debug_seq_item seq_item;


    covergroup pd_debug_cvg;

        reset_cv : coverpoint seq_item.rstn;

        //count_seq_cv : coverpoint seq_item.e_valid iff (seq_item.rstn);

        count_en : coverpoint (seq_item.cif2dbg_c_debug_pd_en_reg_3[0] && seq_item.e_valid)  iff (seq_item.rstn);

        match_field1 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3))  iff (seq_item.rstn);

        match_field2 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 & seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3))  iff (seq_item.rstn);

        count_field1 : cross count_en, match_field1;

        count_field2 : cross count_en, match_field2;

        capture_last_en : coverpoint (seq_item.cif2dbg_c_debug_pd_en_reg_3[1] && seq_item.cif2dbg_c_debug_pd_en_reg_3[3])  iff (seq_item.rstn);
        capture_first_en : coverpoint (seq_item.cif2dbg_c_debug_pd_en_reg_3[1] && ~seq_item.cif2dbg_c_debug_pd_en_reg_3[3])  iff (seq_item.rstn);

        capture_trigger_en : coverpoint (seq_item.cif2dbg_c_debug_pd_en_reg_3[2] && seq_item.eq_pd[113])  iff (seq_item.rstn);

        capture_field1_last : cross capture_last_en, count_en, match_field1;

        capture_field1_first : cross capture_last_en, count_en, match_field1;

        capture_trigger : cross capture_trigger_en, count_en {ignore_bins invalid_combinations = binsof(capture_trigger_en) intersect {1} && binsof (count_en) intersect {0};} 

        capture_field2_last : cross capture_last_en, count_en, match_field2;

        capture_field2_first : cross capture_last_en, count_en, match_field2;

        cascade1 : coverpoint (seq_item.e_valid && seq_item.cif2dbg_c_debug_pd_en_reg_1[0] && seq_item.cif2dbg_c_debug_pd_en_reg_1[1] && ~seq_item.eq_pd[113] )  iff (seq_item.rstn);
        cascade2 : coverpoint (seq_item.e_valid && seq_item.cif2dbg_c_debug_pd_en_reg_2[0] && seq_item.cif2dbg_c_debug_pd_en_reg_2[1] && ~seq_item.eq_pd[113] )  iff (seq_item.rstn);

        match_instance1 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1))  iff (seq_item.rstn);

        match_instance2 : coverpoint ((seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2 & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2) == (seq_item.eq_pd & seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2))  iff (seq_item.rstn);

        cascade_from_instance1 : cross cascade1, match_instance1 {ignore_bins invalid_combinations = binsof(cascade1) intersect {0} && binsof (match_instance1) intersect {1};} 
        cascade_from_instance2 : cross cascade2, match_instance2 {ignore_bins invalid_combinations = binsof(cascade2) intersect {0} && binsof (match_instance2) intersect {1};} 


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
    