module hazard_tb;

    logic [4:0] id_rs1;
    logic [4:0] id_rs2;

    logic [4:0] ex_rd;
    logic       ex_memread;

    logic stall;

    hazard_detection dut (
        .id_rs1(id_rs1),
        .id_rs2(id_rs2),
        .ex_rd(ex_rd),
        .ex_memread(ex_memread),
        .stall(stall)
    );

    initial begin

        // --------------------------------
        // Test 1: Load-use hazard
        // --------------------------------
        id_rs1 = 5'd3;
        id_rs2 = 5'd4;

        ex_rd = 5'd3;
        ex_memread = 1'b1;

        #10;

        $display("TEST 1: Load-use hazard");
        $display("STALL = %b", stall);

        // --------------------------------
        // Test 2: No dependency
        // --------------------------------
        id_rs1 = 5'd5;
        id_rs2 = 5'd6;

        ex_rd = 5'd3;
        ex_memread = 1'b1;

        #10;

        $display("TEST 2: No dependency");
        $display("STALL = %b", stall);

        // --------------------------------
        // Test 3: Not a load
        // --------------------------------
        id_rs1 = 5'd3;
        id_rs2 = 5'd4;

        ex_rd = 5'd3;
        ex_memread = 1'b0;

        #10;

        $display("TEST 3: EX instruction is not a load");
        $display("STALL = %b", stall);

        // --------------------------------
        // Test 4: Dependency on x0
        // --------------------------------
        id_rs1 = 5'd0;
        id_rs2 = 5'd4;

        ex_rd = 5'd0;
        ex_memread = 1'b1;

        #10;

        $display("TEST 4: x0 dependency");
        $display("STALL = %b", stall);

        $finish;

    end

endmodule
