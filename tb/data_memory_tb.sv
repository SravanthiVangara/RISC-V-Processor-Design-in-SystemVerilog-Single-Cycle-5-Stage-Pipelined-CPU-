// Code your testbench here
// or browse Examples
module data_memory_tb;

logic clk;
logic mem_read;
logic mem_write;
logic [31:0] address;
logic [31:0] write_data;
logic [31:0] read_data;

data_memory dut(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(address),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;

initial
begin

$dumpfile("data_mem.vcd");
$dumpvars(0,data_memory_tb);

clk = 0;

$display("DATA MEMORY TEST START");

mem_write = 1;
mem_read  = 0;
address   = 8;
write_data = 55;

#10;

mem_write = 0;
mem_read  = 1;
address   = 8;

#5;

if(read_data == 55)
    $display("DATA MEMORY TEST PASSED");
else
    $display("DATA MEMORY TEST FAILED");

#10;
$finish;

end

endmodule