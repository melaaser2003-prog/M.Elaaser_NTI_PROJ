module SPI_Wrapper_tb();
parameter MEM_DEPTH =256;
parameter ADDR_SIZE =8;
parameter IDLE      =3'b000;
parameter CHK_CMD   =3'b001;
parameter READ_ADD  =3'b010;
parameter READ_DATA =3'b011;
parameter WRITE     =3'b100;
reg MOSI_tb ,SS_n_tb , clk_tb,rst_n_tb ;
wire MISO_tb ;
reg [9:0]address, data;
integer i=0;
SPI_Wrapper #(.MEM_DEPTH(MEM_DEPTH), .ADDR_SIZE(ADDR_SIZE) , .IDLE(IDLE) , .CHK_CMD(CHK_CMD) ,.WRITE(WRITE),.READ_ADD(READ_ADD),.READ_DATA(READ_DATA) ) 
                                                                                                                                                     DUT
                                                                                                                                                     ( .MOSI(MOSI_tb) , .SS_n(SS_n_tb) , .clk(clk_tb) , .rst_n(rst_n_tb),.MISO(MISO_tb));
initial begin
clk_tb=0;
forever
 #1 clk_tb=~clk_tb;
end


initial begin
 $readmemh("mem.dat",DUT.ram.mem);
 rst_n_tb=0;
 SS_n_tb=1;
 MOSI_tb=0;
 address=0;
 data=0;
 @(negedge clk_tb);
 rst_n_tb=1;
 //write address
 SS_n_tb=0;
 repeat(2)@(negedge clk_tb);
 address=10'b00_1111_0111;//wr_address ='hf7
 for(i=9;i>=0;i=i-1)begin
  MOSI_tb=address[i];
   @(negedge clk_tb);
 end
SS_n_tb=1;
 @(negedge clk_tb);

 SS_n_tb=0;
 //write data   mem[247]='hf0
@(negedge clk_tb);
 MOSI_tb=0;
 @(negedge clk_tb);
 data = 10'b01_1111_0000; 
for(i=9;i>=0;i=i-1)begin
  MOSI_tb=data[i];
   @(negedge clk_tb);
 end
SS_n_tb=1;
 @(negedge clk_tb);

 //read address 
 SS_n_tb=0;
 @(negedge clk_tb);
 MOSI_tb=1;
 @(negedge clk_tb);
 address = 10'b10_1111_0111;//rd_add='hf7
 for(i=9;i>=0;i=i-1)begin
  MOSI_tb=address[i];
   @(negedge clk_tb);
 end
 SS_n_tb=1;
 @(negedge clk_tb);

 //read_data
 SS_n_tb=0;
 @(negedge clk_tb);
 MOSI_tb=1;
 @(negedge clk_tb);
 data = 10'b11_1111_1111;//dout=mem[247]=f0  , dummy data we ignore it 
for(i=9;i>=0;i=i-1)begin
  MOSI_tb=data[i];
   @(negedge clk_tb);
 end  
 repeat(10)@(negedge clk_tb);
 SS_n_tb=1;
 @(negedge clk_tb);
 $stop;
end
endmodule