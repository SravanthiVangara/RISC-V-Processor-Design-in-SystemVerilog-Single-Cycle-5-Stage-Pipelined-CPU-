// Code your testbench here
// or browse Examples
module register_file_tb;

logic clk;
logic we;
logic [4:0] rs1, rs2, rd;
logic [31:0] write_data;
logic [31:0] read_data1, read_data2;

register_file DUT (
    .clk(clk),
    .we(we),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
  
   initial begin
    $dumpfile("register_file.vcd");
    $dumpvars(0,register_file_tb);
end

initial begin
    $display("Register File Test Start");

    we = 1;
    rd = 5;
    write_data = 32'd100;
    #10;

    rs1 = 5;
    #5;

    if (read_data1 != 100)
        $error("Register write failed");

    rd = 0;
    write_data = 999;
    #10;

    rs1 = 0;
    #5;

    if (read_data1 != 0)
        $error("x0 register failed");

    $display("Register File Test Passed");
    $finish;
end

endmodule