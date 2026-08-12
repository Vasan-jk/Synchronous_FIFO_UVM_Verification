class fifo_output_monitor extends uvm_monitor;
`uvm_component_utils(fifo_output_monitor)
uvm_analysis_port#(fifo_seq_item) out_monitor_port;

virtual fifo_interface.monout vif;
fifo_config monout_cfg;
fifo_seq_item tr;

function new(string name = "fifo_output_monitor", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_cfg",monout_cfg)))
    `uvm_fatal(get_type_name(),"OUTPUT MONITOR CONFIG NOT CONNECTED")
  out_monitor_port = new("out_monitor_port", this);
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = monout_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  repeat(5)  @(vif.monout_cb);
  forever begin
    tr = fifo_seq_item::type_id::create("tr");
    collect_data();
    `uvm_info("OUTPUT_MONITOR",$sformatf("OUTPUT MONITOR\n%s",tr.sprint()),UVM_HIGH) 
  end
endtask

virtual task collect_data();
begin
  @(vif.monout_cb);
  tr.data_out = vif.monout_cb.data_out;
  tr.full = vif.monout_cb.full;
  tr.empty = vif.monout_cb.empty;
  out_monitor_port.write(tr);
end
endtask
endclass
