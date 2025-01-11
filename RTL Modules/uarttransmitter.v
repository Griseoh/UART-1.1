`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2025 03:42:49 PM
// Design Name: 
// Module Name: uarttransmitter
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


module uarttransmitter(clk,rst,baud_tick,data_in,send,tx_serial,tx_done);
    input clk,rst,baud_tick,send;
    input [7:0]data_in;
    output reg tx_serial,tx_done;
    
    parameter IDLE = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11;
    reg [1:0]current_state, next_state;
    reg [2:0]bit_index;
    reg [7:0]shift_reg;
    
    always@(posedge clk or posedge rst)begin        //State Transition Logic
        if(rst)begin
            current_state <= IDLE;
            tx_serial <= 1'b1;
            tx_done <= 1'b0;
            bit_index <= 3'b000;
        end
        else begin
            current_state <= next_state; 
        end
    end
    
    always@(*)begin                                 //State Machine Logic
        next_state = current_state;
        case (current_state)
            IDLE :begin
                if(send)begin
                    next_state = START;
                end
            end
            START :begin
                next_state = DATA;
            end
            DATA :begin
                if(baud_tick)begin
                    if(bit_index == 7)begin
                        next_state = STOP;
                    end
                end
            end
            STOP :begin
                if(baud_tick)begin
                    next_state = IDLE;
                end
            end
            default : begin
                next_state = IDLE;
            end
        endcase
    end
    
    always@(posedge clk)begin                   //Data Handling Logic for each state
        case(current_state)
            IDLE :begin
                tx_done <= 1'b0;
                if(send)begin
                    shift_reg <= data_in;
                    bit_index <= 1'b0;
                    tx_serial <= 1'b1;
                end
            end
            START :begin
                tx_serial <= 1'b0;
            end
            DATA :begin
                if(baud_tick)begin
                    tx_serial <= shift_reg[bit_index];
                    bit_index <= bit_index + 1'b1;
                end
            end
            STOP :begin
                if(baud_tick)begin
                    tx_serial <= 1'b1;
                    tx_done <= 1'b1;
                end
            end
        endcase
    end 
endmodule
