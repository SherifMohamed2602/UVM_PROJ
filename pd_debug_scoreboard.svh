
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

        predictor(exp)
        if (t.rstn === 0) begin
            
        end

        // else if (t.load_en === 1) begin
        // pd_debug_seq_item exp;

        //     // Copy & store transaction in scoreboard
        //     exp = lab_tx_out::type_id::create("exp");
        //     exp.instruction.opc  = t.opcode;
        //     exp.instruction.op_a = t.operand_a;
        //     exp.instruction.op_b = t.operand_b;
        //     expect_a[t.write_pointer] = exp;
        // end
    endfunction


    virtual task predictor(ref pd_debug_seq_item exp);

            // if ()begin  
            //     `uvm_error("run_phase", $sformatf("Comparison failed, Transaction recieved by the DUT: %s, While the reference out : %0b", seq_item.convert2string(), , ));
            //     error_count++;
            // end
            // else begin
            //     `uvm_info("run_phase", $sformatf("Correct out: %s", seq_item.convert2string()), UVM_HIGH);
            //     correct_count++;
            // end
    
    endtask

    
    virtual function void report_phase (uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase", $sformatf("total successful transcations : %0d", correct_count), UVM_MEDIUM);
        `uvm_info("report_phase", $sformatf("total failed transcations : %0d", error_count), UVM_MEDIUM);
    endfunction

endclass 
