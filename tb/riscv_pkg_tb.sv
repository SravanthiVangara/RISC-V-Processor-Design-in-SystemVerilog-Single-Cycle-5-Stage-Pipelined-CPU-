// Code your testbench here
// or browse Examples
module pkg_tb;

import riscv_pkg::*;

initial begin
    $display("XLEN = %0d", XLEN);
    $display("Register count = %0d", REG_COUNT);

    $display("Opcode R-type = %b", OPCODE_RTYPE);
    $display("ALU ADD code = %0d", ALU_ADD);

    $display("Package working correctly!");
    $finish;
end

endmodule