module counter #(parameter WIDTH = 5) (

input wire clk,
input wire enab,
input wire load,
input wire rst,
input wire [WIDTH-1 : 0]cnt_in,
output reg [WIDTH-1 : 0]cnt_out
);


always @(posedge clk or posedge rst) 
	begin
		if (rst) begin
			cnt_out <= 0;
		end
  	else if (load) 
  		begin
  			cnt_out <= cnt_in;
  		end
		else if (enab) 
			begin
				cnt_out <=	cnt_out + 1;
			end
		else
			begin
				cnt_out <= cnt_out;
			end


	end

endmodule 