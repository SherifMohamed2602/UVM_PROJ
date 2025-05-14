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


    // used flags
    
    rand bit match_field1;
    rand bit match_field2;



    function new(string name = "pd_debug_seq_item");
        super.new(name);
    endfunction 

    virtual function string convert2string_in();
        return $sformatf("\nInputs:  \nrstn = %b, \ne_valid = %b, \neq_pd = %h, eq_pd[113] = %b\n
Inputs to Second instance: \nfield1_val_1 = %h, \nfield1_mask_1 = %h, \nfield2_val_1 = %h, \nfield2_mask_1 = %h, \nen_reg_1 = %b, \ncaptured_word_sel_1 = %d, \n
Inputs to Second instance: \nfield1_val_2 = %h, \nfield1_mask_2 = %h, \nfield2_val_2 = %h, \nfield2_mask_2 = %h, \nen_reg_2 = %b, \ncaptured_word_sel_2 = %d, \n
Inputs to third instance: \nfield1_val_3 = %h, \nfield1_mask3 = %h, \nfield2_val_3 = %h, \nfield2_mask3 = %h, \nen_reg_3 = %b, \ncaptured_word_sel_3 = %d \n",
            rstn,
            e_valid,
            eq_pd,
            eq_pd[113],
            mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1,
            mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1,
            mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1,
            mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1,
            cif2dbg_c_debug_pd_en_reg_1,
            cif2dbg_c_debug_pd_captured_word_sel_1,
            mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2,
            mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2,
            mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2,
            mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2,
            cif2dbg_c_debug_pd_en_reg_2,
            cif2dbg_c_debug_pd_captured_word_sel_2,
            mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3,
            cif2dbg_c_debug_pd_en_reg_3,
            cif2dbg_c_debug_pd_captured_word_sel_3
);

    endfunction

    virtual function string convert2string_out();
        return $sformatf("\nOutputs of the wrapper: \nf1_cnt_inc = %b, \nf2_cnt_inc = %b, \ncapture_match_cnt_inc = %b, \ntotal_pd_cnt_inc = %b, \nf1_byte_cnt_inc = %b, \nf2_byte_cnt_inc = %b, \nbyte_cnt_amount = %h, \ncapture_match_f1 = %b, \ncapture_match_f2 = %b, \ncapture_match_o = %b, \npd_out = %h, \neq_pd_out = %h,\neq_pd_out[113] = %b \n",
            dbg2cif_e_debug_pd_field1_cnt_inc,
            dbg2cif_e_debug_pd_field2_cnt_inc,
            dbg2cif_e_debug_pd_capture_match_cnt_inc,
            dbg2cif_e_debug_pd_total_pd_cnt_inc,
            dbg2cif_e_debug_pd_field1_byte_cnt_inc,
            dbg2cif_e_debug_pd_field2_byte_cnt_inc,
            dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount,
            dbg2cif_e_debug_pd_capture_match_field1,
            dbg2cif_e_debug_pd_capture_match_field2,
            capture_match_o,
            dbg2cif_c_debug_pd_out,
            eq_pd_out,
            eq_pd_out[113]
  );
    endfunction


    constraint pd_debug_reset_c {
        rstn == 0;
        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 == eq_pd;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 == eq_pd;
        cif2dbg_c_debug_pd_en_reg_1[0] == 1;
        cif2dbg_c_debug_pd_en_reg_2[0] == 1;
        cif2dbg_c_debug_pd_en_reg_3[0] == 1;
    }


    constraint pd_debug_count_c {
        rstn  == 1;
        e_valid dist {0:/ 30, 1:/ 70};

        match_field1 dist {0:/ 50, 1:/ 50};
        match_field2 dist {0:/ 50, 1:/ 50};

        (match_field1) -> (mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3) == (eq_pd & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3);

        (match_field2) -> (mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3) == (eq_pd & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3);
    }

    constraint pd_debug_capture_off_c {

        cif2dbg_c_debug_pd_en_reg_3[0] == 1;
        cif2dbg_c_debug_pd_en_reg_3[1] == 0;
        cif2dbg_c_debug_pd_en_reg_3[2] == 0;

    }

    constraint pd_debug_capture_always_on_c {
        
        cif2dbg_c_debug_pd_en_reg_3 == 4'b1111;
        // cif2dbg_c_debug_pd_captured_word_sel_3[0] == 0;

    }

    constraint pd_debug_capture_last_on_c {
        
        cif2dbg_c_debug_pd_en_reg_3 == 4'b0111;
        // cif2dbg_c_debug_pd_captured_word_sel_3[0] == 0;

    }


    constraint pd_debug_cascade_bug_c {
        rstn == 1;
        e_valid == 1;
        eq_pd[113] == 0;
        (match_field1) -> (mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3) == (eq_pd & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3);
        (match_field2) -> (mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3) == (eq_pd & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3);
        
        (mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1) == (eq_pd & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1);

        cif2dbg_c_debug_pd_en_reg_1 == 4'b1111;
        cif2dbg_c_debug_pd_en_reg_2 == 4'b0001;
        cif2dbg_c_debug_pd_en_reg_3 == 4'b0001;
        //cif2dbg_c_debug_pd_captured_word_sel_3[0] == 0;

    }



endclass     