class fifo_wrdriver extends uvm_driver#(fifo_seq_item);
`uvm_component_utils(fifo_wrdriver)
fifo_config wrdrv_cfg;
virtual fifo_interface.drvwr vif;
fifo_seq_item tr;

function new(string name = "fifo_wrdriver", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_cfg",wrdrv_cfg)))
    `uvm_fatal(get_type_name(),"WR_INPUT_DRIVER NOT CONNECTED")
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = wrdrv_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  begin
    repeat(2) @(vif.drvwr_cb);
    forever begin
      seq_item_port.get_next_item(req);
      drive(req);
      seq_item_port.item_done();
    end
  end
endtask

task drive(tr); 
begin
  @(vif.drvwr_cb);
  vif.drvwr_cb.data_in <= tr.data_in;
  vif.drvwr_cb.wr_cs <= tr.wr_cs;
  vif.drvwr_cb.wr_en <= tr.wr_en;
end
endtask


endclass
