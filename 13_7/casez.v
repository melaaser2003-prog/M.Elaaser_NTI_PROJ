module casez_example (
input [3:0]a,b,c,
input [2:0]sel,
output reg[3:0]y
);
always @(a or b or c or sel)

casez (sel)
3'b000 : y =a;
3'b0??, 3'b?0? : y =b; //10x
3'b11z : y =c;
default : y =4'bx;

endcase
endmodule
