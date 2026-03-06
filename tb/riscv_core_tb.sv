// Code your testbench here
// or browse Examples
module riscv_core_tb;

logic clk;
logic rst;

riscv_core dut(
.clk(clk),
.rst(rst)
);

always #5 clk = ~clk;

initial begin

$dumpfile("cpu.vcd");
$dumpvars(0,riscv_core_tb);

clk = 0;
rst = 1;

#10;
rst = 0;

#200;

$display("CPU simulation complete");

$finish;

end

endmodule