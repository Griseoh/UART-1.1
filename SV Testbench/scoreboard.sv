`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 11:01:31 PM
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


class scoreboard;
    mailbox #(transaction) mbx1;
    transaction trans;
    
    function new(mailbox #(transaction) mbx1);
        this.mbx1 = mbx1;
    endfunction
    
    task compare(input transaction trans);
        if(trans.tx_data == trans.rx_data) $display("[SCO]: Verified");
        else $display("[SCO]: Mismatch!");
    endtask
    
    task run();
        forever begin
            mbx1.get(trans);
            $display("[SCO]: Data received from Monitor");
            if(trans.rx_done == 1'b1)begin
                compare(trans);
            end
        end
    endtask
endclass
