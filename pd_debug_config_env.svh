
class pd_debug_config_env extends uvm_object;
    `uvm_object_utils(pd_debug_config_env)

pd_debug_config_agt pd_debug_agt_cfg;
bit enable_scoreboard = 1;
bit enable_coverage   = 1;


    function new(string name = "pd_debug_config_env");
        super.new(name);
    endfunction
endclass 