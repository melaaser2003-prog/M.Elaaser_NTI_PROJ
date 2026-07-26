`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 03:16:18 PM
// Design Name: 
// Module Name: timing_paths
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timing_paths (
    input wire clk,
    input wire in_data,      
    input wire in_comb,      
    output wire out_data,   
    output wire out_comb     
);

    reg reg_A;
    reg reg_B;

    always @(posedge clk) begin
        reg_A <= in_data; 
    end

    always @(posedge clk) begin
        reg_B <= ~reg_A; 
    end

    assign out_data = reg_B;

    assign out_comb = in_comb & 1'b1;

endmodule
