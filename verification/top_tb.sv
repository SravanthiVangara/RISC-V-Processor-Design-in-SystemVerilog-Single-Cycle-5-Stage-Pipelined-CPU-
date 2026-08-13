class driver;

    task run();
        $display("Driver running");
    endtask

endclass


class monitor;

    task run();
        $display("Monitor running");
    endtask

endclass


class riscv_sequence;

    bit [31:0] instr_list [0:4];

    function new();

        instr_list[0] = 32'h003100B3;
        instr_list[1] = 32'h40628233;
        instr_list[2] = 32'h005303B3;

    endfunction

endclass


class env;

    driver d;
    monitor m;

    function new();

        d = new();
        m = new();

    endfunction

    task run();

        fork
            d.run();
            m.run();
        join

    endtask

endclass


module tb_top;

    reg clk;
    reg rst;

    env e;

    pipeline_cpu dut(
        .clk(clk),
        .rst(rst)
    );


    //=============================
    // CLOCK
    //=============================

    initial clk = 1'b0;

    always #5 clk = ~clk;


    //=============================
    // RESET
    //=============================

    initial begin

        rst = 1'b1;

        #20;

        rst = 1'b0;

    end


    //=============================
    // WAVEFORM
    //=============================

    initial begin

        $dumpfile("pipeline.vcd");
        $dumpvars(0, tb_top);

    end


    //=============================
    // SVA
    //=============================

    property x0_always_zero;

        @(posedge clk)
        disable iff (rst)
        dut.regfile[0] == 32'b0;

    endproperty

    assert property (x0_always_zero)
        else $error("SVA FAILED: x0 changed from zero!");


    //=============================
    // EASY SVA OUTPUT
    //=============================

    always @(posedge clk) begin

        if (!rst) begin

            if (dut.regfile[0] == 32'b0)

                $display("SVA PASS: x0 = %h",
                         dut.regfile[0]);

            else

                $display("SVA FAIL: x0 = %h",
                         dut.regfile[0]);

        end

    end


    //=============================
    // PIPELINE OBSERVATION
    //=============================

    always @(posedge clk) begin

        if (!rst) begin

            $display(
                "PC=%h INSTR=%h ALU=%h MEM=%h",
                dut.pc,
                dut.instr,
                dut.alu_result,
                dut.mem_result
            );

        end

    end


    //=============================
    // TEST
    //=============================

    initial begin

        e = new();

        #30;

        e.run();

        #200;

        $finish;

    end

endmodule
