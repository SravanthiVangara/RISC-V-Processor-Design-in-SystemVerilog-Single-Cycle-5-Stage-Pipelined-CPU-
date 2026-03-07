//=============================
// DRIVER
//=============================

class driver;

  task run();
    $display("Driver running");
  endtask

endclass


//=============================
// MONITOR
//=============================

class monitor;

  task run();
    $display("Monitor running");
  endtask

endclass


//=============================
// SEQUENCE
//=============================

class riscv_sequence;

  bit [31:0] instr_list [0:4];

  function new();
    instr_list[0] = 32'h003100B3;
    instr_list[1] = 32'h40628233;
    instr_list[2] = 32'h0002A303;
  endfunction

endclass


//=============================
// ENVIRONMENT
//=============================

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



//=============================
// TOP TESTBENCH
//=============================

module tb_top;

reg clk;
reg rst;

env e;


// DUT instance
pipeline_cpu dut(
  .clk(clk),
  .rst(rst)
);


//=============================
// CLOCK
//=============================

initial clk = 0;
always #5 clk = ~clk;


//=============================
// RESET
//=============================

initial begin
  rst = 1;
  #20 rst = 0;
end
  initial begin
  
$dumpfile("dump.vcd");
  $dumpvars(0,tb_top);
  end

//=============================
// ASSERTION
//=============================

property no_write_x0;

  @(posedge clk)
  disable iff(rst)
  (dut.mem_rd == 0) |-> (dut.mem_result == 0);

endproperty

assert property(no_write_x0);


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
