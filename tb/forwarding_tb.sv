// Code your testbench here
// or browse Examples
module forwarding_tb;

    logic [4:0] ex_rs1;
    logic [4:0] ex_rs2;

    logic [4:0] mem_rd;
    logic       mem_regwrite;

    logic [4:0] wb_rd;
    logic       wb_regwrite;

    logic [1:0] forwardA;
    logic [1:0] forwardB;

    forwarding_unit dut (
        .ex_rs1(ex_rs1),
        .ex_rs2(ex_rs2),
        .mem_rd(mem_rd),
        .mem_regwrite(mem_regwrite),
        .wb_rd(wb_rd),
        .wb_regwrite(wb_regwrite),
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    initial begin

        // --------------------------------
        // Test 1: MEM forwarding
        // --------------------------------
        ex_rs1 = 5'd3;
        ex_rs2 = 5'd4;

        mem_rd = 5'd3;
        mem_regwrite = 1'b1;

        wb_rd = 5'd0;
        wb_regwrite = 1'b0;

        #10;

        $display("TEST 1: MEM forwarding");
        $display("forwardA = %b, forwardB = %b",
                 forwardA, forwardB);

        // --------------------------------
        // Test 2: WB forwarding
        // --------------------------------
        mem_rd = 5'd0;
        mem_regwrite = 1'b0;

        wb_rd = 5'd4;
        wb_regwrite = 1'b1;

        #10;

        $display("TEST 2: WB forwarding");
        $display("forwardA = %b, forwardB = %b",
                 forwardA, forwardB);

        // --------------------------------
        // Test 3: No forwarding
        // --------------------------------
        mem_rd = 5'd0;
        mem_regwrite = 1'b0;

        wb_rd = 5'd0;
        wb_regwrite = 1'b0;

        #10;

        $display("TEST 3: No forwarding");
        $display("forwardA = %b, forwardB = %b",
                 forwardA, forwardB);

        // --------------------------------
        // Test 4: MEM priority over WB
        // --------------------------------
        ex_rs1 = 5'd5;

        mem_rd = 5'd5;
        mem_regwrite = 1'b1;

        wb_rd = 5'd5;
        wb_regwrite = 1'b1;

        #10;

        $display("TEST 4: MEM priority");
        $display("forwardA = %b", forwardA);

        $finish;

    end

endmodule
