`include "defines.svh"

class fifo_scoreboard extends uvm_scoreboard;
`uvm_component_utils(fifo_scoreboard)

bit [`DATA_WIDTH-1:0] q[$];
bit [`DATA_WIDTH-1:0] q_out;
bit exp_emp, exp_full;

uvm_tlm_analysis_fifo #(fifo_seq_item) wrin_fifo;
uvm_tlm_analysis_fifo #(fifo_seq_item) rdin_fifo;
uvm_tlm_analysis_fifo #(fifo_seq_item) out_fifo;

fifo_seq_item t_wrin;
fifo_seq_item t_rdin;
fifo_seq_item t_out;

function new(string name = "fifo_scoreboard", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  wrin_fifo = new("wrin_fifo", this);
  rdin_fifo = new("rdin_fifo", this);
  out_fifo = new("out_fifo", this);
  t_wrin = fifo_seq_item::type_id::create("t_wrin");
  t_rdin = fifo_seq_item::type_id::create("t_rdin");
  t_out  = fifo_seq_item::type_id::create("t_out");
endfunction

task run_phase(uvm_phase phase);

forever begin
    wrin_fifo.get(t_wrin);
    rdin_fifo.get(t_rdin);
    out_fifo.get(t_out);
    if( t_wrin.wr_cs && t_wrin.wr_en)begin
      if(q.size() < (1 << `ADDR_WIDTH))
        q.push_front(t_wrin.data_in);
    end

    if(t_wrin.rd_cs && t_wrin.rd_en)begin
      if(q.size() > 0)begin
        q_out = q.pop_back();
          if(q_out != t_rdin.data_out) begin
            `uvm_error("SCOREBOARD","DATA OUT MISMATCH")
        end
      end
    end
    
    begin
      exp_emp = (q.size() == 0) ? 1:0;
      if(exp_emp) begin
        if(exp_emp != t_out.empty) begin
          `uvm_error("SCOREBOARD","EMPTY MISMATCH")
        end
      end
    end

    begin
    exp_full = q.size() == (1<<`ADDR_WIDTH) ? 1:0;
    if(exp_full) begin
        if(exp_full != t_out.full) begin
          `uvm_error("SCOREBOARD", "FULL MISMATCH")
        end
      end
    end
end
endtask

endclass 
  
