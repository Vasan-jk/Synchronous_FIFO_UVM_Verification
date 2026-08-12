class fifo_rdinput_monitor extends uvm_monitor;
`uvm_component_utils(fifo_rdinput_monitor)
uvm_analysis_port #(fifo_seq_item) rdinput_monitor_port;

virtual fifo_interface.moninrd vif;
fifo_config rdmonin_cfg;
fifo_seq_item tr;

function new(string name = "fifo_rdinput_monitor", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_cfg",rdmonin_cfg)))
    `uvm_fatal(get_type_name(),"RD_INPUT_MONITOR CONFIG NOT CONNECTED")
  rdinput_monitor_port = new("rdinput_monitor_port", this);
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = rdmonin_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);
  begin
    repeat(4) @(vif.moninrd_cb);
  forever begin
    collect_input();
    `uvm_info("WR_INPUT_MONITOR",$sformatf("Write Input MONITOR\n%s",tr.sprint()),UVM_HIGH)  
  end
  end
endtask

task collect_input();
  begin
  @(vif.moninrd_cb);
  tr = fifo_seq_item::type_id::create("tr");
  tr.rd_cs = vif.moninrd_cb.rd_cs;
  tr.rd_en = vif.moninrd_cb.rd_en;
  rdinput_monitor_port.write(tr);
  end
endtask
endclass
