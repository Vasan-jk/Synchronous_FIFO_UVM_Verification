`include "defines.svh"
class fifo_seq_item extends uvm_sequence_item;
rand bit [`DATA_WIDTH - 1: 0] data_in;
rand bit wr_cs;
rand bit rd_cs;
rand bit wr_en;
rand bit rd_en;
bit full;
bit empty;
bit [`DATA_WIDTH - 1: 0] data_out;

`uvm_object_utils_begin(fifo_seq_item)
`uvm_field_int(data_in, UVM_ALL_ON)
`uvm_field_int(wr_cs, UVM_ALL_ON)
`uvm_field_int(rd_cs, UVM_ALL_ON)
`uvm_field_int(wr_en, UVM_ALL_ON)
`uvm_field_int(rd_en, UVM_ALL_ON)
`uvm_field_int(full, UVM_ALL_ON)
`uvm_field_int(empty, UVM_ALL_ON)
`uvm_field_int(data_out, UVM_ALL_ON)
`uvm_object_utils_end
function new(string name = "fifo_seq_item");
super.new(name);
endfunction

endclass
