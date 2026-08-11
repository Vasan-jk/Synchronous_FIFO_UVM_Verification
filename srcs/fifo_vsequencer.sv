class fifo_vsequencer extends uvm_sequencer;
`uvm_component_utils(fifo_vsequencer)

  fifo_wrsequencer wrsqr;
  fifo_rdsequencer rdsqr;

  function new(string name = "fifo_vsequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
