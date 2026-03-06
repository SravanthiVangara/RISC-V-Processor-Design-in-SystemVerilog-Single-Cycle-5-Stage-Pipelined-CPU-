// Code your design here
module branch_comp
(
    input  logic [31:0] rs1,
    input  logic [31:0] rs2,
    input  logic [2:0]  funct3,

    output logic branch_taken
);

always_comb
begin

case(funct3)

3'b000: branch_taken = (rs1 == rs2); // BEQ
3'b001: branch_taken = (rs1 != rs2); // BNE
3'b100: branch_taken = (rs1 < rs2);  // BLT
3'b101: branch_taken = (rs1 >= rs2); // BGE

default: branch_taken = 0;

endcase

end

endmodule