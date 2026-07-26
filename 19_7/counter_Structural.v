module updown_counter_Structural (
  input  clk,    
  input  rst,
  input  up,      
  output reg [1:0] count  
);
  reg d1,d0,q1,q0;

  always @(*) begin 
    q0 = count[0];
    q1 = count[1];
    d0 = ~q0;
    d1 = (up & (q1 ^ q0) )|(~up & ~(q1 ^ q0));
  end

  d_ff f1 (.d(d0),.clk(clock),.rst(reset),.q(count[0]));
  d_ff f1 (.d(d1),.clk(clock),.rst(reset),.q(count[1]));


endmodule

module d_ff (
    input d,
    input clk,
    input rst,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst) q <= 1'b0;
        else     q <= d;
    end
endmodule