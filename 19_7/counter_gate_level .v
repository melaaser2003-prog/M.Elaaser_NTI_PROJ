module updown_counter_gate_level (
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

  always@(posedge clk, posedge rst)
    begin
      if (rst) begin
        count <= 2'b0;
      end
      else begin
        count <= {d1,d0};
      end
  end

endmodule