// Code your design here
module hazard_detection(

input [4:0] id_rs1,
input [4:0] id_rs2,

input [4:0] ex_rd,
input ex_memread,

output reg stall

);

always @(*) begin

stall = 0;

if(ex_memread && ((ex_rd == id_rs1) || (ex_rd == id_rs2)))
stall = 1;

end

endmodule