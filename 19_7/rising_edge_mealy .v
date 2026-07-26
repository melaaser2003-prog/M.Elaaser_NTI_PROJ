module rising_edge_mealy (
  input wire level,
  input wire clk,
  input wire reset,
  output reg tick 
);

  localparam  zero = 1'b0,  one  = 1'b1;
  reg  present_state, next_state;
  
  always@(posedge clk, negedge reset)
    begin : State_Register
    if(!reset)
      present_state <= zero ;
    else 
      present_state <= next_state;
  end
  
  always@(*)
    begin
      tick = 1'b0;
      case(present_state)
        zero: if (level) begin
          next_state = one ;
          tick = 1'b1;
        end
        else next_state = zero ;

        one : if (level) begin
          next_state = one ;
          tick = 1'b0;
        end
        else begin
          next_state = zero ;
          tick = 1'b0;
        end 
        default : next_state = zero;
    endcase
  end

endmodule