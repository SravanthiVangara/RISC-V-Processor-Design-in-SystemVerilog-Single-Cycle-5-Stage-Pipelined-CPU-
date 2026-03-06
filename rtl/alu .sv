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