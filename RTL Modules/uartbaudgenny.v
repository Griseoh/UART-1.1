`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 04:07:03 PM
// Design Name: 
// Module Name: uartbaudgenny
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


module uartbaudgenny(clk,rst,baud_tick);
    input clk,rst;
    output reg baud_tick;
    
    reg [15:0]tick_count;
    parameter clk_freq = 500000000, baud_rate = 96000;
    parameter ticks = clk_freq/baud_rate;
    
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            baud_tick <= 1'b0;
            tick_count <= 16'h0000;
        end
        else begin
            if(tick_count == ticks -1)begin
                tick_count <= 16'h0000;
                baud_tick <= 1'b1;
            end
            else begin
                tick_count <= tick_count +1'b1;
                baud_tick <= 1'b0;
            end
        end
    end
endmodule
