class fifo_rdinput_agent extends uvm_agent;
`uvm_component_utils(fifo_rdinput_agent)
fifo_rdsequencer rdsqr;
fifo_rddriver rddrv;
fifo_rdinput_monitor rdinmon;
fifo_config rdinp_cfg;

function new(string name = "fifo_rdinput_agent", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_config", rdinp_cfg)))
    `uvm_fatal(get_type_name(),"RD_INPUT_AGENT_CONFIG_NOT_CONNECTED") 
  if(rdinp_cfg.wrinput_agent_is_active == UVM_ACTIVE) begin
  rdsqr = fifo_rdsequencer::type_id::create("rdsqr",this);
  rddrv = fifo_rddriver::type_id::create("rddrv",this);
  end
  rdinmon = fifo_rdinput_monitor::type_id::create("rdinmon",this);
endfunction

function void connect_phase(uvm_phase phase);
  if(rdinp_cfg.wrinput_agent_is_active == UVM_ACTIVE) begin
    rddrv.seq_item_port.connect(rdsqr.seq_item_export);
  end
endfunction

endclass
