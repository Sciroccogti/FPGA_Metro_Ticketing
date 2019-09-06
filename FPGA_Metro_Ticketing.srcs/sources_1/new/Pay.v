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
    input [3:0] stat,
    output [7:0] payed
    // output [6:0] seg,
    // output [3:0] an,
    // output dp
);
    reg [7:0] payed_ = 8'h00;
    always @(posedge clk) begin
        if (stat == 4'h1) begin
            // if (sw[0])
            //     payed_ = payed_ + 1;
            // if (sw[1])
            //     payed_ = payed_ + 5;
            // if (sw[2])
            //     payed_ = payed_ + 10;
            // if (sw[3])
            //     payed_ = payed_ + 20;
            case (sw[3:0])
                4'b1000: payed_ = payed_ + 20;
                4'b0100: payed_ = payed_ + 10;
                4'b0010: payed_ = payed_ + 5;
                4'b0001: payed_ = payed_ + 1;
            endcase
        end
    end
    assign payed[7:0] = payed_;
    // seg7decimal display (payed[7:0], clk, seg[6:0], an[3:0], dp);
endmodule
