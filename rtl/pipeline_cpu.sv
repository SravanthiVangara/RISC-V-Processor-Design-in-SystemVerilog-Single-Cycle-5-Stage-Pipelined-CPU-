module pipeline_cpu(

input clk,
input rst

);

//=============================
// PROGRAM COUNTER
//=============================

reg [31:0] pc;

always @(posedge clk or posedge rst)
begin
    if(rst)
        pc <= 0;
    else
        pc <= pc + 4;
end


//=============================
// INSTRUCTION MEMORY
//=============================

reg [31:0] imem [0:255];

wire [31:0] instr;

assign instr = imem[pc[9:2]];


//=============================
// IF/ID PIPELINE REGISTER
//=============================

reg [31:0] if_id_instr;
reg [31:0] if_id_pc;

always @(posedge clk)
begin
    if_id_instr <= instr;
    if_id_pc    <= pc;
end


//=============================
// DECODE STAGE
//=============================

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

assign rs1 = if_id_instr[19:15];
assign rs2 = if_id_instr[24:20];
assign rd  = if_id_instr[11:7];


//=============================
// REGISTER FILE
//=============================

reg [31:0] regfile [0:31];

wire [31:0] rs1_data;
wire [31:0] rs2_data;

assign rs1_data = regfile[rs1];
assign rs2_data = regfile[rs2];


//=============================
// ID/EX PIPELINE REGISTER
//=============================

reg [31:0] id_ex_rs1_data;
reg [31:0] id_ex_rs2_data;
reg [4:0]  id_ex_rd;

always @(posedge clk)
begin
    id_ex_rs1_data <= rs1_data;
    id_ex_rs2_data <= rs2_data;
    id_ex_rd       <= rd;
end


//=============================
// EXECUTE STAGE (ALU)
//=============================

reg [31:0] alu_result;

always @(*)
begin
    alu_result = id_ex_rs1_data + id_ex_rs2_data;
end


//=============================
// EX/MEM PIPELINE REGISTER
//=============================

reg [31:0] ex_mem_result;
reg [4:0]  ex_mem_rd;

always @(posedge clk)
begin
    ex_mem_result <= alu_result;
    ex_mem_rd     <= id_ex_rd;
end


//=============================
// MEMORY STAGE
//=============================

reg [31:0] mem_result;
reg [4:0]  mem_rd;

always @(posedge clk)
begin
    mem_result <= ex_mem_result;
    mem_rd     <= ex_mem_rd;
end


//=============================
// WRITEBACK STAGE
//=============================

always @(posedge clk)
begin
    if(mem_rd != 0)
        regfile[mem_rd] <= mem_result;
end


endmodule