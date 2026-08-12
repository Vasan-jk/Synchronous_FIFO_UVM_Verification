class fifo_rdsequence extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(fifo_rdsequence)

function new(string name = "fifo_rdsequence");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with {rd_en == 1; rd_cs == 1;});
    finish_item(req);
  end
  end
endtask

endclass

class read_stop extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(read_stop)

function new(string name = "read_stop");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with {rd_cs == 0;});
    finish_item(req);
  end
  end
endtask

endclass

class read_cont extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(read_cont)

function new(string name = "read_cont");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with {rd_cs == 1; rd_en == 1;});
    finish_item(req);
  end
  end
endtask

endclass

class read_un extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(read_un)

function new(string name = "read_un");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
  repeat(`num_of_trans) begin
    start_item(req);
    assert(req.randomize() with {rd_cs == 1;});
    finish_item(req);
  end
  end
endtask

endclass
