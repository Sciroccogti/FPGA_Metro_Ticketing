`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/05 18:42:24
// Design Name: 
// Module Name: Pay
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


module Pay (
    input [15:0] sw,
    input clk,
    output [7:0] payed,
    output [6:0] seg,
    output [1:0] an,
    output dp
);
    reg [7:0] payed_ = 8'h00;
    always @(posedge clk) begin
        if (sw[0])
            payed_ = payed_ + 1;
        if (sw[1])
            payed_ = payed_ + 5;
        if (sw[2])
            payed_ = payed_ + 10;
        if (sw[3])
            payed_ = payed_ + 20;
    end
    assign payed = payed_;
    seg7decimal display (payed_[7:0], clk, seg[6:0], an[1:0], dp);
endmodule
