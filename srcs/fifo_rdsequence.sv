class fifo_rdsequence extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(fifo_rdsequence)

function new(string name = "fifo_rdsequence");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
    start_item(req);
    assert(req.randomize() with {rd_en == 1; rd_cs == 1;});
    finish_item(req);
  end
endtask

endclass
