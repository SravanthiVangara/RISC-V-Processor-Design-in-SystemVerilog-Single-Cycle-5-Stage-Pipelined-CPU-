// Code your design here
package riscv_pkg;

// CPU data width
parameter XLEN = 32;

// Number of registers in RISC-V
parameter REG_COUNT = 32;

// Instruction opcode types
typedef enum logic [6:0] {
    OPCODE_RTYPE = 7'b0110011,
    OPCODE_ITYPE = 7'b0010011,
    OPCODE_LOAD  = 7'b0000011,
    OPCODE_STORE = 7'b0100011,
    OPCODE_BRANCH= 7'b1100011
} opcode_t;

// ALU operations
typedef enum logic [3:0] {
    ALU_ADD,
    ALU_SUB,
    ALU_AND,
    ALU_OR
} alu_op_t;

endpackage