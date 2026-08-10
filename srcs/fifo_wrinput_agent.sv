module fifo_wrinput_agent extends uvm_agent;
`uvm_component_utils(fifo_wrinput_agent)
fifo_wrsequencer wrsqr;
fifo_wrdriver wrdrv;
fifo_wrinput_monitor wrinmon;
fifo_config wrinp_cfg;

function new(string name = "fifo_wrinput_agent", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!(uvm_config_db#(fifo_config)::get(this,"","fifo_config", wrinp_cfg))) begin
    `uvm_fatal(get_type_name(),"WR_INPUT_AGENT_CONFIG_NOT_CONNECTED") 
  if(wrinp.wrinput_agent_is_active == UVM_ACTIVE) begin
  wrsqr = fifo_wrsequencer::type_id::create("wrsqr",this);
  wrdrv = fifo_wrdriver::type_id::create("wrdrv",this);
  end
  wrinmon = fifo_wrinput_monitor::type_id::create("wrinmon",this);
endfuntion

function void connetc_phase(uvm_phase phase);
  if(wrinp.wrinput_agent_is_active == UVM_ACTIVE) begin
    wrdrv.seq_item_port.connect(wrinmon.seq_item_export);
  end
endfunction

endclass
