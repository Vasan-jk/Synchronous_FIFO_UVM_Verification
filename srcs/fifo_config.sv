class fifo_config extends uvm_object;
`uvm_object_utils(fifo_config)
virtual fifo_interface vif;

uvm_active_passive_enum wrinput_agent_is_active;
uvm_active_passive_enum rdinput_agent_is_active;
uvm_active_passive_enum output_agent_is_active;
 
function new(string name = "fifo_config");
  super.new(name);
endfunction

endclass
 
