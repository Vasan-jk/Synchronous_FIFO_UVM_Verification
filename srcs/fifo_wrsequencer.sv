class fifo_wrsequencer extends uvm_sequencer#(fifo_seq_item);
`uvm_component_utils(fifo_wrsequencer)

function new(string name = "fifo_wrsequencer", uvm_component parent);
  super.new(name, parent);
endfunction

endclass
