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
    input [15:0] SW,
    input RESETN,
    input [4:0] BTN,
    output [6:0] SEG,
    output [7:0] AN,
    output DP
    // output [15:0] LED,
    );

    reg CLK50MHZ = 0;

    always @(posedge(CLK100MHZ)) begin
        CLK50MHZ <= ~CLK50MHZ;
    end
    wire [15:0] SWout;
    wire [31:0] num = 32'h00000000;
    switch_debounce debouncer (CLK50MHZ, RESETN, SW, SWout);
    Pay payer (SWout[15:0], CLK50MHZ, num[7:0], SEG[6:0], AN[1:0], DP); // 已付金额输出到末两位
endmodule
