class fifo_vsequence extends uvm_sequence;
`uvm_object_utils(fifo_vsequence)
//fifo_vsequencer vsqr;
`uvm_declare_p_sequencer(fifo_vsequencer)

fifo_wrsequence wrseq;
fifo_rdsequence rdseq;


function new(string name = "fifo_vsequence");
  super.new(name);
endfunction

task body();
  wrseq = fifo_wrsequence::type_id::create("wrseq");
  rdseq = fifo_rdsequence::type_id::create("rdseq");

  fork 
    wrseq.start(p_sequencer.wrsqr);
    rdseq.start(p_sequencer.rdsqr);
  join
endtask
endclass
