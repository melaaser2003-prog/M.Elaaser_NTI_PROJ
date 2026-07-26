module stream_parity_gen #(parameter wi = 8)(
    input wire clk,
    input wire reset,
    input wire serial_in,
    output wire parity_out
);

    reg [wi-1:0] shift_reg;
    wire [wi:0] data;
    
    assign data[0] = serial_in;
    genvar i;
    generate
        for (i = 0; i < wi; i = i + 1) begin : chain
            register re (.clk(clk),.rst(reset),.data_in(data[i]),.data_out(data[i+1]));
        end
    endgenerate

    function calc_parity;
        input [wi-1:0] data_window;
        begin
            calc_parity = ^data_window; 
        end
    endfunction
  

    
    always @(posedge clk) begin 
       shift_reg  <= data[wi:1];
       
    end

    assign parity_out = calc_parity(shift_reg);

    //without delay @(posedge clk)
    /*always @(*) begin 
       shift_reg  = data[wi:1];
       parity_out = calc_parity(shift_reg);
    end
    */

endmodule


module register ( 
    input      clk,
    input      rst,
    input      data_in,
    output reg data_out 
);
    
    always @(posedge clk) begin  
        if (rst) begin
            data_out <= 0;
        end
        else begin
            data_out <= data_in;
        end
    end
    
endmodule