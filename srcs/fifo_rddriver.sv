class fifo_rddriver extends uvm_driver#(fifo_seq_item);
`uvm_component_utils(fifo_rddriver)
fifo_config rddrv_cfg;
virtual fifo_interface.drvrd vif;

function new(string name = "fifo_rddriver", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_cfg",rddrv_cfg)))
    `uvm_fatal(get_type_name(),"WR_INPUT_DRIVER NOT CONNECTED")
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = rddrv_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  begin
    repeat(3) @(vif.drvrd_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
  end
  end
endtask

task drive(fifo_seq_item tr); 
begin
  @(vif.drvrd_cb);
  vif.drvrd_cb.rd_cs <= tr.rd_cs;
  vif.drvrd_cb.rd_en <= tr.rd_en;
end
endtask


endclass
