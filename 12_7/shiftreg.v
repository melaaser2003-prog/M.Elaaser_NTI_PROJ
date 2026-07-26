module shiftreg #(parameter width = 20)
(
input wire clk, 
input wire rst_n, 
input wire shift_en,
input wire serial_in,
output reg [width-1 : 0] parallel_out

);
always @(posedge clk)
	begin
	if (shift_en)
		begin
			parallel_out <= {parallel_out[width-2:0],serial_in}
		end
	else
		begin
			parallel_out <= parallel_out
		end
	end






endmodule
