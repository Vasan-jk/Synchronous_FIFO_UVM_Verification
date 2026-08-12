class fifo_test extends uvm_test;
`uvm_component_utils(fifo_test)
fifo_config a_cfg;

fifo_environment env;

function new(string name = "fifo_test", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  env = fifo_environment::type_id::create("env", this);

  a_cfg = fifo_config::type_id::create("a_cfg");

  if(!(uvm_config_db #(virtual fifo_interface)::get(this,"","fifo_if",a_cfg.vif)))
    `uvm_fatal(get_type_name(),"TEST CONFIG NOT CONNECTED")
  a_cfg.wrinput_agent_is_active = UVM_ACTIVE;
  a_cfg.rdinput_agent_is_active = UVM_ACTIVE;
  a_cfg.output_agent_is_active = UVM_PASSIVE;

  uvm_config_db#(fifo_config)::set(this,"*","fifo_cfg",a_cfg);
  
endfunction

endclass

class base_test extends fifo_test;
`uvm_component_utils(base_test)

function new(string name="test1",uvm_component parent);
  super.new(name,parent);
 endfunction

  fifo_vsequence vseq;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction

task run_phase(uvm_phase phase);
  vseq = fifo_vsequence::type_id::create("vseq");
  phase.raise_objection(this);
  vseq.start(env.vsqr);
  #30;
  phase.drop_objection(this);
endtask
endclass

class write_continuous extends fifo_test;
`uvm_component_utils(write_continuous)

function new(string name="write_continuous",uvm_component parent);
  super.new(name,parent);
 endfunction

  write_contin vseq;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction

task run_phase(uvm_phase phase);
  vseq = write_contin::type_id::create("vseq");
  phase.raise_objection(this);
  vseq.start(env.vsqr);
  #30;
  phase.drop_objection(this);
endtask
endclass

class read_continuous extends fifo_test;
`uvm_component_utils(read_continuous)

function new(string name="read_continuous",uvm_component parent);
  super.new(name,parent);
 endfunction

  read_contin vseq;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction

task run_phase(uvm_phase phase);
  vseq = read_contin::type_id::create("vseq");
  phase.raise_objection(this);
  vseq.start(env.vsqr);
  #30;
  phase.drop_objection(this);
endtask
endclass

class read_write_rand extends fifo_test;
`uvm_component_utils(read_write_rand)

function new(string name="read_write_rand",uvm_component parent);
  super.new(name,parent);
 endfunction

  rw_rand vseq;

 function void build_phase(uvm_phase phase);
  super.build_phase(phase);
 endfunction

task run_phase(uvm_phase phase);
  vseq = rw_rand::type_id::create("vseq");
  phase.raise_objection(this);
  vseq.start(env.vsqr);
  #30;
  phase.drop_objection(this);
endtask
endclass
