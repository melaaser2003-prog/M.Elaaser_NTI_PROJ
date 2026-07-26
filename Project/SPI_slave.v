module SPI_Slave(MOSI ,SS_n ,clk,rst_n,tx_data, tx_valid,MISO,rx_data,rx_valid);
parameter IDLE      =3'b000;
parameter CHK_CMD   =3'b001;
parameter READ_ADD  =3'b010;
parameter READ_DATA =3'b011;
parameter WRITE     =3'b100;
input clk , rst_n , SS_n , MOSI , tx_valid;
input [7:0] tx_data;
output reg MISO , rx_valid;
output reg [9:0] rx_data;
(* fsm_encoding = "gray" *)
reg [2:0]cs,ns;
reg received_add;
reg [3:0]s_p_counter ;
reg [2:0]p_s_counter;


//cs logic
always @(posedge clk ) begin
 if (~rst_n) begin	
  cs<=IDLE;
 end
 else begin
  cs<=ns;
 end
end

// ns logic
always@(*) begin
 case(cs)
  IDLE: begin
         if(~SS_n) begin
          ns=CHK_CMD;
         end
         else begin
          ns=IDLE;
         end
        end
  CHK_CMD: begin
  	        if(SS_n) begin
  	         ns=IDLE;
  	        end
  	        else if ( (~SS_n) && (~MOSI)) begin
  	         ns=WRITE;
  	        end
  	        else if((~SS_n) && (MOSI) && (~received_add) ) begin
  	         ns=READ_ADD;
  	        end
  	        else if((~SS_n) && (MOSI) && (received_add)) begin
  	         ns=READ_DATA;
  	        end
           end
  WRITE: begin
  	      if (SS_n) begin
  	       ns=IDLE;
  	      end
  	      else begin
  	       ns=WRITE;
  	      end
         end
  READ_ADD: begin
  	         if(SS_n) begin
  	          ns=IDLE;
  	         end
  	         else begin
  	          ns=READ_ADD;
  	         end
            end
  READ_DATA: begin
  	          if(SS_n) begin
  	           ns=IDLE;
  	          end
  	          else begin
  	           ns=READ_DATA;
  	          end
             end
    default: ns=IDLE;
 endcase
end

//output logic
always @(posedge clk ) begin
 if (~rst_n) begin
  MISO<=0;
  rx_valid<=0;
  rx_data<=0;
  s_p_counter<=9;
  p_s_counter<=7;
  received_add<=0;
 end
 else begin
  case(cs)
    IDLE : begin
          rx_valid<=0;
          rx_data<=0;
          MISO<=0;
          s_p_counter<=9;
          p_s_counter<=7;
         end
    CHK_CMD: begin
          rx_valid<=0;
          rx_data<=0;
          MISO<=0;
          s_p_counter<=9;
          p_s_counter<=7;
         end
    WRITE: begin
            rx_data[s_p_counter]<=MOSI;
            s_p_counter<=(s_p_counter>0)? s_p_counter-1:0;
            rx_valid<=(s_p_counter==0)?1:0;  
           end
    READ_ADD: begin
               rx_data[s_p_counter]<=MOSI;
               s_p_counter<=(s_p_counter>0)? s_p_counter-1:0;
               rx_valid<=(s_p_counter==0)?1'b1:1'b0;
               received_add<=(s_p_counter==0)?1'b1:1'b0;
              end
    READ_DATA: begin
                if(tx_valid==0) begin
                 rx_data[s_p_counter]<=MOSI;
                 s_p_counter<=(s_p_counter>0)? s_p_counter-1:0;
                 rx_valid<=(s_p_counter==0)?1:0;    
                end
                else begin
                 MISO<=tx_data[p_s_counter];
                 p_s_counter<=(p_s_counter>0)?p_s_counter-1:0;
                 if(p_s_counter==0) begin
                     received_add<=0;
                 end
                end
               end
  endcase   
 end
end
endmodule

