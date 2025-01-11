`timescale 1ns / 1ps
`include "transaction.sv"
`include "driver.sv"
`include "generator.sv"
`include "monitor.sv"
`include "scoreboard.sv"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 08:46:39 PM
// Design Name: 
// Module Name: uarttestbench
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


module uarttestbench;

    uart_if uif;
    monitor mon;
    scoreboard sco;
    mailbox #(transaction)mbx1;
    driver drv;
    generator gen;
    mailbox #(transaction)mbx0;
    
    uartprotocoltop dut(uif.clk,uif.rst,uif.tx_data,uif.tx_start,uif.tx_serial,uif.rx_serial,uif.rx_data,uif.rx_done,uif.tx_done);
    
    initial begin
        uif.clk <= 0;
    end
    
    always #10 uif.clk <= ~uif.clk;
    
    initial begin
        mbx0 = new();
        mbx1 = new();
        
        gen = new(mbx0);
        drv = new(mbx0);
        
        mon = new(mbx1);
        sco = new(mbx1);
        
        mon.uif = uif;
    end
    
    initial begin
        fork
            gen.run();
            drv.run();
            mon.run();
            sco.run();
        join
        
        $display("Simulation Finished");
        $finish;
    end
endmodule
