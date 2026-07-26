module driver #(parameter WIDTH = 8)(
 	input wire data_en,
 	input wire [WIDTH-1 : 0] data_in,
 	output reg [WIDTH-1 : 0] data_out
 	
 );
 
always @ (*)
	begin
		if (data_en) 
		begin
		 	data_out = data_in;
		end 
		else
		begin
			data_out = 8'bZ;
		end


	end



 endmodule 