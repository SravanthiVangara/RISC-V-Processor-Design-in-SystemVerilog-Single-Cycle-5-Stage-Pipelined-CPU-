// Code your testbench here
// or browse Examples
module imem_tb;

logic [31:0] addr;
logic [31:0] instruction;

instruction_memory DUT(
 .addr(addr),
 .instruction(instruction)
);
initial begin
  $dumpfile("imem.vcd");
 $dumpvars(0, imem_tb);
end
initial begin
 
 addr = 0;
 #5;

 addr = 4;
 #5;

 addr = 8;
 #5;

 $finish;
end

endmodule
