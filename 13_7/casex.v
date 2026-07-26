module casex_example (
input [3:0] a,b,c,
input [2:0] sel,
output reg [3:0] y
);
always @( a or b or c or sel )
casex (sel)
3'b000 : y =a; 
3'b0xx, 3'bx0x : y =b; //x1x 10x
3'b11x : y =c;
default : y =4'bx;
endcase
endmodule