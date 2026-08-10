class fifo_rdsequencer extends uvm_sequencer#(fifo_seq_item);
`uvm_component_utils(fifo_rdsequencer)

function new(string name = "fifo_rdsequencer", uvm_component parent);
  super.new(name, parent);
endfunction

endclass
