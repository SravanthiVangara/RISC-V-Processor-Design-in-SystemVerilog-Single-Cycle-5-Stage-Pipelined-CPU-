
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
        if (rst)
            pc <= 32'b0;
        else
            pc <= pc + 32'd4;
    end


    //=============================
    // INSTRUCTION MEMORY
    //=============================

    reg [31:0] imem [0:255];

    wire [31:0] instr;

    assign instr = imem[pc[9:2]];

    integer i;

    initial begin

        // ADD x1, x2, x3
        imem[0] = 32'h003100B3;

        // SUB x4, x5, x6
        imem[1] = 32'h40628233;

        // ADD x7, x6, x5
        imem[2] = 32'h005303B3;

        // NOP
        for (i = 3; i < 256; i = i + 1)
            imem[i] = 32'h00000013;

    end


    //=============================
    // IF/ID PIPELINE REGISTER
    //=============================

    reg [31:0] if_id_instr;
    reg [31:0] if_id_pc;

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            if_id_instr <= 32'b0;
            if_id_pc    <= 32'b0;
        end
        else begin
            if_id_instr <= instr;
            if_id_pc    <= pc;
        end
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

    assign rs1_data =
        (rs1 == 5'd0) ? 32'b0 : regfile[rs1];

    assign rs2_data =
        (rs2 == 5'd0) ? 32'b0 : regfile[rs2];

    integer j;

    initial begin
        for (j = 0; j < 32; j = j + 1)
            regfile[j] = 32'b0;
    end


    //=============================
    // ID/EX PIPELINE REGISTER
    //=============================

    reg [31:0] id_ex_rs1_data;
    reg [31:0] id_ex_rs2_data;
    reg [4:0]  id_ex_rd;

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            id_ex_rs1_data <= 32'b0;
            id_ex_rs2_data <= 32'b0;
            id_ex_rd       <= 5'b0;
        end
        else begin
            id_ex_rs1_data <= rs1_data;
            id_ex_rs2_data <= rs2_data;
            id_ex_rd       <= rd;
        end
    end


    //=============================
    // EXECUTE STAGE
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

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            ex_mem_result <= 32'b0;
            ex_mem_rd     <= 5'b0;
        end
        else begin
            ex_mem_result <= alu_result;
            ex_mem_rd     <= id_ex_rd;
        end
    end


    //=============================
    // MEMORY STAGE
    //=============================

    reg [31:0] mem_result;
    reg [4:0]  mem_rd;

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            mem_result <= 32'b0;
            mem_rd     <= 5'b0;
        end
        else begin
            mem_result <= ex_mem_result;
            mem_rd     <= ex_mem_rd;
        end
    end


    //=============================
    // WRITEBACK STAGE
    //=============================

    always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            regfile[0] <= 32'b0;
        end
        else begin

            if (mem_rd != 5'd0)
                regfile[mem_rd] <= mem_result;

            // RISC-V x0 is always zero
            regfile[0] <= 32'b0;

        end
    end

endmodule
