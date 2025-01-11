`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 11:06:35 PM
// Design Name: 
// Module Name: 
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


interface uart_if;
    bit clk,rst;
    bit tx_done,rx_done;
    bit tx_serial,rx_serial;
    bit[7:0]rx_data;
    bit[7:0]tx_data;
    bit tx_start;
endinterface
