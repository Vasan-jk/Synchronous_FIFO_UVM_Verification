class fifo_wrsequence extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(fifo_wrsequence)

function new(string name = "fifo_wrsequence");
  super.new(name);
endfunction

task body();
  req = trans::type_id::create("req");
  begin
    start_item(req);
    assert(req.randomize());
    finish_item(req);
  end
endtask

endclass
