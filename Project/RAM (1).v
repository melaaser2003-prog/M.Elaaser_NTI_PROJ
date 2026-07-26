module RAM(din,clk,rst_n,rx_valid,dout,tx_valid);
parameter MEM_DEPTH =256;
parameter ADDR_SIZE =8;
input [9:0]din;
input clk,rst_n ,rx_valid;
output reg [7:0] dout;
output reg tx_valid;
reg [7:0] mem [MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0] rd_add , wr_add;
always @(posedge clk ) begin
 if (!rst_n) begin	
 dout<=8'b0;
 tx_valid<=1'b0;
 wr_add<={ADDR_SIZE{1'b0}};
 rd_add<={ADDR_SIZE{1'b0}};
 end
 else if(rx_valid)  begin
  case(din[9:8])
   2'b00: begin
           wr_add<=din[7:0];
           tx_valid<=1'b0;
          end
   2'b01: begin
           mem[wr_add]<=din[7:0];
           tx_valid<=1'b0;
          end
   2'b10: begin
           rd_add<=din[7:0];
           tx_valid<=0;
          end 
   2'b11: begin
   	dout<=mem[rd_add];
        tx_valid<=1;	
   end
  endcase
 end
end
endmodule


  