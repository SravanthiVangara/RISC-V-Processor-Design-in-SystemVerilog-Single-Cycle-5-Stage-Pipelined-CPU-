// Code your testbench here
// or browse Examples
module hazard_tb;

reg [4:0] id_rs1;
reg [4:0] id_rs2;

reg [4:0] ex_rd;
reg ex_memread;

wire stall;

hazard_detection dut(
id_rs1,
id_rs2,
ex_rd,
ex_memread,
stall
);
initial begin
  $dumpfile("dump.vcd"); 
  $dumpvars(0,hazard_tb);
initial begin

id_rs1 = 5'd3;
id_rs2 = 5'd4;

ex_rd = 5'd3;
ex_memread = 1;

#10;

$display("STALL = %b",stall);

end

endmodule