// Code your design here
module instruction_memory(
 input  logic [31:0] addr,
 output logic [31:0] instruction
);

logic [31:0] mem [0:255];

initial begin
 mem[0] = 32'h002081B3;
 mem[1] = 32'h40628233;
 mem[2] = 32'h005303B3;
end

assign instruction = mem[addr[9:2]];

endmodule