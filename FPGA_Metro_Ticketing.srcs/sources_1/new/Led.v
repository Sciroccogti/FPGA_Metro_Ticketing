`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/06 13:09:52
// Design Name: 
// Module Name: Led
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


module Led(
    input [3:0] ticketnum,
    input clk,
    output [15:0] led
    );
    reg [15:0] led_ = 16'h0000;
    always @(posedge clk) begin : lit
        integer i;
        for (i = 0; i < 16; i = i + 1)
            if (i < ticketnum)
                led_[i] = 1;
            else
                led_[i] = 0;
    end
    assign led = led_;
endmodule

module RGB (
    input [3:0] stat,
    input clk,
    output [5:0] led 
);
    reg [5:0] led_ = 6'b000000; // rgb rgb
    always @(posedge clk) begin
        case (stat)
            4'h0: led_ = 6'b000001;
            4'h1: led_ = 6'b001010;
            4'h2: led_ = 6'b010010;
            default: led_ = 6'b111111;
        endcase
    end
    assign led = led_;
endmodule // RGB 