`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/06 12:53:54
// Design Name: 
// Module Name: Ticket
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

module Ticket (
    input [7:0] start,
    input [7:0] destination,
    input rst,
    input clk,
    output [7:0] price
);
    reg [7:0] price_ = 4'h00;
    always @(clk) begin
        if (rst)
            price_ = 4'h00;
        else
            price_ = destination + start;
    end
    assign price = price_;
endmodule // Ticket 