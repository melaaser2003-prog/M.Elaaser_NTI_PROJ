module my_dff (
	input clk,
	input d,
	output q	
);

  always @(posedge clk ) begin
  	q<=d;
  end
endmodule 











module top_module ( 
	input clk,
	input d,
	output q 
	);
wire d,;
	my_dff d1 (clk,,)
	my_dff d2 (clk,,)
	my_dff d2 (clk,,)
endmodule
