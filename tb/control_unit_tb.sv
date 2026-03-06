// Code your testbench here
// or browse Examples
module control_unit_tb;

logic [6:0] opcode;

logic RegWrite;
logic MemRead;
logic MemWrite;
logic Branch;
logic ALUSrc;
logic MemtoReg;
logic [1:0] ALUOp;

control_unit dut(
    .opcode(opcode),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .ALUSrc(ALUSrc),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp)
);

initial begin

    $dumpfile("control.vcd");
    $dumpvars(0, control_unit_tb);

    // R-type
    opcode = 7'b0110011;
    #10;

    // ADDI
    opcode = 7'b0010011;
    #10;

    // LOAD
    opcode = 7'b0000011;
    #10;

    // STORE
    opcode = 7'b0100011;
    #10;

    // BRANCH
    opcode = 7'b1100011;
    #10;

    $finish;

end

endmodule