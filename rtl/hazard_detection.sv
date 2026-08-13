module hazard_detection (
    input  logic [4:0] id_rs1,
    input  logic [4:0] id_rs2,

    input  logic [4:0] ex_rd,
    input  logic       ex_memread,

    output logic       stall
);

always_comb begin

    stall = 1'b0;

    // Load-use hazard:
    // instruction in EX is loading a value that the
    // instruction in ID immediately needs.
    if (ex_memread &&
        (ex_rd != 5'd0) &&
        ((ex_rd == id_rs1) || (ex_rd == id_rs2))) begin

        stall = 1'b1;

    end

end

endmodule
