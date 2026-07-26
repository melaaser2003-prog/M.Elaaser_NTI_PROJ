module stream_parity_gen_ddd( 
    input clk      ,rst     ,serial_in,
    output reg [7:0] sin,
    output reg parity_out   
);
  
  function parity(input [7:0] t); begin
      parity = ^t;
    end
  endfunction 

  always @(posedge clk) begin 
    if(rst) begin
      sin        <= 0;
      parity_out <= 0;
    end else begin
      sin        <= {sin[6:0], serial_in};
      parity_out <= parity({sin[6:0], serial_in}); 
    end
  end
  
endmodule
