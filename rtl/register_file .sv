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