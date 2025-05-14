//-----------------------------------------------------
// Design Name : gen_multicycle_debug_data_mux
// File Name   : gen_multicycle_debug_data_mux.v
// Function    : Implements a mux that should be defined as multicycle
// Coder       : shira
// ver         : 
//-----------------------------------------------------


module gen_multicycle_debug_data_mux (/*AUTOARG*/
   // Outputs
   out_data_bus,
   // Inputs
   clk, in_data_bus, in_data_sel
   );    

     
   parameter IN_DATA_BUS_WIDTH = 100;
   parameter NUM_OF_IN_DATA_BUSES = 3;   
   parameter OUT_DATA_BUS_WIDTH = 32;

   
   localparam DATA_SEL_OPTIONS = NUM_OF_IN_DATA_BUSES*(IN_DATA_BUS_WIDTH/OUT_DATA_BUS_WIDTH + (IN_DATA_BUS_WIDTH % OUT_DATA_BUS_WIDTH == 0 ? 0 : 1)); //Calc the number of out data busses assuming that each two in data buses are not set on the same out bus (thus needs padding).
   localparam DATA_SEL_WIDTH = $clog2(DATA_SEL_OPTIONS); //The width of the required selector
   localparam LAST_DATA_WIDTH = IN_DATA_BUS_WIDTH - (IN_DATA_BUS_WIDTH/OUT_DATA_BUS_WIDTH)*OUT_DATA_BUS_WIDTH;   
   
   //General
   input clk;
  
   //Incoming data bus
   input [NUM_OF_IN_DATA_BUSES*IN_DATA_BUS_WIDTH-1:0] in_data_bus;
   input [DATA_SEL_WIDTH-1:0] 			      in_data_sel;
   
   //Outgoing data bus
   output [OUT_DATA_BUS_WIDTH-1:0] 		      out_data_bus;

   //wire [OUT_DATA_BUS_WIDTH-1:0] 		      muxed_data_next;
   wire [DATA_SEL_OPTIONS*OUT_DATA_BUS_WIDTH-1:0]     in_data_bus_spaced;
   wire [DATA_SEL_OPTIONS*OUT_DATA_BUS_WIDTH-1:0]     in_data_bus_padded;
   wire [OUT_DATA_BUS_WIDTH-1:0] 		      out_data_bus;
   

   
   reg [OUT_DATA_BUS_WIDTH-1:0] 		      gen_debug_muxed_data_to_multicycle;
   reg [DATA_SEL_OPTIONS-1:0] 			      one_hot_select_vector_r;
   wire [OUT_DATA_BUS_WIDTH-1:0] 		      muxed_data_masked[DATA_SEL_OPTIONS-1:0];
   wire [OUT_DATA_BUS_WIDTH-1:0] 		      muxed_data_after_or[DATA_SEL_OPTIONS-1:0];
   
   //Created to avoid Lints
   assign in_data_bus_padded = {{(DATA_SEL_OPTIONS*OUT_DATA_BUS_WIDTH-IN_DATA_BUS_WIDTH*NUM_OF_IN_DATA_BUSES){1'b0}}, in_data_bus};   

   genvar 					      i,j;
   generate
      for (i = 0; i < NUM_OF_IN_DATA_BUSES; i = i + 1) 
	begin: gen1
	   for (j = 0; j < DATA_SEL_OPTIONS/NUM_OF_IN_DATA_BUSES; j = j + 1) 
	     begin: gen1
    		if (LAST_DATA_WIDTH == 0) 
	    	  assign in_data_bus_spaced[OUT_DATA_BUS_WIDTH*(i*DATA_SEL_OPTIONS/NUM_OF_IN_DATA_BUSES + j)+:OUT_DATA_BUS_WIDTH] = in_data_bus_padded[(i*DATA_SEL_OPTIONS/NUM_OF_IN_DATA_BUSES+j)*OUT_DATA_BUS_WIDTH+:OUT_DATA_BUS_WIDTH];	
		else
		  assign in_data_bus_spaced[OUT_DATA_BUS_WIDTH*(i*DATA_SEL_OPTIONS/NUM_OF_IN_DATA_BUSES + j)+:OUT_DATA_BUS_WIDTH] = (j == (DATA_SEL_OPTIONS/NUM_OF_IN_DATA_BUSES-1)) ?
																    {{(OUT_DATA_BUS_WIDTH-LAST_DATA_WIDTH){1'b0}},in_data_bus_padded[(i*IN_DATA_BUS_WIDTH+j*OUT_DATA_BUS_WIDTH)+:LAST_DATA_WIDTH]} :
																    in_data_bus_padded[(i*IN_DATA_BUS_WIDTH+j*OUT_DATA_BUS_WIDTH)+:OUT_DATA_BUS_WIDTH];	     						
	     end
	end
   endgenerate

   always @(posedge clk) begin
      one_hot_select_vector_r <=  1'b1 << in_data_sel;
   end

//   //Take the relevant data
//   mux_of_bus #(.INPUT_WIDTH(DATA_SEL_OPTIONS*OUT_DATA_BUS_WIDTH), .OUTPUT_WIDTH(OUT_DATA_BUS_WIDTH), .SELECTOR_WIDTH(DATA_SEL_WIDTH))
//        i_mux_of_bus 		(.data_in(in_data_bus_spaced), .index(in_data_sel), .data_out(muxed_data_next));

   genvar k;
   generate
      for (k = 0; k < DATA_SEL_OPTIONS; k= k + 1) begin: gen2
	 assign muxed_data_masked[k] = in_data_bus_spaced[k*OUT_DATA_BUS_WIDTH +: OUT_DATA_BUS_WIDTH] & ({OUT_DATA_BUS_WIDTH{one_hot_select_vector_r[k]}});
	 if (k==0)
	   assign muxed_data_after_or[0] = muxed_data_masked[0];
	 else
	   assign muxed_data_after_or[k] = muxed_data_after_or[k-1] | muxed_data_masked[k];
      end
   endgenerate
   
				 
   always @(posedge clk) 
     begin        
//        gen_debug_muxed_data_to_multicycle           <=  muxed_data_next;	
        gen_debug_muxed_data_to_multicycle           <=  muxed_data_after_or[DATA_SEL_OPTIONS-1];	
     end

   assign out_data_bus = gen_debug_muxed_data_to_multicycle;
   
  
endmodule