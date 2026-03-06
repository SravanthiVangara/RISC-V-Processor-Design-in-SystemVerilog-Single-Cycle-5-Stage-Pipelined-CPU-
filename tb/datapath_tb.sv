// Code your testbench here
// or browse Examples
module datapath_tb;

logic clk;
logic rst;

datapath dut(
.clk(clk),
.rst(rst)
);

always #5 clk = ~clk;

initial begin

$dumpfile("datapath.vcd");
$dumpvars(0,datapath_tb);

clk=0;
rst=1;

#10;
rst=0;

#100;

$display("DATAPATH SIMULATION COMPLETE");

$finish;

end

endmodule