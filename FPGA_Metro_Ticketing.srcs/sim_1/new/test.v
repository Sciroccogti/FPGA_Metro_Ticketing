`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/04 21:48:39
// Design Name: 
// Module Name: test
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


module test(

    );
    wire [6:0] SEG;
    wire [7:0] AN;
    wire DP;
    wire [8:0] count = 8'h0A;
    wire [15:0] SW;
    reg clk = 1;
    always @(*)
        clk = ~clk;
    // generate
    //     genvar i;
    //     for (i = 0; i < 15; i = i + 1) begin : add
    //         assign count[i*4 + 3:i*4] = i + 1;
    //     end
    // endgenerate
    seg7decimal show (count[8:0], clk, SEG[6:0], AN[1:0], DP);
endmodule
