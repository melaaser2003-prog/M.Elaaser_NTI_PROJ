module counter#(parameter WIDTH=5)( 
    input wire clk,
    input wire rst,
    input wire load,
    input wire enab,
    input [WIDTH-1:0] cnt_in,
    output reg [WIDTH-1:0] cnt_out   
);
  
  function [WIDTH-1:0] cnt (input [WIDTH-1:0]cnt_i,cnt_o,
			   input	load,enab);
    begin
      if (load) begin
          cnt = cnt_i;
      end
      else 
      begin
          if(enab)begin
            cnt = cnt_o +1;
          end
	  else 
    begin
	  cnt = cnt_o;
	  end
      end
    end
    
  endfunction 

  always @(posedge clk ) begin 
      if(rst) begin
        cnt_out<= 0;
      end 
      else begin
          cnt_out<=cnt(cnt_in,cnt_out,load,enab);
      end
  end  
endmodule