// Code your testbench here
// or browse Examples
module mux2_tb;

logic [31:0] a;
logic [31:0] b;
logic sel;
logic [31:0] y;

mux2 dut(
.a(a),
.b(b),
.sel(sel),
.y(y)
);

initial begin

$dumpfile("mux.vcd");
$dumpvars(0,mux2_tb);

$display("MUX TEST START");

a = 10;
b = 20;

sel = 0;
#5;

if(y == 10)
$display("TEST1 PASS");

sel = 1;
#5;

if(y == 20)
$display("TEST2 PASS");

$display("MUX TEST COMPLETE");

end

endmodule