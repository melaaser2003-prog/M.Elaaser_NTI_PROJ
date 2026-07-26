module rising_edge_test;

  reg level;
  reg clk;
  reg rst;
  wire  me,mo; 

  rising_edge_moore mo1 (
  .level(level),
  .clk  (clk)  ,
  .reset(rst),
  .tick (mo)
);
  rising_edge_mealy me1 (
  .level(level),
  .clk  (clk)  ,
  .reset(rst),
  .tick (me)
);

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst =1;
    level = 0;
    #12;//12
    level = 1;
    #18;//30
    level=0;
    #2;//32
    level=1; ///glitch 
    #2;//34
    level=0;
    #8;//42
    level = 1;
    #5;
    level = 0;
    $display("\nTEST finished");
    $finish;
  end

endmodule
