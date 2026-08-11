`uvm_analysis_imp_decl(_wrinmon)
`uvm_analysis_imp_decl(_rdinmon)
`uvm_analysis_imp_decl(_outmon)

class fifo_scoreboard extends uvm_scoreboard;
`uvm_component_utils(fifo_scoreboard)

bit [`DATA_WIDTH-1:0] q[$];
bit [`DATA WIDTH-1:0] q_out;
bit empty, full;
uvm_analysis_imp_wrinmon #(fifo_seq_item, fifo_scoreboard) wrin_fifo;
uvm_analysis_imp_rdinmon #(fifo_seq_item, fifo_scoreboard) rdin_fifo;
uvm_analysis_imp_outmon #(fifo_seq_item, fifo_scoreboard) out_fifo;

fifo_seq_item t_wrin;
fifo_seq_item t_rdin;
fifo_seq_item t_out;

function new(string name = "fifo_scoreboard", uvm_component parent);
  super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  wrin_fifo = new(this, "wrin_fifo");
  rdin_fifo = new(this, "rdin_fifo");
  out_fifo = new(this,"out_fifo");
endfunction

virtual function void write_wrinmon(fifo_seq_item t_wrinmon);
  t_wrin = t_wrinmon;  
endfunction
virtual function void write_rdinmon(fifo_seq_item t_rdinmon);
  t_rdin = t_rdinmon;  
endfunction
virtual function void write_outmon(fifo_seq_item t_wrinmon);
  t_out = t_outmon;  
endfunction


task run_phase(uvm_phase phase);
forever begin

    if((q.size() < (1<<`ADDR_WIDTH)) && t_wrin.wr_cs && t_wrin.wr_en)
      q.push_front(t_wrin.data_in);

    if((q.size() > 0) && t_wrin.rd_cs && t_wrin.rd_en)begin
      q_out = q.pop_back();
      if(q_out != t_rdin.data_out) begin
          `uvm_error("SCOREBOARD","DATA OUT MISMATCH")
      end
    end
    if(q.size() == 0) begin
      empty = 1;
      if(empty != t_out.empty) begin
        `uvm_error("SCOREBOARD","EMPTY MISMATCH")
      end
    end
    if(q.size() == (1<<`ADDR_WIDTH)) begin
      full = 1;
      if(full != t_out.full) begin
        `uvm_error("SCOREBOARD", "FULL MISMATCH")
      end
    end
end
endtask

endclass 
  
