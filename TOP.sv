module TOP ();

    import pd_debug_pkg::*;    
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    logic clk;
    always #1 clk = ~clk;


    pd_debug_if PD_if (clk);


    pd_debug_wrapper #(

    .PD_WIDTH(PD_WIDTH),
    .PACKET_SIZE_OFFSET(PACKET_SIZE_OFFSET),
    .PACKET_SIZE_WIDTH(PACKET_SIZE_WIDTH),
    .PD_MUX_SEL_WIDTH(PD_MUX_SEL_WIDTH)

    ) pd_debug_u (
        .clk(clk),
        .CFG_anchor_clk_override,
        .rstn(PD_if.rstn),
        .e_valid(PD_if.e_valid), 
        .eq_pd(PD_if.eq_pd),
        .mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1(PD_if.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1),
        .mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1(PD_if.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1),
        .mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1(PD_if.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1),
        .mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1(PD_if.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1),

        .mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2(PD_if.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2), 
        .mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2(PD_if.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2),
        .mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2(PD_if.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2),
        .mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2(PD_if.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2),

        .mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3(PD_if.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3), 
        .mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3(PD_if.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3),
        .mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3(PD_if.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3),
        .mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3(PD_if.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3),
        .cif2dbg_c_debug_pd_en_reg_1(PD_if.cif2dbg_c_debug_pd_en_reg_1),
        .cif2dbg_c_debug_pd_en_reg_2(PD_if.cif2dbg_c_debug_pd_en_reg_2), 
        .cif2dbg_c_debug_pd_en_reg_3(PD_if.cif2dbg_c_debug_pd_en_reg_3), 

        .cif2dbg_c_debug_pd_captured_word_sel_1(PD_if.cif2dbg_c_debug_pd_captured_word_sel_1), 
        .cif2dbg_c_debug_pd_captured_word_sel_2(PD_if.cif2dbg_c_debug_pd_captured_word_sel_2), 
        .cif2dbg_c_debug_pd_captured_word_sel_3(PD_if.cif2dbg_c_debug_pd_captured_word_sel_3),

        .dbg2cif_e_debug_pd_field1_cnt_inc(PD_if.dbg2cif_e_debug_pd_field1_cnt_inc), 
        .dbg2cif_e_debug_pd_field2_cnt_inc(PD_if.dbg2cif_e_debug_pd_field2_cnt_inc),
        .dbg2cif_e_debug_pd_capture_match_cnt_inc(PD_if.dbg2cif_e_debug_pd_capture_match_cnt_inc), 
        .dbg2cif_e_debug_pd_total_pd_cnt_inc(PD_if.dbg2cif_e_debug_pd_total_pd_cnt_inc),
        .dbg2cif_e_debug_pd_field1_byte_cnt_inc(PD_if.dbg2cif_e_debug_pd_field1_byte_cnt_inc), 
        .dbg2cif_e_debug_pd_field2_byte_cnt_inc(PD_if.dbg2cif_e_debug_pd_field2_byte_cnt_inc),
        .dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount(PD_if.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount),
        .dbg2cif_e_debug_pd_capture_match_field1(PD_if.dbg2cif_e_debug_pd_capture_match_field1), 
        .dbg2cif_e_debug_pd_capture_match_field2(PD_if.dbg2cif_e_debug_pd_capture_match_field2), 
        .capture_match_o(PD_if.capture_match_o), 
        .dbg2cif_c_debug_pd_out(PD_if.dbg2cif_c_debug_pd_out), 
        .eq_pd_out(PD_if.eq_pd_out)
    );

    initial begin

        uvm_config_db #(virtual pd_debug_if)::set(null, "uvm_test_top", "PD_if", PD_if);

        run_test();
    end
endmodule