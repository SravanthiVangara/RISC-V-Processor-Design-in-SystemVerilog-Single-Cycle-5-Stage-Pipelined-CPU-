module register_file_tb;

    logic clk;
    logic we;

    logic [4:0] rs1;
    logic [4:0] rs2;
    logic [4:0] rd;

    logic [31:0] write_data;

    logic [31:0] read_data1;
    logic [31:0] read_data2;

    register_file dut (
        .clk(clk),
        .we(we),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock
    always #5 clk = ~clk;

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        clk = 1'b0;

        we = 1'b0;
        rs1 = 5'd0;
        rs2 = 5'd0;
        rd = 5'd0;
        write_data = 32'b0;

        // --------------------------------
        // Test 1: Write x5
        // --------------------------------
        #5;

        we = 1'b1;
        rd = 5'd5;
        write_data = 32'h12345678;

        #10;

        we = 1'b0;
        rs1 = 5'd5;

        #1;

        $display("TEST 1: x5 = %h", read_data1);

        // --------------------------------
        // Test 2: Read x5 and x0
        // --------------------------------
        rs1 = 5'd5;
        rs2 = 5'd0;

        #1;

        $display("TEST 2: x5 = %h, x0 = %h",
                 read_data1, read_data2);

        // --------------------------------
        // Test 3: Attempt to write x0
        // --------------------------------
        we = 1'b1;
        rd = 5'd0;
        write_data = 32'hFFFFFFFF;

        #10;

        we = 1'b0;
        rs1 = 5'd0;

        #1;

        $display("TEST 3: x0 = %h", read_data1);

        // --------------------------------
        // Test 4: Write x10
        // --------------------------------
        we = 1'b1;
        rd = 5'd10;
        write_data = 32'hAABBCCDD;

        #10;

        we = 1'b0;
        rs1 = 5'd10;

        #1;

        $display("TEST 4: x10 = %h", read_data1);

        $finish;

    end

endmodule
