class fifo_output_monitor extends uvm_monitor;
`uvm_component_utils(fifo_output_monitor)
uvm_analysis_port#(trans) out_monitor_port;

virtual fifo_if.monout vif;
fifo_config monout_cfg;
fifo_seq_item tr;

function new(string name = "fifo_output_monitor", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_config",monout_cfg)))
    `uvm_fatal(get_type_name(),"OUTPUT MONITOR CONFIG NOT CONNECTED")
  out_monitor_port = new(this,"out_monitor_port");
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = monout_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  forever begin
    tr = fifo_seq_item::type_id::create("tr");
    collect_data();
    `uvm_info("OUTPUT_MONITOR",$sformatf("OUTPUT MONITOR\n%s",tr.sprint()),UVM_NONE) 
  end
endtask

virtual task collect_data();
begin
  @(vif.monout_cb);
  tr.data_out = vif.monout_cb.data_out;
  tr.full = vif.monout_cb.full;
  tr.empty = vif.monout_cb.empty;
end
endtask
endclass
