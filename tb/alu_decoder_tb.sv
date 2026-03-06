// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
module alu_decoder_tb;

logic [2:0] funct3;
logic funct7;
logic [1:0] alu_op;
logic [3:0] alu_sel;

alu_decoder DUT (
    .funct3(funct3),
    .funct7(funct7),
    .alu_op(alu_op),
    .alu_sel(alu_sel)
);
 initial begin
   $dumpfile("alu_decoder.vcd");
   $dumpvars(0, alu_decoder_tb);
end
initial begin
    $display("ALU DECODER TEST START");

    alu_op = 2'b00;
    #5;
    if (alu_sel != 0) $error("Load/Store ADD failed");

    alu_op = 2'b01;
    #5;
    if (alu_sel != 1) $error("Branch SUB failed");

    alu_op = 2'b10;
    funct3 = 3'b000;
    funct7 = 0;
    #5;
    if (alu_sel != 0) $error("ADD failed");

    funct7 = 1;
    #5;
    if (alu_sel != 1) $error("SUB failed");

    $display("ALU DECODER TEST PASSED");
    $finish;
end

endmodule