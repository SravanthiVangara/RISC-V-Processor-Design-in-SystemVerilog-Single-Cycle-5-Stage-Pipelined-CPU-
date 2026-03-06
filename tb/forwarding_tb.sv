// Code your testbench here
// or browse Examples
module forwarding_tb;

reg [4:0] ex_rs1;
reg [4:0] ex_rs2;

reg [4:0] mem_rd;
reg mem_regwrite;

reg [4:0] wb_rd;
reg wb_regwrite;

wire [1:0] forwardA;
wire [1:0] forwardB;

forwarding_unit dut(
ex_rs1,
ex_rs2,
mem_rd,
mem_regwrite,
wb_rd,
wb_regwrite,
forwardA,
forwardB
);

initial begin

ex_rs1 = 5'd3;
ex_rs2 = 5'd4;

mem_rd = 5'd3;
mem_regwrite = 1;

wb_rd = 0;
wb_regwrite = 0;

#10;

$display("forwardA = %b",forwardA);
$display("forwardB = %b",forwardB);

end

endmodule