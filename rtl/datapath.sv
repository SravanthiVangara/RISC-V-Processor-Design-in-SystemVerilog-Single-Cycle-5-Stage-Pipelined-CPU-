// Code your design here
// Code your design here
module pc (
    input  logic clk,
    input  logic rst,
    input  logic [31:0] next_pc,
    output logic [31:0] pc_out
);

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        pc_out <= 32'h00000000;
    else
        pc_out <= next_pc;
end

endmodule

// Code your design here

// Code your design here
module register_file (
    input  logic clk,
    input  logic we,                     // write enable
    input  logic [4:0] rs1,              // read register 1
    input  logic [4:0] rs2,              // read register 2
    input  logic [4:0] rd,               // destination register
    input  logic [31:0] write_data,      // data to write

    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

logic [31:0] registers [31:0];

always_ff @(posedge clk) begin
    if (we && rd != 0)
        registers[rd] <= write_data;
end

assign read_data1 = (rs1 == 0) ? 32'b0 : registers[rs1];
assign read_data2 = (rs2 == 0) ? 32'b0 : registers[rs2];

endmodule

// Code your design here
module instruction_memory(
 input  logic [31:0] addr,
 output logic [31:0] instruction
);

logic [31:0] mem [0:255];

initial begin
 mem[0] = 32'h002081B3;
 mem[1] = 32'h40628233;
 mem[2] = 32'h005303B3;
end

assign instruction = mem[addr[9:2]];

endmodule


// Code your design here
module imm_gen (
    input  logic [31:0] instr,
    output logic [31:0] imm_out
);

logic [6:0] opcode;

assign opcode = instr[6:0];

always_comb begin

    case(opcode)

        // I-Type (ADDI, LW)
        7'b0010011,
        7'b0000011:
            imm_out = {{20{instr[31]}}, instr[31:20]};

        // S-Type (SW)
        7'b0100011:
            imm_out = {{20{instr[31]}}, instr[31:25], instr[11:7]};

        // B-Type (BEQ)
        7'b1100011:
            imm_out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};

        // U-Type (LUI)
        7'b0110111:
            imm_out = {instr[31:12], 12'b0};

        // J-Type (JAL)
        7'b1101111:
            imm_out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0};

        default:
            imm_out = 32'b0;

    endcase

end

endmodule
// Code your design here
module data_memory
(
    input  logic        clk,
    input  logic        mem_read,
    input  logic        mem_write,

    input  logic [31:0] address,
    input  logic [31:0] write_data,

    output logic [31:0] read_data
);

logic [31:0] memory [0:255]; // 256 words memory

always_ff @(posedge clk)
begin
    if (mem_write)
        memory[address[9:2]] <= write_data;
end

always_comb
begin
    if (mem_read)
        read_data = memory[address[9:2]];
    else
        read_data = 32'b0;
end

endmodule

// Code your design here
module mux2
(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic sel,

    output logic [31:0] y
);

always_comb
begin
    if(sel == 0)
        y = a;
    else
        y = b;
end

endmodule

// Code your design here
module alu (
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0]  alu_sel,
    output logic [31:0] result
);

always_comb begin
    case (alu_sel)
        4'd0: result = a + b; // ADD
        4'd1: result = a - b; // SUB
        4'd2: result = a & b; // AND
        4'd3: result = a | b; // OR
        default: result = 0;
    endcase
end

endmodule

module datapath
(
    input logic clk,
    input logic rst
);

logic [31:0] pc;
logic [31:0] next_pc;
logic [31:0] instruction;

logic [31:0] rs1_data;
logic [31:0] rs2_data;

logic [31:0] alu_result;
logic [31:0] imm;

logic [31:0] mem_data;

logic mem_read;
logic mem_write;
logic reg_write;
logic alu_src;

logic [3:0] alu_sel;

logic [31:0] alu_in2;

// PC increment
assign next_pc = pc + 4;

// Temporary control signals (until control unit added)
assign mem_read  = 1'b0;
assign mem_write = 1'b0;
assign reg_write = 1'b0;
assign alu_src   = 1'b0;
assign alu_sel   = 4'b0000;


// ---------------- PC ----------------
pc pc_inst(
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc_out(pc)
);


// ---------------- Instruction Memory ----------------
instruction_memory imem(
    .addr(pc),
    .instruction(instruction)
);


// ---------------- Register File ----------------
register_file rf(
    .clk(clk),
    .we(reg_write),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .write_data(mem_data),
    .read_data1(rs1_data),
    .read_data2(rs2_data)
);


// ---------------- Immediate Generator ----------------
imm_gen ig(
    .instr(instruction),
    .imm_out(imm)
);


// ---------------- ALU MUX ----------------
mux2 alu_mux(
    .a(rs2_data),
    .b(imm),
    .sel(alu_src),
    .y(alu_in2)
);


// ---------------- ALU ----------------
alu alu_inst(
    .a(rs1_data),
    .b(alu_in2),
    .alu_sel(alu_sel),
    .result(alu_result)
);


// ---------------- Data Memory ----------------
data_memory dmem(
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(rs2_data),
    .read_data(mem_data)
);

endmodule