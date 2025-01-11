`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 04:33:56 PM
// Design Name: 
// Module Name: uartreceiver
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


module uartreceiver(clk,rst,rx_serial,baud_tick,data_out,rx_done);
    input clk,rst,rx_serial,baud_tick;
    output reg [7:0] data_out;
    output reg rx_done;
    
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0]current_state, next_state;
    reg[2:0] bit_index;
    reg [7:0]shift_reg;
    
    always@(posedge clk or posedge rst)begin            //State Transition Logic
        if(rst)begin
            current_state <= IDLE;
            rx_done <= 1'b0;
            shift_reg <= 8'b00000000;
            bit_index <= 4'b0000;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@(posedge clk)begin                           //State Machine Logic
        case(current_state)
            IDLE:begin
                rx_done <= 2'b0;
                if(~rx_serial)begin
                    next_state <= START;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            
            START:begin
                if(baud_tick)begin
                    next_state <= DATA;
                    bit_index <= 3'b000;
                end
                else begin
                    next_state <= START;
                end 
            end
            
            DATA:begin
                if(baud_tick)begin
                    shift_reg <= {rx_serial,shift_reg[7:1]};
                    if(bit_index == 7)begin
                        next_state <= STOP;
                    end
                    else begin
                        bit_index <= bit_index+1'b1;
                        next_state <= DATA;
                    end
                end
                else begin
                    next_state <= DATA;
                end
            end
            
            STOP:begin
                if(baud_tick)begin
                    if(rx_serial == 1'b1)begin
                        data_out <= shift_reg;
                        rx_done <= 1'b1;
                    end
                    else begin
                        next_state <= IDLE;
                    end
                end
                else begin
                    next_state <= STOP;
                end
            end
            
            default: next_state <= IDLE;
        endcase
    end
endmodule
