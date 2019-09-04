`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// CompANy: 
// Engineer: 
// 
// Create Date: 2019/08/26 14:31:00
// Design Name: 
// Module Name: top
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


module top(
    input CLK100MHZ,
    input [15:0]SW,
    output [6:0]SEG,
    output [7:0]AN,
    output DP
    );

    reg CLK50MHZ = 0;

    always @(posedge(CLK100MHZ)) begin
        CLK50MHZ <= ~CLK50MHZ;
    end

    wire [31:0] count;
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin : add
            assign count[i*4 + 3:i*4] = i + 1;
            end
    endgenerate
    seg7decimal show (count[31:0], CLK100MHZ, SEG[6:0], AN[7:0], DP);
endmodule