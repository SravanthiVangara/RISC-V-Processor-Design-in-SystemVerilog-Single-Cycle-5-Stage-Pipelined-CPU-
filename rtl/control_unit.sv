// Code your design here
module control_unit(

    input  logic [6:0] opcode,

    output logic RegWrite,
    output logic MemRead,
    output logic MemWrite,
    output logic Branch,
    output logic ALUSrc,
    output logic MemtoReg,
    output logic [1:0] ALUOp

);

always_comb begin

    // default values
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    ALUSrc   = 0;
    MemtoReg = 0;
    ALUOp    = 2'b00;

    case(opcode)

        // R-type
        7'b0110011: begin
            RegWrite = 1;
            ALUSrc   = 0;
            ALUOp    = 2'b10;
        end

        // I-type ADDI
        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
        end

        // LOAD
        7'b0000011: begin
            RegWrite = 1;
            MemRead  = 1;
            MemtoReg = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
        end

        // STORE
        7'b0100011: begin
            MemWrite = 1;
            ALUSrc   = 1;
            ALUOp    = 2'b00;
        end

        // BRANCH
        7'b1100011: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

    endcase

end

endmodule