`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/05 19:35:55
// Design Name: 
// Module Name: Select
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

module Select(
    input [4:0] btn,
    input clk,
    output [7:0] start,
    output [7:0] destination,
    output [6:0] seg,
    output [3:0] an,
    output dp
);
    reg [7:0] start_ = 8'h00;
    reg [7:0] destination_ = 8'h00;
    reg isset = 1'b0;
    always @(posedge clk) begin
        if (btn[0])
            start_ = start_ - 1;
        if (btn[1])
            destination_ = destination_ - 1;
        if (btn[2]) // 确认不再更改
            isset = 1'b1;
        if (btn[3])
            destination_ = destination_ + 1;
        if (btn[4])
            start_ = start_ + 1;
    end

    // assign payed = payed_;
    seg7decimal dispstart (start_[7:0], clk, seg[6:0], an[3:2], dp);
    // seg7decimal dispdest (destination_[7:0], clk, seg[6:0], an[1:0], dp);
endmodule // Select