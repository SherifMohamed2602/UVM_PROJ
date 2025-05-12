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

    virtual function string convert2string_in3();
        return $sformatf("mem2dbg_field1_val_3= %0h, mask1= %0h, field2_val_3= %0h, mask2= %0h, \n en_reg_3= %0b, captured_word_sel_3= %0d, rstn=%0b, e_valid=%0b, eq_pd= %0h \n",
            mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3,
            mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3,
            cif2dbg_c_debug_pd_en_reg_3,
            cif2dbg_c_debug_pd_captured_word_sel_3,
            rstn,
            e_valid,
            eq_pd);

    endfunction

    virtual function string convert2string_out();
        return $sformatf("f1_cnt_inc=%0b, f2_cnt_inc=%0b, capture_match_cnt_inc=%0b, total_pd_cnt_inc=%0b, f1_byte_cnt_inc=%0b, f2_byte_cnt_inc=%0b, \n byte_cnt_amount=%0h, capture_match_f1=%0b, capture_match_f2=%0b, capture_match_o=%0b, \n pd_out= %0h, eq_pd_out= %0h \n",
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
            eq_pd_out
  );
    endfunction


    constraint pd_debug_reset_c {
        rstn == 0;
        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 == eq_pd;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1 == eq_pd;
        cif2dbg_c_debug_pd_en_reg_1[0] == 1;
        cif2dbg_c_debug_pd_en_reg_2[0] == 1;
        cif2dbg_c_debug_pd_en_reg_3[0] == 1;
    }

    constraint pd_debug_count_c {
        rstn dist {0:/ 10, 1:/ 90};
        //e_valid dist {0:/ 50, 1:/ 50};

    }



endclass     