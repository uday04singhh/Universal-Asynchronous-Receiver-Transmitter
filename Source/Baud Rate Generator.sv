`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2025 17:57:22
// Design Name: 
// Module Name: Baud Rate Generator
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


module Baud_Rate_Generator(
    input clk , 
    output tx_en , rx_en
    );

reg[12:0] tx_counter ;
reg[9:0] rx_counter;
//counters for rx and tx

// For 100MHz clock, 9600 baud usually needs 10416
// Let's use a small value like 10 for simulation testing
always@ (posedge clk) begin   
    if(tx_counter == 10) // Changed from 5208 
        tx_counter <= 0;
    else
        tx_counter <= tx_counter + 1'b1;
end

always @(posedge clk) begin 
    if(rx_counter == 2) // Changed from 325 [cite: 4]
        rx_counter <= 0;
    else 
        rx_counter <= rx_counter + 1'b1;
end
assign tx_en = (tx_counter == 0) ? 1'b1 : 1'b0 ;
assign rx_en = (rx_counter == 0) ? 1'b1 : 1'b0 ;

endmodule
    












    
            