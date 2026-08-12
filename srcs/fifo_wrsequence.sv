class fifo_wrsequence extends uvm_sequence#(fifo_seq_item);
`uvm_object_utils(fifo_wrsequence)

function new(string name = "fifo_wrsequence");
  super.new(name);
endfunction

task body();
  req = fifo_seq_item::type_id::create("req");
  begin
    start_item(req);
    assert(req.randomize() with{ wr_en == 1; wr_cs == 1;});
    finish_item(req);
  end
endtask

endclass
