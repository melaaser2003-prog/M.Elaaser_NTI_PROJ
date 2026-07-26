module memory#(parameter AWIDTH = 5 ,DWIDTH = 8)(
    input wire cl,
    input wire wr,
    input wire rd,
    input [AWIDTH-1:0] addr ,
    inout [DWIDTH-1:0] data  
   );
	reg [DWIDTH-1:0] mem [0:(1<<AWIDTH)-1];
	reg [DWIDTH-1:0] dataO;


	always @(posedge clk ) 
	begin 
		if (wr) 
		begin
			mem[addr] <= data;
		end
		if (rd) 
		begin
			dataO <= mem[addr];
		end
	end
	
	assign data = (rd) ? dataO : {DWIDTH{1'bz}}; 
	
endmodule