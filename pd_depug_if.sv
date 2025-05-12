interface pd_debug_if(input logic clk);

import pd_debug_pkg::*;    // Transaction classes

//    logic                   CFG_anchor_clk_override,

    logic 			                   rstn;
    logic                              e_valid;
    logic [PD_WIDTH-1:0]               eq_pd;
    logic [PD_WIDTH-1:0]               mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1;

    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2; 
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2;

    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3; 
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3;
    logic [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3;
    logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_1; 
    logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_2;
    logic [3:0] 			           cif2dbg_c_debug_pd_en_reg_3;

    logic [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_1; 
    logic [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_2; 
    logic [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_3; 

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


    task automatic send(pd_debug_seq_item seq_item);

        @(negedge clk);

        rstn    = seq_item.rstn;
        e_valid = seq_item.e_valid;
        eq_pd   = seq_item.eq_pd;

        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1  = seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1;
        mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1   = seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1  = seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1;
        mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1   = seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1;

        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2  = seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2; 
        mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2   = seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2  = seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2;
        mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2   = seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2;

        mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3  = seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3; 
        mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3   = seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3;
        mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3  = seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3;
        mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3   = seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3;

        cif2dbg_c_debug_pd_en_reg_1 = seq_item.cif2dbg_c_debug_pd_en_reg_1; 
        cif2dbg_c_debug_pd_en_reg_2 = seq_item.cif2dbg_c_debug_pd_en_reg_2;
        cif2dbg_c_debug_pd_en_reg_3 = seq_item.cif2dbg_c_debug_pd_en_reg_3;

        cif2dbg_c_debug_pd_captured_word_sel_1 = seq_item.cif2dbg_c_debug_pd_captured_word_sel_1; 
        cif2dbg_c_debug_pd_captured_word_sel_2 = seq_item.cif2dbg_c_debug_pd_captured_word_sel_2; 
        cif2dbg_c_debug_pd_captured_word_sel_3 = seq_item.cif2dbg_c_debug_pd_captured_word_sel_3; 

    endtask


    task automatic get(pd_debug_seq_item seq_item);
        @(negedge clk);
        
        seq_item.rstn = rstn;
        seq_item.e_valid = e_valid;
        seq_item.eq_pd = eq_pd;
        seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 = mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1;
        seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1 = mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1;
        seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1 = mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1;
        seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1 = mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1;

        seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2 = mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2; 
        seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2 = mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2;
        seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2 = mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2;
        seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2 = mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2;

        seq_item.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 = mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3; 
        seq_item.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3 = mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3;
        seq_item.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 = mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3;
        seq_item.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3 = mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3;

        seq_item.cif2dbg_c_debug_pd_en_reg_1 = cif2dbg_c_debug_pd_en_reg_1; 
        seq_item.cif2dbg_c_debug_pd_en_reg_2 = cif2dbg_c_debug_pd_en_reg_2;
        seq_item.cif2dbg_c_debug_pd_en_reg_3 = cif2dbg_c_debug_pd_en_reg_3;

        seq_item.cif2dbg_c_debug_pd_captured_word_sel_1 = cif2dbg_c_debug_pd_captured_word_sel_1; 
        seq_item.cif2dbg_c_debug_pd_captured_word_sel_2 = cif2dbg_c_debug_pd_captured_word_sel_2; 
        seq_item.cif2dbg_c_debug_pd_captured_word_sel_3 = cif2dbg_c_debug_pd_captured_word_sel_3; 


        seq_item.dbg2cif_e_debug_pd_field1_cnt_inc              = dbg2cif_e_debug_pd_field1_cnt_inc; 
        seq_item.dbg2cif_e_debug_pd_field2_cnt_inc              = dbg2cif_e_debug_pd_field2_cnt_inc; 
        seq_item.dbg2cif_e_debug_pd_capture_match_cnt_inc       = dbg2cif_e_debug_pd_capture_match_cnt_inc; 
        seq_item.dbg2cif_e_debug_pd_total_pd_cnt_inc            = dbg2cif_e_debug_pd_total_pd_cnt_inc; 
        seq_item.dbg2cif_e_debug_pd_field1_byte_cnt_inc         = dbg2cif_e_debug_pd_field1_byte_cnt_inc; 
        seq_item.dbg2cif_e_debug_pd_field2_byte_cnt_inc         = dbg2cif_e_debug_pd_field2_byte_cnt_inc; 
        seq_item.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount  = dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount; 
        seq_item.dbg2cif_e_debug_pd_capture_match_field1        = dbg2cif_e_debug_pd_capture_match_field1; 
        seq_item.dbg2cif_e_debug_pd_capture_match_field2        = dbg2cif_e_debug_pd_capture_match_field2; 

        seq_item.capture_match_o        = capture_match_o; 
        seq_item.dbg2cif_c_debug_pd_out = dbg2cif_c_debug_pd_out; 
        seq_item.eq_pd_out              = eq_pd_out; 


    endtask



endinterface