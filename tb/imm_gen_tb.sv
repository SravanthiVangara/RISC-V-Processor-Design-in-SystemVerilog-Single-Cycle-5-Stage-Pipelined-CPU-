// Code your testbench here
// or browse Examples
module imm_gen_tb;

logic [31:0] instr;
logic [31:0] imm_out;

imm_gen dut(
    .instr(instr),
    .imm_out(imm_out)
);

initial begin

    $dumpfile("imm_gen.vcd");
    $dumpvars(0, imm_gen_tb);

    $display("IMM GEN TEST START");

    // I-type ADDI
    instr = 32'b000000000101_00010_000_00001_0010011;
    #10;

    // S-type SW
    instr = 32'b0000000_00001_00010_010_00011_0100011;
    #10;

    // B-type BEQ
    instr = 32'b0000000_00001_00010_000_00000_1100011;
    #10;

    // U-type LUI
    instr = 32'b00000000000000000001_00001_0110111;
    #10;

    // J-type JAL
    instr = 32'b00000000000100000000_00001_1101111;
    #10;

    $display("IMM GEN TEST DONE");

    $finish;

end

endmodule