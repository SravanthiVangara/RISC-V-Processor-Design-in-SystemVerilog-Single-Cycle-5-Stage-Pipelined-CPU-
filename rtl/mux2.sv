// Code your design here
module mux2
(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic sel,

    output logic [31:0] y
);

always_comb
begin
    if(sel == 0)
        y = a;
    else
        y = b;
end

endmodule