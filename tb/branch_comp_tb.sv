// Code your testbench here
// or browse Examples
module branch_comp_tb;

logic [31:0] rs1;
logic [31:0] rs2;
logic [2:0] funct3;
logic branch_taken;

branch_comp dut(
.rs1(rs1),
.rs2(rs2),
.funct3(funct3),
.branch_taken(branch_taken)
);

initial begin

$dumpfile("branch.vcd");
$dumpvars(0,branch_comp_tb);

$display("BRANCH TEST START");

rs1 = 10;
rs2 = 10;
funct3 = 3'b000; // BEQ
#5;

if(branch_taken)
$display("BEQ PASS");

rs1 = 10;
rs2 = 5;
funct3 = 3'b001; // BNE
#5;

if(branch_taken)
$display("BNE PASS");

rs1 = 3;
rs2 = 8;
funct3 = 3'b100; // BLT
#5;

if(branch_taken)
$display("BLT PASS");

$display("BRANCH TEST COMPLETE");

end

endmodule