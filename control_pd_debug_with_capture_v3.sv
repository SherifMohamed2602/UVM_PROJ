module control_pd_debug_with_capture_v3 #(

  parameter PD_WIDTH = 100, // Width of incoming PD
  parameter PACKET_SIZE_OFFSET = 0, // Offset of the byte count field in the PD
  parameter PACKET_SIZE_WIDTH = 12, // Width of the byte count field in the PD
  parameter PD_MUX_SEL_WIDTH = $clog2(PD_WIDTH/32+ (PD_WIDTH % 32 == 0 ? 0 : 1)), // Width of the index for 32b words in the PD
  parameter DISABLE_LACG = 0 // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.

  )(
  input 			                  clk,
  input 			                  CFG_anchor_clk_override,
  input 			                  rstn,
  input 			                  e_valid, // Input PD valid
  input [PD_WIDTH-1:0] 		      eq_pd, // Input PD data
  input [PD_WIDTH-1:0] 		      mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray, // Matching masks and values
  input [PD_WIDTH-1:0] 		      mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray,
  input [PD_WIDTH-1:0] 		      mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray,
  input [PD_WIDTH-1:0] 		      mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray,
  input [3:0] 			            cif2dbg_c_debug_pd_en_reg, // Configurations
  input 			                  capture_trigger, // Designer can use this bit to perform arbitrary captures to field1
  input [PD_MUX_SEL_WIDTH-1:0] 	cif2dbg_c_debug_pd_captured_word_sel, // Word select for dbg2cif_c_debug_pd_out
  output logic 			         dbg2cif_e_debug_pd_field1_cnt_inc, // Match on field1
  output logic 			         dbg2cif_e_debug_pd_field2_cnt_inc, // Match on field2
  output logic 			         dbg2cif_e_debug_pd_capture_match_cnt_inc, // capture_trigger found
  output logic 			         dbg2cif_e_debug_pd_total_pd_cnt_inc, // Total PDs
  output logic 			         dbg2cif_e_debug_pd_field1_byte_cnt_inc, // Field1 byte counter
  output logic 			         dbg2cif_e_debug_pd_field2_byte_cnt_inc, // Field2 byte counter
  output logic [PACKET_SIZE_WIDTH-1:0] dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount, // Byte count field from PD as designated by PACKET_SIZE_WIDTH and PACKET_SIZE_OFFSET
  output logic 			         dbg2cif_e_debug_pd_capture_match_field1, // Pulse indicating PD has been captured for field1
  output logic 			         dbg2cif_e_debug_pd_capture_match_field2, // Pulse indicating PD has been captured for field2
  output logic 			         capture_match_o, // Pulse indicating PD has been captured for field1. This is available for the designer to use in their pipeline.
  output logic [32-1:0] 	      dbg2cif_c_debug_pd_out // Captured PD field
);
   
   // LACG_MIN_WIDTH should be defined in a project common_defines.v file.
   localparam USE_LACG = 0;
   
   logic [32-1:0] 		       dbg2cif_c_debug_pd_out_field1; // pd captured by capture match on field1 or capture_trigger
   logic [32-1:0] 		       dbg2cif_c_debug_pd_out_field2; // pd captured by capture match on field2
   logic                       pd_capture_event_field1;
   logic                       pd_capture_event_field2;
   logic                       pd_capture_field1;
   logic                       pd_capture_field2;
   logic 			             pd_capture_q_field1;
   logic 			             pd_capture_q_field2;
   logic [PD_WIDTH-1:0] 	    dbg2cif_c_debug_pd_in_field1;
   logic [PD_WIDTH-1:0] 	    dbg2cif_c_debug_pd_in_field2;
   logic [PD_WIDTH-1:0]        dbg2cif_c_debug_pd_in_field1_nxt;
   logic [PD_WIDTH-1:0]        dbg2cif_c_debug_pd_in_field2_nxt;
   
   logic                       capture_match_field1;
   logic                       capture_match_field2;
   
   logic                       cif2dbg_c_debug_pd_en_trigger_match; // enables capture trigger input and capture match output
   logic 		      	       cif2dbg_c_debug_pd_capture_last_en; // capture regardless of whether a PD has already been captured - effectively capture last PD
   logic                       cif2dbg_c_debug_pd_capture_en; // capture on valid
   logic                       cif2dbg_c_debug_pd_en; // enable match counters and capture
   
   assign cif2dbg_c_debug_pd_en = cif2dbg_c_debug_pd_en_reg[0];
   assign cif2dbg_c_debug_pd_capture_en = cif2dbg_c_debug_pd_en_reg[1];
   assign cif2dbg_c_debug_pd_en_trigger_match = cif2dbg_c_debug_pd_en_reg[2]; 
   assign cif2dbg_c_debug_pd_capture_last_en = cif2dbg_c_debug_pd_en_reg[3]; 
   
   assign capture_match_field1 = e_valid && ((eq_pd & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray) == (mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray & mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray));
   assign capture_match_field2 = e_valid && ((eq_pd & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray) == (mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray & mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray));
   
   assign dbg2cif_e_debug_pd_field1_cnt_inc = e_valid && capture_match_field1 && cif2dbg_c_debug_pd_en;
   assign dbg2cif_e_debug_pd_field2_cnt_inc = e_valid && capture_match_field2 && cif2dbg_c_debug_pd_en;
   
   assign dbg2cif_e_debug_pd_total_pd_cnt_inc = e_valid & cif2dbg_c_debug_pd_en;
   assign dbg2cif_e_debug_pd_field1_byte_cnt_inc = dbg2cif_e_debug_pd_field1_cnt_inc;
   assign dbg2cif_e_debug_pd_field2_byte_cnt_inc = dbg2cif_e_debug_pd_field2_cnt_inc;
   assign dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount = eq_pd[PACKET_SIZE_OFFSET +: PACKET_SIZE_WIDTH];
   
   assign pd_capture_event_field1 = cif2dbg_c_debug_pd_capture_en && 
				    (dbg2cif_e_debug_pd_field1_cnt_inc || (capture_trigger && e_valid && cif2dbg_c_debug_pd_en_trigger_match)) && 
				    (!pd_capture_q_field1 || cif2dbg_c_debug_pd_capture_last_en);
   assign pd_capture_event_field2 = cif2dbg_c_debug_pd_capture_en && 
				    dbg2cif_e_debug_pd_field2_cnt_inc ;
   
   assign pd_capture_field1 = (cif2dbg_c_debug_pd_capture_en == 1'd0) ? 1'd0 :
                              pd_capture_event_field1 ? 1'd1 :  pd_capture_q_field1 ; 

   assign pd_capture_field2 = (cif2dbg_c_debug_pd_capture_en == 1'd0) ? 1'd0 :
                              pd_capture_event_field2 ? 1'd1 :  pd_capture_q_field2 ; 

   assign dbg2cif_e_debug_pd_capture_match_field1 = pd_capture_event_field1;
   assign dbg2cif_e_debug_pd_capture_match_field2 = pd_capture_event_field2;
   assign dbg2cif_e_debug_pd_capture_match_cnt_inc = e_valid && capture_trigger && cif2dbg_c_debug_pd_en_trigger_match && cif2dbg_c_debug_pd_en;

   assign capture_match_o = pd_capture_event_field1;

   always_ff @(posedge clk) begin
      if (!rstn) pd_capture_q_field1 <= 1'b0;
      else       pd_capture_q_field1 <= pd_capture_field1;
   end

   always_comb begin
      dbg2cif_c_debug_pd_in_field1_nxt = dbg2cif_c_debug_pd_in_field1;
      if (pd_capture_event_field1) begin
	 dbg2cif_c_debug_pd_in_field1_nxt = eq_pd;
      end
   end
   
   generate
      if (USE_LACG) begin
	 ip_lacg_rn #(.DWIDTH(PD_WIDTH))
	 ip_lacg_field1
	   (.TEST__ENABLE(1'b0), 
	    .data_in (dbg2cif_c_debug_pd_in_field1_nxt), 
	    .anchor_clk_en (pd_capture_event_field1), 
	    .data_out (dbg2cif_c_debug_pd_in_field1), .*);
      end
      else begin
	 always_ff @ (posedge clk) begin    
	    dbg2cif_c_debug_pd_in_field1 <= dbg2cif_c_debug_pd_in_field1_nxt;
	 end
      end
   endgenerate

   gen_multicycle_debug_data_mux 
     #(/*AUTOINSTPARAM*/
       // Parameters
       .IN_DATA_BUS_WIDTH    (PD_WIDTH), // Templated
       .NUM_OF_IN_DATA_BUSES (1), // Templated
       .OUT_DATA_BUS_WIDTH   (32)) // Templated
   gen_multicycle_captured_pd_field1 
     (/*AUTOINST*/
      // Outputs
      .out_data_bus (dbg2cif_c_debug_pd_out_field1), // Templated
      // Inputs
      .clk          (clk),      // Templated
      .in_data_bus  (dbg2cif_c_debug_pd_in_field1), // Templated
      .in_data_sel  (cif2dbg_c_debug_pd_captured_word_sel[PD_MUX_SEL_WIDTH-1:1])
      );

   always_ff @(posedge clk) begin
      if (!rstn) pd_capture_q_field2 <= 1'b0;
      else       pd_capture_q_field2 <= pd_capture_field2;
   end

   always_comb begin
      dbg2cif_c_debug_pd_in_field2_nxt = dbg2cif_c_debug_pd_in_field2;
      if (pd_capture_event_field2) begin
	 dbg2cif_c_debug_pd_in_field2_nxt = eq_pd;
      end
   end
   
   generate
      if (USE_LACG) begin
	 ip_lacg_rn #(.DWIDTH(PD_WIDTH))
	 ip_lacg_field2
	   (.TEST__ENABLE(1'b0), 
	    .data_in (dbg2cif_c_debug_pd_in_field2_nxt), 
	    .anchor_clk_en (pd_capture_event_field2), 
	    .data_out (dbg2cif_c_debug_pd_in_field2), .*);
      end
      else begin
	 always_ff @ (posedge clk) begin    
	    dbg2cif_c_debug_pd_in_field2 <= dbg2cif_c_debug_pd_in_field2_nxt;
	 end
      end
   endgenerate

   gen_multicycle_debug_data_mux 
     #(/*AUTOINSTPARAM*/
       // Parameters
       .IN_DATA_BUS_WIDTH    (PD_WIDTH), // Templated
       .NUM_OF_IN_DATA_BUSES (1), // Templated
       .OUT_DATA_BUS_WIDTH   (32)) // Templated
   gen_multicycle_captured_pd_field2 
     (/*AUTOINST*/
      // Outputs
      .out_data_bus (dbg2cif_c_debug_pd_out_field2), // Templated
      // Inputs
      .clk          (clk),      // Templated
      .in_data_bus  (dbg2cif_c_debug_pd_in_field2), // Templated
      .in_data_sel  (cif2dbg_c_debug_pd_captured_word_sel[PD_MUX_SEL_WIDTH-1:1])
      );
   
   assign dbg2cif_c_debug_pd_out = dbg2cif_c_debug_pd_out_field1;

endmodule