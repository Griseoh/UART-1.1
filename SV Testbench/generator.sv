`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 09:12:14 PM
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
class generator;
    transaction trans;
    mailbox #(transaction)mbx0;
    int i = 0;
    
    function new(mailbox #(transaction)mbx0);
        this.mbx0 = mbx0;
        trans = new();
    endfunction
    
    task run();
            while(i<20)begin
                if(trans.tx_done == 1'b1)begin
                    assert(trans.randomize())
                    else $display("Randomization Failed");
                    $display("[GEN]: Data sent to Driver");
                    mbx0.put(trans.copy());
                    i = i+1;
                end
                else begin
                    if(i!=0)begin
                        i = i-1;
                    end
                end
            end
    endtask
endclass
