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
    input [15:0] sw,
    input clk,
    input [3:0] stat,
    output [31:0] num,
    output [6:0] seg,
    output [7:0] an,
    output dp,
    output [21:0] led
);

    reg [7:0] start = 8'h00;
    reg [7:0] destination = 8'h00;
    reg [7:0] price = 8'h00;
    reg [4:0] ticketnum = 4'h0;
    reg [7:0] payed = 8'h00;
    reg [4:0] ticketnum = 4'h0;

    always @(posedge clk) begin
        if (sw[15]) begin
            start = 8'h00;
            destination = 8'h00;
            ticketnum = 4'h0;
            payed = 8'h00;
        end
        else
            if (stat == 4'h0)
                case (btn)
                    5'b00001:  start = start - 1;
                    5'b00010:  destination = destination + 1;
                    5'b01000:  destination = destination - 1;
                    5'b10000:  start = start + 1;
                endcase
            else
                if (stat == 4'h1) begin
                    case (sw[3:0])
                        4'b1000: payed = payed + 20;
                        4'b0100: payed = payed + 10;
                        4'b0010: payed = payed + 5;
                        4'b0001: payed = payed + 1;
                    endcase
                    case (btn)
                        5'b00001:  ticketnum = ticketnum - 1;
                        5'b10000:  ticketnum = ticketnum + 1;
                    endcase
                end
    end
    
    always @(clk) begin
        if (sw[15])
            price = 4'h00;
        else
            price = (destination + start) * ticketnum;
    end

    // Ticket conductor (start, destination, sw[15], clk, price);
    assign num = {start, destination, price, payed};
    
    Led litled (ticketnum, clk, led[15:0]);
    seg7decimal display (num[31:0], clk, seg[6:0], an[7:0], dp);
    // seg7decimal dispstation (station[15:0], clk, seg[6:0], an[3:0], dp);
endmodule // Select