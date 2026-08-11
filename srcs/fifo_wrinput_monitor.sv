class fifo_wrinput_monitor extends uvm_monitor;
`uvm_component_utils(fifo_wrinput_monitor)
uvm_analysis_port #(fifo_seq_item) wrinput_monitor_port;

virtual fifo_interface.moninwr vif;
fifo_config wrmonin_cfg;
fifo_seq_item tr;

function new(string name = "fifo_wrinput_monitor", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_config",wrmonin_cfg)))
    `uvm_fatal(get_type_name(),"WR_INPUT_MONITOR CONFIG NOT CONNECTED")
  wrinput_monitor_port = new(this,"wrinput_monitor_port");
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  vif = wrmonin_cfg.vif;
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);
  begin
    repeat(2) @(vif.moninwr_cb);
  forever begin
    collect_input();
    `uvm_info("WR_INPUT_MONITOR",$sformatf("Write Input MONITOR\n%s",tr.sprint()),UVM_HIGH)  
  end
  end
endtask

task collect_input();
  begin
  @(vif.moninwr_cb);
  tr = fifo_seq_item::type_id::create("tr");
  tr.data_in = vif.moninwr_cb.data_in;
  tr.wr_cs = vif.moninwr_cb.wr_cs;
  tr.wr_en = vif.moninwr_cb.wr_en;
  end
endtask
endclass
