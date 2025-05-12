
class pd_debug_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(pd_debug_scoreboard)

    uvm_analysis_imp  #(pd_debug_seq_item,  pd_debug_scoreboard) scb_export;

    pd_debug_seq_item seq_item;

    int correct_count, error_count;

    function new(string name = "pd_debug_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scb_export = new("scb_export", this);
    endfunction 

    virtual function void write(input pd_debug_seq_item t);

        pd_debug_seq_item exp;
        exp = pd_debug_seq_item::type_id::create("exp");
        predictor(t, exp);

        automatic bit mismatch = 0;

        if ((t.dbg2cif_e_debug_pd_field1_cnt_inc !== exp.dbg2cif_e_debug_pd_field1_cnt_inc) ||
            (t.dbg2cif_e_debug_pd_field1_byte_cnt_inc !== exp.dbg2cif_e_debug_pd_field1_byte_cnt_inc)) 
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in field1 counters, 
                        Recieved by the DUT _cnt_inc: %0b, _byte_cnt_inc: %0b, 
                        While the reference _cnt_inc: %0b, _byte_cnt_inc: %0b", t.dbg2cif_e_debug_pd_field1_cnt_inc,
                         t.dbg2cif_e_debug_pd_field1_byte_cnt_inc, exp.dbg2cif_e_debug_pd_field1_cnt_inc,
                         exp.dbg2cif_e_debug_pd_field1_byte_cnt_inc))
            mismatch = 1;
        end

        if ((t.dbg2cif_e_debug_pd_field2_cnt_inc !== exp.dbg2cif_e_debug_pd_field2_cnt_inc) ||
            (t.dbg2cif_e_debug_pd_field2_byte_cnt_inc !== exp.dbg2cif_e_debug_pd_field2_byte_cnt_inc)) 
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in field2 counters, 
                        Recieved by the DUT _cnt_inc: %0b, _byte_cnt_inc: %0b, 
                        While the reference _cnt_inc: %0b, _byte_cnt_inc: %0b", t.dbg2cif_e_debug_pd_field2_cnt_inc,
                         t.dbg2cif_e_debug_pd_field2_byte_cnt_inc, exp.dbg2cif_e_debug_pd_field2_cnt_inc,
                         exp.dbg2cif_e_debug_pd_field2_byte_cnt_inc))
            mismatch = 1;
        end


        if (t.dbg2cif_e_debug_pd_total_pd_cnt_inc !== exp.dbg2cif_e_debug_pd_total_pd_cnt_inc)
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in total counter, 
                        Recieved by the DUT total_pd_cnt_inc: %0b, 
                        While the reference: %0b", t.dbg2cif_e_debug_pd_total_pd_cnt_inc,
                        exp.dbg2cif_e_debug_pd_total_pd_cnt_inc))
            mismatch = 1;
        end

        if (t.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount !== exp.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount)
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in total byte count increment amount, 
                        Recieved by the DUT: %0b, 
                        While the reference: %0b", t.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount,
                        exp.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount))
            mismatch = 1;
        end

        if ((t.dbg2cif_e_debug_pd_capture_match_cnt_inc !== exp.dbg2cif_e_debug_pd_capture_match_cnt_inc) ||
            (t.dbg2cif_e_debug_pd_capture_match_field1 !== exp.dbg2cif_e_debug_pd_capture_match_field1) || 
            (t.dbg2cif_e_debug_pd_capture_match_field2 !== exp.dbg2cif_e_debug_pd_capture_match_field2) || 
            (t.capture_match_o !== exp.capture_match_o)) 
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in matching flags, 
                        Recieved by the DUT _capture_match_cnt_inc: %0b, _capture_match_field1: %0b, capture_match_field2: %0b, capture_match_o: %0b,
                        While the reference _capture_match_cnt_inc: %0b, _capture_match_field1: %0b, capture_match_field2: %0b, capture_match_o: %0b",
                         t.dbg2cif_e_debug_pd_capture_match_cnt_inc, t.dbg2cif_e_debug_pd_capture_match_field1, 
                         t.dbg2cif_e_debug_pd_capture_match_field2, t.capture_match_o,
                         exp.dbg2cif_e_debug_pd_capture_match_cnt_inc, exp.dbg2cif_e_debug_pd_capture_match_field1
                         exp.dbg2cif_e_debug_pd_capture_match_field2, exp.capture_match_o))
            mismatch = 1;
        end


        if (t.dbg2cif_c_debug_pd_out !== exp.dbg2cif_c_debug_pd_out)
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in pd_out, 
                        Recieved by the DUT: %0b, While the reference: %0b", 
                        t.dbg2cif_c_debug_pd_out, exp.dbg2cif_c_debug_pd_out))
            mismatch = 1;
        end        
        
        if (t.eq_pd_out !== exp.eq_pd_out)
        begin
            `uvm_error(get_type_name(), $sformatf("Comparison failed in cascaded ep_pd, 
                        Recieved by the DUT: %0b, While the reference: %0b",
                        t.eq_pd_out, exp.eq_pd_out))
            mismatch = 1;
        end

        if (mismatch)begin  
            `uvm_error(get_type_name(), "Comparison failed");
            error_count++;
        end
        else begin
            `uvm_info(get_type_name(), "Correct outputs", UVM_HIGH);
            correct_count++;
        end

    endfunction


    virtual task automatic predictor(input pd_debug_seq_item actual, ref pd_debug_seq_item exp);

        // internals for the model
        logic field1_matched  = 0; 
        logic field2_matched  = 0;
        logic capture_trigger = 0;
        static bit field1_captured;
        static bit field2_captured;

        bit cascaded_capture = cascade_capture(actual);

        // default values
        exp.dbg2cif_e_debug_pd_field1_cnt_inc = 0;
        exp.dbg2cif_e_debug_pd_field2_cnt_inc = 0; 
        exp.dbg2cif_e_debug_pd_capture_match_cnt_inc = 0; 
        exp.dbg2cif_e_debug_pd_total_pd_cnt_inc = 0; 
        exp.dbg2cif_e_debug_pd_field1_byte_cnt_inc = 0; 
        exp.dbg2cif_e_debug_pd_field2_byte_cnt_inc = 0; 
        exp.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount = 0;
        exp.dbg2cif_e_debug_pd_capture_match_field1 = 0; 
        exp.dbg2cif_e_debug_pd_capture_match_field2 = 0; 
        exp.capture_match_o = 0;
        exp.dbg2cif_c_debug_pd_out = 0; 
        exp.eq_pd_out = actual.eq_pd;

        // model 
        if (actual.rstn === 0) begin
            exp.dbg2cif_e_debug_pd_field1_cnt_inc = 0;
            exp.dbg2cif_e_debug_pd_field2_cnt_inc = 0; 
            exp.dbg2cif_e_debug_pd_capture_match_cnt_inc = 0; 
            exp.dbg2cif_e_debug_pd_total_pd_cnt_inc = 0; 
            exp.dbg2cif_e_debug_pd_field1_byte_cnt_inc = 0; 
            exp.dbg2cif_e_debug_pd_field2_byte_cnt_inc = 0; 
            exp.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount = 0;
            exp.dbg2cif_e_debug_pd_capture_match_field1 = 0; 
            exp.dbg2cif_e_debug_pd_capture_match_field2 = 0; 
            exp.capture_match_o = 0;
            exp.dbg2cif_c_debug_pd_out = 0; 
            exp.eq_pd_out = 0;
            field1_captured = 0;
            field2_captured = 0;

        end
        else begin
            // Counting model
            exp.dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount = exp.eq_pd[PACKET_SIZE_OFFSET +: PACKET_SIZE_WIDTH]
            if (actual.e_valid && (actual.cif2dbg_c_debug_pd_en_reg_3[0] == 1)) begin 

                exp.dbg2cif_e_debug_pd_total_pd_cnt_inc = 1;

                if ((actual.eq_pd & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3) == 
                (actual.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3 & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3)) begin
                    field1_matched = 1;
                    exp.dbg2cif_e_debug_pd_field1_cnt_inc = 1;
                    exp.dbg2cif_e_debug_pd_field1_byte_cnt_inc = 1;
                end

                if ((actual.eq_pd & actual.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3) == 
                (actual.mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3 & actual.mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3)) begin
                    field2_matched = 1;
                    exp.dbg2cif_e_debug_pd_field2_cnt_inc = 1;
                    exp.dbg2cif_e_debug_pd_field2_byte_cnt_inc = 1;
                end

                if ((actual.cif2dbg_c_debug_pd_en_reg_3[2] == 1) && (actual.eq_pd[113]) || cascaded_capture) begin 
                    exp.dbg2cif_e_debug_pd_capture_match_cnt_inc = 1;
                    capture_trigger = 1;
                end

            end 

            // Capturing model 

            if ((actual.cif2dbg_c_debug_pd_en_reg_3[1] == 1) && (actual.cif2dbg_c_debug_pd_en_reg_3[0] == 1)) begin 
                    
                if (field2_matched) begin
                    if ((actual.cif2dbg_c_debug_pd_en_reg_3[3] == 1) || ((actual.cif2dbg_c_debug_pd_en_reg_3[3] == 0) && !field2_captured)) begin
                        exp.dbg2cif_e_debug_pd_capture_match_field2 = 1;
                        field2_captured = 1;
                        if (actual.cif2dbg_c_debug_pd_captured_word_sel_3[0] == 1) begin 
                            exp.eq_pd_out = select_32(actual.cif2dbg_c_debug_pd_captured_word_sel_3[PD_MUX_SEL_WIDTH:1], actual.eq_pd);
                        end
                    end
                end

                if (field1_matched || capture_trigger) begin
                    if ((actual.cif2dbg_c_debug_pd_en_reg_3[3] == 1) || ((actual.cif2dbg_c_debug_pd_en_reg_3[3] == 0) && !field1_captured)) begin
                        field1_captured = 1;
                        exp.dbg2cif_e_debug_pd_capture_match_field1 = 1;
                        exp.capture_match_o = 1;
                        if (actual.cif2dbg_c_debug_pd_captured_word_sel_3[0] == 0) begin 
                            exp.eq_pd_out = select_32(actual.cif2dbg_c_debug_pd_captured_word_sel_3[PD_MUX_SEL_WIDTH:1], actual.eq_pd);
                        end
                    end
                end
            end 
        end

        exp.eq_pd_out[113] = actual.eq_pd[113] | cascaded_capture;
    
    endtask

    function automatic logic [31:0] select_32 (input logic [(PD_MUX_SEL_WIDTH-1):0] word_sel,
                                            input logic [PD_WIDTH-1:0] eq_pd);

        localparam int num_of_chunks = (PD_WIDTH % 32 == 0) ? (PD_WIDTH / 32) : (PD_WIDTH / 32 + 1);
        localparam int num_zeros_to_pad = (num_of_chunks * 32) - PD_WIDTH;

        int start_select = word_sel * 32;

        logic [(num_of_chunks * 32) - 1:0] eq_pd_padded;
        eq_pd_padded = {{num_zeros_to_pad{1'b0}}, eq_pd};

        return eq_pd_padded[start_select +: 32];

    endfunction


    function automatic bit cascade_capture (input pd_debug_seq_item actual);

        // internals for the model
        logic field1_matched1  = 0; 
        logic field1_matched2  = 0;
        logic capture_trigger1 = 0;
        logic capture_trigger2 = 0;
        static bit field1_captured1;
        static bit field1_captured2;

        if (actual.e_valid && (actual.cif2dbg_c_debug_pd_en_reg_1[0] == 1)) 
            if ((actual.eq_pd & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1) == 
                (actual.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1 & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1))
                field1_matched1 = 1;

        if (actual.e_valid && (actual.cif2dbg_c_debug_pd_en_reg_2[0] == 1)) 
            if ((actual.eq_pd & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2) == 
                (actual.mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2 & actual.mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2))
                field1_matched2 = 1;

        if ((actual.cif2dbg_c_debug_pd_en_reg_1[2] == 1) && actual.eq_pd[113]) 
            capture_trigger1 = 1;

        if ((actual.cif2dbg_c_debug_pd_en_reg_2[2] == 1) && actual.eq_pd[113]) 
            capture_trigger2 = 1;


        if ((actual.cif2dbg_c_debug_pd_en_reg_1[1] == 1) && (actual.cif2dbg_c_debug_pd_en_reg_1[0] == 1)) begin 
            if (field1_matched1 || capture_trigger1) begin
                if ((actual.cif2dbg_c_debug_pd_en_reg_1[3] == 1) || ((actual.cif2dbg_c_debug_pd_en_reg_1[3] == 0) && !field1_captured1)) begin
                    field1_captured1 = 1;
                    return 1;
                end
            end
        end 

        else if ((actual.cif2dbg_c_debug_pd_en_reg_2[1] == 1) && (actual.cif2dbg_c_debug_pd_en_reg_2[0] == 1)) begin 
            if (field1_matched2 || capture_trigger2) begin
                if ((actual.cif2dbg_c_debug_pd_en_reg_2[3] == 1) || ((actual.cif2dbg_c_debug_pd_en_reg_2[3] == 0) && !field1_captured2)) begin
                    field1_captured2 = 1;
                    return 1;
                end
            end
        end 
        else 
        return 0;

    endfunction


    
    virtual function void report_phase (uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase", $sformatf("total successful transcations : %0d", correct_count), UVM_MEDIUM);
        `uvm_info("report_phase", $sformatf("total failed transcations : %0d", error_count), UVM_MEDIUM);
    endfunction

endclass 
