module pd_debug_wrapper#(

  parameter PD_WIDTH = 200, // Width of incoming PD
  parameter PACKET_SIZE_OFFSET = 0, // Offset of the byte count field in the PD
  parameter PACKET_SIZE_WIDTH = 12, // Width of the byte count field in the PD
  parameter PD_MUX_SEL_WIDTH = $clog2(PD_WIDTH/32+ (PD_WIDTH % 32 == 0 ? 0 : 1)), // Width of the index for 32b words in the PD
  parameter DISABLE_LACG = 0 // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.

  )(
  input 			       clk,
  input 			       CFG_anchor_clk_override,
  input 			       rstn,
  input 			       e_valid, // Input PD valid
  input [PD_WIDTH-1:0] 		       eq_pd, // Input PD data
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1, // Matching masks and values
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1,

  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2, // Matching masks and values
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2,

  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3, // Matching masks and values
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3,
  input [PD_WIDTH-1:0] 		       mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3,
  input [3:0] 			       cif2dbg_c_debug_pd_en_reg_1, // Configurations
  input [3:0] 			       cif2dbg_c_debug_pd_en_reg_2, // Configurations
  input [3:0] 			       cif2dbg_c_debug_pd_en_reg_3, // Configurations

  // input 			       capture_trigger, // Designer can use this bit to perform arbitrary captures to field1
  input [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_1, // Word select for dbg2cif_c_debug_pd_out
  input [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_2, // Word select for dbg2cif_c_debug_pd_out
  input [PD_MUX_SEL_WIDTH:0] 	       cif2dbg_c_debug_pd_captured_word_sel_3, // Word select for dbg2cif_c_debug_pd_out

  output logic 			       dbg2cif_e_debug_pd_field1_cnt_inc, // Match on field1
  output logic 			       dbg2cif_e_debug_pd_field2_cnt_inc, // Match on field2
  output logic 			       dbg2cif_e_debug_pd_capture_match_cnt_inc, // capture_trigger found
  output logic 			       dbg2cif_e_debug_pd_total_pd_cnt_inc, // Total PDs
  output logic 			       dbg2cif_e_debug_pd_field1_byte_cnt_inc, // Field1 byte counter
  output logic 			       dbg2cif_e_debug_pd_field2_byte_cnt_inc, // Field2 byte counter
  output logic [PACKET_SIZE_WIDTH-1:0] dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount, // Byte count field from PD as designated by PACKET_SIZE_WIDTH and PACKET_SIZE_OFFSET
  output logic 			       dbg2cif_e_debug_pd_capture_match_field1, // Pulse indicating PD has been captured for field1
  output logic 			       dbg2cif_e_debug_pd_capture_match_field2, // Pulse indicating PD has been captured for field2
  output logic 			       capture_match_o, // Pulse indicating PD has been captured for field1. This is available for the designer to use in their pipeline.
  output logic [32-1:0] 	       dbg2cif_c_debug_pd_out, // Captured PD field
  output logic [PD_WIDTH-1:0] 		       eq_pd_out
);



logic dbg2cif_e_debug_pd_field1_cnt_inc_1;
logic dbg2cif_e_debug_pd_field2_cnt_inc_1;
logic dbg2cif_e_debug_pd_capture_match_cnt_inc_1;
logic dbg2cif_e_debug_pd_total_pd_cnt_inc_1;
logic dbg2cif_e_debug_pd_field1_byte_cnt_inc_1;
logic dbg2cif_e_debug_pd_field2_byte_cnt_inc_1;
logic [PACKET_SIZE_WIDTH-1:0] dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_1;
logic dbg2cif_e_debug_pd_capture_match_field1_1;
logic dbg2cif_e_debug_pd_capture_match_field2_1;
logic capture_match_o_1;
logic [32-1:0] dbg2cif_c_debug_pd_out_1;



logic e_valid_after_pd_debug_1;
logic [PD_WIDTH-1:0] eq_pd_after_pd_debug_1;
logic dbg2cif_e_debug_pd_field1_cnt_inc_2;
logic dbg2cif_e_debug_pd_field2_cnt_inc_2;
logic dbg2cif_e_debug_pd_capture_match_cnt_inc_2;
logic dbg2cif_e_debug_pd_total_pd_cnt_inc_2;
logic dbg2cif_e_debug_pd_field1_byte_cnt_inc_2;
logic dbg2cif_e_debug_pd_field2_byte_cnt_inc_2;
logic [PACKET_SIZE_WIDTH-1:0] dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_2;
logic dbg2cif_e_debug_pd_capture_match_field1_2;
logic dbg2cif_e_debug_pd_capture_match_field2_2;
logic capture_match_o_2;
logic [32-1:0] dbg2cif_c_debug_pd_out_2;

logic e_valid_after_pd_debug_2;
logic [PD_WIDTH-1:0] eq_pd_after_pd_debug_2;
logic dbg2cif_e_debug_pd_field1_cnt_inc_3;
logic dbg2cif_e_debug_pd_field2_cnt_inc_3;
logic dbg2cif_e_debug_pd_capture_match_cnt_inc_3;
logic dbg2cif_e_debug_pd_total_pd_cnt_inc_3;
logic dbg2cif_e_debug_pd_field1_byte_cnt_inc_3;
logic dbg2cif_e_debug_pd_field2_byte_cnt_inc_3;
logic [PACKET_SIZE_WIDTH-1:0] dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_3;
logic dbg2cif_e_debug_pd_capture_match_field1_3;
logic dbg2cif_e_debug_pd_capture_match_field2_3;
logic capture_match_o_3;
logic [32-1:0] dbg2cif_c_debug_pd_out_3;


logic e_valid_after_pd_debug_3;
logic [PD_WIDTH-1:0] eq_pd_after_pd_debug_3;

assign dbg2cif_e_debug_pd_field1_cnt_inc = dbg2cif_e_debug_pd_field1_cnt_inc_3;
assign dbg2cif_e_debug_pd_field2_cnt_inc = dbg2cif_e_debug_pd_field2_cnt_inc_3;
assign dbg2cif_e_debug_pd_capture_match_cnt_inc = dbg2cif_e_debug_pd_capture_match_cnt_inc_3;
assign dbg2cif_e_debug_pd_total_pd_cnt_inc = dbg2cif_e_debug_pd_total_pd_cnt_inc_3;
assign dbg2cif_e_debug_pd_field1_byte_cnt_inc = dbg2cif_e_debug_pd_field1_byte_cnt_inc_3;
assign dbg2cif_e_debug_pd_field2_byte_cnt_inc = dbg2cif_e_debug_pd_field2_byte_cnt_inc_3;
assign dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount = dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_3;
assign dbg2cif_e_debug_pd_capture_match_field1 = dbg2cif_e_debug_pd_capture_match_field1_3;
assign dbg2cif_e_debug_pd_capture_match_field2 = dbg2cif_e_debug_pd_capture_match_field2_3;
assign capture_match_o = capture_match_o_3;
assign dbg2cif_c_debug_pd_out = dbg2cif_c_debug_pd_out_3;
assign eq_pd_out = eq_pd_after_pd_debug_3;

control_pd_debug_with_capture_v3 #(

  .PD_WIDTH(PD_WIDTH), // Width of incoming PD
  .PACKET_SIZE_OFFSET(PACKET_SIZE_OFFSET), // Offset of the byte count field in the PD
  .PACKET_SIZE_WIDTH(PACKET_SIZE_WIDTH), // Width of the byte count field in the PD
  .PD_MUX_SEL_WIDTH(PD_MUX_SEL_WIDTH), // Width of the index for 32b words in the PD
  .DISABLE_LACG(DISABLE_LACG) // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.

  )pd_debug_1 ( 			       clk,
   			       CFG_anchor_clk_override,
   			       rstn,
   			       e_valid, //  PD valid
				   eq_pd, //  PD data
				   mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_1, // Matching masks and values
				   mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_1,
				   mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_1,
				   mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_1,
				   cif2dbg_c_debug_pd_en_reg_1, // Configurations
				   			       eq_pd[113], // Designer can use this bit to perform arbitrary captures to field1
				  cif2dbg_c_debug_pd_captured_word_sel_1, // Word select for dbg2cif_c_debug_pd_out
				  dbg2cif_e_debug_pd_field1_cnt_inc_1, // Match on field1
				  dbg2cif_e_debug_pd_field2_cnt_inc_1, // Match on field2
				  dbg2cif_e_debug_pd_capture_match_cnt_inc_1, // capture_trigger found
				  dbg2cif_e_debug_pd_total_pd_cnt_inc_1, // Total PDs
				  dbg2cif_e_debug_pd_field1_byte_cnt_inc_1, // Field1 byte counter
				  dbg2cif_e_debug_pd_field2_byte_cnt_inc_1, // Field2 byte counter
				  dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_1, // Byte count field from PD as designated by PACKET_SIZE_WIDTH and PACKET_SIZE_OFFSET
				  dbg2cif_e_debug_pd_capture_match_field1_1, // Pulse indicating PD has been captured for field1
				  dbg2cif_e_debug_pd_capture_match_field2_1, // Pulse indicating PD has been captured for field2
				  capture_match_o_1, // Pulse indicating PD has been captured for field1. This is available for the designer to use in their pipeline.
				  dbg2cif_c_debug_pd_out_1); // Captured PD field)


always @(posedge clk) begin
	eq_pd_after_pd_debug_1<=eq_pd;
	e_valid_after_pd_debug_1<=e_valid;
end

control_pd_debug_with_capture_v3 #(

  .PD_WIDTH(PD_WIDTH), // Width of incoming PD
  .PACKET_SIZE_OFFSET(PACKET_SIZE_OFFSET), // Offset of the byte count field in the PD
  .PACKET_SIZE_WIDTH(PACKET_SIZE_WIDTH), // Width of the byte count field in the PD
  .PD_MUX_SEL_WIDTH(PD_MUX_SEL_WIDTH), // Width of the index for 32b words in the PD
  .DISABLE_LACG(DISABLE_LACG) // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.

  ) pd_debug_2 ( 			       clk,
   			       CFG_anchor_clk_override,
   			       rstn,
   			       e_valid_after_pd_debug_1, //  PD valid
				   eq_pd_after_pd_debug_1, //  PD data
				   mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_2, // Matching masks and values
				   mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_2,
				   mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_2,
				   mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_2,
				   cif2dbg_c_debug_pd_en_reg_2, // Configurations
				   			       eq_pd_after_pd_debug_1[113], // Designer can use this bit to perform arbitrary captures to field1
				  cif2dbg_c_debug_pd_captured_word_sel_2, // Word select for dbg2cif_c_debug_pd_out
				  dbg2cif_e_debug_pd_field1_cnt_inc_2, // Match on field1
				  dbg2cif_e_debug_pd_field2_cnt_inc_2, // Match on field2
				  dbg2cif_e_debug_pd_capture_match_cnt_inc_2, // capture_trigger found
				  dbg2cif_e_debug_pd_total_pd_cnt_inc_2, // Total PDs
				  dbg2cif_e_debug_pd_field1_byte_cnt_inc_2, // Field1 byte counter
				  dbg2cif_e_debug_pd_field2_byte_cnt_inc_2, // Field2 byte counter
				  dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_2, // Byte count field from PD as designated by PACKET_SIZE_WIDTH and PACKET_SIZE_OFFSET
				  dbg2cif_e_debug_pd_capture_match_field1_2, // Pulse indicating PD has been captured for field1
				  dbg2cif_e_debug_pd_capture_match_field2_2, // Pulse indicating PD has been captured for field2
				  capture_match_o_2, // Pulse indicating PD has been captured for field1. This is available for the designer to use in their pipeline.
				  dbg2cif_c_debug_pd_out_2); // Captured PD field)


