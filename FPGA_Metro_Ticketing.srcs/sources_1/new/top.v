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
    // always @(SWout) begin
    //     count = 32'h00000000;
    //     for ( i = 0; i < 16; i = i + 1)
    //         count = count + SWout[i];
    // end
    wire [15:0] SWout;
    switch_debounce debouncer (CLK50MHZ, RESETN, SW, SWout);
    
    Show shower (SWout[15:0], CLK50MHZ, RESETN, SEG[6:0], AN[7:0], DP);
endmodule

module Show (
    input [15:0] SWout,
    input clk,
    input RESETN,
    output [6:0] SEG,
    output [7:0] AN,
    output DP
);
    reg [31:0] count = 32'h00000000;
    always @(posedge clk) begin
        case (SWout)
            1: count = count + 1;
            // default: 
        endcase
    end
    seg7decimal display (count[31:0], clk, SEG[6:0], AN[7:0], DP);
endmodule // 