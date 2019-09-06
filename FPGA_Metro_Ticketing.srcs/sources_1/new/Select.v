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
    output [15:0] station,
    output [6:0] seg,
    output [3:0] an,
    output dp
);
    reg [7:0] start_ = 8'h00;
    reg [7:0] destination_ = 8'h00;

    always @(posedge clk) begin
        if (stat == 4'h0)
            case (btn)
                5'b00001:  start_ = start_ - 1;
                5'b00010:  destination_ = destination_ + 1;
                5'b01000:  destination_ = destination_ - 1;
                5'b10000:  start_ = start_ + 1;
            endcase
    end
    
    assign station = {start_, destination_};
    seg7decimal dispstation (station[15:0], clk, seg[6:0], an[3:0], dp);
endmodule // Select