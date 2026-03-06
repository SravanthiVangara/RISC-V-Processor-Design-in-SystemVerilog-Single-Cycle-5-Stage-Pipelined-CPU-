// Code your design here
// Code your design here
module alu_decoder (
    input  logic [2:0] funct3,
    input  logic       funct7,
    input  logic [1:0] alu_op,
    output logic [3:0] alu_sel
);

always_comb begin
    case (alu_op)

        2'b00: alu_sel = 4'd0; // ADD for load/store

        2'b01: alu_sel = 4'd1; // SUB for branch

        2'b10: begin
            case (funct3)
                3'b000: alu_sel = (funct7) ? 4'd1 : 4'd0; // SUB or ADD
                3'b111: alu_sel = 4'd2; // AND
                3'b110: alu_sel = 4'd3; // OR
                default: alu_sel = 4'd0;
            endcase
        end

        default: alu_sel = 4'd0;

    endcase
end

endmodule