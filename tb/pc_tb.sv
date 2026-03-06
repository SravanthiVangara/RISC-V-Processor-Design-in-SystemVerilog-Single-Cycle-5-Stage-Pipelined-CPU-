// Code your testbench here
// or browse Examples
module pc_tb;

logic clk;
logic rst;
logic [31:0] next_pc;
logic [31:0] pc_out;

pc DUT (
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc_out(pc_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
  
   initial begin
    $dumpfile("pc.vcd");
    $dumpvars(0,pc_tb);
end

initial begin
    $display("PC TEST START");

    rst = 1;
    next_pc = 0;
    #10;

    rst = 0;
    next_pc = 32'h4;
    #10;

    if (pc_out != 32'h4)
        $error("PC failed test");

    next_pc = 32'h8;
    #10;

    if (pc_out != 32'h8)
        $error("PC failed test");

    $display("PC TEST PASSED");
    $finish;
  
 
end

endmodule