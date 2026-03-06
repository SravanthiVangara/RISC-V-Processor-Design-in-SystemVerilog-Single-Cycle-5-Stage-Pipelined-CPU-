// Code your testbench here
// or browse Examples
module alu_tb;

logic [31:0] a;
logic [31:0] b;
logic [3:0] alu_sel;
logic [31:0] result;

alu DUT (
    .a(a),
    .b(b),
    .alu_sel(alu_sel),
    .result(result)
);
 initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0, alu_tb);
end
initial begin
    $display("ALU TEST START");

    a = 10;
    b = 5;

    alu_sel = 0; // ADD
    #5;
    if (result != 15) $error("ADD failed");

    alu_sel = 1; // SUB
    #5;
    if (result != 5) $error("SUB failed");

    alu_sel = 2; // AND
    #5;
    if (result != (10 & 5)) $error("AND failed");

    alu_sel = 3; // OR
    #5;
    if (result != (10 | 5)) $error("OR failed");

    $display("ALU TEST PASSED");
  
    $finish;
  
 
end

endmodule