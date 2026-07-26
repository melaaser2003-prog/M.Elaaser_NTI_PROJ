module SPI_Wrapper(MOSI ,SS_n , clk,rst_n , MISO);
parameter MEM_DEPTH =256;
parameter ADDR_SIZE =8;
parameter IDLE =3'b000;
parameter CHK_CMD =3'b001;
parameter READ_ADD=3'b010;
parameter READ_DATA=3'b011;
parameter WRITE=3'b100;
input MOSI ,SS_n , clk,rst_n ;
output MISO;
wire rx_valid ,tx_valid;
wire [9:0]rx_data;
wire [7:0]tx_data;
 SPI_Slave #(.IDLE(IDLE) , .CHK_CMD(CHK_CMD) , .WRITE(WRITE),.READ_ADD(READ_ADD),.READ_DATA(READ_DATA)) spi(.MOSI(MOSI) ,
                                                                                                            .SS_n(SS_n) ,
                                                                                                            .clk(clk),
                                                                                                            .rst_n(rst_n),
                                                                                                            .tx_data(tx_data),
                                                                                                            .tx_valid(tx_valid),
                                                                                                            .MISO(MISO),
                                                                                                            .rx_data(rx_data),
                                                                                                            .rx_valid(rx_valid));
  RAM #(.MEM_DEPTH(MEM_DEPTH),.ADDR_SIZE(ADDR_SIZE)) ram (.din(rx_data),
                                                       	  .clk(clk),
                                                       	  .rst_n(rst_n),
                                                       	  .rx_valid(rx_valid),
                                                       	  .dout(tx_data),
                                                       	  .tx_valid(tx_valid));
endmodule
