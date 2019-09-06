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
    output DP,
    output [15:0] LED
    );

    reg CLK50MHZ = 0;

    always @(posedge(CLK100MHZ)) begin
        CLK50MHZ <= ~CLK50MHZ;
    end
    wire [15:0] SWout;
    wire [4:0] BTNout;
    wire [31:0] num = 31'h00000000;
    // wire [15:0] payment = 16'h0000;
    // wire [15:0] station = 16'h0000;
    reg [3:0] stat = 4'h0; // 状�?�编�??
    switch_debounce swdebouncer (CLK50MHZ, RESETN, SW, SWout);
    key_debounce keydebouncer(CLK50MHZ, RESETN, BTN[4:0], BTNout[4:0]);
    // // 已付金额输出到末两位
    // // 起点、终点输出到首四�???
    always @(posedge CLK50MHZ) begin // 进入下一状�??
        if (SW[15])
            stat = 4'h0;
        else
            if (BTNout[2])
                stat = stat + 1;
    end
    Select selector (BTNout[4:0], SWout[15:0], CLK50MHZ, stat, num[31:0], SEG[6:0], AN[7:0], DP, LED[15:0]);
    // Pay payer (SWout[15:0], CLK50MHZ, stat, payment[15:0]);
endmodule
