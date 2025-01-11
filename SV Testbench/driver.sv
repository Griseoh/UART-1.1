`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 10:35:43 PM
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

class driver;
    virtual uart_if uif;
    mailbox #(transaction)mbx0;
    transaction data_packet;
    
    function new(mailbox #(transaction)mbx0);
        this.mbx0 = mbx0;
    endfunction
    
    task run();
        forever begin
            mbx0.get(data_packet);
            @(posedge uif.clk);
            uif.clk <= data_packet.clk;
            uif.rst <= data_packet.rst;
            uif.tx_done <= data_packet.tx_done;
            uif.rx_done <= data_packet.rx_done;
            uif.tx_serial <= data_packet.tx_serial;
            uif.rx_serial <= data_packet.rx_serial;
            uif.rx_data <= data_packet.rx_data;
            uif.tx_data <= data_packet.tx_data;
            uif.tx_start <= data_packet.tx_start;
            $display("[DRV]: Interface Triggered");
        end
    endtask   
endclass
