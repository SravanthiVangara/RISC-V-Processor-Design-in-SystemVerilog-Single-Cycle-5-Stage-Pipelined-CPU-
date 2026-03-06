// ---------------- CONTROL UNIT ----------------
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

    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    ALUSrc   = 0;
    MemtoReg = 0;
    ALUOp    = 2'b00;

    case(opcode)

        7'b0110011: begin
            RegWrite = 1;
            ALUOp    = 2'b10;
        end

        7'b0010011: begin
            RegWrite = 1;
            ALUSrc   = 1;
        end

        7'b0000011: begin
            RegWrite = 1;
            MemRead  = 1;
            MemtoReg = 1;
            ALUSrc   = 1;
        end

        7'b0100011: begin
            MemWrite = 1;
            ALUSrc   = 1;
        end

        7'b1100011: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

    endcase

end

endmodule


// ---------------- DATAPATH ----------------
module datapath(

    input logic clk,
    input logic rst,
    output logic [31:0] instruction

);

logic [31:0] pc;

always_ff @(posedge clk or posedge rst)
begin
    if(rst)
        pc <= 0;
    else
        pc <= pc + 4;
end

assign instruction = 32'h00000013; // NOP instruction

endmodule


// ---------------- TOP MODULE ----------------
module riscv_core
(
    input logic clk,
    input logic rst
);

logic [31:0] instruction;

logic mem_read;
logic mem_write;
logic reg_write;
logic alu_src;

logic [3:0] alu_sel;

datapath dp(
.clk(clk),
.rst(rst),
.instruction(instruction)
);

control_unit cu(
.opcode(instruction[6:0]),
.RegWrite(reg_write),
.MemRead(mem_read),
.MemWrite(mem_write),
.Branch(),
.ALUSrc(alu_src),
.MemtoReg(),
.ALUOp()
);

endmodule
module riscv_core
(
    input logic clk,
    input logic rst
);

logic [31:0] instruction;

logic mem_read;
logic mem_write;
logic reg_write;
logic alu_src;

logic [3:0] alu_sel;

datapath dp(
    .clk(clk),
    .rst(rst),
    .instruction(instruction)
);

control_unit cu(
    .instruction(instruction),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .reg_write(reg_write),
    .alu_src(alu_src),
    .alu_sel(alu_sel)
);

endmodule