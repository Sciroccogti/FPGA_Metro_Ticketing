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
    input stat,
    output [7:0] station,
    output [6:0] seg,
    output [1:0] an,
    output dp
);
    reg [7:0] station_ = 8'h00;
    // reg [7:0] destination_ = 8'h00;
    // reg isset = 1'b0;
    // always @(posedge btn[0]) begin
    //     station_ = station_ - 1;
    // end
    // always @(posedge btn[1])
    //     destination_ = destination_ - 1;
    // always @(posedge btn[2]) // 确认不再更改
    //     isset = 1'b1;
    // always @(posedge btn[3] and ~isset)
    //     destination_ = destination_ + 1;
    always @(posedge clk) begin
        if (stat == 4'h0 && btn[4] == 1'b1)
            station_ = station_ + 1;
        // else
        //     if (stat == 4'h0 && btn[1] == 1'b1)
        //         station_ = station_ - 1;
    end
    // wire clk_ = clk;
    // wire [6:0] seg_ = seg[6:0];
    // wire dp_ = dp;
    assign station = station_;
    seg7decimal dispstation (station_[7:0], clk, seg[6:0], an[1:0], dp);
    // seg7decimal dispdest (destination_[7:0], clk, seg[6:0], an[1:0], dp);
endmodule // Select