`include "fifo_interface.sv"
`include "test_pkg.sv"
`include "ram_dp_ar_aw.sv"
`include "sync_fifo.sv"

module fifo_top;
import uvm_pkg::*;
virtual fifo_interface vif;
bit clk, rst;


syn_fifo dut(
.clk(clk)      , // Clock input
.rst(rst)      , // Active high reset
.wr_cs(vif.wr_cs)    , // Write chip select
.rd_cs(vif.rd_cs)    , // Read chip select
.data_in(vif.data_in)  , // Data input
.rd_en(vif.rd_en)    , // Read enable
.wr_en(vif.wr_en)    , // Write Enable
.data_out(vif.data_out) , // Data Output
.empty(vif.empty)    , // FIFO empty
.full(vif.full)       // FIFO full
);

initial begin
uvm_config_db#(virtual fifo_interface)::set(null,"*","fifo_if",vif);
$dumpfile("waves.vcd");
$dumpvars;
run_test();
end

initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
rst = 0;
#10;
rst = 1;
#10;
rst = 0;
end
endmodule


