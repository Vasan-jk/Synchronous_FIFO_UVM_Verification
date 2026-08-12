class fifo_wrsequence extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(fifo_wrsequence)

function new(string name = "fifo_wrsequence");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with{ wr_en == 1; wr_cs == 1;});
    finish_item(req);
  end
  end
endtask

endclass

class write_cont extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(write_cont)

function new(string name = "write_cont");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with{ wr_en == 1; wr_cs == 1;});
    finish_item(req);
  end
  end
endtask

endclass

class write_stop extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(write_stop)

function new(string name = "write_stop");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with{wr_cs == 0; wr_en == 0;});
    finish_item(req);
  end
  end
endtask

endclass

class write_un extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(write_un)

function new(string name = "write_un");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with{wr_cs == 1;});
    finish_item(req);
  end
  end
endtask

endclass
               
