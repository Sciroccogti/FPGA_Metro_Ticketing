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
    wire [4:0] BTNout;
    wire [31:0] num = 32'h00000000;
    // switch_debounce swdebouncer (CLK50MHZ, RESETN, SW, SWout);
    // key_debounce keydebouncer(CLK50MHZ, RESETN, BTN[4:0], BTNout[4:0]);
    // 已付金额输出到末两位
    // Pay payer (SWout[15:0], CLK50MHZ, num[7:0], SEG[6:0], AN[3:2], DP);
    // 起点、终点输出到首四�?
    Select selector (BTN[4:0], CLK50MHZ, num[31:24], SWout[15:8], SEG[6:0], AN[7:4], DP);
endmodule
