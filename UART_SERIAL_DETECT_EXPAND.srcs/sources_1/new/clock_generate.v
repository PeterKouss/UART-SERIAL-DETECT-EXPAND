`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/23 15:21:31
// Design Name: 
// Module Name: clock_generate
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


module clock_generate(
    input sys_clk,
    input [12:0] buderate_code, //13d'325 as 9600Hz, 13d'27 as 115200Hz
    output reg uart_clk_16x=0
    );

    reg [12:0] counter=1;

    always @(posedge sys_clk) begin
        if (counter == buderate_code) begin
            counter<=1;
            uart_clk_16x <= ~uart_clk_16x;
        end
        else begin
            counter<=counter+1;
        end
    end

endmodule
