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


class write_contin extends uvm_sequence;
`uvm_object_utils(write_contin)
`uvm_declare_p_sequencer(fifo_vsequencer)

write_cont wrcont;
read_stop rdstp;


function new(string name = "fifo_vsequence");
  super.new(name);
endfunction

task body();
  wrcont = write_cont::type_id::create("wrcont");
  rdstp = read_stop::type_id::create("rdstp");

  fork
    wrcont.start(p_sequencer.wrsqr);
    rdstp.start(p_sequencer.rdsqr);
  join
endtask
endclass

class read_contin extends uvm_sequence;
`uvm_object_utils(read_contin)
`uvm_declare_p_sequencer(fifo_vsequencer)

read_cont rdcont;
write_stop wrstp;


function new(string name = "fifo_vsequence");
  super.new(name);
endfunction

task body();
  rdcont = read_cont::type_id::create("rdcont");
  wrstp = write_stop::type_id::create("wrstp");

  fork
    rdcont.start(p_sequencer.wrsqr);
    wrstp.start(p_sequencer.rdsqr);
  join
endtask
endclass

class rw_rand extends uvm_sequence;
`uvm_object_utils(rw_rand)
`uvm_declare_p_sequencer(fifo_vsequencer)

read_un rdun;
write_un wrun;


function new(string name = "fifo_vsequence");
  super.new(name);
endfunction

task body();
  rdun = read_un::type_id::create("rdcont");
  wrun = write_un::type_id::create("wrstp");

  fork
    rdun.start(p_sequencer.wrsqr);
    wrun.start(p_sequencer.rdsqr);
  join
endtask
endclass
