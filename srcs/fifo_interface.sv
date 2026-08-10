interface fifo_interface(input clk, rst);
logic [DATA_WIDTH - 1: 0] data_in;
logic [DATA_WIDTH - 1: 0] data_out;
logic wr_cs;
logic rd_cs;
logic wr_en;
logic rd_en;
logic full;
logic empty;

clocking drvrd_cb @(clocking clk);
default input #1 output #1;
input data_out, full, empty;
output data_in, wr_cs, rd_cs, wr_en, rd_en;
endclocking


clocking drvwr_cb @(clocking clk);
default input #1 output #1;
input data_out, full, empty;
output data_in, wr_cs, rd_cs, wr_en, rd_en;
endclocking


clocking moninrd_cb @(clocking clk);
default input #1 output #1;
input data_in, wr_cs, rd_cs, wr_en, rd_en;
endclocking


clocking moninwr_cb @(clocking clk);
default input #1 output #1;
input data_in, wr_cs, rd_cs, wr_en, rd_en;
endclocking


clocking monout_cb @(clocking clk);
default input #1 output #1;
input data_out, full, empty;
endclocking

modport drvrd(clocking drvrd_cb);
modport drvwr(clocking drvwr_cb);
modport moninrd(clocking moninrd_cb);
modport moninwr(clocking moninwr_cb);
modport monout(clocking monout_cb);

endinterface
