module rising_edge_moore (
  input wire level,
  input wire clk,
  input wire reset,
  output reg tick 
);

  localparam [1:0] zero = 2'b00, 
                   edg  = 2'b01, 
                   one  = 2'b10; 
  reg [1:0] present_state, next_state;
  
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
        zero:next_state = level ? edg : zero ;
        edg :begin
          next_state = level ? one : zero ;
          tick = 1'b1;
        end
        one :begin
          next_state = level ? one : zero ;
          tick = 1'b0;
        end
        default : next_state = zero;
    endcase
  end

endmodule



