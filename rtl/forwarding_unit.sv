module forwarding_unit (
    input  logic [4:0] ex_rs1,
    input  logic [4:0] ex_rs2,

    input  logic [4:0] mem_rd,
    input  logic       mem_regwrite,

    input  logic [4:0] wb_rd,
    input  logic       wb_regwrite,

    output logic [1:0] forwardA,
    output logic [1:0] forwardB
);

always_comb begin

    // Default: use normal register-file values
    forwardA = 2'b00;
    forwardB = 2'b00;

    // MEM stage has priority because it contains
    // the more recently produced value.
    if (mem_regwrite && (mem_rd != 5'd0) &&
        (mem_rd == ex_rs1))
        forwardA = 2'b10;

    else if (wb_regwrite && (wb_rd != 5'd0) &&
             (wb_rd == ex_rs1))
        forwardA = 2'b01;

    if (mem_regwrite && (mem_rd != 5'd0) &&
        (mem_rd == ex_rs2))
        forwardB = 2'b10;

    else if (wb_regwrite && (wb_rd != 5'd0) &&
             (wb_rd == ex_rs2))
        forwardB = 2'b01;

end

endmodule
