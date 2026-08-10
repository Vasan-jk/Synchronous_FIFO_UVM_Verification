module fifo_output_agent extends uvm_agent;
`uvm_component_utils(fifo_output_agent)
fifo_output_monitor outmon;


function new(string name = "fifo_output_agent", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(wrinp.wrinput_agent_is_active == UVM_PASSIVE) begin
  outmon = fifo_output_monitor::type_id::create("wrinmon",this);
  end
endfuntion


endclass
