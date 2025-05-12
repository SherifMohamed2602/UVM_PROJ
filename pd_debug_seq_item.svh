class pd_debug_seq_item extends uvm_sequence_item;
    `uvm_object_utils(pd_debug_seq_item)


    // Inputs 
    rand logic 			                   rstn;
    rand logic                             e_valid;
    rand logic [PD_WIDTH-1:0]              eq_pd;
    rand logic [PD_WIDTH-1:0]              mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1;

    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2; 
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2;

    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3; 
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3;
    rand logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3;
    rand logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_1; 
    rand logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_2;
    rand logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_3;

    rand logic [PD_MUX_SEL_WIDTH:0] 	   cif2dbg_c_debug_pd_captured_word_sel_1; 
    rand logic [PD_MUX_SEL_WIDTH:0]        cif2dbg_c_debug_pd_captured_word_sel_2; 
    rand logic [PD_MUX_SEL_WIDTH:0]        cif2dbg_c_debug_pd_captured_word_sel_3; 
    
    // Outputs
    logic 			                   dbg2cif_e_debug_pd_field1_cnt_inc;
    logic 			                   dbg2cif_e_debug_pd_field2_cnt_inc; 
    logic 			                   dbg2cif_e_debug_pd_capture_match_cnt_inc; 
    logic 			                   dbg2cif_e_debug_pd_total_pd_cnt_inc; 
    logic 			                   dbg2cif_e_debug_pd_field1_byte_cnt_inc; 
    logic 			                   dbg2cif_e_debug_pd_field2_byte_cnt_inc; 
    logic [PACKET_SIZE_WIDTH-1:0]      dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount;
    logic 			                   dbg2cif_e_debug_pd_capture_match_field1; 
    logic 			                   dbg2cif_e_debug_pd_capture_match_field2; 
    logic 			                   capture_match_o;
    logic [32-1:0] 	                   dbg2cif_c_debug_pd_out; 
    logic [PD_WIDTH-1:0] 		       eq_pd_out;


    function new(string name = "pd_debug_seq_item");
        super.new(name);
    endfunction 

    // virtual function string convert2string();
    //     return $sformatf("%s, rstn = %0b", super.convert2string(), rstn);
    // endfunction

    // virtual function string convert2string_stimulus();
    //     return $sformatf("rstn = %0b, ", rstn);
    // endfunction


    constraint pd_debug_reset_c {
        rstn == 0;
        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 == eq_pd;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1 == eq_pd;
        cif2dbg_c_debug_pd_en_reg_1[0] = 1;
        cif2dbg_c_debug_pd_en_reg_2[0] = 1;
        cif2dbg_c_debug_pd_en_reg_3[0] = 1;
    }

    constraint pd_debug_count_c {
        rstn dist {0:= 10, 1:= 90};
    }



endclass     