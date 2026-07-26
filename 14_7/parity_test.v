module parity_test;

  reg  clk;
  reg  rst;
  reg  serial_in;
  wire parity_out;
  

  stream_parity_gen p1 ( 
    .clk        ( clk        ),
    .reset      ( rst        ),
    .serial_in  ( serial_in  ),
    .parity_out ( parity_out ) 
  );

  
  task expect;
    input exp_out;
    if (parity_out !== exp_out) begin
      $display("TEST FAILED");
      $display("At time %0d rst=%b parity_out=%b", $time, rst, parity_out);
      $display("parity_out should be %b", exp_out);
      $finish;
    end
    else begin
      $display("At time %0d rst=%b  parity_out=%b", $time, rst, parity_out);
    end
  endtask



  task sen(input [7:0] d);
    integer i;
    begin
        for (i = 7; i >= 0; i = i - 1) begin
            @(negedge clk);
            serial_in = d[i];              
        end
    end
  endtask

task all(input [7:0]b);
    integer i;
    reg t;
    for(i=1;i<=b;i=i+1) begin
      sen(i); @(negedge clk);
      t=^i;
      expect(t);
    end
endtask



  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst = 1; serial_in = 0;
    @(negedge clk);
    rst = 0; 
    all(255);
    
    $display("TEST PASSED");
    $finish;
  end

endmodule
