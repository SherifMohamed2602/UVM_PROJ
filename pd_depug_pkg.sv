
package pd_debug_pkg;
  timeunit 1ns; timeprecision 1ns;

  // Include and import the standard UVM library
  
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  // parameters for interface siganls 

  parameter PD_WIDTH = 200; // Width of incoming PD
  parameter PACKET_SIZE_OFFSET = 0; // Offset of the byte count field in the PD
  parameter PACKET_SIZE_WIDTH = 12; // Width of the byte count field in the PD
  parameter PD_MUX_SEL_WIDTH = $clog2(PD_WIDTH/32+ (PD_WIDTH % 32 == 0 ? 0 : 1)); // Width of the index for 32b words in the PD
  parameter DISABLE_LACG = 0; // Set to manually disable the usage of LACG. The module will automatically disable LACG for PD_WIDTH < `LACG_MIN_WIDTH.


typedef class pd_debug_seq_item;
typedef class pd_debug_reset_sequence;
typedef class pd_debug_count_sequence;
typedef class pd_debug_capture_sequence;
typedef class pd_debug_driver;
typedef class pd_debug_monitor;
typedef class pd_debug_agent;
typedef class pd_debug_coverage;
typedef class pd_debug_env;
typedef class pd_debug_scoreboard;
typedef class pd_debug_base_test;
typedef class pd_debug_count_test;
typedef class pd_debug_capture_test;
typedef class pd_debug_config_env;
typedef class pd_debug_config_agt;



// UVM components

`include "pd_debug_env.svh"
`include "pd_debug_config_env.svh"
`include "pd_debug_config_agt.svh"
`include "pd_debug_agent.svh"
`include "pd_debug_driver.svh"
`include "pd_debug_monitor.svh"
`include "pd_debug_coverage.svh"
`include "pd_debug_scoreboard.svh"
`include "pd_debug_seq_item.svh"
`include "pd_debug_reset_sequence.svh"
`include "pd_debug_count_sequence.svh"
`include "pd_debug_capture_sequence.svh"
`include "pd_debug_count_test.svh"
`include "pd_debug_base_test.svh"
`include "pd_debug_capture_test.svh"






endpackage: pd_debug_pkg