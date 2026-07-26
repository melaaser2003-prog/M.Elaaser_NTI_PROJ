module fsm_2 (
  input wire a,
  input wire b,
  input wire clk,
  input wire reset,
  output y0,
  output y1
);

  // State Encoding
  localparam [1:0] S0 = 2'b00,
                   S1 = 2'b01,
				   S2 = 2'b10;
  
  // Signals/Registers declaration 
  reg [1:0] present_state, next_state;
  
  // State_Register  -- 1st segment
  always@(posedge clk, negedge reset)
    begin : State_Register
	  if(!reset)
	    //present_state <= next_state;
		present_state <= S0;
	  else 
	    //present_state <= S0;
	    present_state <= next_state;
	end
  
  // Next State Logic & Output logic (both Moore and Mealy)  -- 2nd segment
  always@(*)
    begin
    y0 = 1'b0;
    y1 = 1'b1;
	  case(present_state)
	    S0:
		  begin
		    if(!a)
			  	begin
			    	next_state = S0;
			  	end
			else 
			  begin
			    if(b)
				  	begin
				    	next_state = S2;
				    	y0 = 1'b1;
				  	end
				else 
				  begin
				    next_state = S1;
				  end
			  end
		  end
		  S1:
		  begin
				if(!a)
			  	next_state = S1;
				else 
			  	next_state = S0;
		  end
		  S2:
		  begin
		    y1 = 1'b0;
		    next_state = S0;
		  end
	    default : next_state = S0;
	  endcase
	end

endmodule