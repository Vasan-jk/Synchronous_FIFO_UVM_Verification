class fifo_environment extends uvm_env;
`uvm_component_utils(fifo_environment)

fifo_vsequencer vsqr;
fifo_wrinput_agent wrinagnt;
fifo_rdinput_agent rdinagnt;
fifo_output_agent outagnt;
fifo_scoreboard scb;

function new(string name = "fifo_environment", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  vsqr = fifo_vsequencer::type_id::create("vsqr",this);
  wrinagnt = fifo_wrinput_agent::type_id::create("wrinagnt", this);
  rdinagnt = fifo_rdinput_agent::type_id::create("rdinagnt", this);
  outagnt = fifo_output_agent::type_id::create("outagnt", this);
  scb = fifo_scoreboard::type_id::create("scb", this);
endfunction

function void connect_phase(uvm_phase phase);
  vsqr.wrsqr = wrinagnt.wrsqr;
  vsqr.rdsqr = rdinagnt.rdsqr;
  wrinagnt.wrinmon.wrinput_monitor_port.connect(scb.wrin_fifo.analysis_export);
  rdinagnt.rdinmon.rdinput_monitor_port.connect(scb.rdin_fifo.analysis_export);
  outagnt.outmon.out_monitor_port.connect(scb.out_fifo.analysis_export);
endfunction

endclass
