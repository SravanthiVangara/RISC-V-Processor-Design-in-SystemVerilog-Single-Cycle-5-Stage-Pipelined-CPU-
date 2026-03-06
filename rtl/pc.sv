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