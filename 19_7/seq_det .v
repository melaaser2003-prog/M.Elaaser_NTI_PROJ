module seq_det_non (
  input wire sin,
  input wire clk,
  input wire reset,
  output reg det 
);

  localparam [2:0] S0 = 3'b000, //1
                   S1 = 3'b001, //01
                   S2 = 3'b010, //101
                   S3 = 3'b100, //0101
                   S4 = 3'b101, //10101
                   S5 = 3'b110, //110101

  reg [2:0] present_state, next_state;
  
  always@(posedge clk, negedge reset)
    begin : State_Register
    if(!reset)
      present_state <= S0;
    else 
      present_state <= next_state;
  end
  
  always@(*)
    begin
      next_state = current_state;
      det = 1'b0;
      case(present_state)
        S0:next_state = sin ? S1 : S0 ;//1
        S1:next_state = sin ? S0 : S2 ;//01
        S2:next_state = sin ? S3 : S0 ;//101
        S3:next_state = sin ? S0 : S4 ;//0101
        S4:next_state = sin ? S5 : S0 ;//10101
        S5:begin
          det=sin ? 1'b1 : 1'b0;
          next_state = S0 ; //110101
        end
        default : next_state = S0;
    endcase
  end

endmodule

/////////////////////////////////////////////

module seq_det_over (
  input wire sin,
  input wire clk,
  input wire reset,
  output reg det 
);

  localparam [2:0] S0 = 3'b000, //1
                   S1 = 3'b001, //01
                   S2 = 3'b010, //101
                   S3 = 3'b100, //0101
                   S4 = 3'b101, //10101
                   S5 = 3'b110, //110101

  reg [2:0] present_state, next_state;
  
  always@(posedge clk, negedge reset)
    begin : State_Register
    if(!reset)
      present_state <= S0;
    else 
      present_state <= next_state;
  end
  
  always@(*)
    begin
      next_state = current_state;
      det = 1'b0;
      case(present_state)
        S0:next_state = sin ? S1 : S0 ;//1
        S1:next_state = sin ? S1 : S2 ;//01    |    //11
        S2:next_state = sin ? S3 : S0 ;//101   |   //001
        S3:next_state = sin ? S1 : S4 ;//0101  |  //1101
        S4:next_state = sin ? S5 : S0 ;//10101 | //00101
        S5:begin
          if (sin) begin   //110101 
            det = 1'b1;
            next_state = S1  ;
          end
          else begin //010101
            next_state = S4  ;
          end
        end
        default : next_state = S0;
    endcase
  end

endmodule