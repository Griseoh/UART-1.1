`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 04:55:41 PM
// Design Name: 
// Module Name: uartprotocoltop
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


module uartprotocoltop(clk,rst,tx_data,tx_start,tx_serial,rx_serial,rx_data,rx_done,tx_done);
    input clk,rst,tx_start,rx_serial;
    output rx_done,tx_done,tx_serial;
    input [7:0]tx_data;
    output [7:0]rx_data;
    
    wire baud_tick;
    
    uartbaudgenny ubg0(clk,rst,baud_tick);
    uarttransmitter utx0(clk,rst,baud_tick,tx_data,tx_start,tx_serial,tx_done);
    uartreceiver urx0(clk,rst,rx_serial,baud_tick,rx_data,rx_done);
endmodule
