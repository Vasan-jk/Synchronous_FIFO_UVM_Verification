`include "fifo_interface.sv"
`include "test_pkg.sv"
`include "ram_dp_ar_aw.sv"
`include "sync_fifo.sv"

module fifo_top;
import uvm_pkg::*;
import test_pkg::*;
bit clk, rst;
fifo_interface fif(.clk(clk), .rst(rst));


syn_fifo dut(
.clk(clk)      , // Clock input
.rst(rst)      , // Active high reset
.wr_cs(fif.wr_cs)    , // Write chip select
.rd_cs(fif.rd_cs)    , // Read chip select
.data_in(fif.data_in)  , // Data input
.rd_en(fif.rd_en)    , // Read enable
.wr_en(fif.wr_en)    , // Write Enable
.data_out(fif.data_out) , // Data Output
.empty(fif.empty)    , // FIFO empty
.full(fif.full)       // FIFO full
);

initial begin
uvm_config_db#(virtual fifo_interface)::set(null,"*","fifo_if",fif);
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


