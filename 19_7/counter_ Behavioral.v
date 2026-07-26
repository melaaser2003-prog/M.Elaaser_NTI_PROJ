module updown_counter_Behavioral (
  input  clk,    
  input  rst,
  input  up,      
  output reg [1:0] count  
);

  always@(posedge clk, posedge rst)
    begin
      if (rst) begin
        count <= 2'b0;
      end
      else begin
        count<= up ? count + 1 : count - 1 ;
      end
  end

endmodule