always @(posedge clk) begin
	eq_pd_after_pd_debug_2<=eq_pd_after_pd_debug_1;
	eq_pd_after_pd_debug_2[113]<=eq_pd_after_pd_debug_1[113] || capture_match_o_2;
	e_valid_after_pd_debug_2<=e_valid_after_pd_debug_1;
end

control_pd_debug_with_capture_v3 #(

  .PD_WIDTH(PD_WIDTH), // Width of incoming PD
  .PACKET_SIZE_OFFSET(PACKET_SIZE_OFFSET), // Offset of the byte count field in the PD
  .PACKET_SIZE_WIDTH(PACKET_SIZE_WIDTH), // Width of the byte count field in the PD
  .PD_MUX_SEL_WIDTH(PD_MUX_SEL_WIDTH), // Width of the index for 32b words in the PD
  .DISABLE_LACG(DISABLE_LACG) // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.

  )pd_debug_3 ( 			       clk,
   			       CFG_anchor_clk_override,
   			       rstn,
   			       e_valid_after_pd_debug_2, //  PD valid
				   eq_pd_after_pd_debug_2, //  PD data
				   mem2dbg_c_debug_pd_field1_value_cfg_mem_regarray_3, // Matching masks and values
				   mem2dbg_c_debug_pd_field1_mask_cfg_mem_regarray_3,
				   mem2dbg_c_debug_pd_field2_value_cfg_mem_regarray_3,
				   mem2dbg_c_debug_pd_field2_mask_cfg_mem_regarray_3,
				   cif2dbg_c_debug_pd_en_reg_3, // Configurations
				   			       eq_pd_after_pd_debug_2[113], // Designer can use this bit to perform arbitrary captures to field1
				  cif2dbg_c_debug_pd_captured_word_sel_3, // Word select for dbg2cif_c_debug_pd_out
				  dbg2cif_e_debug_pd_field1_cnt_inc_3, // Match on field1
				  dbg2cif_e_debug_pd_field2_cnt_inc_3, // Match on field2
				  dbg2cif_e_debug_pd_capture_match_cnt_inc_3, // capture_trigger found
				  dbg2cif_e_debug_pd_total_pd_cnt_inc_3, // Total PDs
				  dbg2cif_e_debug_pd_field1_byte_cnt_inc_3, // Field1 byte counter
				  dbg2cif_e_debug_pd_field2_byte_cnt_inc_3, // Field2 byte counter
				  dbg2cif_eq_debug_pd_field_byte_cnt_inc_amount_3, // Byte count field from PD as designated by PACKET_SIZE_WIDTH and PACKET_SIZE_OFFSET
				  dbg2cif_e_debug_pd_capture_match_field1_3, // Pulse indicating PD has been captured for field1
				  dbg2cif_e_debug_pd_capture_match_field2_3, // Pulse indicating PD has been captured for field2
				  capture_match_o_3, // Pulse indicating PD has been captured for field1. This is available for the designer to use in their pipeline.
				  dbg2cif_c_debug_pd_out_3); // Captured PD field)


always @(posedge clk) begin
	eq_pd_after_pd_debug_3<=eq_pd_after_pd_debug_2;
	eq_pd_after_pd_debug_3[113]<=eq_pd_after_pd_debug_2[113] || capture_match_o_3;
	e_valid_after_pd_debug_3<=e_valid_after_pd_debug_2;
end
endmodule : pd_debug_wrapper