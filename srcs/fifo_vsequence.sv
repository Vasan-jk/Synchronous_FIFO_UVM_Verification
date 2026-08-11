class fifo_vsequence extends uvm_sequence;
`uvm_object_utils(fifo_vsequence)
fifo_vsequencer vsqr;
`uvm_declare_p_sequencer(vsqr)

fifo_wrsequence wrseq;
fifo_rdsequence rdseq;


function new(string name = "fifo_vsequence", uvm_component parent);
  super.new(name, parent);
endfunction

task body();
  wrseq = fifo_wrsequence::type_id::create("wrseq);
  rdseq = fifo_rdsequence::type_id::create("rdseq");

  fork 
    wrseq.start(p_sequencer.wrsqr);
    wrseq.start(p_sequencer.rdsqr);
  join
endtask
endclass
