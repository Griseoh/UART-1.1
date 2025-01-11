`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 11:00:14 PM
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

class monitor;
    mailbox #(transaction)mbx1;
    transaction trans;
    virtual uart_if uif;
    
    function new(mailbox #(transaction)mbx1);
        this.mbx1 = mbx1;
    endfunction
    
    task run();
        trans = new();
        forever begin
            @(posedge uif.clk);
            trans.clk <= uif.clk;
            trans.rst <= uif.rst;
            trans.tx_done <= uif.tx_done;
            trans.rx_done <= uif.rx_done;
            trans.tx_serial <= uif.tx_serial;
            trans.rx_serial <= uif.rx_serial;
            trans.rx_data <= uif.rx_data;
            trans.tx_data <= uif.tx_data;
            trans.tx_start <= uif.tx_start;
            $display("[MON]: Interface Triggered");
        end
     endtask
endclass
