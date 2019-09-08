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
	// initial begin
		reg [7:0] start = 8'h00;
		reg [7:0] destination = 8'h00;
		reg [7:0] price = 8'h00;
		reg [3:0] ticketnum = 4'h1;
		reg [7:0] payed = 8'h00;
	// end
	always @(posedge clk) begin
		if (sw[15]) begin
			start = 0;
			destination = 0;
			ticketnum = 1;
			payed = 0;
		end
		else
			case (stat)
				4'h0: 	case (btn)
						5'b00001:  begin
							if (start == 0)
								start = 92;
							else
								start = start - 1;
						end
						5'b00010:  begin
							if (destination == 92)
								destination = 0;
							else
								destination = destination + 1;
						end
						5'b01000:  begin
							if (destination == 0)
								destination = 92;
							else
								destination = destination - 1;
						end
						5'b10000:  begin
							if (start == 92)
								start = 0;
							else
								start = start + 1;
						end
					endcase
				4'h1: 	
					begin // 选择票数,同时付款
						if (btn[3]) begin// push down :repay
							start = 8'h00;
							destination = 8'h00;
							ticketnum = 4'h1;
						end
						else
							case (sw[3:0])
								4'b1000: payed = payed + 20;
								4'b0100: payed = payed + 10;
								4'b0010: payed = payed + 5;
								4'b0001: payed = payed + 1;
							endcase
							case (btn)
								5'b00001:
								if (ticketnum > 0)
									ticketnum = ticketnum - 1;
								5'b10000:  
								if (ticketnum < 15)
									ticketnum = ticketnum + 1;
							endcase
					end
				4'h2:	
					begin:repayment // start to repay
						reg [7:0] repay, repay20, repay10, repay5;
						repay = payed - price;
						repay20 = repay / 20;
						repay = repay % 20;
						repay10 = repay / 10;
						repay = repay % 10;
						repay5 = repay / 5;
						repay = repay % 5;
						start = repay20 * 10 + repay10;
						destination = repay5 * 10 + repay;
					end
				4'h3:
					begin
						start = 0;
						destination = 0;
						ticketnum = 1;
						payed = 0;
					end
			endcase
	end
	
	assign num = {start, destination, price * ticketnum, payed};
	
	Led litled (ticketnum, clk, led[15:0]);
	RGB litrgb (stat, clk, led[21:16]);
	seg7decimal display (num[31:0], stat, clk, seg[6:0], an[7:0], dp);

	always @(clk) begin
		if (sw[15])
			price = 4'h00;
		else
		if (stat != 4'h2) begin
		if(start == 0 && destination == 0)
			price = 0;
		else
		if(start == 0 && destination == 1)
			price = 2;/*
		else
		if(start == 0 && destination == 2)
			price = 2;
		else
		if(start == 0 && destination == 3)
			price = 3;
		else
		if(start == 0 && destination == 4)
			price = 3;
		else
		if(start == 0 && destination == 5)
			price = 4;
		else
		if(start == 0 && destination == 6)
			price = 4;
		else
		if(start == 0 && destination == 7)
			price = 4;
		else
		if(start == 0 && destination == 8)
			price = 5;
		else
		if(start == 0 && destination == 9)
			price = 5;
		else
		if(start == 0 && destination == 10)
			price = 5;
		else
		if(start == 0 && destination == 11)
			price = 5;
		else
		if(start == 0 && destination == 12)
			price = 5;
		else
		if(start == 0 && destination == 13)
			price = 6;
		else
		if(start == 0 && destination == 14)
			price = 6;
		else
		if(start == 0 && destination == 15)
			price = 6;
		else
		if(start == 0 && destination == 16)
			price = 6;
		else
		if(start == 0 && destination == 17)
			price = 6;
		else
		if(start == 0 && destination == 18)
			price = 7;
		else
		if(start == 0 && destination == 19)
			price = 7;
		else
		if(start == 0 && destination == 20)
			price = 7;
		else
		if(start == 0 && destination == 21)
			price = 7;
		else
		if(start == 0 && destination == 22)
			price = 7;
		else
		if(start == 0 && destination == 23)
			price = 6;
		else
		if(start == 0 && destination == 24)
			price = 5;
		else
		if(start == 0 && destination == 25)
			price = 5;
		else
		if(start == 0 && destination == 26)
			price = 5;
		else
		if(start == 0 && destination == 27)
			price = 5;
		else
		if(start == 0 && destination == 28)
			price = 4;
		else
		if(start == 0 && destination == 29)
			price = 4;
		else
		if(start == 0 && destination == 30)
			price = 4;
		else
		if(start == 0 && destination == 31)
			price = 4;
		else
		if(start == 0 && destination == 32)
			price = 3;
		else
		if(start == 0 && destination == 33)
			price = 3;
		else
		if(start == 0 && destination == 34)
			price = 4;
		else
		if(start == 0 && destination == 35)
			price = 4;
		else
		if(start == 0 && destination == 36)
			price = 4;
		else
		if(start == 0 && destination == 37)
			price = 4;
		else
		if(start == 0 && destination == 38)
			price = 5;
		else
		if(start == 0 && destination == 39)
			price = 5;
		else
		if(start == 0 && destination == 40)
			price = 5;
		else
		if(start == 0 && destination == 41)
			price = 5;
		else
		if(start == 0 && destination == 42)
			price = 6;
		else
		if(start == 0 && destination == 43)
			price = 6;
		else
		if(start == 0 && destination == 44)
			price = 6;
		else
		if(start == 0 && destination == 45)
			price = 6;
		else
		if(start == 0 && destination == 46)
			price = 6;
		else
		if(start == 0 && destination == 47)
			price = 7;
		else
		if(start == 0 && destination == 48)
			price = 5;
		else
		if(start == 0 && destination == 49)
			price = 5;
		else
		if(start == 0 && destination == 50)
			price = 5;
		else
		if(start == 0 && destination == 51)
			price = 4;
		else
		if(start == 0 && destination == 52)
			price = 4;
		else
		if(start == 0 && destination == 53)
			price = 4;
		else
		if(start == 0 && destination == 54)
			price = 3;
		else
		if(start == 0 && destination == 55)
			price = 3;
		else
		if(start == 0 && destination == 56)
			price = 2;
		else
		if(start == 0 && destination == 57)
			price = 2;
		else
		if(start == 0 && destination == 58)
			price = 3;
		else
		if(start == 0 && destination == 59)
			price = 3;
		else
		if(start == 0 && destination == 60)
			price = 3;
		else
		if(start == 0 && destination == 61)
			price = 3;
		else
		if(start == 0 && destination == 62)
			price = 4;
		else
		if(start == 0 && destination == 63)
			price = 4;
		else
		if(start == 0 && destination == 64)
			price = 4;
		else
		if(start == 0 && destination == 65)
			price = 4;
		else
		if(start == 0 && destination == 66)
			price = 5;
		else
		if(start == 0 && destination == 67)
			price = 5;
		else
		if(start == 0 && destination == 68)
			price = 5;
		else
		if(start == 0 && destination == 69)
			price = 5;
		else
		if(start == 0 && destination == 70)
			price = 5;
		else
		if(start == 0 && destination == 71)
			price = 5;
		else
		if(start == 0 && destination == 72)
			price = 6;
		else
		if(start == 0 && destination == 73)
			price = 6;
		else
		if(start == 0 && destination == 74)
			price = 6;
		else
		if(start == 0 && destination == 75)
			price = 6;
		else
		if(start == 0 && destination == 76)
			price = 7;
		else
		if(start == 0 && destination == 77)
			price = 4;
		else
		if(start == 0 && destination == 78)
			price = 3;
		else
		if(start == 0 && destination == 79)
			price = 3;
		else
		if(start == 0 && destination == 80)
			price = 3;
		else
		if(start == 0 && destination == 81)
			price = 3;
		else
		if(start == 0 && destination == 82)
			price = 4;
		else
		if(start == 0 && destination == 83)
			price = 4;
		else
		if(start == 0 && destination == 84)
			price = 4;
		else
		if(start == 0 && destination == 85)
			price = 5;
		else
		if(start == 0 && destination == 86)
			price = 5;
		else
		if(start == 0 && destination == 87)
			price = 6;
		else
		if(start == 0 && destination == 88)
			price = 6;
		else
		if(start == 0 && destination == 89)
			price = 6;
		else
		if(start == 0 && destination == 90)
			price = 7;
		else
		if(start == 0 && destination == 91)
			price = 7;
		else
		if(start == 0 && destination == 92)
			price = 7;
		else
		if(start == 1 && destination == 0)
			price = 2;
		else
		if(start == 1 && destination == 1)
			price = 0;
		else
		if(start == 1 && destination == 2)
			price = 2;
		else
		if(start == 1 && destination == 3)
			price = 2;
		else
		if(start == 1 && destination == 4)
			price = 3;
		else
		if(start == 1 && destination == 5)
			price = 3;
		else
		if(start == 1 && destination == 6)
			price = 4;
		else
		if(start == 1 && destination == 7)
			price = 4;
		else
		if(start == 1 && destination == 8)
			price = 4;
		else
		if(start == 1 && destination == 9)
			price = 5;
		else
		if(start == 1 && destination == 10)
			price = 5;
		else
		if(start == 1 && destination == 11)
			price = 5;
		else
		if(start == 1 && destination == 12)
			price = 5;
		else
		if(start == 1 && destination == 13)
			price = 5;
		else
		if(start == 1 && destination == 14)
			price = 6;
		else
		if(start == 1 && destination == 15)
			price = 6;
		else
		if(start == 1 && destination == 16)
			price = 6;
		else
		if(start == 1 && destination == 17)
			price = 6;
		else
		if(start == 1 && destination == 18)
			price = 6;
		else
		if(start == 1 && destination == 19)
			price = 7;
		else
		if(start == 1 && destination == 20)
			price = 7;
		else
		if(start == 1 && destination == 21)
			price = 7;
		else
		if(start == 1 && destination == 22)
			price = 7;
		else
		if(start == 1 && destination == 23)
			price = 5;
		else
		if(start == 1 && destination == 24)
			price = 5;
		else
		if(start == 1 && destination == 25)
			price = 5;
		else
		if(start == 1 && destination == 26)
			price = 5;
		else
		if(start == 1 && destination == 27)
			price = 4;
		else
		if(start == 1 && destination == 28)
			price = 4;
		else
		if(start == 1 && destination == 29)
			price = 4;
		else
		if(start == 1 && destination == 30)
			price = 4;
		else
		if(start == 1 && destination == 31)
			price = 3;
		else
		if(start == 1 && destination == 32)
			price = 3;
		else
		if(start == 1 && destination == 33)
			price = 3;
		else
		if(start == 1 && destination == 34)
			price = 3;
		else
		if(start == 1 && destination == 35)
			price = 4;
		else
		if(start == 1 && destination == 36)
			price = 4;
		else
		if(start == 1 && destination == 37)
			price = 4;
		else
		if(start == 1 && destination == 38)
			price = 4;
		else
		if(start == 1 && destination == 39)
			price = 5;
		else
		if(start == 1 && destination == 40)
			price = 5;
		else
		if(start == 1 && destination == 41)
			price = 5;
		else
		if(start == 1 && destination == 42)
			price = 5;
		else
		if(start == 1 && destination == 43)
			price = 6;
		else
		if(start == 1 && destination == 44)
			price = 6;
		else
		if(start == 1 && destination == 45)
			price = 6;
		else
		if(start == 1 && destination == 46)
			price = 6;
		else
		if(start == 1 && destination == 47)
			price = 7;
		else
		if(start == 1 && destination == 48)
			price = 5;
		else
		if(start == 1 && destination == 49)
			price = 5;
		else
		if(start == 1 && destination == 50)
			price = 4;
		else
		if(start == 1 && destination == 51)
			price = 4;
		else
		if(start == 1 && destination == 52)
			price = 4;
		else
		if(start == 1 && destination == 53)
			price = 3;
		else
		if(start == 1 && destination == 54)
			price = 3;
		else
		if(start == 1 && destination == 55)
			price = 3;
		else
		if(start == 1 && destination == 56)
			price = 2;
		else
		if(start == 1 && destination == 57)
			price = 2;
		else
		if(start == 1 && destination == 58)
			price = 2;
		else
		if(start == 1 && destination == 59)
			price = 3;
		else
		if(start == 1 && destination == 60)
			price = 3;
		else
		if(start == 1 && destination == 61)
			price = 3;
		else
		if(start == 1 && destination == 62)
			price = 3;
		else
		if(start == 1 && destination == 63)
			price = 4;
		else
		if(start == 1 && destination == 64)
			price = 4;
		else
		if(start == 1 && destination == 65)
			price = 4;
		else
		if(start == 1 && destination == 66)
			price = 4;
		else
		if(start == 1 && destination == 67)
			price = 5;
		else
		if(start == 1 && destination == 68)
			price = 5;
		else
		if(start == 1 && destination == 69)
			price = 5;
		else
		if(start == 1 && destination == 70)
			price = 5;
		else
		if(start == 1 && destination == 71)
			price = 5;
		else
		if(start == 1 && destination == 72)
			price = 6;
		else
		if(start == 1 && destination == 73)
			price = 6;
		else
		if(start == 1 && destination == 74)
			price = 6;
		else
		if(start == 1 && destination == 75)
			price = 6;
		else
		if(start == 1 && destination == 76)
			price = 7;
		else
		if(start == 1 && destination == 77)
			price = 4;
		else
		if(start == 1 && destination == 78)
			price = 3;
		else
		if(start == 1 && destination == 79)
			price = 3;
		else
		if(start == 1 && destination == 80)
			price = 3;
		else
		if(start == 1 && destination == 81)
			price = 3;
		else
		if(start == 1 && destination == 82)
			price = 3;
		else
		if(start == 1 && destination == 83)
			price = 4;
		else
		if(start == 1 && destination == 84)
			price = 4;
		else
		if(start == 1 && destination == 85)
			price = 4;
		else
		if(start == 1 && destination == 86)
			price = 5;
		else
		if(start == 1 && destination == 87)
			price = 6;
		else
		if(start == 1 && destination == 88)
			price = 6;
		else
		if(start == 1 && destination == 89)
			price = 6;
		else
		if(start == 1 && destination == 90)
			price = 6;
		else
		if(start == 1 && destination == 91)
			price = 7;
		else
		if(start == 1 && destination == 92)
			price = 7;
		else
		if(start == 2 && destination == 0)
			price = 2;
		else
		if(start == 2 && destination == 1)
			price = 2;
		else
		if(start == 2 && destination == 2)
			price = 0;
		else
		if(start == 2 && destination == 3)
			price = 2;
		else
		if(start == 2 && destination == 4)
			price = 2;
		else
		if(start == 2 && destination == 5)
			price = 3;
		else
		if(start == 2 && destination == 6)
			price = 3;
		else
		if(start == 2 && destination == 7)
			price = 3;
		else
		if(start == 2 && destination == 8)
			price = 4;
		else
		if(start == 2 && destination == 9)
			price = 4;
		else
		if(start == 2 && destination == 10)
			price = 4;
		else
		if(start == 2 && destination == 11)
			price = 5;
		else
		if(start == 2 && destination == 12)
			price = 5;
		else
		if(start == 2 && destination == 13)
			price = 5;
		else
		if(start == 2 && destination == 14)
			price = 5;
		else
		if(start == 2 && destination == 15)
			price = 5;
		else
		if(start == 2 && destination == 16)
			price = 6;
		else
		if(start == 2 && destination == 17)
			price = 6;
		else
		if(start == 2 && destination == 18)
			price = 6;
		else
		if(start == 2 && destination == 19)
			price = 6;
		else
		if(start == 2 && destination == 20)
			price = 6;
		else
		if(start == 2 && destination == 21)
			price = 7;
		else
		if(start == 2 && destination == 22)
			price = 7;
		else
		if(start == 2 && destination == 23)
			price = 5;
		else
		if(start == 2 && destination == 24)
			price = 5;
		else
		if(start == 2 && destination == 25)
			price = 4;
		else
		if(start == 2 && destination == 26)
			price = 4;
		else
		if(start == 2 && destination == 27)
			price = 4;
		else
		if(start == 2 && destination == 28)
			price = 4;
		else
		if(start == 2 && destination == 29)
			price = 3;
		else
		if(start == 2 && destination == 30)
			price = 3;
		else
		if(start == 2 && destination == 31)
			price = 3;
		else
		if(start == 2 && destination == 32)
			price = 3;
		else
		if(start == 2 && destination == 33)
			price = 3;
		else
		if(start == 2 && destination == 34)
			price = 3;
		else
		if(start == 2 && destination == 35)
			price = 3;
		else
		if(start == 2 && destination == 36)
			price = 4;
		else
		if(start == 2 && destination == 37)
			price = 4;
		else
		if(start == 2 && destination == 38)
			price = 4;
		else
		if(start == 2 && destination == 39)
			price = 4;
		else
		if(start == 2 && destination == 40)
			price = 5;
		else
		if(start == 2 && destination == 41)
			price = 5;
		else
		if(start == 2 && destination == 42)
			price = 5;
		else
		if(start == 2 && destination == 43)
			price = 5;
		else
		if(start == 2 && destination == 44)
			price = 6;
		else
		if(start == 2 && destination == 45)
			price = 6;
		else
		if(start == 2 && destination == 46)
			price = 6;
		else
		if(start == 2 && destination == 47)
			price = 6;
		else
		if(start == 2 && destination == 48)
			price = 5;
		else
		if(start == 2 && destination == 49)
			price = 5;
		else
		if(start == 2 && destination == 50)
			price = 4;
		else
		if(start == 2 && destination == 51)
			price = 4;
		else
		if(start == 2 && destination == 52)
			price = 4;
		else
		if(start == 2 && destination == 53)
			price = 4;
		else
		if(start == 2 && destination == 54)
			price = 3;
		else
		if(start == 2 && destination == 55)
			price = 3;
		else
		if(start == 2 && destination == 56)
			price = 2;
		else
		if(start == 2 && destination == 57)
			price = 2;
		else
		if(start == 2 && destination == 58)
			price = 2;
		else
		if(start == 2 && destination == 59)
			price = 2;
		else
		if(start == 2 && destination == 60)
			price = 3;
		else
		if(start == 2 && destination == 61)
			price = 3;
		else
		if(start == 2 && destination == 62)
			price = 3;
		else
		if(start == 2 && destination == 63)
			price = 3;
		else
		if(start == 2 && destination == 64)
			price = 3;
		else
		if(start == 2 && destination == 65)
			price = 4;
		else
		if(start == 2 && destination == 66)
			price = 4;
		else
		if(start == 2 && destination == 67)
			price = 4;
		else
		if(start == 2 && destination == 68)
			price = 4;
		else
		if(start == 2 && destination == 69)
			price = 5;
		else
		if(start == 2 && destination == 70)
			price = 5;
		else
		if(start == 2 && destination == 71)
			price = 5;
		else
		if(start == 2 && destination == 72)
			price = 5;
		else
		if(start == 2 && destination == 73)
			price = 6;
		else
		if(start == 2 && destination == 74)
			price = 6;
		else
		if(start == 2 && destination == 75)
			price = 6;
		else
		if(start == 2 && destination == 76)
			price = 6;
		else
		if(start == 2 && destination == 77)
			price = 3;
		else
		if(start == 2 && destination == 78)
			price = 3;
		else
		if(start == 2 && destination == 79)
			price = 2;
		else
		if(start == 2 && destination == 80)
			price = 2;
		else
		if(start == 2 && destination == 81)
			price = 3;
		else
		if(start == 2 && destination == 82)
			price = 3;
		else
		if(start == 2 && destination == 83)
			price = 3;
		else
		if(start == 2 && destination == 84)
			price = 3;
		else
		if(start == 2 && destination == 85)
			price = 4;
		else
		if(start == 2 && destination == 86)
			price = 5;
		else
		if(start == 2 && destination == 87)
			price = 5;
		else
		if(start == 2 && destination == 88)
			price = 6;
		else
		if(start == 2 && destination == 89)
			price = 6;
		else
		if(start == 2 && destination == 90)
			price = 6;
		else
		if(start == 2 && destination == 91)
			price = 6;
		else
		if(start == 2 && destination == 92)
			price = 7;
		else
		if(start == 3 && destination == 0)
			price = 3;
		else
		if(start == 3 && destination == 1)
			price = 2;
		else
		if(start == 3 && destination == 2)
			price = 2;
		else
		if(start == 3 && destination == 3)
			price = 0;
		else
		if(start == 3 && destination == 4)
			price = 2;
		else
		if(start == 3 && destination == 5)
			price = 3;
		else
		if(start == 3 && destination == 6)
			price = 3;
		else
		if(start == 3 && destination == 7)
			price = 3;
		else
		if(start == 3 && destination == 8)
			price = 4;
		else
		if(start == 3 && destination == 9)
			price = 4;
		else
		if(start == 3 && destination == 10)
			price = 4;
		else
		if(start == 3 && destination == 11)
			price = 4;
		else
		if(start == 3 && destination == 12)
			price = 5;
		else
		if(start == 3 && destination == 13)
			price = 5;
		else
		if(start == 3 && destination == 14)
			price = 5;
		else
		if(start == 3 && destination == 15)
			price = 5;
		else
		if(start == 3 && destination == 16)
			price = 5;
		else
		if(start == 3 && destination == 17)
			price = 6;
		else
		if(start == 3 && destination == 18)
			price = 6;
		else
		if(start == 3 && destination == 19)
			price = 6;
		else
		if(start == 3 && destination == 20)
			price = 6;
		else
		if(start == 3 && destination == 21)
			price = 7;
		else
		if(start == 3 && destination == 22)
			price = 7;
		else
		if(start == 3 && destination == 23)
			price = 5;
		else
		if(start == 3 && destination == 24)
			price = 5;
		else
		if(start == 3 && destination == 25)
			price = 4;
		else
		if(start == 3 && destination == 26)
			price = 4;
		else
		if(start == 3 && destination == 27)
			price = 4;
		else
		if(start == 3 && destination == 28)
			price = 3;
		else
		if(start == 3 && destination == 29)
			price = 3;
		else
		if(start == 3 && destination == 30)
			price = 3;
		else
		if(start == 3 && destination == 31)
			price = 3;
		else
		if(start == 3 && destination == 32)
			price = 2;
		else
		if(start == 3 && destination == 33)
			price = 2;
		else
		if(start == 3 && destination == 34)
			price = 3;
		else
		if(start == 3 && destination == 35)
			price = 3;
		else
		if(start == 3 && destination == 36)
			price = 3;
		else
		if(start == 3 && destination == 37)
			price = 4;
		else
		if(start == 3 && destination == 38)
			price = 4;
		else
		if(start == 3 && destination == 39)
			price = 4;
		else
		if(start == 3 && destination == 40)
			price = 5;
		else
		if(start == 3 && destination == 41)
			price = 5;
		else
		if(start == 3 && destination == 42)
			price = 5;
		else
		if(start == 3 && destination == 43)
			price = 5;
		else
		if(start == 3 && destination == 44)
			price = 5;
		else
		if(start == 3 && destination == 45)
			price = 6;
		else
		if(start == 3 && destination == 46)
			price = 6;
		else
		if(start == 3 && destination == 47)
			price = 6;
		else
		if(start == 3 && destination == 48)
			price = 5;
		else
		if(start == 3 && destination == 49)
			price = 5;
		else
		if(start == 3 && destination == 50)
			price = 5;
		else
		if(start == 3 && destination == 51)
			price = 4;
		else
		if(start == 3 && destination == 52)
			price = 4;
		else
		if(start == 3 && destination == 53)
			price = 4;
		else
		if(start == 3 && destination == 54)
			price = 3;
		else
		if(start == 3 && destination == 55)
			price = 3;
		else
		if(start == 3 && destination == 56)
			price = 3;
		else
		if(start == 3 && destination == 57)
			price = 2;
		else
		if(start == 3 && destination == 58)
			price = 3;
		else
		if(start == 3 && destination == 59)
			price = 2;
		else
		if(start == 3 && destination == 60)
			price = 2;
		else
		if(start == 3 && destination == 61)
			price = 3;
		else
		if(start == 3 && destination == 62)
			price = 3;
		else
		if(start == 3 && destination == 63)
			price = 3;
		else
		if(start == 3 && destination == 64)
			price = 3;
		else
		if(start == 3 && destination == 65)
			price = 3;
		else
		if(start == 3 && destination == 66)
			price = 4;
		else
		if(start == 3 && destination == 67)
			price = 4;
		else
		if(start == 3 && destination == 68)
			price = 4;
		else
		if(start == 3 && destination == 69)
			price = 4;
		else
		if(start == 3 && destination == 70)
			price = 5;
		else
		if(start == 3 && destination == 71)
			price = 5;
		else
		if(start == 3 && destination == 72)
			price = 5;
		else
		if(start == 3 && destination == 73)
			price = 5;
		else
		if(start == 3 && destination == 74)
			price = 6;
		else
		if(start == 3 && destination == 75)
			price = 6;
		else
		if(start == 3 && destination == 76)
			price = 6;
		else
		if(start == 3 && destination == 77)
			price = 3;
		else
		if(start == 3 && destination == 78)
			price = 2;
		else
		if(start == 3 && destination == 79)
			price = 2;
		else
		if(start == 3 && destination == 80)
			price = 2;
		else
		if(start == 3 && destination == 81)
			price = 2;
		else
		if(start == 3 && destination == 82)
			price = 3;
		else
		if(start == 3 && destination == 83)
			price = 3;
		else
		if(start == 3 && destination == 84)
			price = 3;
		else
		if(start == 3 && destination == 85)
			price = 4;
		else
		if(start == 3 && destination == 86)
			price = 4;
		else
		if(start == 3 && destination == 87)
			price = 5;
		else
		if(start == 3 && destination == 88)
			price = 5;
		else
		if(start == 3 && destination == 89)
			price = 6;
		else
		if(start == 3 && destination == 90)
			price = 6;
		else
		if(start == 3 && destination == 91)
			price = 6;
		else
		if(start == 3 && destination == 92)
			price = 7;
		else
		if(start == 4 && destination == 0)
			price = 3;
		else
		if(start == 4 && destination == 1)
			price = 3;
		else
		if(start == 4 && destination == 2)
			price = 2;
		else
		if(start == 4 && destination == 3)
			price = 2;
		else
		if(start == 4 && destination == 4)
			price = 0;
		else
		if(start == 4 && destination == 5)
			price = 2;
		else
		if(start == 4 && destination == 6)
			price = 2;
		else
		if(start == 4 && destination == 7)
			price = 3;
		else
		if(start == 4 && destination == 8)
			price = 3;
		else
		if(start == 4 && destination == 9)
			price = 3;
		else
		if(start == 4 && destination == 10)
			price = 4;
		else
		if(start == 4 && destination == 11)
			price = 4;
		else
		if(start == 4 && destination == 12)
			price = 4;
		else
		if(start == 4 && destination == 13)
			price = 5;
		else
		if(start == 4 && destination == 14)
			price = 5;
		else
		if(start == 4 && destination == 15)
			price = 5;
		else
		if(start == 4 && destination == 16)
			price = 5;
		else
		if(start == 4 && destination == 17)
			price = 5;
		else
		if(start == 4 && destination == 18)
			price = 6;
		else
		if(start == 4 && destination == 19)
			price = 6;
		else
		if(start == 4 && destination == 20)
			price = 6;
		else
		if(start == 4 && destination == 21)
			price = 6;
		else
		if(start == 4 && destination == 22)
			price = 7;
		else
		if(start == 4 && destination == 23)
			price = 5;
		else
		if(start == 4 && destination == 24)
			price = 4;
		else
		if(start == 4 && destination == 25)
			price = 4;
		else
		if(start == 4 && destination == 26)
			price = 4;
		else
		if(start == 4 && destination == 27)
			price = 3;
		else
		if(start == 4 && destination == 28)
			price = 3;
		else
		if(start == 4 && destination == 29)
			price = 3;
		else
		if(start == 4 && destination == 30)
			price = 2;
		else
		if(start == 4 && destination == 31)
			price = 2;
		else
		if(start == 4 && destination == 32)
			price = 2;
		else
		if(start == 4 && destination == 33)
			price = 2;
		else
		if(start == 4 && destination == 34)
			price = 2;
		else
		if(start == 4 && destination == 35)
			price = 3;
		else
		if(start == 4 && destination == 36)
			price = 3;
		else
		if(start == 4 && destination == 37)
			price = 3;
		else
		if(start == 4 && destination == 38)
			price = 3;
		else
		if(start == 4 && destination == 39)
			price = 4;
		else
		if(start == 4 && destination == 40)
			price = 4;
		else
		if(start == 4 && destination == 41)
			price = 5;
		else
		if(start == 4 && destination == 42)
			price = 5;
		else
		if(start == 4 && destination == 43)
			price = 5;
		else
		if(start == 4 && destination == 44)
			price = 5;
		else
		if(start == 4 && destination == 45)
			price = 5;
		else
		if(start == 4 && destination == 46)
			price = 6;
		else
		if(start == 4 && destination == 47)
			price = 6;
		else
		if(start == 4 && destination == 48)
			price = 5;
		else
		if(start == 4 && destination == 49)
			price = 5;
		else
		if(start == 4 && destination == 50)
			price = 5;
		else
		if(start == 4 && destination == 51)
			price = 5;
		else
		if(start == 4 && destination == 52)
			price = 5;
		else
		if(start == 4 && destination == 53)
			price = 4;
		else
		if(start == 4 && destination == 54)
			price = 3;
		else
		if(start == 4 && destination == 55)
			price = 3;
		else
		if(start == 4 && destination == 56)
			price = 3;
		else
		if(start == 4 && destination == 57)
			price = 3;
		else
		if(start == 4 && destination == 58)
			price = 3;
		else
		if(start == 4 && destination == 59)
			price = 2;
		else
		if(start == 4 && destination == 60)
			price = 2;
		else
		if(start == 4 && destination == 61)
			price = 2;
		else
		if(start == 4 && destination == 62)
			price = 2;
		else
		if(start == 4 && destination == 63)
			price = 3;
		else
		if(start == 4 && destination == 64)
			price = 3;
		else
		if(start == 4 && destination == 65)
			price = 3;
		else
		if(start == 4 && destination == 66)
			price = 3;
		else
		if(start == 4 && destination == 67)
			price = 3;
		else
		if(start == 4 && destination == 68)
			price = 4;
		else
		if(start == 4 && destination == 69)
			price = 4;
		else
		if(start == 4 && destination == 70)
			price = 4;
		else
		if(start == 4 && destination == 71)
			price = 4;
		else
		if(start == 4 && destination == 72)
			price = 5;
		else
		if(start == 4 && destination == 73)
			price = 5;
		else
		if(start == 4 && destination == 74)
			price = 5;
		else
		if(start == 4 && destination == 75)
			price = 5;
		else
		if(start == 4 && destination == 76)
			price = 6;
		else
		if(start == 4 && destination == 77)
			price = 3;
		else
		if(start == 4 && destination == 78)
			price = 2;
		else
		if(start == 4 && destination == 79)
			price = 2;
		else
		if(start == 4 && destination == 80)
			price = 2;
		else
		if(start == 4 && destination == 81)
			price = 2;
		else
		if(start == 4 && destination == 82)
			price = 3;
		else
		if(start == 4 && destination == 83)
			price = 3;
		else
		if(start == 4 && destination == 84)
			price = 3;
		else
		if(start == 4 && destination == 85)
			price = 4;
		else
		if(start == 4 && destination == 86)
			price = 4;
		else
		if(start == 4 && destination == 87)
			price = 5;
		else
		if(start == 4 && destination == 88)
			price = 5;
		else
		if(start == 4 && destination == 89)
			price = 6;
		else
		if(start == 4 && destination == 90)
			price = 6;
		else
		if(start == 4 && destination == 91)
			price = 6;
		else
		if(start == 4 && destination == 92)
			price = 7;
		else
		if(start == 5 && destination == 0)
			price = 4;
		else
		if(start == 5 && destination == 1)
			price = 3;
		else
		if(start == 5 && destination == 2)
			price = 3;
		else
		if(start == 5 && destination == 3)
			price = 3;
		else
		if(start == 5 && destination == 4)
			price = 2;
		else
		if(start == 5 && destination == 5)
			price = 0;
		else
		if(start == 5 && destination == 6)
			price = 2;
		else
		if(start == 5 && destination == 7)
			price = 2;
		else
		if(start == 5 && destination == 8)
			price = 3;
		else
		if(start == 5 && destination == 9)
			price = 3;
		else
		if(start == 5 && destination == 10)
			price = 3;
		else
		if(start == 5 && destination == 11)
			price = 3;
		else
		if(start == 5 && destination == 12)
			price = 4;
		else
		if(start == 5 && destination == 13)
			price = 5;
		else
		if(start == 5 && destination == 14)
			price = 5;
		else
		if(start == 5 && destination == 15)
			price = 5;
		else
		if(start == 5 && destination == 16)
			price = 5;
		else
		if(start == 5 && destination == 17)
			price = 5;
		else
		if(start == 5 && destination == 18)
			price = 5;
		else
		if(start == 5 && destination == 19)
			price = 6;
		else
		if(start == 5 && destination == 20)
			price = 6;
		else
		if(start == 5 && destination == 21)
			price = 6;
		else
		if(start == 5 && destination == 22)
			price = 7;
		else
		if(start == 5 && destination == 23)
			price = 4;
		else
		if(start == 5 && destination == 24)
			price = 4;
		else
		if(start == 5 && destination == 25)
			price = 4;
		else
		if(start == 5 && destination == 26)
			price = 4;
		else
		if(start == 5 && destination == 27)
			price = 3;
		else
		if(start == 5 && destination == 28)
			price = 3;
		else
		if(start == 5 && destination == 29)
			price = 3;
		else
		if(start == 5 && destination == 30)
			price = 2;
		else
		if(start == 5 && destination == 31)
			price = 2;
		else
		if(start == 5 && destination == 32)
			price = 2;
		else
		if(start == 5 && destination == 33)
			price = 2;
		else
		if(start == 5 && destination == 34)
			price = 2;
		else
		if(start == 5 && destination == 35)
			price = 3;
		else
		if(start == 5 && destination == 36)
			price = 3;
		else
		if(start == 5 && destination == 37)
			price = 3;
		else
		if(start == 5 && destination == 38)
			price = 3;
		else
		if(start == 5 && destination == 39)
			price = 4;
		else
		if(start == 5 && destination == 40)
			price = 4;
		else
		if(start == 5 && destination == 41)
			price = 5;
		else
		if(start == 5 && destination == 42)
			price = 5;
		else
		if(start == 5 && destination == 43)
			price = 5;
		else
		if(start == 5 && destination == 44)
			price = 5;
		else
		if(start == 5 && destination == 45)
			price = 5;
		else
		if(start == 5 && destination == 46)
			price = 6;
		else
		if(start == 5 && destination == 47)
			price = 6;
		else
		if(start == 5 && destination == 48)
			price = 6;
		else
		if(start == 5 && destination == 49)
			price = 5;
		else
		if(start == 5 && destination == 50)
			price = 5;
		else
		if(start == 5 && destination == 51)
			price = 5;
		else
		if(start == 5 && destination == 52)
			price = 5;
		else
		if(start == 5 && destination == 53)
			price = 5;
		else
		if(start == 5 && destination == 54)
			price = 4;
		else
		if(start == 5 && destination == 55)
			price = 4;
		else
		if(start == 5 && destination == 56)
			price = 3;
		else
		if(start == 5 && destination == 57)
			price = 3;
		else
		if(start == 5 && destination == 58)
			price = 3;
		else
		if(start == 5 && destination == 59)
			price = 2;
		else
		if(start == 5 && destination == 60)
			price = 2;
		else
		if(start == 5 && destination == 61)
			price = 2;
		else
		if(start == 5 && destination == 62)
			price = 2;
		else
		if(start == 5 && destination == 63)
			price = 3;
		else
		if(start == 5 && destination == 64)
			price = 3;
		else
		if(start == 5 && destination == 65)
			price = 3;
		else
		if(start == 5 && destination == 66)
			price = 3;
		else
		if(start == 5 && destination == 67)
			price = 3;
		else
		if(start == 5 && destination == 68)
			price = 4;
		else
		if(start == 5 && destination == 69)
			price = 4;
		else
		if(start == 5 && destination == 70)
			price = 4;
		else
		if(start == 5 && destination == 71)
			price = 4;
		else
		if(start == 5 && destination == 72)
			price = 5;
		else
		if(start == 5 && destination == 73)
			price = 5;
		else
		if(start == 5 && destination == 74)
			price = 5;
		else
		if(start == 5 && destination == 75)
			price = 5;
		else
		if(start == 5 && destination == 76)
			price = 6;
		else
		if(start == 5 && destination == 77)
			price = 3;
		else
		if(start == 5 && destination == 78)
			price = 3;
		else
		if(start == 5 && destination == 79)
			price = 2;
		else
		if(start == 5 && destination == 80)
			price = 2;
		else
		if(start == 5 && destination == 81)
			price = 3;
		else
		if(start == 5 && destination == 82)
			price = 3;
		else
		if(start == 5 && destination == 83)
			price = 3;
		else
		if(start == 5 && destination == 84)
			price = 4;
		else
		if(start == 5 && destination == 85)
			price = 4;
		else
		if(start == 5 && destination == 86)
			price = 5;
		else
		if(start == 5 && destination == 87)
			price = 5;
		else
		if(start == 5 && destination == 88)
			price = 5;
		else
		if(start == 5 && destination == 89)
			price = 6;
		else
		if(start == 5 && destination == 90)
			price = 6;
		else
		if(start == 5 && destination == 91)
			price = 6;
		else
		if(start == 5 && destination == 92)
			price = 7;
		else
		if(start == 6 && destination == 0)
			price = 4;
		else
		if(start == 6 && destination == 1)
			price = 4;
		else
		if(start == 6 && destination == 2)
			price = 3;
		else
		if(start == 6 && destination == 3)
			price = 3;
		else
		if(start == 6 && destination == 4)
			price = 2;
		else
		if(start == 6 && destination == 5)
			price = 2;
		else
		if(start == 6 && destination == 6)
			price = 0;
		else
		if(start == 6 && destination == 7)
			price = 2;
		else
		if(start == 6 && destination == 8)
			price = 2;
		else
		if(start == 6 && destination == 9)
			price = 3;
		else
		if(start == 6 && destination == 10)
			price = 3;
		else
		if(start == 6 && destination == 11)
			price = 3;
		else
		if(start == 6 && destination == 12)
			price = 4;
		else
		if(start == 6 && destination == 13)
			price = 4;
		else
		if(start == 6 && destination == 14)
			price = 5;
		else
		if(start == 6 && destination == 15)
			price = 5;
		else
		if(start == 6 && destination == 16)
			price = 5;
		else
		if(start == 6 && destination == 17)
			price = 5;
		else
		if(start == 6 && destination == 18)
			price = 5;
		else
		if(start == 6 && destination == 19)
			price = 6;
		else
		if(start == 6 && destination == 20)
			price = 6;
		else
		if(start == 6 && destination == 21)
			price = 6;
		else
		if(start == 6 && destination == 22)
			price = 6;
		else
		if(start == 6 && destination == 23)
			price = 4;
		else
		if(start == 6 && destination == 24)
			price = 4;
		else
		if(start == 6 && destination == 25)
			price = 3;
		else
		if(start == 6 && destination == 26)
			price = 4;
		else
		if(start == 6 && destination == 27)
			price = 3;
		else
		if(start == 6 && destination == 28)
			price = 3;
		else
		if(start == 6 && destination == 29)
			price = 3;
		else
		if(start == 6 && destination == 30)
			price = 3;
		else
		if(start == 6 && destination == 31)
			price = 2;
		else
		if(start == 6 && destination == 32)
			price = 2;
		else
		if(start == 6 && destination == 33)
			price = 2;
		else
		if(start == 6 && destination == 34)
			price = 2;
		else
		if(start == 6 && destination == 35)
			price = 3;
		else
		if(start == 6 && destination == 36)
			price = 3;
		else
		if(start == 6 && destination == 37)
			price = 3;
		else
		if(start == 6 && destination == 38)
			price = 4;
		else
		if(start == 6 && destination == 39)
			price = 4;
		else
		if(start == 6 && destination == 40)
			price = 4;
		else
		if(start == 6 && destination == 41)
			price = 5;
		else
		if(start == 6 && destination == 42)
			price = 5;
		else
		if(start == 6 && destination == 43)
			price = 5;
		else
		if(start == 6 && destination == 44)
			price = 5;
		else
		if(start == 6 && destination == 45)
			price = 6;
		else
		if(start == 6 && destination == 46)
			price = 6;
		else
		if(start == 6 && destination == 47)
			price = 6;
		else
		if(start == 6 && destination == 48)
			price = 6;
		else
		if(start == 6 && destination == 49)
			price = 6;
		else
		if(start == 6 && destination == 50)
			price = 5;
		else
		if(start == 6 && destination == 51)
			price = 5;
		else
		if(start == 6 && destination == 52)
			price = 5;
		else
		if(start == 6 && destination == 53)
			price = 5;
		else
		if(start == 6 && destination == 54)
			price = 4;
		else
		if(start == 6 && destination == 55)
			price = 4;
		else
		if(start == 6 && destination == 56)
			price = 4;
		else
		if(start == 6 && destination == 57)
			price = 3;
		else
		if(start == 6 && destination == 58)
			price = 3;
		else
		if(start == 6 && destination == 59)
			price = 3;
		else
		if(start == 6 && destination == 60)
			price = 2;
		else
		if(start == 6 && destination == 61)
			price = 2;
		else
		if(start == 6 && destination == 62)
			price = 2;
		else
		if(start == 6 && destination == 63)
			price = 3;
		else
		if(start == 6 && destination == 64)
			price = 3;
		else
		if(start == 6 && destination == 65)
			price = 3;
		else
		if(start == 6 && destination == 66)
			price = 3;
		else
		if(start == 6 && destination == 67)
			price = 4;
		else
		if(start == 6 && destination == 68)
			price = 4;
		else
		if(start == 6 && destination == 69)
			price = 4;
		else
		if(start == 6 && destination == 70)
			price = 4;
		else
		if(start == 6 && destination == 71)
			price = 4;
		else
		if(start == 6 && destination == 72)
			price = 5;
		else
		if(start == 6 && destination == 73)
			price = 5;
		else
		if(start == 6 && destination == 74)
			price = 5;
		else
		if(start == 6 && destination == 75)
			price = 5;
		else
		if(start == 6 && destination == 76)
			price = 6;
		else
		if(start == 6 && destination == 77)
			price = 3;
		else
		if(start == 6 && destination == 78)
			price = 3;
		else
		if(start == 6 && destination == 79)
			price = 3;
		else
		if(start == 6 && destination == 80)
			price = 2;
		else
		if(start == 6 && destination == 81)
			price = 3;
		else
		if(start == 6 && destination == 82)
			price = 3;
		else
		if(start == 6 && destination == 83)
			price = 3;
		else
		if(start == 6 && destination == 84)
			price = 4;
		else
		if(start == 6 && destination == 85)
			price = 4;
		else
		if(start == 6 && destination == 86)
			price = 5;
		else
		if(start == 6 && destination == 87)
			price = 5;
		else
		if(start == 6 && destination == 88)
			price = 5;
		else
		if(start == 6 && destination == 89)
			price = 6;
		else
		if(start == 6 && destination == 90)
			price = 6;
		else
		if(start == 6 && destination == 91)
			price = 6;
		else
		if(start == 6 && destination == 92)
			price = 7;
		else
		if(start == 7 && destination == 0)
			price = 4;
		else
		if(start == 7 && destination == 1)
			price = 4;
		else
		if(start == 7 && destination == 2)
			price = 3;
		else
		if(start == 7 && destination == 3)
			price = 3;
		else
		if(start == 7 && destination == 4)
			price = 3;
		else
		if(start == 7 && destination == 5)
			price = 2;
		else
		if(start == 7 && destination == 6)
			price = 2;
		else
		if(start == 7 && destination == 7)
			price = 0;
		else
		if(start == 7 && destination == 8)
			price = 2;
		else
		if(start == 7 && destination == 9)
			price = 2;
		else
		if(start == 7 && destination == 10)
			price = 3;
		else
		if(start == 7 && destination == 11)
			price = 3;
		else
		if(start == 7 && destination == 12)
			price = 4;
		else
		if(start == 7 && destination == 13)
			price = 4;
		else
		if(start == 7 && destination == 14)
			price = 4;
		else
		if(start == 7 && destination == 15)
			price = 4;
		else
		if(start == 7 && destination == 16)
			price = 5;
		else
		if(start == 7 && destination == 17)
			price = 5;
		else
		if(start == 7 && destination == 18)
			price = 5;
		else
		if(start == 7 && destination == 19)
			price = 5;
		else
		if(start == 7 && destination == 20)
			price = 5;
		else
		if(start == 7 && destination == 21)
			price = 6;
		else
		if(start == 7 && destination == 22)
			price = 6;
		else
		if(start == 7 && destination == 23)
			price = 4;
		else
		if(start == 7 && destination == 24)
			price = 3;
		else
		if(start == 7 && destination == 25)
			price = 3;
		else
		if(start == 7 && destination == 26)
			price = 3;
		else
		if(start == 7 && destination == 27)
			price = 4;
		else
		if(start == 7 && destination == 28)
			price = 4;
		else
		if(start == 7 && destination == 29)
			price = 3;
		else
		if(start == 7 && destination == 30)
			price = 3;
		else
		if(start == 7 && destination == 31)
			price = 3;
		else
		if(start == 7 && destination == 32)
			price = 3;
		else
		if(start == 7 && destination == 33)
			price = 2;
		else
		if(start == 7 && destination == 34)
			price = 3;
		else
		if(start == 7 && destination == 35)
			price = 3;
		else
		if(start == 7 && destination == 36)
			price = 3;
		else
		if(start == 7 && destination == 37)
			price = 4;
		else
		if(start == 7 && destination == 38)
			price = 4;
		else
		if(start == 7 && destination == 39)
			price = 4;
		else
		if(start == 7 && destination == 40)
			price = 5;
		else
		if(start == 7 && destination == 41)
			price = 5;
		else
		if(start == 7 && destination == 42)
			price = 5;
		else
		if(start == 7 && destination == 43)
			price = 5;
		else
		if(start == 7 && destination == 44)
			price = 6;
		else
		if(start == 7 && destination == 45)
			price = 6;
		else
		if(start == 7 && destination == 46)
			price = 6;
		else
		if(start == 7 && destination == 47)
			price = 6;
		else
		if(start == 7 && destination == 48)
			price = 6;
		else
		if(start == 7 && destination == 49)
			price = 6;
		else
		if(start == 7 && destination == 50)
			price = 6;
		else
		if(start == 7 && destination == 51)
			price = 5;
		else
		if(start == 7 && destination == 52)
			price = 5;
		else
		if(start == 7 && destination == 53)
			price = 5;
		else
		if(start == 7 && destination == 54)
			price = 5;
		else
		if(start == 7 && destination == 55)
			price = 4;
		else
		if(start == 7 && destination == 56)
			price = 4;
		else
		if(start == 7 && destination == 57)
			price = 4;
		else
		if(start == 7 && destination == 58)
			price = 4;
		else
		if(start == 7 && destination == 59)
			price = 3;
		else
		if(start == 7 && destination == 60)
			price = 3;
		else
		if(start == 7 && destination == 61)
			price = 3;
		else
		if(start == 7 && destination == 62)
			price = 3;
		else
		if(start == 7 && destination == 63)
			price = 3;
		else
		if(start == 7 && destination == 64)
			price = 3;
		else
		if(start == 7 && destination == 65)
			price = 4;
		else
		if(start == 7 && destination == 66)
			price = 4;
		else
		if(start == 7 && destination == 67)
			price = 4;
		else
		if(start == 7 && destination == 68)
			price = 3;
		else
		if(start == 7 && destination == 69)
			price = 3;
		else
		if(start == 7 && destination == 70)
			price = 3;
		else
		if(start == 7 && destination == 71)
			price = 4;
		else
		if(start == 7 && destination == 72)
			price = 4;
		else
		if(start == 7 && destination == 73)
			price = 5;
		else
		if(start == 7 && destination == 74)
			price = 5;
		else
		if(start == 7 && destination == 75)
			price = 5;
		else
		if(start == 7 && destination == 76)
			price = 5;
		else
		if(start == 7 && destination == 77)
			price = 4;
		else
		if(start == 7 && destination == 78)
			price = 3;
		else
		if(start == 7 && destination == 79)
			price = 3;
		else
		if(start == 7 && destination == 80)
			price = 3;
		else
		if(start == 7 && destination == 81)
			price = 3;
		else
		if(start == 7 && destination == 82)
			price = 3;
		else
		if(start == 7 && destination == 83)
			price = 4;
		else
		if(start == 7 && destination == 84)
			price = 4;
		else
		if(start == 7 && destination == 85)
			price = 5;
		else
		if(start == 7 && destination == 86)
			price = 5;
		else
		if(start == 7 && destination == 87)
			price = 6;
		else
		if(start == 7 && destination == 88)
			price = 6;
		else
		if(start == 7 && destination == 89)
			price = 6;
		else
		if(start == 7 && destination == 90)
			price = 6;
		else
		if(start == 7 && destination == 91)
			price = 7;
		else
		if(start == 7 && destination == 92)
			price = 7;
		else
		if(start == 8 && destination == 0)
			price = 5;
		else
		if(start == 8 && destination == 1)
			price = 4;
		else
		if(start == 8 && destination == 2)
			price = 4;
		else
		if(start == 8 && destination == 3)
			price = 4;
		else
		if(start == 8 && destination == 4)
			price = 3;
		else
		if(start == 8 && destination == 5)
			price = 3;
		else
		if(start == 8 && destination == 6)
			price = 2;
		else
		if(start == 8 && destination == 7)
			price = 2;
		else
		if(start == 8 && destination == 8)
			price = 0;
		else
		if(start == 8 && destination == 9)
			price = 2;
		else
		if(start == 8 && destination == 10)
			price = 2;
		else
		if(start == 8 && destination == 11)
			price = 2;
		else
		if(start == 8 && destination == 12)
			price = 3;
		else
		if(start == 8 && destination == 13)
			price = 4;
		else
		if(start == 8 && destination == 14)
			price = 4;
		else
		if(start == 8 && destination == 15)
			price = 4;
		else
		if(start == 8 && destination == 16)
			price = 4;
		else
		if(start == 8 && destination == 17)
			price = 5;
		else
		if(start == 8 && destination == 18)
			price = 5;
		else
		if(start == 8 && destination == 19)
			price = 5;
		else
		if(start == 8 && destination == 20)
			price = 5;
		else
		if(start == 8 && destination == 21)
			price = 6;
		else
		if(start == 8 && destination == 22)
			price = 6;
		else
		if(start == 8 && destination == 23)
			price = 4;
		else
		if(start == 8 && destination == 24)
			price = 3;
		else
		if(start == 8 && destination == 25)
			price = 3;
		else
		if(start == 8 && destination == 26)
			price = 3;
		else
		if(start == 8 && destination == 27)
			price = 3;
		else
		if(start == 8 && destination == 28)
			price = 3;
		else
		if(start == 8 && destination == 29)
			price = 4;
		else
		if(start == 8 && destination == 30)
			price = 3;
		else
		if(start == 8 && destination == 31)
			price = 3;
		else
		if(start == 8 && destination == 32)
			price = 3;
		else
		if(start == 8 && destination == 33)
			price = 3;
		else
		if(start == 8 && destination == 34)
			price = 3;
		else
		if(start == 8 && destination == 35)
			price = 4;
		else
		if(start == 8 && destination == 36)
			price = 4;
		else
		if(start == 8 && destination == 37)
			price = 4;
		else
		if(start == 8 && destination == 38)
			price = 4;
		else
		if(start == 8 && destination == 39)
			price = 5;
		else
		if(start == 8 && destination == 40)
			price = 5;
		else
		if(start == 8 && destination == 41)
			price = 5;
		else
		if(start == 8 && destination == 42)
			price = 6;
		else
		if(start == 8 && destination == 43)
			price = 6;
		else
		if(start == 8 && destination == 44)
			price = 6;
		else
		if(start == 8 && destination == 45)
			price = 6;
		else
		if(start == 8 && destination == 46)
			price = 6;
		else
		if(start == 8 && destination == 47)
			price = 7;
		else
		if(start == 8 && destination == 48)
			price = 6;
		else
		if(start == 8 && destination == 49)
			price = 6;
		else
		if(start == 8 && destination == 50)
			price = 6;
		else
		if(start == 8 && destination == 51)
			price = 6;
		else
		if(start == 8 && destination == 52)
			price = 6;
		else
		if(start == 8 && destination == 53)
			price = 5;
		else
		if(start == 8 && destination == 54)
			price = 5;
		else
		if(start == 8 && destination == 55)
			price = 5;
		else
		if(start == 8 && destination == 56)
			price = 4;
		else
		if(start == 8 && destination == 57)
			price = 4;
		else
		if(start == 8 && destination == 58)
			price = 4;
		else
		if(start == 8 && destination == 59)
			price = 3;
		else
		if(start == 8 && destination == 60)
			price = 3;
		else
		if(start == 8 && destination == 61)
			price = 3;
		else
		if(start == 8 && destination == 62)
			price = 3;
		else
		if(start == 8 && destination == 63)
			price = 3;
		else
		if(start == 8 && destination == 64)
			price = 4;
		else
		if(start == 8 && destination == 65)
			price = 4;
		else
		if(start == 8 && destination == 66)
			price = 4;
		else
		if(start == 8 && destination == 67)
			price = 3;
		else
		if(start == 8 && destination == 68)
			price = 3;
		else
		if(start == 8 && destination == 69)
			price = 3;
		else
		if(start == 8 && destination == 70)
			price = 3;
		else
		if(start == 8 && destination == 71)
			price = 3;
		else
		if(start == 8 && destination == 72)
			price = 4;
		else
		if(start == 8 && destination == 73)
			price = 4;
		else
		if(start == 8 && destination == 74)
			price = 5;
		else
		if(start == 8 && destination == 75)
			price = 5;
		else
		if(start == 8 && destination == 76)
			price = 5;
		else
		if(start == 8 && destination == 77)
			price = 4;
		else
		if(start == 8 && destination == 78)
			price = 4;
		else
		if(start == 8 && destination == 79)
			price = 3;
		else
		if(start == 8 && destination == 80)
			price = 3;
		else
		if(start == 8 && destination == 81)
			price = 4;
		else
		if(start == 8 && destination == 82)
			price = 4;
		else
		if(start == 8 && destination == 83)
			price = 4;
		else
		if(start == 8 && destination == 84)
			price = 5;
		else
		if(start == 8 && destination == 85)
			price = 5;
		else
		if(start == 8 && destination == 86)
			price = 5;
		else
		if(start == 8 && destination == 87)
			price = 6;
		else
		if(start == 8 && destination == 88)
			price = 6;
		else
		if(start == 8 && destination == 89)
			price = 6;
		else
		if(start == 8 && destination == 90)
			price = 7;
		else
		if(start == 8 && destination == 91)
			price = 7;
		else
		if(start == 8 && destination == 92)
			price = 7;
		else
		if(start == 9 && destination == 0)
			price = 5;
		else
		if(start == 9 && destination == 1)
			price = 5;
		else
		if(start == 9 && destination == 2)
			price = 4;
		else
		if(start == 9 && destination == 3)
			price = 4;
		else
		if(start == 9 && destination == 4)
			price = 3;
		else
		if(start == 9 && destination == 5)
			price = 3;
		else
		if(start == 9 && destination == 6)
			price = 3;
		else
		if(start == 9 && destination == 7)
			price = 2;
		else
		if(start == 9 && destination == 8)
			price = 2;
		else
		if(start == 9 && destination == 9)
			price = 0;
		else
		if(start == 9 && destination == 10)
			price = 2;
		else
		if(start == 9 && destination == 11)
			price = 2;
		else
		if(start == 9 && destination == 12)
			price = 3;
		else
		if(start == 9 && destination == 13)
			price = 3;
		else
		if(start == 9 && destination == 14)
			price = 3;
		else
		if(start == 9 && destination == 15)
			price = 4;
		else
		if(start == 9 && destination == 16)
			price = 4;
		else
		if(start == 9 && destination == 17)
			price = 4;
		else
		if(start == 9 && destination == 18)
			price = 5;
		else
		if(start == 9 && destination == 19)
			price = 5;
		else
		if(start == 9 && destination == 20)
			price = 5;
		else
		if(start == 9 && destination == 21)
			price = 5;
		else
		if(start == 9 && destination == 22)
			price = 6;
		else
		if(start == 9 && destination == 23)
			price = 4;
		else
		if(start == 9 && destination == 24)
			price = 3;
		else
		if(start == 9 && destination == 25)
			price = 3;
		else
		if(start == 9 && destination == 26)
			price = 3;
		else
		if(start == 9 && destination == 27)
			price = 3;
		else
		if(start == 9 && destination == 28)
			price = 4;
		else
		if(start == 9 && destination == 29)
			price = 4;
		else
		if(start == 9 && destination == 30)
			price = 4;
		else
		if(start == 9 && destination == 31)
			price = 4;
		else
		if(start == 9 && destination == 32)
			price = 3;
		else
		if(start == 9 && destination == 33)
			price = 3;
		else
		if(start == 9 && destination == 34)
			price = 4;
		else
		if(start == 9 && destination == 35)
			price = 4;
		else
		if(start == 9 && destination == 36)
			price = 4;
		else
		if(start == 9 && destination == 37)
			price = 4;
		else
		if(start == 9 && destination == 38)
			price = 5;
		else
		if(start == 9 && destination == 39)
			price = 5;
		else
		if(start == 9 && destination == 40)
			price = 5;
		else
		if(start == 9 && destination == 41)
			price = 6;
		else
		if(start == 9 && destination == 42)
			price = 6;
		else
		if(start == 9 && destination == 43)
			price = 6;
		else
		if(start == 9 && destination == 44)
			price = 6;
		else
		if(start == 9 && destination == 45)
			price = 6;
		else
		if(start == 9 && destination == 46)
			price = 7;
		else
		if(start == 9 && destination == 47)
			price = 7;
		else
		if(start == 9 && destination == 48)
			price = 7;
		else
		if(start == 9 && destination == 49)
			price = 6;
		else
		if(start == 9 && destination == 50)
			price = 6;
		else
		if(start == 9 && destination == 51)
			price = 6;
		else
		if(start == 9 && destination == 52)
			price = 6;
		else
		if(start == 9 && destination == 53)
			price = 6;
		else
		if(start == 9 && destination == 54)
			price = 5;
		else
		if(start == 9 && destination == 55)
			price = 5;
		else
		if(start == 9 && destination == 56)
			price = 5;
		else
		if(start == 9 && destination == 57)
			price = 4;
		else
		if(start == 9 && destination == 58)
			price = 4;
		else
		if(start == 9 && destination == 59)
			price = 4;
		else
		if(start == 9 && destination == 60)
			price = 4;
		else
		if(start == 9 && destination == 61)
			price = 3;
		else
		if(start == 9 && destination == 62)
			price = 4;
		else
		if(start == 9 && destination == 63)
			price = 4;
		else
		if(start == 9 && destination == 64)
			price = 4;
		else
		if(start == 9 && destination == 65)
			price = 3;
		else
		if(start == 9 && destination == 66)
			price = 3;
		else
		if(start == 9 && destination == 67)
			price = 3;
		else
		if(start == 9 && destination == 68)
			price = 3;
		else
		if(start == 9 && destination == 69)
			price = 3;
		else
		if(start == 9 && destination == 70)
			price = 3;
		else
		if(start == 9 && destination == 71)
			price = 3;
		else
		if(start == 9 && destination == 72)
			price = 3;
		else
		if(start == 9 && destination == 73)
			price = 4;
		else
		if(start == 9 && destination == 74)
			price = 4;
		else
		if(start == 9 && destination == 75)
			price = 5;
		else
		if(start == 9 && destination == 76)
			price = 5;
		else
		if(start == 9 && destination == 77)
			price = 4;
		else
		if(start == 9 && destination == 78)
			price = 4;
		else
		if(start == 9 && destination == 79)
			price = 4;
		else
		if(start == 9 && destination == 80)
			price = 4;
		else
		if(start == 9 && destination == 81)
			price = 4;
		else
		if(start == 9 && destination == 82)
			price = 4;
		else
		if(start == 9 && destination == 83)
			price = 5;
		else
		if(start == 9 && destination == 84)
			price = 5;
		else
		if(start == 9 && destination == 85)
			price = 5;
		else
		if(start == 9 && destination == 86)
			price = 5;
		else
		if(start == 9 && destination == 87)
			price = 6;
		else
		if(start == 9 && destination == 88)
			price = 6;
		else
		if(start == 9 && destination == 89)
			price = 6;
		else
		if(start == 9 && destination == 90)
			price = 7;
		else
		if(start == 9 && destination == 91)
			price = 7;
		else
		if(start == 9 && destination == 92)
			price = 7;
		else
		if(start == 10 && destination == 0)
			price = 5;
		else
		if(start == 10 && destination == 1)
			price = 5;
		else
		if(start == 10 && destination == 2)
			price = 4;
		else
		if(start == 10 && destination == 3)
			price = 4;
		else
		if(start == 10 && destination == 4)
			price = 4;
		else
		if(start == 10 && destination == 5)
			price = 3;
		else
		if(start == 10 && destination == 6)
			price = 3;
		else
		if(start == 10 && destination == 7)
			price = 3;
		else
		if(start == 10 && destination == 8)
			price = 2;
		else
		if(start == 10 && destination == 9)
			price = 2;
		else
		if(start == 10 && destination == 10)
			price = 0;
		else
		if(start == 10 && destination == 11)
			price = 2;
		else
		if(start == 10 && destination == 12)
			price = 3;
		else
		if(start == 10 && destination == 13)
			price = 3;
		else
		if(start == 10 && destination == 14)
			price = 3;
		else
		if(start == 10 && destination == 15)
			price = 3;
		else
		if(start == 10 && destination == 16)
			price = 4;
		else
		if(start == 10 && destination == 17)
			price = 4;
		else
		if(start == 10 && destination == 18)
			price = 4;
		else
		if(start == 10 && destination == 19)
			price = 5;
		else
		if(start == 10 && destination == 20)
			price = 5;
		else
		if(start == 10 && destination == 21)
			price = 5;
		else
		if(start == 10 && destination == 22)
			price = 5;
		else
		if(start == 10 && destination == 23)
			price = 4;
		else
		if(start == 10 && destination == 24)
			price = 4;
		else
		if(start == 10 && destination == 25)
			price = 3;
		else
		if(start == 10 && destination == 26)
			price = 3;
		else
		if(start == 10 && destination == 27)
			price = 4;
		else
		if(start == 10 && destination == 28)
			price = 4;
		else
		if(start == 10 && destination == 29)
			price = 4;
		else
		if(start == 10 && destination == 30)
			price = 4;
		else
		if(start == 10 && destination == 31)
			price = 4;
		else
		if(start == 10 && destination == 32)
			price = 4;
		else
		if(start == 10 && destination == 33)
			price = 3;
		else
		if(start == 10 && destination == 34)
			price = 4;
		else
		if(start == 10 && destination == 35)
			price = 4;
		else
		if(start == 10 && destination == 36)
			price = 4;
		else
		if(start == 10 && destination == 37)
			price = 5;
		else
		if(start == 10 && destination == 38)
			price = 5;
		else
		if(start == 10 && destination == 39)
			price = 5;
		else
		if(start == 10 && destination == 40)
			price = 5;
		else
		if(start == 10 && destination == 41)
			price = 6;
		else
		if(start == 10 && destination == 42)
			price = 6;
		else
		if(start == 10 && destination == 43)
			price = 6;
		else
		if(start == 10 && destination == 44)
			price = 6;
		else
		if(start == 10 && destination == 45)
			price = 7;
		else
		if(start == 10 && destination == 46)
			price = 7;
		else
		if(start == 10 && destination == 47)
			price = 7;
		else
		if(start == 10 && destination == 48)
			price = 7;
		else
		if(start == 10 && destination == 49)
			price = 6;
		else
		if(start == 10 && destination == 50)
			price = 6;
		else
		if(start == 10 && destination == 51)
			price = 6;
		else
		if(start == 10 && destination == 52)
			price = 6;
		else
		if(start == 10 && destination == 53)
			price = 6;
		else
		if(start == 10 && destination == 54)
			price = 5;
		else
		if(start == 10 && destination == 55)
			price = 5;
		else
		if(start == 10 && destination == 56)
			price = 5;
		else
		if(start == 10 && destination == 57)
			price = 5;
		else
		if(start == 10 && destination == 58)
			price = 5;
		else
		if(start == 10 && destination == 59)
			price = 4;
		else
		if(start == 10 && destination == 60)
			price = 4;
		else
		if(start == 10 && destination == 61)
			price = 4;
		else
		if(start == 10 && destination == 62)
			price = 4;
		else
		if(start == 10 && destination == 63)
			price = 4;
		else
		if(start == 10 && destination == 64)
			price = 3;
		else
		if(start == 10 && destination == 65)
			price = 3;
		else
		if(start == 10 && destination == 66)
			price = 3;
		else
		if(start == 10 && destination == 67)
			price = 3;
		else
		if(start == 10 && destination == 68)
			price = 3;
		else
		if(start == 10 && destination == 69)
			price = 2;
		else
		if(start == 10 && destination == 70)
			price = 2;
		else
		if(start == 10 && destination == 71)
			price = 3;
		else
		if(start == 10 && destination == 72)
			price = 3;
		else
		if(start == 10 && destination == 73)
			price = 4;
		else
		if(start == 10 && destination == 74)
			price = 4;
		else
		if(start == 10 && destination == 75)
			price = 4;
		else
		if(start == 10 && destination == 76)
			price = 5;
		else
		if(start == 10 && destination == 77)
			price = 5;
		else
		if(start == 10 && destination == 78)
			price = 4;
		else
		if(start == 10 && destination == 79)
			price = 4;
		else
		if(start == 10 && destination == 80)
			price = 4;
		else
		if(start == 10 && destination == 81)
			price = 4;
		else
		if(start == 10 && destination == 82)
			price = 4;
		else
		if(start == 10 && destination == 83)
			price = 5;
		else
		if(start == 10 && destination == 84)
			price = 5;
		else
		if(start == 10 && destination == 85)
			price = 5;
		else
		if(start == 10 && destination == 86)
			price = 6;
		else
		if(start == 10 && destination == 87)
			price = 6;
		else
		if(start == 10 && destination == 88)
			price = 6;
		else
		if(start == 10 && destination == 89)
			price = 7;
		else
		if(start == 10 && destination == 90)
			price = 7;
		else
		if(start == 10 && destination == 91)
			price = 7;
		else
		if(start == 10 && destination == 92)
			price = 7;
		else
		if(start == 11 && destination == 0)
			price = 5;
		else
		if(start == 11 && destination == 1)
			price = 5;
		else
		if(start == 11 && destination == 2)
			price = 5;
		else
		if(start == 11 && destination == 3)
			price = 4;
		else
		if(start == 11 && destination == 4)
			price = 4;
		else
		if(start == 11 && destination == 5)
			price = 3;
		else
		if(start == 11 && destination == 6)
			price = 3;
		else
		if(start == 11 && destination == 7)
			price = 3;
		else
		if(start == 11 && destination == 8)
			price = 2;
		else
		if(start == 11 && destination == 9)
			price = 2;
		else
		if(start == 11 && destination == 10)
			price = 2;
		else
		if(start == 11 && destination == 11)
			price = 0;
		else
		if(start == 11 && destination == 12)
			price = 3;
		else
		if(start == 11 && destination == 13)
			price = 3;
		else
		if(start == 11 && destination == 14)
			price = 3;
		else
		if(start == 11 && destination == 15)
			price = 3;
		else
		if(start == 11 && destination == 16)
			price = 4;
		else
		if(start == 11 && destination == 17)
			price = 4;
		else
		if(start == 11 && destination == 18)
			price = 4;
		else
		if(start == 11 && destination == 19)
			price = 4;
		else
		if(start == 11 && destination == 20)
			price = 5;
		else
		if(start == 11 && destination == 21)
			price = 5;
		else
		if(start == 11 && destination == 22)
			price = 5;
		else
		if(start == 11 && destination == 23)
			price = 4;
		else
		if(start == 11 && destination == 24)
			price = 4;
		else
		if(start == 11 && destination == 25)
			price = 3;
		else
		if(start == 11 && destination == 26)
			price = 4;
		else
		if(start == 11 && destination == 27)
			price = 4;
		else
		if(start == 11 && destination == 28)
			price = 4;
		else
		if(start == 11 && destination == 29)
			price = 4;
		else
		if(start == 11 && destination == 30)
			price = 4;
		else
		if(start == 11 && destination == 31)
			price = 4;
		else
		if(start == 11 && destination == 32)
			price = 4;
		else
		if(start == 11 && destination == 33)
			price = 4;
		else
		if(start == 11 && destination == 34)
			price = 4;
		else
		if(start == 11 && destination == 35)
			price = 4;
		else
		if(start == 11 && destination == 36)
			price = 5;
		else
		if(start == 11 && destination == 37)
			price = 5;
		else
		if(start == 11 && destination == 38)
			price = 5;
		else
		if(start == 11 && destination == 39)
			price = 5;
		else
		if(start == 11 && destination == 40)
			price = 5;
		else
		if(start == 11 && destination == 41)
			price = 6;
		else
		if(start == 11 && destination == 42)
			price = 6;
		else
		if(start == 11 && destination == 43)
			price = 6;
		else
		if(start == 11 && destination == 44)
			price = 7;
		else
		if(start == 11 && destination == 45)
			price = 7;
		else
		if(start == 11 && destination == 46)
			price = 7;
		else
		if(start == 11 && destination == 47)
			price = 7;
		else
		if(start == 11 && destination == 48)
			price = 7;
		else
		if(start == 11 && destination == 49)
			price = 7;
		else
		if(start == 11 && destination == 50)
			price = 6;
		else
		if(start == 11 && destination == 51)
			price = 6;
		else
		if(start == 11 && destination == 52)
			price = 6;
		else
		if(start == 11 && destination == 53)
			price = 6;
		else
		if(start == 11 && destination == 54)
			price = 5;
		else
		if(start == 11 && destination == 55)
			price = 5;
		else
		if(start == 11 && destination == 56)
			price = 5;
		else
		if(start == 11 && destination == 57)
			price = 5;
		else
		if(start == 11 && destination == 58)
			price = 5;
		else
		if(start == 11 && destination == 59)
			price = 4;
		else
		if(start == 11 && destination == 60)
			price = 4;
		else
		if(start == 11 && destination == 61)
			price = 4;
		else
		if(start == 11 && destination == 62)
			price = 4;
		else
		if(start == 11 && destination == 63)
			price = 3;
		else
		if(start == 11 && destination == 64)
			price = 3;
		else
		if(start == 11 && destination == 65)
			price = 3;
		else
		if(start == 11 && destination == 66)
			price = 3;
		else
		if(start == 11 && destination == 67)
			price = 3;
		else
		if(start == 11 && destination == 68)
			price = 2;
		else
		if(start == 11 && destination == 69)
			price = 2;
		else
		if(start == 11 && destination == 70)
			price = 2;
		else
		if(start == 11 && destination == 71)
			price = 3;
		else
		if(start == 11 && destination == 72)
			price = 3;
		else
		if(start == 11 && destination == 73)
			price = 3;
		else
		if(start == 11 && destination == 74)
			price = 4;
		else
		if(start == 11 && destination == 75)
			price = 4;
		else
		if(start == 11 && destination == 76)
			price = 5;
		else
		if(start == 11 && destination == 77)
			price = 5;
		else
		if(start == 11 && destination == 78)
			price = 5;
		else
		if(start == 11 && destination == 79)
			price = 4;
		else
		if(start == 11 && destination == 80)
			price = 4;
		else
		if(start == 11 && destination == 81)
			price = 4;
		else
		if(start == 11 && destination == 82)
			price = 5;
		else
		if(start == 11 && destination == 83)
			price = 5;
		else
		if(start == 11 && destination == 84)
			price = 5;
		else
		if(start == 11 && destination == 85)
			price = 5;
		else
		if(start == 11 && destination == 86)
			price = 6;
		else
		if(start == 11 && destination == 87)
			price = 6;
		else
		if(start == 11 && destination == 88)
			price = 7;
		else
		if(start == 11 && destination == 89)
			price = 7;
		else
		if(start == 11 && destination == 90)
			price = 7;
		else
		if(start == 11 && destination == 91)
			price = 7;
		else
		if(start == 11 && destination == 92)
			price = 8;
		else
		if(start == 12 && destination == 0)
			price = 5;
		else
		if(start == 12 && destination == 1)
			price = 5;
		else
		if(start == 12 && destination == 2)
			price = 5;
		else
		if(start == 12 && destination == 3)
			price = 5;
		else
		if(start == 12 && destination == 4)
			price = 4;
		else
		if(start == 12 && destination == 5)
			price = 4;
		else
		if(start == 12 && destination == 6)
			price = 4;
		else
		if(start == 12 && destination == 7)
			price = 4;
		else
		if(start == 12 && destination == 8)
			price = 3;
		else
		if(start == 12 && destination == 9)
			price = 3;
		else
		if(start == 12 && destination == 10)
			price = 3;
		else
		if(start == 12 && destination == 11)
			price = 3;
		else
		if(start == 12 && destination == 12)
			price = 0;
		else
		if(start == 12 && destination == 13)
			price = 2;
		else
		if(start == 12 && destination == 14)
			price = 2;
		else
		if(start == 12 && destination == 15)
			price = 2;
		else
		if(start == 12 && destination == 16)
			price = 3;
		else
		if(start == 12 && destination == 17)
			price = 3;
		else
		if(start == 12 && destination == 18)
			price = 3;
		else
		if(start == 12 && destination == 19)
			price = 4;
		else
		if(start == 12 && destination == 20)
			price = 4;
		else
		if(start == 12 && destination == 21)
			price = 4;
		else
		if(start == 12 && destination == 22)
			price = 5;
		else
		if(start == 12 && destination == 23)
			price = 4;
		else
		if(start == 12 && destination == 24)
			price = 4;
		else
		if(start == 12 && destination == 25)
			price = 4;
		else
		if(start == 12 && destination == 26)
			price = 4;
		else
		if(start == 12 && destination == 27)
			price = 5;
		else
		if(start == 12 && destination == 28)
			price = 5;
		else
		if(start == 12 && destination == 29)
			price = 5;
		else
		if(start == 12 && destination == 30)
			price = 5;
		else
		if(start == 12 && destination == 31)
			price = 4;
		else
		if(start == 12 && destination == 32)
			price = 4;
		else
		if(start == 12 && destination == 33)
			price = 4;
		else
		if(start == 12 && destination == 34)
			price = 4;
		else
		if(start == 12 && destination == 35)
			price = 4;
		else
		if(start == 12 && destination == 36)
			price = 5;
		else
		if(start == 12 && destination == 37)
			price = 5;
		else
		if(start == 12 && destination == 38)
			price = 5;
		else
		if(start == 12 && destination == 39)
			price = 5;
		else
		if(start == 12 && destination == 40)
			price = 6;
		else
		if(start == 12 && destination == 41)
			price = 6;
		else
		if(start == 12 && destination == 42)
			price = 6;
		else
		if(start == 12 && destination == 43)
			price = 6;
		else
		if(start == 12 && destination == 44)
			price = 7;
		else
		if(start == 12 && destination == 45)
			price = 7;
		else
		if(start == 12 && destination == 46)
			price = 7;
		else
		if(start == 12 && destination == 47)
			price = 7;
		else
		if(start == 12 && destination == 48)
			price = 7;
		else
		if(start == 12 && destination == 49)
			price = 7;
		else
		if(start == 12 && destination == 50)
			price = 7;
		else
		if(start == 12 && destination == 51)
			price = 7;
		else
		if(start == 12 && destination == 52)
			price = 6;
		else
		if(start == 12 && destination == 53)
			price = 6;
		else
		if(start == 12 && destination == 54)
			price = 6;
		else
		if(start == 12 && destination == 55)
			price = 5;
		else
		if(start == 12 && destination == 56)
			price = 5;
		else
		if(start == 12 && destination == 57)
			price = 5;
		else
		if(start == 12 && destination == 58)
			price = 5;
		else
		if(start == 12 && destination == 59)
			price = 4;
		else
		if(start == 12 && destination == 60)
			price = 4;
		else
		if(start == 12 && destination == 61)
			price = 4;
		else
		if(start == 12 && destination == 62)
			price = 4;
		else
		if(start == 12 && destination == 63)
			price = 4;
		else
		if(start == 12 && destination == 64)
			price = 3;
		else
		if(start == 12 && destination == 65)
			price = 3;
		else
		if(start == 12 && destination == 66)
			price = 3;
		else
		if(start == 12 && destination == 67)
			price = 3;
		else
		if(start == 12 && destination == 68)
			price = 2;
		else
		if(start == 12 && destination == 69)
			price = 2;
		else
		if(start == 12 && destination == 70)
			price = 2;
		else
		if(start == 12 && destination == 71)
			price = 3;
		else
		if(start == 12 && destination == 72)
			price = 3;
		else
		if(start == 12 && destination == 73)
			price = 4;
		else
		if(start == 12 && destination == 74)
			price = 4;
		else
		if(start == 12 && destination == 75)
			price = 4;
		else
		if(start == 12 && destination == 76)
			price = 5;
		else
		if(start == 12 && destination == 77)
			price = 5;
		else
		if(start == 12 && destination == 78)
			price = 5;
		else
		if(start == 12 && destination == 79)
			price = 5;
		else
		if(start == 12 && destination == 80)
			price = 5;
		else
		if(start == 12 && destination == 81)
			price = 4;
		else
		if(start == 12 && destination == 82)
			price = 5;
		else
		if(start == 12 && destination == 83)
			price = 5;
		else
		if(start == 12 && destination == 84)
			price = 5;
		else
		if(start == 12 && destination == 85)
			price = 5;
		else
		if(start == 12 && destination == 86)
			price = 6;
		else
		if(start == 12 && destination == 87)
			price = 6;
		else
		if(start == 12 && destination == 88)
			price = 7;
		else
		if(start == 12 && destination == 89)
			price = 7;
		else
		if(start == 12 && destination == 90)
			price = 7;
		else
		if(start == 12 && destination == 91)
			price = 7;
		else
		if(start == 12 && destination == 92)
			price = 8;
		else
		if(start == 13 && destination == 0)
			price = 6;
		else
		if(start == 13 && destination == 1)
			price = 5;
		else
		if(start == 13 && destination == 2)
			price = 5;
		else
		if(start == 13 && destination == 3)
			price = 5;
		else
		if(start == 13 && destination == 4)
			price = 5;
		else
		if(start == 13 && destination == 5)
			price = 5;
		else
		if(start == 13 && destination == 6)
			price = 4;
		else
		if(start == 13 && destination == 7)
			price = 4;
		else
		if(start == 13 && destination == 8)
			price = 4;
		else
		if(start == 13 && destination == 9)
			price = 3;
		else
		if(start == 13 && destination == 10)
			price = 3;
		else
		if(start == 13 && destination == 11)
			price = 3;
		else
		if(start == 13 && destination == 12)
			price = 2;
		else
		if(start == 13 && destination == 13)
			price = 0;
		else
		if(start == 13 && destination == 14)
			price = 2;
		else
		if(start == 13 && destination == 15)
			price = 2;
		else
		if(start == 13 && destination == 16)
			price = 2;
		else
		if(start == 13 && destination == 17)
			price = 3;
		else
		if(start == 13 && destination == 18)
			price = 3;
		else
		if(start == 13 && destination == 19)
			price = 3;
		else
		if(start == 13 && destination == 20)
			price = 4;
		else
		if(start == 13 && destination == 21)
			price = 4;
		else
		if(start == 13 && destination == 22)
			price = 5;
		else
		if(start == 13 && destination == 23)
			price = 4;
		else
		if(start == 13 && destination == 24)
			price = 5;
		else
		if(start == 13 && destination == 25)
			price = 5;
		else
		if(start == 13 && destination == 26)
			price = 5;
		else
		if(start == 13 && destination == 27)
			price = 5;
		else
		if(start == 13 && destination == 28)
			price = 5;
		else
		if(start == 13 && destination == 29)
			price = 5;
		else
		if(start == 13 && destination == 30)
			price = 5;
		else
		if(start == 13 && destination == 31)
			price = 5;
		else
		if(start == 13 && destination == 32)
			price = 5;
		else
		if(start == 13 && destination == 33)
			price = 4;
		else
		if(start == 13 && destination == 34)
			price = 4;
		else
		if(start == 13 && destination == 35)
			price = 5;
		else
		if(start == 13 && destination == 36)
			price = 5;
		else
		if(start == 13 && destination == 37)
			price = 5;
		else
		if(start == 13 && destination == 38)
			price = 5;
		else
		if(start == 13 && destination == 39)
			price = 5;
		else
		if(start == 13 && destination == 40)
			price = 6;
		else
		if(start == 13 && destination == 41)
			price = 6;
		else
		if(start == 13 && destination == 42)
			price = 6;
		else
		if(start == 13 && destination == 43)
			price = 7;
		else
		if(start == 13 && destination == 44)
			price = 7;
		else
		if(start == 13 && destination == 45)
			price = 7;
		else
		if(start == 13 && destination == 46)
			price = 7;
		else
		if(start == 13 && destination == 47)
			price = 7;
		else
		if(start == 13 && destination == 48)
			price = 7;
		else
		if(start == 13 && destination == 49)
			price = 7;
		else
		if(start == 13 && destination == 50)
			price = 7;
		else
		if(start == 13 && destination == 51)
			price = 7;
		else
		if(start == 13 && destination == 52)
			price = 7;
		else
		if(start == 13 && destination == 53)
			price = 6;
		else
		if(start == 13 && destination == 54)
			price = 6;
		else
		if(start == 13 && destination == 55)
			price = 6;
		else
		if(start == 13 && destination == 56)
			price = 5;
		else
		if(start == 13 && destination == 57)
			price = 5;
		else
		if(start == 13 && destination == 58)
			price = 5;
		else
		if(start == 13 && destination == 59)
			price = 5;
		else
		if(start == 13 && destination == 60)
			price = 4;
		else
		if(start == 13 && destination == 61)
			price = 4;
		else
		if(start == 13 && destination == 62)
			price = 4;
		else
		if(start == 13 && destination == 63)
			price = 4;
		else
		if(start == 13 && destination == 64)
			price = 4;
		else
		if(start == 13 && destination == 65)
			price = 3;
		else
		if(start == 13 && destination == 66)
			price = 3;
		else
		if(start == 13 && destination == 67)
			price = 3;
		else
		if(start == 13 && destination == 68)
			price = 3;
		else
		if(start == 13 && destination == 69)
			price = 2;
		else
		if(start == 13 && destination == 70)
			price = 3;
		else
		if(start == 13 && destination == 71)
			price = 3;
		else
		if(start == 13 && destination == 72)
			price = 3;
		else
		if(start == 13 && destination == 73)
			price = 4;
		else
		if(start == 13 && destination == 74)
			price = 4;
		else
		if(start == 13 && destination == 75)
			price = 4;
		else
		if(start == 13 && destination == 76)
			price = 5;
		else
		if(start == 13 && destination == 77)
			price = 5;
		else
		if(start == 13 && destination == 78)
			price = 5;
		else
		if(start == 13 && destination == 79)
			price = 5;
		else
		if(start == 13 && destination == 80)
			price = 5;
		else
		if(start == 13 && destination == 81)
			price = 5;
		else
		if(start == 13 && destination == 82)
			price = 5;
		else
		if(start == 13 && destination == 83)
			price = 5;
		else
		if(start == 13 && destination == 84)
			price = 5;
		else
		if(start == 13 && destination == 85)
			price = 6;
		else
		if(start == 13 && destination == 86)
			price = 6;
		else
		if(start == 13 && destination == 87)
			price = 7;
		else
		if(start == 13 && destination == 88)
			price = 7;
		else
		if(start == 13 && destination == 89)
			price = 7;
		else
		if(start == 13 && destination == 90)
			price = 7;
		else
		if(start == 13 && destination == 91)
			price = 7;
		else
		if(start == 13 && destination == 92)
			price = 8;
		else
		if(start == 14 && destination == 0)
			price = 6;
		else
		if(start == 14 && destination == 1)
			price = 6;
		else
		if(start == 14 && destination == 2)
			price = 5;
		else
		if(start == 14 && destination == 3)
			price = 5;
		else
		if(start == 14 && destination == 4)
			price = 5;
		else
		if(start == 14 && destination == 5)
			price = 5;
		else
		if(start == 14 && destination == 6)
			price = 5;
		else
		if(start == 14 && destination == 7)
			price = 4;
		else
		if(start == 14 && destination == 8)
			price = 4;
		else
		if(start == 14 && destination == 9)
			price = 3;
		else
		if(start == 14 && destination == 10)
			price = 3;
		else
		if(start == 14 && destination == 11)
			price = 3;
		else
		if(start == 14 && destination == 12)
			price = 2;
		else
		if(start == 14 && destination == 13)
			price = 2;
		else
		if(start == 14 && destination == 14)
			price = 0;
		else
		if(start == 14 && destination == 15)
			price = 2;
		else
		if(start == 14 && destination == 16)
			price = 2;
		else
		if(start == 14 && destination == 17)
			price = 2;
		else
		if(start == 14 && destination == 18)
			price = 3;
		else
		if(start == 14 && destination == 19)
			price = 3;
		else
		if(start == 14 && destination == 20)
			price = 3;
		else
		if(start == 14 && destination == 21)
			price = 4;
		else
		if(start == 14 && destination == 22)
			price = 4;
		else
		if(start == 14 && destination == 23)
			price = 4;
		else
		if(start == 14 && destination == 24)
			price = 5;
		else
		if(start == 14 && destination == 25)
			price = 5;
		else
		if(start == 14 && destination == 26)
			price = 5;
		else
		if(start == 14 && destination == 27)
			price = 5;
		else
		if(start == 14 && destination == 28)
			price = 5;
		else
		if(start == 14 && destination == 29)
			price = 5;
		else
		if(start == 14 && destination == 30)
			price = 5;
		else
		if(start == 14 && destination == 31)
			price = 5;
		else
		if(start == 14 && destination == 32)
			price = 5;
		else
		if(start == 14 && destination == 33)
			price = 5;
		else
		if(start == 14 && destination == 34)
			price = 5;
		else
		if(start == 14 && destination == 35)
			price = 5;
		else
		if(start == 14 && destination == 36)
			price = 5;
		else
		if(start == 14 && destination == 37)
			price = 5;
		else
		if(start == 14 && destination == 38)
			price = 5;
		else
		if(start == 14 && destination == 39)
			price = 5;
		else
		if(start == 14 && destination == 40)
			price = 6;
		else
		if(start == 14 && destination == 41)
			price = 6;
		else
		if(start == 14 && destination == 42)
			price = 7;
		else
		if(start == 14 && destination == 43)
			price = 7;
		else
		if(start == 14 && destination == 44)
			price = 7;
		else
		if(start == 14 && destination == 45)
			price = 7;
		else
		if(start == 14 && destination == 46)
			price = 7;
		else
		if(start == 14 && destination == 47)
			price = 7;
		else
		if(start == 14 && destination == 48)
			price = 7;
		else
		if(start == 14 && destination == 49)
			price = 7;
		else
		if(start == 14 && destination == 50)
			price = 7;
		else
		if(start == 14 && destination == 51)
			price = 7;
		else
		if(start == 14 && destination == 52)
			price = 7;
		else
		if(start == 14 && destination == 53)
			price = 6;
		else
		if(start == 14 && destination == 54)
			price = 6;
		else
		if(start == 14 && destination == 55)
			price = 6;
		else
		if(start == 14 && destination == 56)
			price = 6;
		else
		if(start == 14 && destination == 57)
			price = 5;
		else
		if(start == 14 && destination == 58)
			price = 5;
		else
		if(start == 14 && destination == 59)
			price = 5;
		else
		if(start == 14 && destination == 60)
			price = 5;
		else
		if(start == 14 && destination == 61)
			price = 4;
		else
		if(start == 14 && destination == 62)
			price = 4;
		else
		if(start == 14 && destination == 63)
			price = 4;
		else
		if(start == 14 && destination == 64)
			price = 4;
		else
		if(start == 14 && destination == 65)
			price = 3;
		else
		if(start == 14 && destination == 66)
			price = 3;
		else
		if(start == 14 && destination == 67)
			price = 3;
		else
		if(start == 14 && destination == 68)
			price = 3;
		else
		if(start == 14 && destination == 69)
			price = 3;
		else
		if(start == 14 && destination == 70)
			price = 3;
		else
		if(start == 14 && destination == 71)
			price = 3;
		else
		if(start == 14 && destination == 72)
			price = 4;
		else
		if(start == 14 && destination == 73)
			price = 4;
		else
		if(start == 14 && destination == 74)
			price = 4;
		else
		if(start == 14 && destination == 75)
			price = 5;
		else
		if(start == 14 && destination == 76)
			price = 5;
		else
		if(start == 14 && destination == 77)
			price = 5;
		else
		if(start == 14 && destination == 78)
			price = 5;
		else
		if(start == 14 && destination == 79)
			price = 5;
		else
		if(start == 14 && destination == 80)
			price = 5;
		else
		if(start == 14 && destination == 81)
			price = 5;
		else
		if(start == 14 && destination == 82)
			price = 5;
		else
		if(start == 14 && destination == 83)
			price = 5;
		else
		if(start == 14 && destination == 84)
			price = 5;
		else
		if(start == 14 && destination == 85)
			price = 6;
		else
		if(start == 14 && destination == 86)
			price = 6;
		else
		if(start == 14 && destination == 87)
			price = 7;
		else
		if(start == 14 && destination == 88)
			price = 7;
		else
		if(start == 14 && destination == 89)
			price = 7;
		else
		if(start == 14 && destination == 90)
			price = 7;
		else
		if(start == 14 && destination == 91)
			price = 8;
		else
		if(start == 14 && destination == 92)
			price = 8;
		else
		if(start == 15 && destination == 0)
			price = 6;
		else
		if(start == 15 && destination == 1)
			price = 6;
		else
		if(start == 15 && destination == 2)
			price = 5;
		else
		if(start == 15 && destination == 3)
			price = 5;
		else
		if(start == 15 && destination == 4)
			price = 5;
		else
		if(start == 15 && destination == 5)
			price = 5;
		else
		if(start == 15 && destination == 6)
			price = 5;
		else
		if(start == 15 && destination == 7)
			price = 4;
		else
		if(start == 15 && destination == 8)
			price = 4;
		else
		if(start == 15 && destination == 9)
			price = 4;
		else
		if(start == 15 && destination == 10)
			price = 3;
		else
		if(start == 15 && destination == 11)
			price = 3;
		else
		if(start == 15 && destination == 12)
			price = 2;
		else
		if(start == 15 && destination == 13)
			price = 2;
		else
		if(start == 15 && destination == 14)
			price = 2;
		else
		if(start == 15 && destination == 15)
			price = 0;
		else
		if(start == 15 && destination == 16)
			price = 2;
		else
		if(start == 15 && destination == 17)
			price = 2;
		else
		if(start == 15 && destination == 18)
			price = 3;
		else
		if(start == 15 && destination == 19)
			price = 3;
		else
		if(start == 15 && destination == 20)
			price = 3;
		else
		if(start == 15 && destination == 21)
			price = 4;
		else
		if(start == 15 && destination == 22)
			price = 4;
		else
		if(start == 15 && destination == 23)
			price = 4;
		else
		if(start == 15 && destination == 24)
			price = 5;
		else
		if(start == 15 && destination == 25)
			price = 5;
		else
		if(start == 15 && destination == 26)
			price = 5;
		else
		if(start == 15 && destination == 27)
			price = 5;
		else
		if(start == 15 && destination == 28)
			price = 5;
		else
		if(start == 15 && destination == 29)
			price = 5;
		else
		if(start == 15 && destination == 30)
			price = 5;
		else
		if(start == 15 && destination == 31)
			price = 5;
		else
		if(start == 15 && destination == 32)
			price = 5;
		else
		if(start == 15 && destination == 33)
			price = 5;
		else
		if(start == 15 && destination == 34)
			price = 5;
		else
		if(start == 15 && destination == 35)
			price = 5;
		else
		if(start == 15 && destination == 36)
			price = 5;
		else
		if(start == 15 && destination == 37)
			price = 5;
		else
		if(start == 15 && destination == 38)
			price = 5;
		else
		if(start == 15 && destination == 39)
			price = 6;
		else
		if(start == 15 && destination == 40)
			price = 6;
		else
		if(start == 15 && destination == 41)
			price = 6;
		else
		if(start == 15 && destination == 42)
			price = 7;
		else
		if(start == 15 && destination == 43)
			price = 7;
		else
		if(start == 15 && destination == 44)
			price = 7;
		else
		if(start == 15 && destination == 45)
			price = 7;
		else
		if(start == 15 && destination == 46)
			price = 7;
		else
		if(start == 15 && destination == 47)
			price = 8;
		else
		if(start == 15 && destination == 48)
			price = 7;
		else
		if(start == 15 && destination == 49)
			price = 7;
		else
		if(start == 15 && destination == 50)
			price = 7;
		else
		if(start == 15 && destination == 51)
			price = 7;
		else
		if(start == 15 && destination == 52)
			price = 7;
		else
		if(start == 15 && destination == 53)
			price = 7;
		else
		if(start == 15 && destination == 54)
			price = 6;
		else
		if(start == 15 && destination == 55)
			price = 6;
		else
		if(start == 15 && destination == 56)
			price = 6;
		else
		if(start == 15 && destination == 57)
			price = 6;
		else
		if(start == 15 && destination == 58)
			price = 5;
		else
		if(start == 15 && destination == 59)
			price = 5;
		else
		if(start == 15 && destination == 60)
			price = 5;
		else
		if(start == 15 && destination == 61)
			price = 5;
		else
		if(start == 15 && destination == 62)
			price = 4;
		else
		if(start == 15 && destination == 63)
			price = 4;
		else
		if(start == 15 && destination == 64)
			price = 4;
		else
		if(start == 15 && destination == 65)
			price = 4;
		else
		if(start == 15 && destination == 66)
			price = 4;
		else
		if(start == 15 && destination == 67)
			price = 3;
		else
		if(start == 15 && destination == 68)
			price = 3;
		else
		if(start == 15 && destination == 69)
			price = 3;
		else
		if(start == 15 && destination == 70)
			price = 3;
		else
		if(start == 15 && destination == 71)
			price = 3;
		else
		if(start == 15 && destination == 72)
			price = 4;
		else
		if(start == 15 && destination == 73)
			price = 4;
		else
		if(start == 15 && destination == 74)
			price = 5;
		else
		if(start == 15 && destination == 75)
			price = 5;
		else
		if(start == 15 && destination == 76)
			price = 5;
		else
		if(start == 15 && destination == 77)
			price = 6;
		else
		if(start == 15 && destination == 78)
			price = 5;
		else
		if(start == 15 && destination == 79)
			price = 5;
		else
		if(start == 15 && destination == 80)
			price = 5;
		else
		if(start == 15 && destination == 81)
			price = 5;
		else
		if(start == 15 && destination == 82)
			price = 5;
		else
		if(start == 15 && destination == 83)
			price = 5;
		else
		if(start == 15 && destination == 84)
			price = 6;
		else
		if(start == 15 && destination == 85)
			price = 6;
		else
		if(start == 15 && destination == 86)
			price = 6;
		else
		if(start == 15 && destination == 87)
			price = 7;
		else
		if(start == 15 && destination == 88)
			price = 7;
		else
		if(start == 15 && destination == 89)
			price = 7;
		else
		if(start == 15 && destination == 90)
			price = 7;
		else
		if(start == 15 && destination == 91)
			price = 8;
		else
		if(start == 15 && destination == 92)
			price = 8;
		else
		if(start == 16 && destination == 0)
			price = 6;
		else
		if(start == 16 && destination == 1)
			price = 6;
		else
		if(start == 16 && destination == 2)
			price = 6;
		else
		if(start == 16 && destination == 3)
			price = 5;
		else
		if(start == 16 && destination == 4)
			price = 5;
		else
		if(start == 16 && destination == 5)
			price = 5;
		else
		if(start == 16 && destination == 6)
			price = 5;
		else
		if(start == 16 && destination == 7)
			price = 5;
		else
		if(start == 16 && destination == 8)
			price = 4;
		else
		if(start == 16 && destination == 9)
			price = 4;
		else
		if(start == 16 && destination == 10)
			price = 4;
		else
		if(start == 16 && destination == 11)
			price = 4;
		else
		if(start == 16 && destination == 12)
			price = 3;
		else
		if(start == 16 && destination == 13)
			price = 2;
		else
		if(start == 16 && destination == 14)
			price = 2;
		else
		if(start == 16 && destination == 15)
			price = 2;
		else
		if(start == 16 && destination == 16)
			price = 0;
		else
		if(start == 16 && destination == 17)
			price = 2;
		else
		if(start == 16 && destination == 18)
			price = 2;
		else
		if(start == 16 && destination == 19)
			price = 3;
		else
		if(start == 16 && destination == 20)
			price = 3;
		else
		if(start == 16 && destination == 21)
			price = 3;
		else
		if(start == 16 && destination == 22)
			price = 4;
		else
		if(start == 16 && destination == 23)
			price = 5;
		else
		if(start == 16 && destination == 24)
			price = 5;
		else
		if(start == 16 && destination == 25)
			price = 5;
		else
		if(start == 16 && destination == 26)
			price = 5;
		else
		if(start == 16 && destination == 27)
			price = 5;
		else
		if(start == 16 && destination == 28)
			price = 6;
		else
		if(start == 16 && destination == 29)
			price = 6;
		else
		if(start == 16 && destination == 30)
			price = 5;
		else
		if(start == 16 && destination == 31)
			price = 5;
		else
		if(start == 16 && destination == 32)
			price = 5;
		else
		if(start == 16 && destination == 33)
			price = 5;
		else
		if(start == 16 && destination == 34)
			price = 5;
		else
		if(start == 16 && destination == 35)
			price = 5;
		else
		if(start == 16 && destination == 36)
			price = 5;
		else
		if(start == 16 && destination == 37)
			price = 6;
		else
		if(start == 16 && destination == 38)
			price = 6;
		else
		if(start == 16 && destination == 39)
			price = 6;
		else
		if(start == 16 && destination == 40)
			price = 6;
		else
		if(start == 16 && destination == 41)
			price = 7;
		else
		if(start == 16 && destination == 42)
			price = 7;
		else
		if(start == 16 && destination == 43)
			price = 7;
		else
		if(start == 16 && destination == 44)
			price = 7;
		else
		if(start == 16 && destination == 45)
			price = 7;
		else
		if(start == 16 && destination == 46)
			price = 7;
		else
		if(start == 16 && destination == 47)
			price = 8;
		else
		if(start == 16 && destination == 48)
			price = 8;
		else
		if(start == 16 && destination == 49)
			price = 7;
		else
		if(start == 16 && destination == 50)
			price = 7;
		else
		if(start == 16 && destination == 51)
			price = 7;
		else
		if(start == 16 && destination == 52)
			price = 7;
		else
		if(start == 16 && destination == 53)
			price = 7;
		else
		if(start == 16 && destination == 54)
			price = 6;
		else
		if(start == 16 && destination == 55)
			price = 6;
		else
		if(start == 16 && destination == 56)
			price = 6;
		else
		if(start == 16 && destination == 57)
			price = 6;
		else
		if(start == 16 && destination == 58)
			price = 5;
		else
		if(start == 16 && destination == 59)
			price = 5;
		else
		if(start == 16 && destination == 60)
			price = 5;
		else
		if(start == 16 && destination == 61)
			price = 5;
		else
		if(start == 16 && destination == 62)
			price = 5;
		else
		if(start == 16 && destination == 63)
			price = 5;
		else
		if(start == 16 && destination == 64)
			price = 4;
		else
		if(start == 16 && destination == 65)
			price = 4;
		else
		if(start == 16 && destination == 66)
			price = 4;
		else
		if(start == 16 && destination == 67)
			price = 4;
		else
		if(start == 16 && destination == 68)
			price = 3;
		else
		if(start == 16 && destination == 69)
			price = 3;
		else
		if(start == 16 && destination == 70)
			price = 3;
		else
		if(start == 16 && destination == 71)
			price = 4;
		else
		if(start == 16 && destination == 72)
			price = 4;
		else
		if(start == 16 && destination == 73)
			price = 5;
		else
		if(start == 16 && destination == 74)
			price = 5;
		else
		if(start == 16 && destination == 75)
			price = 5;
		else
		if(start == 16 && destination == 76)
			price = 5;
		else
		if(start == 16 && destination == 77)
			price = 6;
		else
		if(start == 16 && destination == 78)
			price = 6;
		else
		if(start == 16 && destination == 79)
			price = 5;
		else
		if(start == 16 && destination == 80)
			price = 5;
		else
		if(start == 16 && destination == 81)
			price = 5;
		else
		if(start == 16 && destination == 82)
			price = 5;
		else
		if(start == 16 && destination == 83)
			price = 6;
		else
		if(start == 16 && destination == 84)
			price = 6;
		else
		if(start == 16 && destination == 85)
			price = 6;
		else
		if(start == 16 && destination == 86)
			price = 7;
		else
		if(start == 16 && destination == 87)
			price = 7;
		else
		if(start == 16 && destination == 88)
			price = 7;
		else
		if(start == 16 && destination == 89)
			price = 7;
		else
		if(start == 16 && destination == 90)
			price = 8;
		else
		if(start == 16 && destination == 91)
			price = 8;
		else
		if(start == 16 && destination == 92)
			price = 8;
		else
		if(start == 17 && destination == 0)
			price = 6;
		else
		if(start == 17 && destination == 1)
			price = 6;
		else
		if(start == 17 && destination == 2)
			price = 6;
		else
		if(start == 17 && destination == 3)
			price = 6;
		else
		if(start == 17 && destination == 4)
			price = 5;
		else
		if(start == 17 && destination == 5)
			price = 5;
		else
		if(start == 17 && destination == 6)
			price = 5;
		else
		if(start == 17 && destination == 7)
			price = 5;
		else
		if(start == 17 && destination == 8)
			price = 5;
		else
		if(start == 17 && destination == 9)
			price = 4;
		else
		if(start == 17 && destination == 10)
			price = 4;
		else
		if(start == 17 && destination == 11)
			price = 4;
		else
		if(start == 17 && destination == 12)
			price = 3;
		else
		if(start == 17 && destination == 13)
			price = 3;
		else
		if(start == 17 && destination == 14)
			price = 2;
		else
		if(start == 17 && destination == 15)
			price = 2;
		else
		if(start == 17 && destination == 16)
			price = 2;
		else
		if(start == 17 && destination == 17)
			price = 0;
		else
		if(start == 17 && destination == 18)
			price = 2;
		else
		if(start == 17 && destination == 19)
			price = 2;
		else
		if(start == 17 && destination == 20)
			price = 3;
		else
		if(start == 17 && destination == 21)
			price = 3;
		else
		if(start == 17 && destination == 22)
			price = 4;
		else
		if(start == 17 && destination == 23)
			price = 5;
		else
		if(start == 17 && destination == 24)
			price = 5;
		else
		if(start == 17 && destination == 25)
			price = 5;
		else
		if(start == 17 && destination == 26)
			price = 5;
		else
		if(start == 17 && destination == 27)
			price = 6;
		else
		if(start == 17 && destination == 28)
			price = 6;
		else
		if(start == 17 && destination == 29)
			price = 6;
		else
		if(start == 17 && destination == 30)
			price = 5;
		else
		if(start == 17 && destination == 31)
			price = 5;
		else
		if(start == 17 && destination == 32)
			price = 5;
		else
		if(start == 17 && destination == 33)
			price = 5;
		else
		if(start == 17 && destination == 34)
			price = 5;
		else
		if(start == 17 && destination == 35)
			price = 5;
		else
		if(start == 17 && destination == 36)
			price = 6;
		else
		if(start == 17 && destination == 37)
			price = 6;
		else
		if(start == 17 && destination == 38)
			price = 6;
		else
		if(start == 17 && destination == 39)
			price = 6;
		else
		if(start == 17 && destination == 40)
			price = 6;
		else
		if(start == 17 && destination == 41)
			price = 7;
		else
		if(start == 17 && destination == 42)
			price = 7;
		else
		if(start == 17 && destination == 43)
			price = 7;
		else
		if(start == 17 && destination == 44)
			price = 7;
		else
		if(start == 17 && destination == 45)
			price = 7;
		else
		if(start == 17 && destination == 46)
			price = 8;
		else
		if(start == 17 && destination == 47)
			price = 8;
		else
		if(start == 17 && destination == 48)
			price = 8;
		else
		if(start == 17 && destination == 49)
			price = 8;
		else
		if(start == 17 && destination == 50)
			price = 7;
		else
		if(start == 17 && destination == 51)
			price = 7;
		else
		if(start == 17 && destination == 52)
			price = 7;
		else
		if(start == 17 && destination == 53)
			price = 7;
		else
		if(start == 17 && destination == 54)
			price = 7;
		else
		if(start == 17 && destination == 55)
			price = 6;
		else
		if(start == 17 && destination == 56)
			price = 6;
		else
		if(start == 17 && destination == 57)
			price = 6;
		else
		if(start == 17 && destination == 58)
			price = 6;
		else
		if(start == 17 && destination == 59)
			price = 5;
		else
		if(start == 17 && destination == 60)
			price = 5;
		else
		if(start == 17 && destination == 61)
			price = 5;
		else
		if(start == 17 && destination == 62)
			price = 5;
		else
		if(start == 17 && destination == 63)
			price = 5;
		else
		if(start == 17 && destination == 64)
			price = 4;
		else
		if(start == 17 && destination == 65)
			price = 4;
		else
		if(start == 17 && destination == 66)
			price = 4;
		else
		if(start == 17 && destination == 67)
			price = 4;
		else
		if(start == 17 && destination == 68)
			price = 4;
		else
		if(start == 17 && destination == 69)
			price = 3;
		else
		if(start == 17 && destination == 70)
			price = 4;
		else
		if(start == 17 && destination == 71)
			price = 4;
		else
		if(start == 17 && destination == 72)
			price = 4;
		else
		if(start == 17 && destination == 73)
			price = 5;
		else
		if(start == 17 && destination == 74)
			price = 5;
		else
		if(start == 17 && destination == 75)
			price = 5;
		else
		if(start == 17 && destination == 76)
			price = 6;
		else
		if(start == 17 && destination == 77)
			price = 6;
		else
		if(start == 17 && destination == 78)
			price = 6;
		else
		if(start == 17 && destination == 79)
			price = 6;
		else
		if(start == 17 && destination == 80)
			price = 5;
		else
		if(start == 17 && destination == 81)
			price = 5;
		else
		if(start == 17 && destination == 82)
			price = 6;
		else
		if(start == 17 && destination == 83)
			price = 6;
		else
		if(start == 17 && destination == 84)
			price = 6;
		else
		if(start == 17 && destination == 85)
			price = 6;
		else
		if(start == 17 && destination == 86)
			price = 7;
		else
		if(start == 17 && destination == 87)
			price = 7;
		else
		if(start == 17 && destination == 88)
			price = 7;
		else
		if(start == 17 && destination == 89)
			price = 7;
		else
		if(start == 17 && destination == 90)
			price = 8;
		else
		if(start == 17 && destination == 91)
			price = 8;
		else
		if(start == 17 && destination == 92)
			price = 8;
		else
		if(start == 18 && destination == 0)
			price = 7;
		else
		if(start == 18 && destination == 1)
			price = 6;
		else
		if(start == 18 && destination == 2)
			price = 6;
		else
		if(start == 18 && destination == 3)
			price = 6;
		else
		if(start == 18 && destination == 4)
			price = 6;
		else
		if(start == 18 && destination == 5)
			price = 5;
		else
		if(start == 18 && destination == 6)
			price = 5;
		else
		if(start == 18 && destination == 7)
			price = 5;
		else
		if(start == 18 && destination == 8)
			price = 5;
		else
		if(start == 18 && destination == 9)
			price = 5;
		else
		if(start == 18 && destination == 10)
			price = 4;
		else
		if(start == 18 && destination == 11)
			price = 4;
		else
		if(start == 18 && destination == 12)
			price = 3;
		else
		if(start == 18 && destination == 13)
			price = 3;
		else
		if(start == 18 && destination == 14)
			price = 3;
		else
		if(start == 18 && destination == 15)
			price = 3;
		else
		if(start == 18 && destination == 16)
			price = 2;
		else
		if(start == 18 && destination == 17)
			price = 2;
		else
		if(start == 18 && destination == 18)
			price = 0;
		else
		if(start == 18 && destination == 19)
			price = 2;
		else
		if(start == 18 && destination == 20)
			price = 2;
		else
		if(start == 18 && destination == 21)
			price = 3;
		else
		if(start == 18 && destination == 22)
			price = 3;
		else
		if(start == 18 && destination == 23)
			price = 5;
		else
		if(start == 18 && destination == 24)
			price = 5;
		else
		if(start == 18 && destination == 25)
			price = 5;
		else
		if(start == 18 && destination == 26)
			price = 6;
		else
		if(start == 18 && destination == 27)
			price = 6;
		else
		if(start == 18 && destination == 28)
			price = 6;
		else
		if(start == 18 && destination == 29)
			price = 6;
		else
		if(start == 18 && destination == 30)
			price = 6;
		else
		if(start == 18 && destination == 31)
			price = 6;
		else
		if(start == 18 && destination == 32)
			price = 5;
		else
		if(start == 18 && destination == 33)
			price = 5;
		else
		if(start == 18 && destination == 34)
			price = 5;
		else
		if(start == 18 && destination == 35)
			price = 6;
		else
		if(start == 18 && destination == 36)
			price = 6;
		else
		if(start == 18 && destination == 37)
			price = 6;
		else
		if(start == 18 && destination == 38)
			price = 6;
		else
		if(start == 18 && destination == 39)
			price = 6;
		else
		if(start == 18 && destination == 40)
			price = 7;
		else
		if(start == 18 && destination == 41)
			price = 7;
		else
		if(start == 18 && destination == 42)
			price = 7;
		else
		if(start == 18 && destination == 43)
			price = 7;
		else
		if(start == 18 && destination == 44)
			price = 7;
		else
		if(start == 18 && destination == 45)
			price = 8;
		else
		if(start == 18 && destination == 46)
			price = 8;
		else
		if(start == 18 && destination == 47)
			price = 8;
		else
		if(start == 18 && destination == 48)
			price = 8;
		else
		if(start == 18 && destination == 49)
			price = 8;
		else
		if(start == 18 && destination == 50)
			price = 8;
		else
		if(start == 18 && destination == 51)
			price = 7;
		else
		if(start == 18 && destination == 52)
			price = 7;
		else
		if(start == 18 && destination == 53)
			price = 7;
		else
		if(start == 18 && destination == 54)
			price = 7;
		else
		if(start == 18 && destination == 55)
			price = 7;
		else
		if(start == 18 && destination == 56)
			price = 6;
		else
		if(start == 18 && destination == 57)
			price = 6;
		else
		if(start == 18 && destination == 58)
			price = 6;
		else
		if(start == 18 && destination == 59)
			price = 5;
		else
		if(start == 18 && destination == 60)
			price = 5;
		else
		if(start == 18 && destination == 61)
			price = 5;
		else
		if(start == 18 && destination == 62)
			price = 5;
		else
		if(start == 18 && destination == 63)
			price = 5;
		else
		if(start == 18 && destination == 64)
			price = 5;
		else
		if(start == 18 && destination == 65)
			price = 5;
		else
		if(start == 18 && destination == 66)
			price = 4;
		else
		if(start == 18 && destination == 67)
			price = 4;
		else
		if(start == 18 && destination == 68)
			price = 4;
		else
		if(start == 18 && destination == 69)
			price = 4;
		else
		if(start == 18 && destination == 70)
			price = 4;
		else
		if(start == 18 && destination == 71)
			price = 4;
		else
		if(start == 18 && destination == 72)
			price = 5;
		else
		if(start == 18 && destination == 73)
			price = 5;
		else
		if(start == 18 && destination == 74)
			price = 5;
		else
		if(start == 18 && destination == 75)
			price = 5;
		else
		if(start == 18 && destination == 76)
			price = 6;
		else
		if(start == 18 && destination == 77)
			price = 6;
		else
		if(start == 18 && destination == 78)
			price = 6;
		else
		if(start == 18 && destination == 79)
			price = 6;
		else
		if(start == 18 && destination == 80)
			price = 6;
		else
		if(start == 18 && destination == 81)
			price = 6;
		else
		if(start == 18 && destination == 82)
			price = 6;
		else
		if(start == 18 && destination == 83)
			price = 6;
		else
		if(start == 18 && destination == 84)
			price = 6;
		else
		if(start == 18 && destination == 85)
			price = 7;
		else
		if(start == 18 && destination == 86)
			price = 7;
		else
		if(start == 18 && destination == 87)
			price = 7;
		else
		if(start == 18 && destination == 88)
			price = 7;
		else
		if(start == 18 && destination == 89)
			price = 8;
		else
		if(start == 18 && destination == 90)
			price = 8;
		else
		if(start == 18 && destination == 91)
			price = 8;
		else
		if(start == 18 && destination == 92)
			price = 8;
		else
		if(start == 19 && destination == 0)
			price = 7;
		else
		if(start == 19 && destination == 1)
			price = 7;
		else
		if(start == 19 && destination == 2)
			price = 6;
		else
		if(start == 19 && destination == 3)
			price = 6;
		else
		if(start == 19 && destination == 4)
			price = 6;
		else
		if(start == 19 && destination == 5)
			price = 6;
		else
		if(start == 19 && destination == 6)
			price = 6;
		else
		if(start == 19 && destination == 7)
			price = 5;
		else
		if(start == 19 && destination == 8)
			price = 5;
		else
		if(start == 19 && destination == 9)
			price = 5;
		else
		if(start == 19 && destination == 10)
			price = 5;
		else
		if(start == 19 && destination == 11)
			price = 4;
		else
		if(start == 19 && destination == 12)
			price = 4;
		else
		if(start == 19 && destination == 13)
			price = 3;
		else
		if(start == 19 && destination == 14)
			price = 3;
		else
		if(start == 19 && destination == 15)
			price = 3;
		else
		if(start == 19 && destination == 16)
			price = 3;
		else
		if(start == 19 && destination == 17)
			price = 2;
		else
		if(start == 19 && destination == 18)
			price = 2;
		else
		if(start == 19 && destination == 19)
			price = 0;
		else
		if(start == 19 && destination == 20)
			price = 2;
		else
		if(start == 19 && destination == 21)
			price = 3;
		else
		if(start == 19 && destination == 22)
			price = 3;
		else
		if(start == 19 && destination == 23)
			price = 5;
		else
		if(start == 19 && destination == 24)
			price = 6;
		else
		if(start == 19 && destination == 25)
			price = 6;
		else
		if(start == 19 && destination == 26)
			price = 6;
		else
		if(start == 19 && destination == 27)
			price = 6;
		else
		if(start == 19 && destination == 28)
			price = 6;
		else
		if(start == 19 && destination == 29)
			price = 6;
		else
		if(start == 19 && destination == 30)
			price = 6;
		else
		if(start == 19 && destination == 31)
			price = 6;
		else
		if(start == 19 && destination == 32)
			price = 6;
		else
		if(start == 19 && destination == 33)
			price = 6;
		else
		if(start == 19 && destination == 34)
			price = 6;
		else
		if(start == 19 && destination == 35)
			price = 6;
		else
		if(start == 19 && destination == 36)
			price = 6;
		else
		if(start == 19 && destination == 37)
			price = 6;
		else
		if(start == 19 && destination == 38)
			price = 6;
		else
		if(start == 19 && destination == 39)
			price = 6;
		else
		if(start == 19 && destination == 40)
			price = 7;
		else
		if(start == 19 && destination == 41)
			price = 7;
		else
		if(start == 19 && destination == 42)
			price = 7;
		else
		if(start == 19 && destination == 43)
			price = 7;
		else
		if(start == 19 && destination == 44)
			price = 8;
		else
		if(start == 19 && destination == 45)
			price = 8;
		else
		if(start == 19 && destination == 46)
			price = 8;
		else
		if(start == 19 && destination == 47)
			price = 8;
		else
		if(start == 19 && destination == 48)
			price = 8;
		else
		if(start == 19 && destination == 49)
			price = 8;
		else
		if(start == 19 && destination == 50)
			price = 8;
		else
		if(start == 19 && destination == 51)
			price = 8;
		else
		if(start == 19 && destination == 52)
			price = 7;
		else
		if(start == 19 && destination == 53)
			price = 7;
		else
		if(start == 19 && destination == 54)
			price = 7;
		else
		if(start == 19 && destination == 55)
			price = 7;
		else
		if(start == 19 && destination == 56)
			price = 7;
		else
		if(start == 19 && destination == 57)
			price = 6;
		else
		if(start == 19 && destination == 58)
			price = 6;
		else
		if(start == 19 && destination == 59)
			price = 6;
		else
		if(start == 19 && destination == 60)
			price = 6;
		else
		if(start == 19 && destination == 61)
			price = 5;
		else
		if(start == 19 && destination == 62)
			price = 5;
		else
		if(start == 19 && destination == 63)
			price = 5;
		else
		if(start == 19 && destination == 64)
			price = 5;
		else
		if(start == 19 && destination == 65)
			price = 5;
		else
		if(start == 19 && destination == 66)
			price = 5;
		else
		if(start == 19 && destination == 67)
			price = 4;
		else
		if(start == 19 && destination == 68)
			price = 4;
		else
		if(start == 19 && destination == 69)
			price = 4;
		else
		if(start == 19 && destination == 70)
			price = 4;
		else
		if(start == 19 && destination == 71)
			price = 5;
		else
		if(start == 19 && destination == 72)
			price = 5;
		else
		if(start == 19 && destination == 73)
			price = 5;
		else
		if(start == 19 && destination == 74)
			price = 5;
		else
		if(start == 19 && destination == 75)
			price = 6;
		else
		if(start == 19 && destination == 76)
			price = 6;
		else
		if(start == 19 && destination == 77)
			price = 6;
		else
		if(start == 19 && destination == 78)
			price = 6;
		else
		if(start == 19 && destination == 79)
			price = 6;
		else
		if(start == 19 && destination == 80)
			price = 6;
		else
		if(start == 19 && destination == 81)
			price = 6;
		else
		if(start == 19 && destination == 82)
			price = 6;
		else
		if(start == 19 && destination == 83)
			price = 6;
		else
		if(start == 19 && destination == 84)
			price = 6;
		else
		if(start == 19 && destination == 85)
			price = 7;
		else
		if(start == 19 && destination == 86)
			price = 7;
		else
		if(start == 19 && destination == 87)
			price = 7;
		else
		if(start == 19 && destination == 88)
			price = 8;
		else
		if(start == 19 && destination == 89)
			price = 8;
		else
		if(start == 19 && destination == 90)
			price = 8;
		else
		if(start == 19 && destination == 91)
			price = 8;
		else
		if(start == 19 && destination == 92)
			price = 8;
		else
		if(start == 20 && destination == 0)
			price = 7;
		else
		if(start == 20 && destination == 1)
			price = 7;
		else
		if(start == 20 && destination == 2)
			price = 6;
		else
		if(start == 20 && destination == 3)
			price = 6;
		else
		if(start == 20 && destination == 4)
			price = 6;
		else
		if(start == 20 && destination == 5)
			price = 6;
		else
		if(start == 20 && destination == 6)
			price = 6;
		else
		if(start == 20 && destination == 7)
			price = 5;
		else
		if(start == 20 && destination == 8)
			price = 5;
		else
		if(start == 20 && destination == 9)
			price = 5;
		else
		if(start == 20 && destination == 10)
			price = 5;
		else
		if(start == 20 && destination == 11)
			price = 5;
		else
		if(start == 20 && destination == 12)
			price = 4;
		else
		if(start == 20 && destination == 13)
			price = 4;
		else
		if(start == 20 && destination == 14)
			price = 3;
		else
		if(start == 20 && destination == 15)
			price = 3;
		else
		if(start == 20 && destination == 16)
			price = 3;
		else
		if(start == 20 && destination == 17)
			price = 3;
		else
		if(start == 20 && destination == 18)
			price = 2;
		else
		if(start == 20 && destination == 19)
			price = 2;
		else
		if(start == 20 && destination == 20)
			price = 0;
		else
		if(start == 20 && destination == 21)
			price = 2;
		else
		if(start == 20 && destination == 22)
			price = 3;
		else
		if(start == 20 && destination == 23)
			price = 6;
		else
		if(start == 20 && destination == 24)
			price = 6;
		else
		if(start == 20 && destination == 25)
			price = 6;
		else
		if(start == 20 && destination == 26)
			price = 6;
		else
		if(start == 20 && destination == 27)
			price = 6;
		else
		if(start == 20 && destination == 28)
			price = 6;
		else
		if(start == 20 && destination == 29)
			price = 6;
		else
		if(start == 20 && destination == 30)
			price = 6;
		else
		if(start == 20 && destination == 31)
			price = 6;
		else
		if(start == 20 && destination == 32)
			price = 6;
		else
		if(start == 20 && destination == 33)
			price = 6;
		else
		if(start == 20 && destination == 34)
			price = 6;
		else
		if(start == 20 && destination == 35)
			price = 6;
		else
		if(start == 20 && destination == 36)
			price = 6;
		else
		if(start == 20 && destination == 37)
			price = 6;
		else
		if(start == 20 && destination == 38)
			price = 7;
		else
		if(start == 20 && destination == 39)
			price = 7;
		else
		if(start == 20 && destination == 40)
			price = 7;
		else
		if(start == 20 && destination == 41)
			price = 7;
		else
		if(start == 20 && destination == 42)
			price = 7;
		else
		if(start == 20 && destination == 43)
			price = 8;
		else
		if(start == 20 && destination == 44)
			price = 8;
		else
		if(start == 20 && destination == 45)
			price = 8;
		else
		if(start == 20 && destination == 46)
			price = 8;
		else
		if(start == 20 && destination == 47)
			price = 8;
		else
		if(start == 20 && destination == 48)
			price = 8;
		else
		if(start == 20 && destination == 49)
			price = 8;
		else
		if(start == 20 && destination == 50)
			price = 8;
		else
		if(start == 20 && destination == 51)
			price = 8;
		else
		if(start == 20 && destination == 52)
			price = 8;
		else
		if(start == 20 && destination == 53)
			price = 7;
		else
		if(start == 20 && destination == 54)
			price = 7;
		else
		if(start == 20 && destination == 55)
			price = 7;
		else
		if(start == 20 && destination == 56)
			price = 7;
		else
		if(start == 20 && destination == 57)
			price = 7;
		else
		if(start == 20 && destination == 58)
			price = 6;
		else
		if(start == 20 && destination == 59)
			price = 6;
		else
		if(start == 20 && destination == 60)
			price = 6;
		else
		if(start == 20 && destination == 61)
			price = 6;
		else
		if(start == 20 && destination == 62)
			price = 6;
		else
		if(start == 20 && destination == 63)
			price = 5;
		else
		if(start == 20 && destination == 64)
			price = 5;
		else
		if(start == 20 && destination == 65)
			price = 5;
		else
		if(start == 20 && destination == 66)
			price = 5;
		else
		if(start == 20 && destination == 67)
			price = 5;
		else
		if(start == 20 && destination == 68)
			price = 5;
		else
		if(start == 20 && destination == 69)
			price = 4;
		else
		if(start == 20 && destination == 70)
			price = 5;
		else
		if(start == 20 && destination == 71)
			price = 5;
		else
		if(start == 20 && destination == 72)
			price = 5;
		else
		if(start == 20 && destination == 73)
			price = 5;
		else
		if(start == 20 && destination == 74)
			price = 6;
		else
		if(start == 20 && destination == 75)
			price = 6;
		else
		if(start == 20 && destination == 76)
			price = 6;
		else
		if(start == 20 && destination == 77)
			price = 7;
		else
		if(start == 20 && destination == 78)
			price = 6;
		else
		if(start == 20 && destination == 79)
			price = 6;
		else
		if(start == 20 && destination == 80)
			price = 6;
		else
		if(start == 20 && destination == 81)
			price = 6;
		else
		if(start == 20 && destination == 82)
			price = 6;
		else
		if(start == 20 && destination == 83)
			price = 7;
		else
		if(start == 20 && destination == 84)
			price = 7;
		else
		if(start == 20 && destination == 85)
			price = 7;
		else
		if(start == 20 && destination == 86)
			price = 7;
		else
		if(start == 20 && destination == 87)
			price = 8;
		else
		if(start == 20 && destination == 88)
			price = 8;
		else
		if(start == 20 && destination == 89)
			price = 8;
		else
		if(start == 20 && destination == 90)
			price = 8;
		else
		if(start == 20 && destination == 91)
			price = 8;
		else
		if(start == 20 && destination == 92)
			price = 9;
		else
		if(start == 21 && destination == 0)
			price = 7;
		else
		if(start == 21 && destination == 1)
			price = 7;
		else
		if(start == 21 && destination == 2)
			price = 7;
		else
		if(start == 21 && destination == 3)
			price = 7;
		else
		if(start == 21 && destination == 4)
			price = 6;
		else
		if(start == 21 && destination == 5)
			price = 6;
		else
		if(start == 21 && destination == 6)
			price = 6;
		else
		if(start == 21 && destination == 7)
			price = 6;
		else
		if(start == 21 && destination == 8)
			price = 6;
		else
		if(start == 21 && destination == 9)
			price = 5;
		else
		if(start == 21 && destination == 10)
			price = 5;
		else
		if(start == 21 && destination == 11)
			price = 5;
		else
		if(start == 21 && destination == 12)
			price = 4;
		else
		if(start == 21 && destination == 13)
			price = 4;
		else
		if(start == 21 && destination == 14)
			price = 4;
		else
		if(start == 21 && destination == 15)
			price = 4;
		else
		if(start == 21 && destination == 16)
			price = 3;
		else
		if(start == 21 && destination == 17)
			price = 3;
		else
		if(start == 21 && destination == 18)
			price = 3;
		else
		if(start == 21 && destination == 19)
			price = 3;
		else
		if(start == 21 && destination == 20)
			price = 2;
		else
		if(start == 21 && destination == 21)
			price = 0;
		else
		if(start == 21 && destination == 22)
			price = 2;
		else
		if(start == 21 && destination == 23)
			price = 6;
		else
		if(start == 21 && destination == 24)
			price = 6;
		else
		if(start == 21 && destination == 25)
			price = 6;
		else
		if(start == 21 && destination == 26)
			price = 6;
		else
		if(start == 21 && destination == 27)
			price = 7;
		else
		if(start == 21 && destination == 28)
			price = 7;
		else
		if(start == 21 && destination == 29)
			price = 7;
		else
		if(start == 21 && destination == 30)
			price = 7;
		else
		if(start == 21 && destination == 31)
			price = 6;
		else
		if(start == 21 && destination == 32)
			price = 6;
		else
		if(start == 21 && destination == 33)
			price = 6;
		else
		if(start == 21 && destination == 34)
			price = 6;
		else
		if(start == 21 && destination == 35)
			price = 6;
		else
		if(start == 21 && destination == 36)
			price = 7;
		else
		if(start == 21 && destination == 37)
			price = 7;
		else
		if(start == 21 && destination == 38)
			price = 7;
		else
		if(start == 21 && destination == 39)
			price = 7;
		else
		if(start == 21 && destination == 40)
			price = 7;
		else
		if(start == 21 && destination == 41)
			price = 8;
		else
		if(start == 21 && destination == 42)
			price = 8;
		else
		if(start == 21 && destination == 43)
			price = 8;
		else
		if(start == 21 && destination == 44)
			price = 8;
		else
		if(start == 21 && destination == 45)
			price = 8;
		else
		if(start == 21 && destination == 46)
			price = 8;
		else
		if(start == 21 && destination == 47)
			price = 8;
		else
		if(start == 21 && destination == 48)
			price = 8;
		else
		if(start == 21 && destination == 49)
			price = 8;
		else
		if(start == 21 && destination == 50)
			price = 8;
		else
		if(start == 21 && destination == 51)
			price = 8;
		else
		if(start == 21 && destination == 52)
			price = 8;
		else
		if(start == 21 && destination == 53)
			price = 8;
		else
		if(start == 21 && destination == 54)
			price = 7;
		else
		if(start == 21 && destination == 55)
			price = 7;
		else
		if(start == 21 && destination == 56)
			price = 7;
		else
		if(start == 21 && destination == 57)
			price = 7;
		else
		if(start == 21 && destination == 58)
			price = 7;
		else
		if(start == 21 && destination == 59)
			price = 6;
		else
		if(start == 21 && destination == 60)
			price = 6;
		else
		if(start == 21 && destination == 61)
			price = 6;
		else
		if(start == 21 && destination == 62)
			price = 6;
		else
		if(start == 21 && destination == 63)
			price = 6;
		else
		if(start == 21 && destination == 64)
			price = 6;
		else
		if(start == 21 && destination == 65)
			price = 5;
		else
		if(start == 21 && destination == 66)
			price = 5;
		else
		if(start == 21 && destination == 67)
			price = 5;
		else
		if(start == 21 && destination == 68)
			price = 5;
		else
		if(start == 21 && destination == 69)
			price = 5;
		else
		if(start == 21 && destination == 70)
			price = 5;
		else
		if(start == 21 && destination == 71)
			price = 5;
		else
		if(start == 21 && destination == 72)
			price = 5;
		else
		if(start == 21 && destination == 73)
			price = 6;
		else
		if(start == 21 && destination == 74)
			price = 6;
		else
		if(start == 21 && destination == 75)
			price = 6;
		else
		if(start == 21 && destination == 76)
			price = 7;
		else
		if(start == 21 && destination == 77)
			price = 7;
		else
		if(start == 21 && destination == 78)
			price = 7;
		else
		if(start == 21 && destination == 79)
			price = 7;
		else
		if(start == 21 && destination == 80)
			price = 6;
		else
		if(start == 21 && destination == 81)
			price = 6;
		else
		if(start == 21 && destination == 82)
			price = 7;
		else
		if(start == 21 && destination == 83)
			price = 7;
		else
		if(start == 21 && destination == 84)
			price = 7;
		else
		if(start == 21 && destination == 85)
			price = 7;
		else
		if(start == 21 && destination == 86)
			price = 8;
		else
		if(start == 21 && destination == 87)
			price = 8;
		else
		if(start == 21 && destination == 88)
			price = 8;
		else
		if(start == 21 && destination == 89)
			price = 8;
		else
		if(start == 21 && destination == 90)
			price = 8;
		else
		if(start == 21 && destination == 91)
			price = 9;
		else
		if(start == 21 && destination == 92)
			price = 9;
		else
		if(start == 22 && destination == 0)
			price = 7;
		else
		if(start == 22 && destination == 1)
			price = 7;
		else
		if(start == 22 && destination == 2)
			price = 7;
		else
		if(start == 22 && destination == 3)
			price = 7;
		else
		if(start == 22 && destination == 4)
			price = 7;
		else
		if(start == 22 && destination == 5)
			price = 7;
		else
		if(start == 22 && destination == 6)
			price = 6;
		else
		if(start == 22 && destination == 7)
			price = 6;
		else
		if(start == 22 && destination == 8)
			price = 6;
		else
		if(start == 22 && destination == 9)
			price = 6;
		else
		if(start == 22 && destination == 10)
			price = 5;
		else
		if(start == 22 && destination == 11)
			price = 5;
		else
		if(start == 22 && destination == 12)
			price = 5;
		else
		if(start == 22 && destination == 13)
			price = 5;
		else
		if(start == 22 && destination == 14)
			price = 4;
		else
		if(start == 22 && destination == 15)
			price = 4;
		else
		if(start == 22 && destination == 16)
			price = 4;
		else
		if(start == 22 && destination == 17)
			price = 4;
		else
		if(start == 22 && destination == 18)
			price = 3;
		else
		if(start == 22 && destination == 19)
			price = 3;
		else
		if(start == 22 && destination == 20)
			price = 3;
		else
		if(start == 22 && destination == 21)
			price = 2;
		else
		if(start == 22 && destination == 22)
			price = 0;
		else
		if(start == 22 && destination == 23)
			price = 6;
		else
		if(start == 22 && destination == 24)
			price = 7;
		else
		if(start == 22 && destination == 25)
			price = 7;
		else
		if(start == 22 && destination == 26)
			price = 7;
		else
		if(start == 22 && destination == 27)
			price = 7;
		else
		if(start == 22 && destination == 28)
			price = 7;
		else
		if(start == 22 && destination == 29)
			price = 7;
		else
		if(start == 22 && destination == 30)
			price = 7;
		else
		if(start == 22 && destination == 31)
			price = 7;
		else
		if(start == 22 && destination == 32)
			price = 7;
		else
		if(start == 22 && destination == 33)
			price = 6;
		else
		if(start == 22 && destination == 34)
			price = 6;
		else
		if(start == 22 && destination == 35)
			price = 7;
		else
		if(start == 22 && destination == 36)
			price = 7;
		else
		if(start == 22 && destination == 37)
			price = 7;
		else
		if(start == 22 && destination == 38)
			price = 7;
		else
		if(start == 22 && destination == 39)
			price = 7;
		else
		if(start == 22 && destination == 40)
			price = 7;
		else
		if(start == 22 && destination == 41)
			price = 8;
		else
		if(start == 22 && destination == 42)
			price = 8;
		else
		if(start == 22 && destination == 43)
			price = 8;
		else
		if(start == 22 && destination == 44)
			price = 8;
		else
		if(start == 22 && destination == 45)
			price = 8;
		else
		if(start == 22 && destination == 46)
			price = 8;
		else
		if(start == 22 && destination == 47)
			price = 9;
		else
		if(start == 22 && destination == 48)
			price = 9;
		else
		if(start == 22 && destination == 49)
			price = 8;
		else
		if(start == 22 && destination == 50)
			price = 8;
		else
		if(start == 22 && destination == 51)
			price = 8;
		else
		if(start == 22 && destination == 52)
			price = 8;
		else
		if(start == 22 && destination == 53)
			price = 8;
		else
		if(start == 22 && destination == 54)
			price = 8;
		else
		if(start == 22 && destination == 55)
			price = 7;
		else
		if(start == 22 && destination == 56)
			price = 7;
		else
		if(start == 22 && destination == 57)
			price = 7;
		else
		if(start == 22 && destination == 58)
			price = 7;
		else
		if(start == 22 && destination == 59)
			price = 7;
		else
		if(start == 22 && destination == 60)
			price = 6;
		else
		if(start == 22 && destination == 61)
			price = 6;
		else
		if(start == 22 && destination == 62)
			price = 6;
		else
		if(start == 22 && destination == 63)
			price = 6;
		else
		if(start == 22 && destination == 64)
			price = 6;
		else
		if(start == 22 && destination == 65)
			price = 6;
		else
		if(start == 22 && destination == 66)
			price = 6;
		else
		if(start == 22 && destination == 67)
			price = 5;
		else
		if(start == 22 && destination == 68)
			price = 5;
		else
		if(start == 22 && destination == 69)
			price = 5;
		else
		if(start == 22 && destination == 70)
			price = 5;
		else
		if(start == 22 && destination == 71)
			price = 5;
		else
		if(start == 22 && destination == 72)
			price = 6;
		else
		if(start == 22 && destination == 73)
			price = 6;
		else
		if(start == 22 && destination == 74)
			price = 6;
		else
		if(start == 22 && destination == 75)
			price = 6;
		else
		if(start == 22 && destination == 76)
			price = 7;
		else
		if(start == 22 && destination == 77)
			price = 7;
		else
		if(start == 22 && destination == 78)
			price = 7;
		else
		if(start == 22 && destination == 79)
			price = 7;
		else
		if(start == 22 && destination == 80)
			price = 7;
		else
		if(start == 22 && destination == 81)
			price = 7;
		else
		if(start == 22 && destination == 82)
			price = 7;
		else
		if(start == 22 && destination == 83)
			price = 7;
		else
		if(start == 22 && destination == 84)
			price = 7;
		else
		if(start == 22 && destination == 85)
			price = 7;
		else
		if(start == 22 && destination == 86)
			price = 8;
		else
		if(start == 22 && destination == 87)
			price = 8;
		else
		if(start == 22 && destination == 88)
			price = 8;
		else
		if(start == 22 && destination == 89)
			price = 8;
		else
		if(start == 22 && destination == 90)
			price = 9;
		else
		if(start == 22 && destination == 91)
			price = 9;
		else
		if(start == 22 && destination == 92)
			price = 9;
		else
		if(start == 23 && destination == 0)
			price = 6;
		else
		if(start == 23 && destination == 1)
			price = 5;
		else
		if(start == 23 && destination == 2)
			price = 5;
		else
		if(start == 23 && destination == 3)
			price = 5;
		else
		if(start == 23 && destination == 4)
			price = 5;
		else
		if(start == 23 && destination == 5)
			price = 4;
		else
		if(start == 23 && destination == 6)
			price = 4;
		else
		if(start == 23 && destination == 7)
			price = 4;
		else
		if(start == 23 && destination == 8)
			price = 4;
		else
		if(start == 23 && destination == 9)
			price = 4;
		else
		if(start == 23 && destination == 10)
			price = 4;
		else
		if(start == 23 && destination == 11)
			price = 4;
		else
		if(start == 23 && destination == 12)
			price = 4;
		else
		if(start == 23 && destination == 13)
			price = 4;
		else
		if(start == 23 && destination == 14)
			price = 4;
		else
		if(start == 23 && destination == 15)
			price = 4;
		else
		if(start == 23 && destination == 16)
			price = 5;
		else
		if(start == 23 && destination == 17)
			price = 5;
		else
		if(start == 23 && destination == 18)
			price = 5;
		else
		if(start == 23 && destination == 19)
			price = 5;
		else
		if(start == 23 && destination == 20)
			price = 6;
		else
		if(start == 23 && destination == 21)
			price = 6;
		else
		if(start == 23 && destination == 22)
			price = 6;
		else
		if(start == 23 && destination == 23)
			price = 0;
		else
		if(start == 23 && destination == 24)
			price = 2;
		else
		if(start == 23 && destination == 25)
			price = 3;
		else
		if(start == 23 && destination == 26)
			price = 3;
		else
		if(start == 23 && destination == 27)
			price = 3;
		else
		if(start == 23 && destination == 28)
			price = 3;
		else
		if(start == 23 && destination == 29)
			price = 4;
		else
		if(start == 23 && destination == 30)
			price = 4;
		else
		if(start == 23 && destination == 31)
			price = 4;
		else
		if(start == 23 && destination == 32)
			price = 4;
		else
		if(start == 23 && destination == 33)
			price = 4;
		else
		if(start == 23 && destination == 34)
			price = 5;
		else
		if(start == 23 && destination == 35)
			price = 5;
		else
		if(start == 23 && destination == 36)
			price = 5;
		else
		if(start == 23 && destination == 37)
			price = 5;
		else
		if(start == 23 && destination == 38)
			price = 5;
		else
		if(start == 23 && destination == 39)
			price = 6;
		else
		if(start == 23 && destination == 40)
			price = 6;
		else
		if(start == 23 && destination == 41)
			price = 6;
		else
		if(start == 23 && destination == 42)
			price = 7;
		else
		if(start == 23 && destination == 43)
			price = 7;
		else
		if(start == 23 && destination == 44)
			price = 7;
		else
		if(start == 23 && destination == 45)
			price = 7;
		else
		if(start == 23 && destination == 46)
			price = 7;
		else
		if(start == 23 && destination == 47)
			price = 7;
		else
		if(start == 23 && destination == 48)
			price = 7;
		else
		if(start == 23 && destination == 49)
			price = 7;
		else
		if(start == 23 && destination == 50)
			price = 7;
		else
		if(start == 23 && destination == 51)
			price = 7;
		else
		if(start == 23 && destination == 52)
			price = 7;
		else
		if(start == 23 && destination == 53)
			price = 6;
		else
		if(start == 23 && destination == 54)
			price = 6;
		else
		if(start == 23 && destination == 55)
			price = 6;
		else
		if(start == 23 && destination == 56)
			price = 5;
		else
		if(start == 23 && destination == 57)
			price = 5;
		else
		if(start == 23 && destination == 58)
			price = 5;
		else
		if(start == 23 && destination == 59)
			price = 5;
		else
		if(start == 23 && destination == 60)
			price = 5;
		else
		if(start == 23 && destination == 61)
			price = 5;
		else
		if(start == 23 && destination == 62)
			price = 5;
		else
		if(start == 23 && destination == 63)
			price = 5;
		else
		if(start == 23 && destination == 64)
			price = 4;
		else
		if(start == 23 && destination == 65)
			price = 4;
		else
		if(start == 23 && destination == 66)
			price = 4;
		else
		if(start == 23 && destination == 67)
			price = 4;
		else
		if(start == 23 && destination == 68)
			price = 4;
		else
		if(start == 23 && destination == 69)
			price = 3;
		else
		if(start == 23 && destination == 70)
			price = 3;
		else
		if(start == 23 && destination == 71)
			price = 4;
		else
		if(start == 23 && destination == 72)
			price = 4;
		else
		if(start == 23 && destination == 73)
			price = 5;
		else
		if(start == 23 && destination == 74)
			price = 5;
		else
		if(start == 23 && destination == 75)
			price = 5;
		else
		if(start == 23 && destination == 76)
			price = 5;
		else
		if(start == 23 && destination == 77)
			price = 5;
		else
		if(start == 23 && destination == 78)
			price = 5;
		else
		if(start == 23 && destination == 79)
			price = 5;
		else
		if(start == 23 && destination == 80)
			price = 5;
		else
		if(start == 23 && destination == 81)
			price = 5;
		else
		if(start == 23 && destination == 82)
			price = 5;
		else
		if(start == 23 && destination == 83)
			price = 5;
		else
		if(start == 23 && destination == 84)
			price = 6;
		else
		if(start == 23 && destination == 85)
			price = 6;
		else
		if(start == 23 && destination == 86)
			price = 6;
		else
		if(start == 23 && destination == 87)
			price = 7;
		else
		if(start == 23 && destination == 88)
			price = 7;
		else
		if(start == 23 && destination == 89)
			price = 7;
		else
		if(start == 23 && destination == 90)
			price = 7;
		else
		if(start == 23 && destination == 91)
			price = 8;
		else
		if(start == 23 && destination == 92)
			price = 8;
		else
		if(start == 24 && destination == 0)
			price = 5;
		else
		if(start == 24 && destination == 1)
			price = 5;
		else
		if(start == 24 && destination == 2)
			price = 5;
		else
		if(start == 24 && destination == 3)
			price = 5;
		else
		if(start == 24 && destination == 4)
			price = 4;
		else
		if(start == 24 && destination == 5)
			price = 4;
		else
		if(start == 24 && destination == 6)
			price = 4;
		else
		if(start == 24 && destination == 7)
			price = 3;
		else
		if(start == 24 && destination == 8)
			price = 3;
		else
		if(start == 24 && destination == 9)
			price = 3;
		else
		if(start == 24 && destination == 10)
			price = 4;
		else
		if(start == 24 && destination == 11)
			price = 4;
		else
		if(start == 24 && destination == 12)
			price = 4;
		else
		if(start == 24 && destination == 13)
			price = 5;
		else
		if(start == 24 && destination == 14)
			price = 5;
		else
		if(start == 24 && destination == 15)
			price = 5;
		else
		if(start == 24 && destination == 16)
			price = 5;
		else
		if(start == 24 && destination == 17)
			price = 5;
		else
		if(start == 24 && destination == 18)
			price = 5;
		else
		if(start == 24 && destination == 19)
			price = 6;
		else
		if(start == 24 && destination == 20)
			price = 6;
		else
		if(start == 24 && destination == 21)
			price = 6;
		else
		if(start == 24 && destination == 22)
			price = 7;
		else
		if(start == 24 && destination == 23)
			price = 2;
		else
		if(start == 24 && destination == 24)
			price = 0;
		else
		if(start == 24 && destination == 25)
			price = 2;
		else
		if(start == 24 && destination == 26)
			price = 2;
		else
		if(start == 24 && destination == 27)
			price = 3;
		else
		if(start == 24 && destination == 28)
			price = 3;
		else
		if(start == 24 && destination == 29)
			price = 3;
		else
		if(start == 24 && destination == 30)
			price = 3;
		else
		if(start == 24 && destination == 31)
			price = 4;
		else
		if(start == 24 && destination == 32)
			price = 4;
		else
		if(start == 24 && destination == 33)
			price = 4;
		else
		if(start == 24 && destination == 34)
			price = 4;
		else
		if(start == 24 && destination == 35)
			price = 5;
		else
		if(start == 24 && destination == 36)
			price = 5;
		else
		if(start == 24 && destination == 37)
			price = 5;
		else
		if(start == 24 && destination == 38)
			price = 5;
		else
		if(start == 24 && destination == 39)
			price = 5;
		else
		if(start == 24 && destination == 40)
			price = 6;
		else
		if(start == 24 && destination == 41)
			price = 6;
		else
		if(start == 24 && destination == 42)
			price = 6;
		else
		if(start == 24 && destination == 43)
			price = 6;
		else
		if(start == 24 && destination == 44)
			price = 7;
		else
		if(start == 24 && destination == 45)
			price = 7;
		else
		if(start == 24 && destination == 46)
			price = 7;
		else
		if(start == 24 && destination == 47)
			price = 7;
		else
		if(start == 24 && destination == 48)
			price = 7;
		else
		if(start == 24 && destination == 49)
			price = 7;
		else
		if(start == 24 && destination == 50)
			price = 7;
		else
		if(start == 24 && destination == 51)
			price = 6;
		else
		if(start == 24 && destination == 52)
			price = 6;
		else
		if(start == 24 && destination == 53)
			price = 6;
		else
		if(start == 24 && destination == 54)
			price = 6;
		else
		if(start == 24 && destination == 55)
			price = 5;
		else
		if(start == 24 && destination == 56)
			price = 5;
		else
		if(start == 24 && destination == 57)
			price = 5;
		else
		if(start == 24 && destination == 58)
			price = 5;
		else
		if(start == 24 && destination == 59)
			price = 4;
		else
		if(start == 24 && destination == 60)
			price = 4;
		else
		if(start == 24 && destination == 61)
			price = 4;
		else
		if(start == 24 && destination == 62)
			price = 4;
		else
		if(start == 24 && destination == 63)
			price = 4;
		else
		if(start == 24 && destination == 64)
			price = 5;
		else
		if(start == 24 && destination == 65)
			price = 5;
		else
		if(start == 24 && destination == 66)
			price = 5;
		else
		if(start == 24 && destination == 67)
			price = 4;
		else
		if(start == 24 && destination == 68)
			price = 4;
		else
		if(start == 24 && destination == 69)
			price = 4;
		else
		if(start == 24 && destination == 70)
			price = 4;
		else
		if(start == 24 && destination == 71)
			price = 4;
		else
		if(start == 24 && destination == 72)
			price = 5;
		else
		if(start == 24 && destination == 73)
			price = 5;
		else
		if(start == 24 && destination == 74)
			price = 5;
		else
		if(start == 24 && destination == 75)
			price = 5;
		else
		if(start == 24 && destination == 76)
			price = 6;
		else
		if(start == 24 && destination == 77)
			price = 5;
		else
		if(start == 24 && destination == 78)
			price = 5;
		else
		if(start == 24 && destination == 79)
			price = 4;
		else
		if(start == 24 && destination == 80)
			price = 4;
		else
		if(start == 24 && destination == 81)
			price = 5;
		else
		if(start == 24 && destination == 82)
			price = 5;
		else
		if(start == 24 && destination == 83)
			price = 5;
		else
		if(start == 24 && destination == 84)
			price = 5;
		else
		if(start == 24 && destination == 85)
			price = 6;
		else
		if(start == 24 && destination == 86)
			price = 6;
		else
		if(start == 24 && destination == 87)
			price = 7;
		else
		if(start == 24 && destination == 88)
			price = 7;
		else
		if(start == 24 && destination == 89)
			price = 7;
		else
		if(start == 24 && destination == 90)
			price = 7;
		else
		if(start == 24 && destination == 91)
			price = 7;
		else
		if(start == 24 && destination == 92)
			price = 8;
		else
		if(start == 25 && destination == 0)
			price = 5;
		else
		if(start == 25 && destination == 1)
			price = 5;
		else
		if(start == 25 && destination == 2)
			price = 4;
		else
		if(start == 25 && destination == 3)
			price = 4;
		else
		if(start == 25 && destination == 4)
			price = 4;
		else
		if(start == 25 && destination == 5)
			price = 4;
		else
		if(start == 25 && destination == 6)
			price = 3;
		else
		if(start == 25 && destination == 7)
			price = 3;
		else
		if(start == 25 && destination == 8)
			price = 3;
		else
		if(start == 25 && destination == 9)
			price = 3;
		else
		if(start == 25 && destination == 10)
			price = 3;
		else
		if(start == 25 && destination == 11)
			price = 3;
		else
		if(start == 25 && destination == 12)
			price = 4;
		else
		if(start == 25 && destination == 13)
			price = 5;
		else
		if(start == 25 && destination == 14)
			price = 5;
		else
		if(start == 25 && destination == 15)
			price = 5;
		else
		if(start == 25 && destination == 16)
			price = 5;
		else
		if(start == 25 && destination == 17)
			price = 5;
		else
		if(start == 25 && destination == 18)
			price = 5;
		else
		if(start == 25 && destination == 19)
			price = 6;
		else
		if(start == 25 && destination == 20)
			price = 6;
		else
		if(start == 25 && destination == 21)
			price = 6;
		else
		if(start == 25 && destination == 22)
			price = 7;
		else
		if(start == 25 && destination == 23)
			price = 3;
		else
		if(start == 25 && destination == 24)
			price = 2;
		else
		if(start == 25 && destination == 25)
			price = 0;
		else
		if(start == 25 && destination == 26)
			price = 2;
		else
		if(start == 25 && destination == 27)
			price = 2;
		else
		if(start == 25 && destination == 28)
			price = 3;
		else
		if(start == 25 && destination == 29)
			price = 3;
		else
		if(start == 25 && destination == 30)
			price = 3;
		else
		if(start == 25 && destination == 31)
			price = 3;
		else
		if(start == 25 && destination == 32)
			price = 3;
		else
		if(start == 25 && destination == 33)
			price = 4;
		else
		if(start == 25 && destination == 34)
			price = 4;
		else
		if(start == 25 && destination == 35)
			price = 4;
		else
		if(start == 25 && destination == 36)
			price = 5;
		else
		if(start == 25 && destination == 37)
			price = 5;
		else
		if(start == 25 && destination == 38)
			price = 5;
		else
		if(start == 25 && destination == 39)
			price = 5;
		else
		if(start == 25 && destination == 40)
			price = 5;
		else
		if(start == 25 && destination == 41)
			price = 6;
		else
		if(start == 25 && destination == 42)
			price = 6;
		else
		if(start == 25 && destination == 43)
			price = 6;
		else
		if(start == 25 && destination == 44)
			price = 6;
		else
		if(start == 25 && destination == 45)
			price = 7;
		else
		if(start == 25 && destination == 46)
			price = 7;
		else
		if(start == 25 && destination == 47)
			price = 7;
		else
		if(start == 25 && destination == 48)
			price = 7;
		else
		if(start == 25 && destination == 49)
			price = 7;
		else
		if(start == 25 && destination == 50)
			price = 6;
		else
		if(start == 25 && destination == 51)
			price = 6;
		else
		if(start == 25 && destination == 52)
			price = 6;
		else
		if(start == 25 && destination == 53)
			price = 6;
		else
		if(start == 25 && destination == 54)
			price = 5;
		else
		if(start == 25 && destination == 55)
			price = 5;
		else
		if(start == 25 && destination == 56)
			price = 5;
		else
		if(start == 25 && destination == 57)
			price = 5;
		else
		if(start == 25 && destination == 58)
			price = 5;
		else
		if(start == 25 && destination == 59)
			price = 4;
		else
		if(start == 25 && destination == 60)
			price = 4;
		else
		if(start == 25 && destination == 61)
			price = 4;
		else
		if(start == 25 && destination == 62)
			price = 4;
		else
		if(start == 25 && destination == 63)
			price = 4;
		else
		if(start == 25 && destination == 64)
			price = 4;
		else
		if(start == 25 && destination == 65)
			price = 5;
		else
		if(start == 25 && destination == 66)
			price = 4;
		else
		if(start == 25 && destination == 67)
			price = 4;
		else
		if(start == 25 && destination == 68)
			price = 4;
		else
		if(start == 25 && destination == 69)
			price = 4;
		else
		if(start == 25 && destination == 70)
			price = 4;
		else
		if(start == 25 && destination == 71)
			price = 4;
		else
		if(start == 25 && destination == 72)
			price = 5;
		else
		if(start == 25 && destination == 73)
			price = 5;
		else
		if(start == 25 && destination == 74)
			price = 5;
		else
		if(start == 25 && destination == 75)
			price = 5;
		else
		if(start == 25 && destination == 76)
			price = 6;
		else
		if(start == 25 && destination == 77)
			price = 5;
		else
		if(start == 25 && destination == 78)
			price = 4;
		else
		if(start == 25 && destination == 79)
			price = 4;
		else
		if(start == 25 && destination == 80)
			price = 4;
		else
		if(start == 25 && destination == 81)
			price = 4;
		else
		if(start == 25 && destination == 82)
			price = 5;
		else
		if(start == 25 && destination == 83)
			price = 5;
		else
		if(start == 25 && destination == 84)
			price = 5;
		else
		if(start == 25 && destination == 85)
			price = 5;
		else
		if(start == 25 && destination == 86)
			price = 6;
		else
		if(start == 25 && destination == 87)
			price = 6;
		else
		if(start == 25 && destination == 88)
			price = 6;
		else
		if(start == 25 && destination == 89)
			price = 7;
		else
		if(start == 25 && destination == 90)
			price = 7;
		else
		if(start == 25 && destination == 91)
			price = 7;
		else
		if(start == 25 && destination == 92)
			price = 8;
		else
		if(start == 26 && destination == 0)
			price = 5;
		else
		if(start == 26 && destination == 1)
			price = 5;
		else
		if(start == 26 && destination == 2)
			price = 4;
		else
		if(start == 26 && destination == 3)
			price = 4;
		else
		if(start == 26 && destination == 4)
			price = 4;
		else
		if(start == 26 && destination == 5)
			price = 4;
		else
		if(start == 26 && destination == 6)
			price = 4;
		else
		if(start == 26 && destination == 7)
			price = 3;
		else
		if(start == 26 && destination == 8)
			price = 3;
		else
		if(start == 26 && destination == 9)
			price = 3;
		else
		if(start == 26 && destination == 10)
			price = 3;
		else
		if(start == 26 && destination == 11)
			price = 4;
		else
		if(start == 26 && destination == 12)
			price = 4;
		else
		if(start == 26 && destination == 13)
			price = 5;
		else
		if(start == 26 && destination == 14)
			price = 5;
		else
		if(start == 26 && destination == 15)
			price = 5;
		else
		if(start == 26 && destination == 16)
			price = 5;
		else
		if(start == 26 && destination == 17)
			price = 5;
		else
		if(start == 26 && destination == 18)
			price = 6;
		else
		if(start == 26 && destination == 19)
			price = 6;
		else
		if(start == 26 && destination == 20)
			price = 6;
		else
		if(start == 26 && destination == 21)
			price = 6;
		else
		if(start == 26 && destination == 22)
			price = 7;
		else
		if(start == 26 && destination == 23)
			price = 3;
		else
		if(start == 26 && destination == 24)
			price = 2;
		else
		if(start == 26 && destination == 25)
			price = 2;
		else
		if(start == 26 && destination == 26)
			price = 0;
		else
		if(start == 26 && destination == 27)
			price = 2;
		else
		if(start == 26 && destination == 28)
			price = 2;
		else
		if(start == 26 && destination == 29)
			price = 3;
		else
		if(start == 26 && destination == 30)
			price = 3;
		else
		if(start == 26 && destination == 31)
			price = 3;
		else
		if(start == 26 && destination == 32)
			price = 3;
		else
		if(start == 26 && destination == 33)
			price = 3;
		else
		if(start == 26 && destination == 34)
			price = 4;
		else
		if(start == 26 && destination == 35)
			price = 4;
		else
		if(start == 26 && destination == 36)
			price = 4;
		else
		if(start == 26 && destination == 37)
			price = 5;
		else
		if(start == 26 && destination == 38)
			price = 5;
		else
		if(start == 26 && destination == 39)
			price = 5;
		else
		if(start == 26 && destination == 40)
			price = 5;
		else
		if(start == 26 && destination == 41)
			price = 6;
		else
		if(start == 26 && destination == 42)
			price = 6;
		else
		if(start == 26 && destination == 43)
			price = 6;
		else
		if(start == 26 && destination == 44)
			price = 6;
		else
		if(start == 26 && destination == 45)
			price = 6;
		else
		if(start == 26 && destination == 46)
			price = 7;
		else
		if(start == 26 && destination == 47)
			price = 7;
		else
		if(start == 26 && destination == 48)
			price = 7;
		else
		if(start == 26 && destination == 49)
			price = 6;
		else
		if(start == 26 && destination == 50)
			price = 6;
		else
		if(start == 26 && destination == 51)
			price = 6;
		else
		if(start == 26 && destination == 52)
			price = 6;
		else
		if(start == 26 && destination == 53)
			price = 6;
		else
		if(start == 26 && destination == 54)
			price = 5;
		else
		if(start == 26 && destination == 55)
			price = 5;
		else
		if(start == 26 && destination == 56)
			price = 5;
		else
		if(start == 26 && destination == 57)
			price = 4;
		else
		if(start == 26 && destination == 58)
			price = 4;
		else
		if(start == 26 && destination == 59)
			price = 4;
		else
		if(start == 26 && destination == 60)
			price = 4;
		else
		if(start == 26 && destination == 61)
			price = 3;
		else
		if(start == 26 && destination == 62)
			price = 4;
		else
		if(start == 26 && destination == 63)
			price = 4;
		else
		if(start == 26 && destination == 64)
			price = 4;
		else
		if(start == 26 && destination == 65)
			price = 4;
		else
		if(start == 26 && destination == 66)
			price = 5;
		else
		if(start == 26 && destination == 67)
			price = 5;
		else
		if(start == 26 && destination == 68)
			price = 4;
		else
		if(start == 26 && destination == 69)
			price = 4;
		else
		if(start == 26 && destination == 70)
			price = 4;
		else
		if(start == 26 && destination == 71)
			price = 5;
		else
		if(start == 26 && destination == 72)
			price = 5;
		else
		if(start == 26 && destination == 73)
			price = 5;
		else
		if(start == 26 && destination == 74)
			price = 5;
		else
		if(start == 26 && destination == 75)
			price = 6;
		else
		if(start == 26 && destination == 76)
			price = 6;
		else
		if(start == 26 && destination == 77)
			price = 5;
		else
		if(start == 26 && destination == 78)
			price = 4;
		else
		if(start == 26 && destination == 79)
			price = 4;
		else
		if(start == 26 && destination == 80)
			price = 4;
		else
		if(start == 26 && destination == 81)
			price = 4;
		else
		if(start == 26 && destination == 82)
			price = 4;
		else
		if(start == 26 && destination == 83)
			price = 5;
		else
		if(start == 26 && destination == 84)
			price = 5;
		else
		if(start == 26 && destination == 85)
			price = 5;
		else
		if(start == 26 && destination == 86)
			price = 6;
		else
		if(start == 26 && destination == 87)
			price = 6;
		else
		if(start == 26 && destination == 88)
			price = 6;
		else
		if(start == 26 && destination == 89)
			price = 7;
		else
		if(start == 26 && destination == 90)
			price = 7;
		else
		if(start == 26 && destination == 91)
			price = 7;
		else
		if(start == 26 && destination == 92)
			price = 7;
		else
		if(start == 27 && destination == 0)
			price = 5;
		else
		if(start == 27 && destination == 1)
			price = 4;
		else
		if(start == 27 && destination == 2)
			price = 4;
		else
		if(start == 27 && destination == 3)
			price = 4;
		else
		if(start == 27 && destination == 4)
			price = 3;
		else
		if(start == 27 && destination == 5)
			price = 3;
		else
		if(start == 27 && destination == 6)
			price = 3;
		else
		if(start == 27 && destination == 7)
			price = 4;
		else
		if(start == 27 && destination == 8)
			price = 3;
		else
		if(start == 27 && destination == 9)
			price = 3;
		else
		if(start == 27 && destination == 10)
			price = 4;
		else
		if(start == 27 && destination == 11)
			price = 4;
		else
		if(start == 27 && destination == 12)
			price = 5;
		else
		if(start == 27 && destination == 13)
			price = 5;
		else
		if(start == 27 && destination == 14)
			price = 5;
		else
		if(start == 27 && destination == 15)
			price = 5;
		else
		if(start == 27 && destination == 16)
			price = 5;
		else
		if(start == 27 && destination == 17)
			price = 6;
		else
		if(start == 27 && destination == 18)
			price = 6;
		else
		if(start == 27 && destination == 19)
			price = 6;
		else
		if(start == 27 && destination == 20)
			price = 6;
		else
		if(start == 27 && destination == 21)
			price = 7;
		else
		if(start == 27 && destination == 22)
			price = 7;
		else
		if(start == 27 && destination == 23)
			price = 3;
		else
		if(start == 27 && destination == 24)
			price = 3;
		else
		if(start == 27 && destination == 25)
			price = 2;
		else
		if(start == 27 && destination == 26)
			price = 2;
		else
		if(start == 27 && destination == 27)
			price = 0;
		else
		if(start == 27 && destination == 28)
			price = 2;
		else
		if(start == 27 && destination == 29)
			price = 2;
		else
		if(start == 27 && destination == 30)
			price = 2;
		else
		if(start == 27 && destination == 31)
			price = 3;
		else
		if(start == 27 && destination == 32)
			price = 3;
		else
		if(start == 27 && destination == 33)
			price = 3;
		else
		if(start == 27 && destination == 34)
			price = 3;
		else
		if(start == 27 && destination == 35)
			price = 4;
		else
		if(start == 27 && destination == 36)
			price = 4;
		else
		if(start == 27 && destination == 37)
			price = 4;
		else
		if(start == 27 && destination == 38)
			price = 4;
		else
		if(start == 27 && destination == 39)
			price = 5;
		else
		if(start == 27 && destination == 40)
			price = 5;
		else
		if(start == 27 && destination == 41)
			price = 5;
		else
		if(start == 27 && destination == 42)
			price = 6;
		else
		if(start == 27 && destination == 43)
			price = 6;
		else
		if(start == 27 && destination == 44)
			price = 6;
		else
		if(start == 27 && destination == 45)
			price = 6;
		else
		if(start == 27 && destination == 46)
			price = 7;
		else
		if(start == 27 && destination == 47)
			price = 7;
		else
		if(start == 27 && destination == 48)
			price = 7;
		else
		if(start == 27 && destination == 49)
			price = 6;
		else
		if(start == 27 && destination == 50)
			price = 6;
		else
		if(start == 27 && destination == 51)
			price = 6;
		else
		if(start == 27 && destination == 52)
			price = 6;
		else
		if(start == 27 && destination == 53)
			price = 5;
		else
		if(start == 27 && destination == 54)
			price = 5;
		else
		if(start == 27 && destination == 55)
			price = 5;
		else
		if(start == 27 && destination == 56)
			price = 4;
		else
		if(start == 27 && destination == 57)
			price = 4;
		else
		if(start == 27 && destination == 58)
			price = 4;
		else
		if(start == 27 && destination == 59)
			price = 4;
		else
		if(start == 27 && destination == 60)
			price = 3;
		else
		if(start == 27 && destination == 61)
			price = 3;
		else
		if(start == 27 && destination == 62)
			price = 3;
		else
		if(start == 27 && destination == 63)
			price = 4;
		else
		if(start == 27 && destination == 64)
			price = 4;
		else
		if(start == 27 && destination == 65)
			price = 4;
		else
		if(start == 27 && destination == 66)
			price = 4;
		else
		if(start == 27 && destination == 67)
			price = 5;
		else
		if(start == 27 && destination == 68)
			price = 5;
		else
		if(start == 27 && destination == 69)
			price = 4;
		else
		if(start == 27 && destination == 70)
			price = 5;
		else
		if(start == 27 && destination == 71)
			price = 5;
		else
		if(start == 27 && destination == 72)
			price = 5;
		else
		if(start == 27 && destination == 73)
			price = 5;
		else
		if(start == 27 && destination == 74)
			price = 6;
		else
		if(start == 27 && destination == 75)
			price = 6;
		else
		if(start == 27 && destination == 76)
			price = 6;
		else
		if(start == 27 && destination == 77)
			price = 4;
		else
		if(start == 27 && destination == 78)
			price = 4;
		else
		if(start == 27 && destination == 79)
			price = 4;
		else
		if(start == 27 && destination == 80)
			price = 3;
		else
		if(start == 27 && destination == 81)
			price = 4;
		else
		if(start == 27 && destination == 82)
			price = 4;
		else
		if(start == 27 && destination == 83)
			price = 4;
		else
		if(start == 27 && destination == 84)
			price = 5;
		else
		if(start == 27 && destination == 85)
			price = 5;
		else
		if(start == 27 && destination == 86)
			price = 5;
		else
		if(start == 27 && destination == 87)
			price = 6;
		else
		if(start == 27 && destination == 88)
			price = 6;
		else
		if(start == 27 && destination == 89)
			price = 6;
		else
		if(start == 27 && destination == 90)
			price = 7;
		else
		if(start == 27 && destination == 91)
			price = 7;
		else
		if(start == 27 && destination == 92)
			price = 7;
		else
		if(start == 28 && destination == 0)
			price = 4;
		else
		if(start == 28 && destination == 1)
			price = 4;
		else
		if(start == 28 && destination == 2)
			price = 4;
		else
		if(start == 28 && destination == 3)
			price = 3;
		else
		if(start == 28 && destination == 4)
			price = 3;
		else
		if(start == 28 && destination == 5)
			price = 3;
		else
		if(start == 28 && destination == 6)
			price = 3;
		else
		if(start == 28 && destination == 7)
			price = 4;
		else
		if(start == 28 && destination == 8)
			price = 3;
		else
		if(start == 28 && destination == 9)
			price = 4;
		else
		if(start == 28 && destination == 10)
			price = 4;
		else
		if(start == 28 && destination == 11)
			price = 4;
		else
		if(start == 28 && destination == 12)
			price = 5;
		else
		if(start == 28 && destination == 13)
			price = 5;
		else
		if(start == 28 && destination == 14)
			price = 5;
		else
		if(start == 28 && destination == 15)
			price = 5;
		else
		if(start == 28 && destination == 16)
			price = 6;
		else
		if(start == 28 && destination == 17)
			price = 6;
		else
		if(start == 28 && destination == 18)
			price = 6;
		else
		if(start == 28 && destination == 19)
			price = 6;
		else
		if(start == 28 && destination == 20)
			price = 6;
		else
		if(start == 28 && destination == 21)
			price = 7;
		else
		if(start == 28 && destination == 22)
			price = 7;
		else
		if(start == 28 && destination == 23)
			price = 3;
		else
		if(start == 28 && destination == 24)
			price = 3;
		else
		if(start == 28 && destination == 25)
			price = 3;
		else
		if(start == 28 && destination == 26)
			price = 2;
		else
		if(start == 28 && destination == 27)
			price = 2;
		else
		if(start == 28 && destination == 28)
			price = 0;
		else
		if(start == 28 && destination == 29)
			price = 2;
		else
		if(start == 28 && destination == 30)
			price = 2;
		else
		if(start == 28 && destination == 31)
			price = 2;
		else
		if(start == 28 && destination == 32)
			price = 3;
		else
		if(start == 28 && destination == 33)
			price = 3;
		else
		if(start == 28 && destination == 34)
			price = 3;
		else
		if(start == 28 && destination == 35)
			price = 3;
		else
		if(start == 28 && destination == 36)
			price = 4;
		else
		if(start == 28 && destination == 37)
			price = 4;
		else
		if(start == 28 && destination == 38)
			price = 4;
		else
		if(start == 28 && destination == 39)
			price = 4;
		else
		if(start == 28 && destination == 40)
			price = 5;
		else
		if(start == 28 && destination == 41)
			price = 5;
		else
		if(start == 28 && destination == 42)
			price = 5;
		else
		if(start == 28 && destination == 43)
			price = 6;
		else
		if(start == 28 && destination == 44)
			price = 6;
		else
		if(start == 28 && destination == 45)
			price = 6;
		else
		if(start == 28 && destination == 46)
			price = 6;
		else
		if(start == 28 && destination == 47)
			price = 7;
		else
		if(start == 28 && destination == 48)
			price = 6;
		else
		if(start == 28 && destination == 49)
			price = 6;
		else
		if(start == 28 && destination == 50)
			price = 6;
		else
		if(start == 28 && destination == 51)
			price = 6;
		else
		if(start == 28 && destination == 52)
			price = 5;
		else
		if(start == 28 && destination == 53)
			price = 5;
		else
		if(start == 28 && destination == 54)
			price = 5;
		else
		if(start == 28 && destination == 55)
			price = 5;
		else
		if(start == 28 && destination == 56)
			price = 4;
		else
		if(start == 28 && destination == 57)
			price = 4;
		else
		if(start == 28 && destination == 58)
			price = 4;
		else
		if(start == 28 && destination == 59)
			price = 3;
		else
		if(start == 28 && destination == 60)
			price = 3;
		else
		if(start == 28 && destination == 61)
			price = 3;
		else
		if(start == 28 && destination == 62)
			price = 3;
		else
		if(start == 28 && destination == 63)
			price = 3;
		else
		if(start == 28 && destination == 64)
			price = 4;
		else
		if(start == 28 && destination == 65)
			price = 4;
		else
		if(start == 28 && destination == 66)
			price = 4;
		else
		if(start == 28 && destination == 67)
			price = 4;
		else
		if(start == 28 && destination == 68)
			price = 4;
		else
		if(start == 28 && destination == 69)
			price = 5;
		else
		if(start == 28 && destination == 70)
			price = 5;
		else
		if(start == 28 && destination == 71)
			price = 5;
		else
		if(start == 28 && destination == 72)
			price = 5;
		else
		if(start == 28 && destination == 73)
			price = 6;
		else
		if(start == 28 && destination == 74)
			price = 6;
		else
		if(start == 28 && destination == 75)
			price = 6;
		else
		if(start == 28 && destination == 76)
			price = 6;
		else
		if(start == 28 && destination == 77)
			price = 4;
		else
		if(start == 28 && destination == 78)
			price = 4;
		else
		if(start == 28 && destination == 79)
			price = 3;
		else
		if(start == 28 && destination == 80)
			price = 3;
		else
		if(start == 28 && destination == 81)
			price = 3;
		else
		if(start == 28 && destination == 82)
			price = 4;
		else
		if(start == 28 && destination == 83)
			price = 4;
		else
		if(start == 28 && destination == 84)
			price = 4;
		else
		if(start == 28 && destination == 85)
			price = 5;
		else
		if(start == 28 && destination == 86)
			price = 5;
		else
		if(start == 28 && destination == 87)
			price = 6;
		else
		if(start == 28 && destination == 88)
			price = 6;
		else
		if(start == 28 && destination == 89)
			price = 6;
		else
		if(start == 28 && destination == 90)
			price = 6;
		else
		if(start == 28 && destination == 91)
			price = 7;
		else
		if(start == 28 && destination == 92)
			price = 7;
		else
		if(start == 29 && destination == 0)
			price = 4;
		else
		if(start == 29 && destination == 1)
			price = 4;
		else
		if(start == 29 && destination == 2)
			price = 3;
		else
		if(start == 29 && destination == 3)
			price = 3;
		else
		if(start == 29 && destination == 4)
			price = 3;
		else
		if(start == 29 && destination == 5)
			price = 3;
		else
		if(start == 29 && destination == 6)
			price = 3;
		else
		if(start == 29 && destination == 7)
			price = 3;
		else
		if(start == 29 && destination == 8)
			price = 4;
		else
		if(start == 29 && destination == 9)
			price = 4;
		else
		if(start == 29 && destination == 10)
			price = 4;
		else
		if(start == 29 && destination == 11)
			price = 4;
		else
		if(start == 29 && destination == 12)
			price = 5;
		else
		if(start == 29 && destination == 13)
			price = 5;
		else
		if(start == 29 && destination == 14)
			price = 5;
		else
		if(start == 29 && destination == 15)
			price = 5;
		else
		if(start == 29 && destination == 16)
			price = 6;
		else
		if(start == 29 && destination == 17)
			price = 6;
		else
		if(start == 29 && destination == 18)
			price = 6;
		else
		if(start == 29 && destination == 19)
			price = 6;
		else
		if(start == 29 && destination == 20)
			price = 6;
		else
		if(start == 29 && destination == 21)
			price = 7;
		else
		if(start == 29 && destination == 22)
			price = 7;
		else
		if(start == 29 && destination == 23)
			price = 4;
		else
		if(start == 29 && destination == 24)
			price = 3;
		else
		if(start == 29 && destination == 25)
			price = 3;
		else
		if(start == 29 && destination == 26)
			price = 3;
		else
		if(start == 29 && destination == 27)
			price = 2;
		else
		if(start == 29 && destination == 28)
			price = 2;
		else
		if(start == 29 && destination == 29)
			price = 0;
		else
		if(start == 29 && destination == 30)
			price = 2;
		else
		if(start == 29 && destination == 31)
			price = 2;
		else
		if(start == 29 && destination == 32)
			price = 2;
		else
		if(start == 29 && destination == 33)
			price = 2;
		else
		if(start == 29 && destination == 34)
			price = 3;
		else
		if(start == 29 && destination == 35)
			price = 3;
		else
		if(start == 29 && destination == 36)
			price = 3;
		else
		if(start == 29 && destination == 37)
			price = 4;
		else
		if(start == 29 && destination == 38)
			price = 4;
		else
		if(start == 29 && destination == 39)
			price = 4;
		else
		if(start == 29 && destination == 40)
			price = 5;
		else
		if(start == 29 && destination == 41)
			price = 5;
		else
		if(start == 29 && destination == 42)
			price = 5;
		else
		if(start == 29 && destination == 43)
			price = 5;
		else
		if(start == 29 && destination == 44)
			price = 6;
		else
		if(start == 29 && destination == 45)
			price = 6;
		else
		if(start == 29 && destination == 46)
			price = 6;
		else
		if(start == 29 && destination == 47)
			price = 6;
		else
		if(start == 29 && destination == 48)
			price = 6;
		else
		if(start == 29 && destination == 49)
			price = 6;
		else
		if(start == 29 && destination == 50)
			price = 6;
		else
		if(start == 29 && destination == 51)
			price = 5;
		else
		if(start == 29 && destination == 52)
			price = 5;
		else
		if(start == 29 && destination == 53)
			price = 5;
		else
		if(start == 29 && destination == 54)
			price = 4;
		else
		if(start == 29 && destination == 55)
			price = 4;
		else
		if(start == 29 && destination == 56)
			price = 4;
		else
		if(start == 29 && destination == 57)
			price = 4;
		else
		if(start == 29 && destination == 58)
			price = 4;
		else
		if(start == 29 && destination == 59)
			price = 3;
		else
		if(start == 29 && destination == 60)
			price = 3;
		else
		if(start == 29 && destination == 61)
			price = 3;
		else
		if(start == 29 && destination == 62)
			price = 3;
		else
		if(start == 29 && destination == 63)
			price = 3;
		else
		if(start == 29 && destination == 64)
			price = 3;
		else
		if(start == 29 && destination == 65)
			price = 4;
		else
		if(start == 29 && destination == 66)
			price = 4;
		else
		if(start == 29 && destination == 67)
			price = 4;
		else
		if(start == 29 && destination == 68)
			price = 4;
		else
		if(start == 29 && destination == 69)
			price = 4;
		else
		if(start == 29 && destination == 70)
			price = 5;
		else
		if(start == 29 && destination == 71)
			price = 5;
		else
		if(start == 29 && destination == 72)
			price = 5;
		else
		if(start == 29 && destination == 73)
			price = 5;
		else
		if(start == 29 && destination == 74)
			price = 6;
		else
		if(start == 29 && destination == 75)
			price = 6;
		else
		if(start == 29 && destination == 76)
			price = 6;
		else
		if(start == 29 && destination == 77)
			price = 4;
		else
		if(start == 29 && destination == 78)
			price = 3;
		else
		if(start == 29 && destination == 79)
			price = 3;
		else
		if(start == 29 && destination == 80)
			price = 3;
		else
		if(start == 29 && destination == 81)
			price = 3;
		else
		if(start == 29 && destination == 82)
			price = 3;
		else
		if(start == 29 && destination == 83)
			price = 4;
		else
		if(start == 29 && destination == 84)
			price = 4;
		else
		if(start == 29 && destination == 85)
			price = 5;
		else
		if(start == 29 && destination == 86)
			price = 5;
		else
		if(start == 29 && destination == 87)
			price = 6;
		else
		if(start == 29 && destination == 88)
			price = 6;
		else
		if(start == 29 && destination == 89)
			price = 6;
		else
		if(start == 29 && destination == 90)
			price = 6;
		else
		if(start == 29 && destination == 91)
			price = 7;
		else
		if(start == 29 && destination == 92)
			price = 7;
		else
		if(start == 30 && destination == 0)
			price = 4;
		else
		if(start == 30 && destination == 1)
			price = 4;
		else
		if(start == 30 && destination == 2)
			price = 3;
		else
		if(start == 30 && destination == 3)
			price = 3;
		else
		if(start == 30 && destination == 4)
			price = 2;
		else
		if(start == 30 && destination == 5)
			price = 2;
		else
		if(start == 30 && destination == 6)
			price = 3;
		else
		if(start == 30 && destination == 7)
			price = 3;
		else
		if(start == 30 && destination == 8)
			price = 3;
		else
		if(start == 30 && destination == 9)
			price = 4;
		else
		if(start == 30 && destination == 10)
			price = 4;
		else
		if(start == 30 && destination == 11)
			price = 4;
		else
		if(start == 30 && destination == 12)
			price = 5;
		else
		if(start == 30 && destination == 13)
			price = 5;
		else
		if(start == 30 && destination == 14)
			price = 5;
		else
		if(start == 30 && destination == 15)
			price = 5;
		else
		if(start == 30 && destination == 16)
			price = 5;
		else
		if(start == 30 && destination == 17)
			price = 5;
		else
		if(start == 30 && destination == 18)
			price = 6;
		else
		if(start == 30 && destination == 19)
			price = 6;
		else
		if(start == 30 && destination == 20)
			price = 6;
		else
		if(start == 30 && destination == 21)
			price = 7;
		else
		if(start == 30 && destination == 22)
			price = 7;
		else
		if(start == 30 && destination == 23)
			price = 4;
		else
		if(start == 30 && destination == 24)
			price = 3;
		else
		if(start == 30 && destination == 25)
			price = 3;
		else
		if(start == 30 && destination == 26)
			price = 3;
		else
		if(start == 30 && destination == 27)
			price = 2;
		else
		if(start == 30 && destination == 28)
			price = 2;
		else
		if(start == 30 && destination == 29)
			price = 2;
		else
		if(start == 30 && destination == 30)
			price = 0;
		else
		if(start == 30 && destination == 31)
			price = 2;
		else
		if(start == 30 && destination == 32)
			price = 2;
		else
		if(start == 30 && destination == 33)
			price = 2;
		else
		if(start == 30 && destination == 34)
			price = 3;
		else
		if(start == 30 && destination == 35)
			price = 3;
		else
		if(start == 30 && destination == 36)
			price = 3;
		else
		if(start == 30 && destination == 37)
			price = 3;
		else
		if(start == 30 && destination == 38)
			price = 4;
		else
		if(start == 30 && destination == 39)
			price = 4;
		else
		if(start == 30 && destination == 40)
			price = 4;
		else
		if(start == 30 && destination == 41)
			price = 5;
		else
		if(start == 30 && destination == 42)
			price = 5;
		else
		if(start == 30 && destination == 43)
			price = 5;
		else
		if(start == 30 && destination == 44)
			price = 6;
		else
		if(start == 30 && destination == 45)
			price = 6;
		else
		if(start == 30 && destination == 46)
			price = 6;
		else
		if(start == 30 && destination == 47)
			price = 6;
		else
		if(start == 30 && destination == 48)
			price = 6;
		else
		if(start == 30 && destination == 49)
			price = 6;
		else
		if(start == 30 && destination == 50)
			price = 5;
		else
		if(start == 30 && destination == 51)
			price = 5;
		else
		if(start == 30 && destination == 52)
			price = 5;
		else
		if(start == 30 && destination == 53)
			price = 5;
		else
		if(start == 30 && destination == 54)
			price = 4;
		else
		if(start == 30 && destination == 55)
			price = 4;
		else
		if(start == 30 && destination == 56)
			price = 4;
		else
		if(start == 30 && destination == 57)
			price = 3;
		else
		if(start == 30 && destination == 58)
			price = 3;
		else
		if(start == 30 && destination == 59)
			price = 3;
		else
		if(start == 30 && destination == 60)
			price = 3;
		else
		if(start == 30 && destination == 61)
			price = 2;
		else
		if(start == 30 && destination == 62)
			price = 3;
		else
		if(start == 30 && destination == 63)
			price = 3;
		else
		if(start == 30 && destination == 64)
			price = 3;
		else
		if(start == 30 && destination == 65)
			price = 3;
		else
		if(start == 30 && destination == 66)
			price = 3;
		else
		if(start == 30 && destination == 67)
			price = 4;
		else
		if(start == 30 && destination == 68)
			price = 4;
		else
		if(start == 30 && destination == 69)
			price = 4;
		else
		if(start == 30 && destination == 70)
			price = 4;
		else
		if(start == 30 && destination == 71)
			price = 5;
		else
		if(start == 30 && destination == 72)
			price = 5;
		else
		if(start == 30 && destination == 73)
			price = 5;
		else
		if(start == 30 && destination == 74)
			price = 6;
		else
		if(start == 30 && destination == 75)
			price = 6;
		else
		if(start == 30 && destination == 76)
			price = 6;
		else
		if(start == 30 && destination == 77)
			price = 3;
		else
		if(start == 30 && destination == 78)
			price = 3;
		else
		if(start == 30 && destination == 79)
			price = 3;
		else
		if(start == 30 && destination == 80)
			price = 3;
		else
		if(start == 30 && destination == 81)
			price = 3;
		else
		if(start == 30 && destination == 82)
			price = 3;
		else
		if(start == 30 && destination == 83)
			price = 4;
		else
		if(start == 30 && destination == 84)
			price = 4;
		else
		if(start == 30 && destination == 85)
			price = 4;
		else
		if(start == 30 && destination == 86)
			price = 5;
		else
		if(start == 30 && destination == 87)
			price = 5;
		else
		if(start == 30 && destination == 88)
			price = 6;
		else
		if(start == 30 && destination == 89)
			price = 6;
		else
		if(start == 30 && destination == 90)
			price = 6;
		else
		if(start == 30 && destination == 91)
			price = 6;
		else
		if(start == 30 && destination == 92)
			price = 7;
		else
		if(start == 31 && destination == 0)
			price = 4;
		else
		if(start == 31 && destination == 1)
			price = 3;
		else
		if(start == 31 && destination == 2)
			price = 3;
		else
		if(start == 31 && destination == 3)
			price = 3;
		else
		if(start == 31 && destination == 4)
			price = 2;
		else
		if(start == 31 && destination == 5)
			price = 2;
		else
		if(start == 31 && destination == 6)
			price = 2;
		else
		if(start == 31 && destination == 7)
			price = 3;
		else
		if(start == 31 && destination == 8)
			price = 3;
		else
		if(start == 31 && destination == 9)
			price = 4;
		else
		if(start == 31 && destination == 10)
			price = 4;
		else
		if(start == 31 && destination == 11)
			price = 4;
		else
		if(start == 31 && destination == 12)
			price = 4;
		else
		if(start == 31 && destination == 13)
			price = 5;
		else
		if(start == 31 && destination == 14)
			price = 5;
		else
		if(start == 31 && destination == 15)
			price = 5;
		else
		if(start == 31 && destination == 16)
			price = 5;
		else
		if(start == 31 && destination == 17)
			price = 5;
		else
		if(start == 31 && destination == 18)
			price = 6;
		else
		if(start == 31 && destination == 19)
			price = 6;
		else
		if(start == 31 && destination == 20)
			price = 6;
		else
		if(start == 31 && destination == 21)
			price = 6;
		else
		if(start == 31 && destination == 22)
			price = 7;
		else
		if(start == 31 && destination == 23)
			price = 4;
		else
		if(start == 31 && destination == 24)
			price = 4;
		else
		if(start == 31 && destination == 25)
			price = 3;
		else
		if(start == 31 && destination == 26)
			price = 3;
		else
		if(start == 31 && destination == 27)
			price = 3;
		else
		if(start == 31 && destination == 28)
			price = 2;
		else
		if(start == 31 && destination == 29)
			price = 2;
		else
		if(start == 31 && destination == 30)
			price = 2;
		else
		if(start == 31 && destination == 31)
			price = 0;
		else
		if(start == 31 && destination == 32)
			price = 2;
		else
		if(start == 31 && destination == 33)
			price = 2;
		else
		if(start == 31 && destination == 34)
			price = 2;
		else
		if(start == 31 && destination == 35)
			price = 3;
		else
		if(start == 31 && destination == 36)
			price = 3;
		else
		if(start == 31 && destination == 37)
			price = 3;
		else
		if(start == 31 && destination == 38)
			price = 3;
		else
		if(start == 31 && destination == 39)
			price = 4;
		else
		if(start == 31 && destination == 40)
			price = 4;
		else
		if(start == 31 && destination == 41)
			price = 5;
		else
		if(start == 31 && destination == 42)
			price = 5;
		else
		if(start == 31 && destination == 43)
			price = 5;
		else
		if(start == 31 && destination == 44)
			price = 5;
		else
		if(start == 31 && destination == 45)
			price = 6;
		else
		if(start == 31 && destination == 46)
			price = 6;
		else
		if(start == 31 && destination == 47)
			price = 6;
		else
		if(start == 31 && destination == 48)
			price = 6;
		else
		if(start == 31 && destination == 49)
			price = 5;
		else
		if(start == 31 && destination == 50)
			price = 5;
		else
		if(start == 31 && destination == 51)
			price = 5;
		else
		if(start == 31 && destination == 52)
			price = 5;
		else
		if(start == 31 && destination == 53)
			price = 5;
		else
		if(start == 31 && destination == 54)
			price = 4;
		else
		if(start == 31 && destination == 55)
			price = 4;
		else
		if(start == 31 && destination == 56)
			price = 3;
		else
		if(start == 31 && destination == 57)
			price = 3;
		else
		if(start == 31 && destination == 58)
			price = 3;
		else
		if(start == 31 && destination == 59)
			price = 3;
		else
		if(start == 31 && destination == 60)
			price = 2;
		else
		if(start == 31 && destination == 61)
			price = 2;
		else
		if(start == 31 && destination == 62)
			price = 2;
		else
		if(start == 31 && destination == 63)
			price = 3;
		else
		if(start == 31 && destination == 64)
			price = 3;
		else
		if(start == 31 && destination == 65)
			price = 3;
		else
		if(start == 31 && destination == 66)
			price = 3;
		else
		if(start == 31 && destination == 67)
			price = 4;
		else
		if(start == 31 && destination == 68)
			price = 4;
		else
		if(start == 31 && destination == 69)
			price = 4;
		else
		if(start == 31 && destination == 70)
			price = 4;
		else
		if(start == 31 && destination == 71)
			price = 5;
		else
		if(start == 31 && destination == 72)
			price = 5;
		else
		if(start == 31 && destination == 73)
			price = 5;
		else
		if(start == 31 && destination == 74)
			price = 5;
		else
		if(start == 31 && destination == 75)
			price = 6;
		else
		if(start == 31 && destination == 76)
			price = 6;
		else
		if(start == 31 && destination == 77)
			price = 3;
		else
		if(start == 31 && destination == 78)
			price = 3;
		else
		if(start == 31 && destination == 79)
			price = 3;
		else
		if(start == 31 && destination == 80)
			price = 2;
		else
		if(start == 31 && destination == 81)
			price = 3;
		else
		if(start == 31 && destination == 82)
			price = 3;
		else
		if(start == 31 && destination == 83)
			price = 3;
		else
		if(start == 31 && destination == 84)
			price = 4;
		else
		if(start == 31 && destination == 85)
			price = 4;
		else
		if(start == 31 && destination == 86)
			price = 5;
		else
		if(start == 31 && destination == 87)
			price = 5;
		else
		if(start == 31 && destination == 88)
			price = 5;
		else
		if(start == 31 && destination == 89)
			price = 6;
		else
		if(start == 31 && destination == 90)
			price = 6;
		else
		if(start == 31 && destination == 91)
			price = 6;
		else
		if(start == 31 && destination == 92)
			price = 7;
		else
		if(start == 32 && destination == 0)
			price = 3;
		else
		if(start == 32 && destination == 1)
			price = 3;
		else
		if(start == 32 && destination == 2)
			price = 3;
		else
		if(start == 32 && destination == 3)
			price = 2;
		else
		if(start == 32 && destination == 4)
			price = 2;
		else
		if(start == 32 && destination == 5)
			price = 2;
		else
		if(start == 32 && destination == 6)
			price = 2;
		else
		if(start == 32 && destination == 7)
			price = 3;
		else
		if(start == 32 && destination == 8)
			price = 3;
		else
		if(start == 32 && destination == 9)
			price = 3;
		else
		if(start == 32 && destination == 10)
			price = 4;
		else
		if(start == 32 && destination == 11)
			price = 4;
		else
		if(start == 32 && destination == 12)
			price = 4;
		else
		if(start == 32 && destination == 13)
			price = 5;
		else
		if(start == 32 && destination == 14)
			price = 5;
		else
		if(start == 32 && destination == 15)
			price = 5;
		else
		if(start == 32 && destination == 16)
			price = 5;
		else
		if(start == 32 && destination == 17)
			price = 5;
		else
		if(start == 32 && destination == 18)
			price = 5;
		else
		if(start == 32 && destination == 19)
			price = 6;
		else
		if(start == 32 && destination == 20)
			price = 6;
		else
		if(start == 32 && destination == 21)
			price = 6;
		else
		if(start == 32 && destination == 22)
			price = 7;
		else
		if(start == 32 && destination == 23)
			price = 4;
		else
		if(start == 32 && destination == 24)
			price = 4;
		else
		if(start == 32 && destination == 25)
			price = 3;
		else
		if(start == 32 && destination == 26)
			price = 3;
		else
		if(start == 32 && destination == 27)
			price = 3;
		else
		if(start == 32 && destination == 28)
			price = 3;
		else
		if(start == 32 && destination == 29)
			price = 2;
		else
		if(start == 32 && destination == 30)
			price = 2;
		else
		if(start == 32 && destination == 31)
			price = 2;
		else
		if(start == 32 && destination == 32)
			price = 0;
		else
		if(start == 32 && destination == 33)
			price = 2;
		else
		if(start == 32 && destination == 34)
			price = 2;
		else
		if(start == 32 && destination == 35)
			price = 2;
		else
		if(start == 32 && destination == 36)
			price = 3;
		else
		if(start == 32 && destination == 37)
			price = 3;
		else
		if(start == 32 && destination == 38)
			price = 3;
		else
		if(start == 32 && destination == 39)
			price = 3;
		else
		if(start == 32 && destination == 40)
			price = 4;
		else
		if(start == 32 && destination == 41)
			price = 5;
		else
		if(start == 32 && destination == 42)
			price = 5;
		else
		if(start == 32 && destination == 43)
			price = 5;
		else
		if(start == 32 && destination == 44)
			price = 5;
		else
		if(start == 32 && destination == 45)
			price = 5;
		else
		if(start == 32 && destination == 46)
			price = 6;
		else
		if(start == 32 && destination == 47)
			price = 6;
		else
		if(start == 32 && destination == 48)
			price = 6;
		else
		if(start == 32 && destination == 49)
			price = 5;
		else
		if(start == 32 && destination == 50)
			price = 5;
		else
		if(start == 32 && destination == 51)
			price = 5;
		else
		if(start == 32 && destination == 52)
			price = 5;
		else
		if(start == 32 && destination == 53)
			price = 5;
		else
		if(start == 32 && destination == 54)
			price = 4;
		else
		if(start == 32 && destination == 55)
			price = 4;
		else
		if(start == 32 && destination == 56)
			price = 3;
		else
		if(start == 32 && destination == 57)
			price = 3;
		else
		if(start == 32 && destination == 58)
			price = 3;
		else
		if(start == 32 && destination == 59)
			price = 2;
		else
		if(start == 32 && destination == 60)
			price = 2;
		else
		if(start == 32 && destination == 61)
			price = 2;
		else
		if(start == 32 && destination == 62)
			price = 2;
		else
		if(start == 32 && destination == 63)
			price = 2;
		else
		if(start == 32 && destination == 64)
			price = 3;
		else
		if(start == 32 && destination == 65)
			price = 3;
		else
		if(start == 32 && destination == 66)
			price = 3;
		else
		if(start == 32 && destination == 67)
			price = 3;
		else
		if(start == 32 && destination == 68)
			price = 4;
		else
		if(start == 32 && destination == 69)
			price = 4;
		else
		if(start == 32 && destination == 70)
			price = 4;
		else
		if(start == 32 && destination == 71)
			price = 4;
		else
		if(start == 32 && destination == 72)
			price = 5;
		else
		if(start == 32 && destination == 73)
			price = 5;
		else
		if(start == 32 && destination == 74)
			price = 5;
		else
		if(start == 32 && destination == 75)
			price = 5;
		else
		if(start == 32 && destination == 76)
			price = 6;
		else
		if(start == 32 && destination == 77)
			price = 3;
		else
		if(start == 32 && destination == 78)
			price = 3;
		else
		if(start == 32 && destination == 79)
			price = 2;
		else
		if(start == 32 && destination == 80)
			price = 2;
		else
		if(start == 32 && destination == 81)
			price = 3;
		else
		if(start == 32 && destination == 82)
			price = 3;
		else
		if(start == 32 && destination == 83)
			price = 3;
		else
		if(start == 32 && destination == 84)
			price = 3;
		else
		if(start == 32 && destination == 85)
			price = 4;
		else
		if(start == 32 && destination == 86)
			price = 5;
		else
		if(start == 32 && destination == 87)
			price = 5;
		else
		if(start == 32 && destination == 88)
			price = 5;
		else
		if(start == 32 && destination == 89)
			price = 6;
		else
		if(start == 32 && destination == 90)
			price = 6;
		else
		if(start == 32 && destination == 91)
			price = 6;
		else
		if(start == 32 && destination == 92)
			price = 7;
		else
		if(start == 33 && destination == 0)
			price = 3;
		else
		if(start == 33 && destination == 1)
			price = 3;
		else
		if(start == 33 && destination == 2)
			price = 3;
		else
		if(start == 33 && destination == 3)
			price = 2;
		else
		if(start == 33 && destination == 4)
			price = 2;
		else
		if(start == 33 && destination == 5)
			price = 2;
		else
		if(start == 33 && destination == 6)
			price = 2;
		else
		if(start == 33 && destination == 7)
			price = 2;
		else
		if(start == 33 && destination == 8)
			price = 3;
		else
		if(start == 33 && destination == 9)
			price = 3;
		else
		if(start == 33 && destination == 10)
			price = 3;
		else
		if(start == 33 && destination == 11)
			price = 4;
		else
		if(start == 33 && destination == 12)
			price = 4;
		else
		if(start == 33 && destination == 13)
			price = 4;
		else
		if(start == 33 && destination == 14)
			price = 5;
		else
		if(start == 33 && destination == 15)
			price = 5;
		else
		if(start == 33 && destination == 16)
			price = 5;
		else
		if(start == 33 && destination == 17)
			price = 5;
		else
		if(start == 33 && destination == 18)
			price = 5;
		else
		if(start == 33 && destination == 19)
			price = 6;
		else
		if(start == 33 && destination == 20)
			price = 6;
		else
		if(start == 33 && destination == 21)
			price = 6;
		else
		if(start == 33 && destination == 22)
			price = 6;
		else
		if(start == 33 && destination == 23)
			price = 4;
		else
		if(start == 33 && destination == 24)
			price = 4;
		else
		if(start == 33 && destination == 25)
			price = 4;
		else
		if(start == 33 && destination == 26)
			price = 3;
		else
		if(start == 33 && destination == 27)
			price = 3;
		else
		if(start == 33 && destination == 28)
			price = 3;
		else
		if(start == 33 && destination == 29)
			price = 2;
		else
		if(start == 33 && destination == 30)
			price = 2;
		else
		if(start == 33 && destination == 31)
			price = 2;
		else
		if(start == 33 && destination == 32)
			price = 2;
		else
		if(start == 33 && destination == 33)
			price = 0;
		else
		if(start == 33 && destination == 34)
			price = 2;
		else
		if(start == 33 && destination == 35)
			price = 2;
		else
		if(start == 33 && destination == 36)
			price = 3;
		else
		if(start == 33 && destination == 37)
			price = 3;
		else
		if(start == 33 && destination == 38)
			price = 3;
		else
		if(start == 33 && destination == 39)
			price = 3;
		else
		if(start == 33 && destination == 40)
			price = 4;
		else
		if(start == 33 && destination == 41)
			price = 4;
		else
		if(start == 33 && destination == 42)
			price = 5;
		else
		if(start == 33 && destination == 43)
			price = 5;
		else
		if(start == 33 && destination == 44)
			price = 5;
		else
		if(start == 33 && destination == 45)
			price = 5;
		else
		if(start == 33 && destination == 46)
			price = 6;
		else
		if(start == 33 && destination == 47)
			price = 6;
		else
		if(start == 33 && destination == 48)
			price = 6;
		else
		if(start == 33 && destination == 49)
			price = 5;
		else
		if(start == 33 && destination == 50)
			price = 5;
		else
		if(start == 33 && destination == 51)
			price = 5;
		else
		if(start == 33 && destination == 52)
			price = 5;
		else
		if(start == 33 && destination == 53)
			price = 4;
		else
		if(start == 33 && destination == 54)
			price = 4;
		else
		if(start == 33 && destination == 55)
			price = 4;
		else
		if(start == 33 && destination == 56)
			price = 3;
		else
		if(start == 33 && destination == 57)
			price = 3;
		else
		if(start == 33 && destination == 58)
			price = 3;
		else
		if(start == 33 && destination == 59)
			price = 2;
		else
		if(start == 33 && destination == 60)
			price = 2;
		else
		if(start == 33 && destination == 61)
			price = 2;
		else
		if(start == 33 && destination == 62)
			price = 2;
		else
		if(start == 33 && destination == 63)
			price = 2;
		else
		if(start == 33 && destination == 64)
			price = 3;
		else
		if(start == 33 && destination == 65)
			price = 3;
		else
		if(start == 33 && destination == 66)
			price = 3;
		else
		if(start == 33 && destination == 67)
			price = 3;
		else
		if(start == 33 && destination == 68)
			price = 3;
		else
		if(start == 33 && destination == 69)
			price = 4;
		else
		if(start == 33 && destination == 70)
			price = 4;
		else
		if(start == 33 && destination == 71)
			price = 4;
		else
		if(start == 33 && destination == 72)
			price = 5;
		else
		if(start == 33 && destination == 73)
			price = 5;
		else
		if(start == 33 && destination == 74)
			price = 5;
		else
		if(start == 33 && destination == 75)
			price = 5;
		else
		if(start == 33 && destination == 76)
			price = 6;
		else
		if(start == 33 && destination == 77)
			price = 3;
		else
		if(start == 33 && destination == 78)
			price = 3;
		else
		if(start == 33 && destination == 79)
			price = 2;
		else
		if(start == 33 && destination == 80)
			price = 2;
		else
		if(start == 33 && destination == 81)
			price = 2;
		else
		if(start == 33 && destination == 82)
			price = 3;
		else
		if(start == 33 && destination == 83)
			price = 3;
		else
		if(start == 33 && destination == 84)
			price = 3;
		else
		if(start == 33 && destination == 85)
			price = 4;
		else
		if(start == 33 && destination == 86)
			price = 4;
		else
		if(start == 33 && destination == 87)
			price = 5;
		else
		if(start == 33 && destination == 88)
			price = 5;
		else
		if(start == 33 && destination == 89)
			price = 5;
		else
		if(start == 33 && destination == 90)
			price = 6;
		else
		if(start == 33 && destination == 91)
			price = 6;
		else
		if(start == 33 && destination == 92)
			price = 7;
		else
		if(start == 34 && destination == 0)
			price = 4;
		else
		if(start == 34 && destination == 1)
			price = 3;
		else
		if(start == 34 && destination == 2)
			price = 3;
		else
		if(start == 34 && destination == 3)
			price = 3;
		else
		if(start == 34 && destination == 4)
			price = 2;
		else
		if(start == 34 && destination == 5)
			price = 2;
		else
		if(start == 34 && destination == 6)
			price = 2;
		else
		if(start == 34 && destination == 7)
			price = 3;
		else
		if(start == 34 && destination == 8)
			price = 3;
		else
		if(start == 34 && destination == 9)
			price = 4;
		else
		if(start == 34 && destination == 10)
			price = 4;
		else
		if(start == 34 && destination == 11)
			price = 4;
		else
		if(start == 34 && destination == 12)
			price = 4;
		else
		if(start == 34 && destination == 13)
			price = 4;
		else
		if(start == 34 && destination == 14)
			price = 5;
		else
		if(start == 34 && destination == 15)
			price = 5;
		else
		if(start == 34 && destination == 16)
			price = 5;
		else
		if(start == 34 && destination == 17)
			price = 5;
		else
		if(start == 34 && destination == 18)
			price = 5;
		else
		if(start == 34 && destination == 19)
			price = 6;
		else
		if(start == 34 && destination == 20)
			price = 6;
		else
		if(start == 34 && destination == 21)
			price = 6;
		else
		if(start == 34 && destination == 22)
			price = 6;
		else
		if(start == 34 && destination == 23)
			price = 5;
		else
		if(start == 34 && destination == 24)
			price = 4;
		else
		if(start == 34 && destination == 25)
			price = 4;
		else
		if(start == 34 && destination == 26)
			price = 4;
		else
		if(start == 34 && destination == 27)
			price = 3;
		else
		if(start == 34 && destination == 28)
			price = 3;
		else
		if(start == 34 && destination == 29)
			price = 3;
		else
		if(start == 34 && destination == 30)
			price = 3;
		else
		if(start == 34 && destination == 31)
			price = 2;
		else
		if(start == 34 && destination == 32)
			price = 2;
		else
		if(start == 34 && destination == 33)
			price = 2;
		else
		if(start == 34 && destination == 34)
			price = 0;
		else
		if(start == 34 && destination == 35)
			price = 2;
		else
		if(start == 34 && destination == 36)
			price = 2;
		else
		if(start == 34 && destination == 37)
			price = 3;
		else
		if(start == 34 && destination == 38)
			price = 3;
		else
		if(start == 34 && destination == 39)
			price = 3;
		else
		if(start == 34 && destination == 40)
			price = 3;
		else
		if(start == 34 && destination == 41)
			price = 4;
		else
		if(start == 34 && destination == 42)
			price = 4;
		else
		if(start == 34 && destination == 43)
			price = 5;
		else
		if(start == 34 && destination == 44)
			price = 5;
		else
		if(start == 34 && destination == 45)
			price = 5;
		else
		if(start == 34 && destination == 46)
			price = 5;
		else
		if(start == 34 && destination == 47)
			price = 6;
		else
		if(start == 34 && destination == 48)
			price = 6;
		else
		if(start == 34 && destination == 49)
			price = 5;
		else
		if(start == 34 && destination == 50)
			price = 5;
		else
		if(start == 34 && destination == 51)
			price = 5;
		else
		if(start == 34 && destination == 52)
			price = 5;
		else
		if(start == 34 && destination == 53)
			price = 5;
		else
		if(start == 34 && destination == 54)
			price = 4;
		else
		if(start == 34 && destination == 55)
			price = 4;
		else
		if(start == 34 && destination == 56)
			price = 3;
		else
		if(start == 34 && destination == 57)
			price = 3;
		else
		if(start == 34 && destination == 58)
			price = 3;
		else
		if(start == 34 && destination == 59)
			price = 2;
		else
		if(start == 34 && destination == 60)
			price = 2;
		else
		if(start == 34 && destination == 61)
			price = 2;
		else
		if(start == 34 && destination == 62)
			price = 2;
		else
		if(start == 34 && destination == 63)
			price = 2;
		else
		if(start == 34 && destination == 64)
			price = 3;
		else
		if(start == 34 && destination == 65)
			price = 3;
		else
		if(start == 34 && destination == 66)
			price = 3;
		else
		if(start == 34 && destination == 67)
			price = 3;
		else
		if(start == 34 && destination == 68)
			price = 3;
		else
		if(start == 34 && destination == 69)
			price = 4;
		else
		if(start == 34 && destination == 70)
			price = 4;
		else
		if(start == 34 && destination == 71)
			price = 4;
		else
		if(start == 34 && destination == 72)
			price = 5;
		else
		if(start == 34 && destination == 73)
			price = 5;
		else
		if(start == 34 && destination == 74)
			price = 5;
		else
		if(start == 34 && destination == 75)
			price = 5;
		else
		if(start == 34 && destination == 76)
			price = 6;
		else
		if(start == 34 && destination == 77)
			price = 3;
		else
		if(start == 34 && destination == 78)
			price = 3;
		else
		if(start == 34 && destination == 79)
			price = 3;
		else
		if(start == 34 && destination == 80)
			price = 2;
		else
		if(start == 34 && destination == 81)
			price = 2;
		else
		if(start == 34 && destination == 82)
			price = 3;
		else
		if(start == 34 && destination == 83)
			price = 3;
		else
		if(start == 34 && destination == 84)
			price = 3;
		else
		if(start == 34 && destination == 85)
			price = 4;
		else
		if(start == 34 && destination == 86)
			price = 4;
		else
		if(start == 34 && destination == 87)
			price = 5;
		else
		if(start == 34 && destination == 88)
			price = 5;
		else
		if(start == 34 && destination == 89)
			price = 5;
		else
		if(start == 34 && destination == 90)
			price = 5;
		else
		if(start == 34 && destination == 91)
			price = 6;
		else
		if(start == 34 && destination == 92)
			price = 6;
		else
		if(start == 35 && destination == 0)
			price = 4;
		else
		if(start == 35 && destination == 1)
			price = 4;
		else
		if(start == 35 && destination == 2)
			price = 3;
		else
		if(start == 35 && destination == 3)
			price = 3;
		else
		if(start == 35 && destination == 4)
			price = 3;
		else
		if(start == 35 && destination == 5)
			price = 3;
		else
		if(start == 35 && destination == 6)
			price = 3;
		else
		if(start == 35 && destination == 7)
			price = 3;
		else
		if(start == 35 && destination == 8)
			price = 4;
		else
		if(start == 35 && destination == 9)
			price = 4;
		else
		if(start == 35 && destination == 10)
			price = 4;
		else
		if(start == 35 && destination == 11)
			price = 4;
		else
		if(start == 35 && destination == 12)
			price = 4;
		else
		if(start == 35 && destination == 13)
			price = 5;
		else
		if(start == 35 && destination == 14)
			price = 5;
		else
		if(start == 35 && destination == 15)
			price = 5;
		else
		if(start == 35 && destination == 16)
			price = 5;
		else
		if(start == 35 && destination == 17)
			price = 5;
		else
		if(start == 35 && destination == 18)
			price = 6;
		else
		if(start == 35 && destination == 19)
			price = 6;
		else
		if(start == 35 && destination == 20)
			price = 6;
		else
		if(start == 35 && destination == 21)
			price = 6;
		else
		if(start == 35 && destination == 22)
			price = 7;
		else
		if(start == 35 && destination == 23)
			price = 5;
		else
		if(start == 35 && destination == 24)
			price = 5;
		else
		if(start == 35 && destination == 25)
			price = 4;
		else
		if(start == 35 && destination == 26)
			price = 4;
		else
		if(start == 35 && destination == 27)
			price = 4;
		else
		if(start == 35 && destination == 28)
			price = 3;
		else
		if(start == 35 && destination == 29)
			price = 3;
		else
		if(start == 35 && destination == 30)
			price = 3;
		else
		if(start == 35 && destination == 31)
			price = 3;
		else
		if(start == 35 && destination == 32)
			price = 2;
		else
		if(start == 35 && destination == 33)
			price = 2;
		else
		if(start == 35 && destination == 34)
			price = 2;
		else
		if(start == 35 && destination == 35)
			price = 0;
		else
		if(start == 35 && destination == 36)
			price = 2;
		else
		if(start == 35 && destination == 37)
			price = 2;
		else
		if(start == 35 && destination == 38)
			price = 2;
		else
		if(start == 35 && destination == 39)
			price = 3;
		else
		if(start == 35 && destination == 40)
			price = 3;
		else
		if(start == 35 && destination == 41)
			price = 4;
		else
		if(start == 35 && destination == 42)
			price = 4;
		else
		if(start == 35 && destination == 43)
			price = 4;
		else
		if(start == 35 && destination == 44)
			price = 5;
		else
		if(start == 35 && destination == 45)
			price = 5;
		else
		if(start == 35 && destination == 46)
			price = 5;
		else
		if(start == 35 && destination == 47)
			price = 5;
		else
		if(start == 35 && destination == 48)
			price = 6;
		else
		if(start == 35 && destination == 49)
			price = 6;
		else
		if(start == 35 && destination == 50)
			price = 5;
		else
		if(start == 35 && destination == 51)
			price = 5;
		else
		if(start == 35 && destination == 52)
			price = 5;
		else
		if(start == 35 && destination == 53)
			price = 5;
		else
		if(start == 35 && destination == 54)
			price = 4;
		else
		if(start == 35 && destination == 55)
			price = 4;
		else
		if(start == 35 && destination == 56)
			price = 4;
		else
		if(start == 35 && destination == 57)
			price = 3;
		else
		if(start == 35 && destination == 58)
			price = 3;
		else
		if(start == 35 && destination == 59)
			price = 2;
		else
		if(start == 35 && destination == 60)
			price = 2;
		else
		if(start == 35 && destination == 61)
			price = 2;
		else
		if(start == 35 && destination == 62)
			price = 2;
		else
		if(start == 35 && destination == 63)
			price = 3;
		else
		if(start == 35 && destination == 64)
			price = 3;
		else
		if(start == 35 && destination == 65)
			price = 3;
		else
		if(start == 35 && destination == 66)
			price = 3;
		else
		if(start == 35 && destination == 67)
			price = 3;
		else
		if(start == 35 && destination == 68)
			price = 4;
		else
		if(start == 35 && destination == 69)
			price = 4;
		else
		if(start == 35 && destination == 70)
			price = 4;
		else
		if(start == 35 && destination == 71)
			price = 5;
		else
		if(start == 35 && destination == 72)
			price = 5;
		else
		if(start == 35 && destination == 73)
			price = 5;
		else
		if(start == 35 && destination == 74)
			price = 5;
		else
		if(start == 35 && destination == 75)
			price = 6;
		else
		if(start == 35 && destination == 76)
			price = 6;
		else
		if(start == 35 && destination == 77)
			price = 4;
		else
		if(start == 35 && destination == 78)
			price = 3;
		else
		if(start == 35 && destination == 79)
			price = 3;
		else
		if(start == 35 && destination == 80)
			price = 3;
		else
		if(start == 35 && destination == 81)
			price = 3;
		else
		if(start == 35 && destination == 82)
			price = 3;
		else
		if(start == 35 && destination == 83)
			price = 3;
		else
		if(start == 35 && destination == 84)
			price = 4;
		else
		if(start == 35 && destination == 85)
			price = 4;
		else
		if(start == 35 && destination == 86)
			price = 4;
		else
		if(start == 35 && destination == 87)
			price = 4;
		else
		if(start == 35 && destination == 88)
			price = 5;
		else
		if(start == 35 && destination == 89)
			price = 5;
		else
		if(start == 35 && destination == 90)
			price = 5;
		else
		if(start == 35 && destination == 91)
			price = 6;
		else
		if(start == 35 && destination == 92)
			price = 6;
		else
		if(start == 36 && destination == 0)
			price = 4;
		else
		if(start == 36 && destination == 1)
			price = 4;
		else
		if(start == 36 && destination == 2)
			price = 4;
		else
		if(start == 36 && destination == 3)
			price = 3;
		else
		if(start == 36 && destination == 4)
			price = 3;
		else
		if(start == 36 && destination == 5)
			price = 3;
		else
		if(start == 36 && destination == 6)
			price = 3;
		else
		if(start == 36 && destination == 7)
			price = 3;
		else
		if(start == 36 && destination == 8)
			price = 4;
		else
		if(start == 36 && destination == 9)
			price = 4;
		else
		if(start == 36 && destination == 10)
			price = 4;
		else
		if(start == 36 && destination == 11)
			price = 5;
		else
		if(start == 36 && destination == 12)
			price = 5;
		else
		if(start == 36 && destination == 13)
			price = 5;
		else
		if(start == 36 && destination == 14)
			price = 5;
		else
		if(start == 36 && destination == 15)
			price = 5;
		else
		if(start == 36 && destination == 16)
			price = 5;
		else
		if(start == 36 && destination == 17)
			price = 6;
		else
		if(start == 36 && destination == 18)
			price = 6;
		else
		if(start == 36 && destination == 19)
			price = 6;
		else
		if(start == 36 && destination == 20)
			price = 6;
		else
		if(start == 36 && destination == 21)
			price = 7;
		else
		if(start == 36 && destination == 22)
			price = 7;
		else
		if(start == 36 && destination == 23)
			price = 5;
		else
		if(start == 36 && destination == 24)
			price = 5;
		else
		if(start == 36 && destination == 25)
			price = 5;
		else
		if(start == 36 && destination == 26)
			price = 4;
		else
		if(start == 36 && destination == 27)
			price = 4;
		else
		if(start == 36 && destination == 28)
			price = 4;
		else
		if(start == 36 && destination == 29)
			price = 3;
		else
		if(start == 36 && destination == 30)
			price = 3;
		else
		if(start == 36 && destination == 31)
			price = 3;
		else
		if(start == 36 && destination == 32)
			price = 3;
		else
		if(start == 36 && destination == 33)
			price = 3;
		else
		if(start == 36 && destination == 34)
			price = 2;
		else
		if(start == 36 && destination == 35)
			price = 2;
		else
		if(start == 36 && destination == 36)
			price = 0;
		else
		if(start == 36 && destination == 37)
			price = 2;
		else
		if(start == 36 && destination == 38)
			price = 2;
		else
		if(start == 36 && destination == 39)
			price = 2;
		else
		if(start == 36 && destination == 40)
			price = 3;
		else
		if(start == 36 && destination == 41)
			price = 4;
		else
		if(start == 36 && destination == 42)
			price = 4;
		else
		if(start == 36 && destination == 43)
			price = 4;
		else
		if(start == 36 && destination == 44)
			price = 4;
		else
		if(start == 36 && destination == 45)
			price = 5;
		else
		if(start == 36 && destination == 46)
			price = 5;
		else
		if(start == 36 && destination == 47)
			price = 5;
		else
		if(start == 36 && destination == 48)
			price = 6;
		else
		if(start == 36 && destination == 49)
			price = 6;
		else
		if(start == 36 && destination == 50)
			price = 6;
		else
		if(start == 36 && destination == 51)
			price = 6;
		else
		if(start == 36 && destination == 52)
			price = 5;
		else
		if(start == 36 && destination == 53)
			price = 5;
		else
		if(start == 36 && destination == 54)
			price = 5;
		else
		if(start == 36 && destination == 55)
			price = 4;
		else
		if(start == 36 && destination == 56)
			price = 4;
		else
		if(start == 36 && destination == 57)
			price = 4;
		else
		if(start == 36 && destination == 58)
			price = 3;
		else
		if(start == 36 && destination == 59)
			price = 3;
		else
		if(start == 36 && destination == 60)
			price = 3;
		else
		if(start == 36 && destination == 61)
			price = 2;
		else
		if(start == 36 && destination == 62)
			price = 3;
		else
		if(start == 36 && destination == 63)
			price = 3;
		else
		if(start == 36 && destination == 64)
			price = 3;
		else
		if(start == 36 && destination == 65)
			price = 3;
		else
		if(start == 36 && destination == 66)
			price = 4;
		else
		if(start == 36 && destination == 67)
			price = 4;
		else
		if(start == 36 && destination == 68)
			price = 4;
		else
		if(start == 36 && destination == 69)
			price = 4;
		else
		if(start == 36 && destination == 70)
			price = 4;
		else
		if(start == 36 && destination == 71)
			price = 5;
		else
		if(start == 36 && destination == 72)
			price = 5;
		else
		if(start == 36 && destination == 73)
			price = 5;
		else
		if(start == 36 && destination == 74)
			price = 6;
		else
		if(start == 36 && destination == 75)
			price = 6;
		else
		if(start == 36 && destination == 76)
			price = 6;
		else
		if(start == 36 && destination == 77)
			price = 4;
		else
		if(start == 36 && destination == 78)
			price = 4;
		else
		if(start == 36 && destination == 79)
			price = 3;
		else
		if(start == 36 && destination == 80)
			price = 3;
		else
		if(start == 36 && destination == 81)
			price = 3;
		else
		if(start == 36 && destination == 82)
			price = 3;
		else
		if(start == 36 && destination == 83)
			price = 4;
		else
		if(start == 36 && destination == 84)
			price = 4;
		else
		if(start == 36 && destination == 85)
			price = 4;
		else
		if(start == 36 && destination == 86)
			price = 4;
		else
		if(start == 36 && destination == 87)
			price = 4;
		else
		if(start == 36 && destination == 88)
			price = 4;
		else
		if(start == 36 && destination == 89)
			price = 5;
		else
		if(start == 36 && destination == 90)
			price = 5;
		else
		if(start == 36 && destination == 91)
			price = 5;
		else
		if(start == 36 && destination == 92)
			price = 6;
		else
		if(start == 37 && destination == 0)
			price = 4;
		else
		if(start == 37 && destination == 1)
			price = 4;
		else
		if(start == 37 && destination == 2)
			price = 4;
		else
		if(start == 37 && destination == 3)
			price = 4;
		else
		if(start == 37 && destination == 4)
			price = 3;
		else
		if(start == 37 && destination == 5)
			price = 3;
		else
		if(start == 37 && destination == 6)
			price = 3;
		else
		if(start == 37 && destination == 7)
			price = 4;
		else
		if(start == 37 && destination == 8)
			price = 4;
		else
		if(start == 37 && destination == 9)
			price = 4;
		else
		if(start == 37 && destination == 10)
			price = 5;
		else
		if(start == 37 && destination == 11)
			price = 5;
		else
		if(start == 37 && destination == 12)
			price = 5;
		else
		if(start == 37 && destination == 13)
			price = 5;
		else
		if(start == 37 && destination == 14)
			price = 5;
		else
		if(start == 37 && destination == 15)
			price = 5;
		else
		if(start == 37 && destination == 16)
			price = 6;
		else
		if(start == 37 && destination == 17)
			price = 6;
		else
		if(start == 37 && destination == 18)
			price = 6;
		else
		if(start == 37 && destination == 19)
			price = 6;
		else
		if(start == 37 && destination == 20)
			price = 6;
		else
		if(start == 37 && destination == 21)
			price = 7;
		else
		if(start == 37 && destination == 22)
			price = 7;
		else
		if(start == 37 && destination == 23)
			price = 5;
		else
		if(start == 37 && destination == 24)
			price = 5;
		else
		if(start == 37 && destination == 25)
			price = 5;
		else
		if(start == 37 && destination == 26)
			price = 5;
		else
		if(start == 37 && destination == 27)
			price = 4;
		else
		if(start == 37 && destination == 28)
			price = 4;
		else
		if(start == 37 && destination == 29)
			price = 4;
		else
		if(start == 37 && destination == 30)
			price = 3;
		else
		if(start == 37 && destination == 31)
			price = 3;
		else
		if(start == 37 && destination == 32)
			price = 3;
		else
		if(start == 37 && destination == 33)
			price = 3;
		else
		if(start == 37 && destination == 34)
			price = 3;
		else
		if(start == 37 && destination == 35)
			price = 2;
		else
		if(start == 37 && destination == 36)
			price = 2;
		else
		if(start == 37 && destination == 37)
			price = 0;
		else
		if(start == 37 && destination == 38)
			price = 2;
		else
		if(start == 37 && destination == 39)
			price = 2;
		else
		if(start == 37 && destination == 40)
			price = 3;
		else
		if(start == 37 && destination == 41)
			price = 3;
		else
		if(start == 37 && destination == 42)
			price = 4;
		else
		if(start == 37 && destination == 43)
			price = 4;
		else
		if(start == 37 && destination == 44)
			price = 4;
		else
		if(start == 37 && destination == 45)
			price = 4;
		else
		if(start == 37 && destination == 46)
			price = 5;
		else
		if(start == 37 && destination == 47)
			price = 5;
		else
		if(start == 37 && destination == 48)
			price = 6;
		else
		if(start == 37 && destination == 49)
			price = 6;
		else
		if(start == 37 && destination == 50)
			price = 6;
		else
		if(start == 37 && destination == 51)
			price = 6;
		else
		if(start == 37 && destination == 52)
			price = 6;
		else
		if(start == 37 && destination == 53)
			price = 5;
		else
		if(start == 37 && destination == 54)
			price = 5;
		else
		if(start == 37 && destination == 55)
			price = 5;
		else
		if(start == 37 && destination == 56)
			price = 4;
		else
		if(start == 37 && destination == 57)
			price = 4;
		else
		if(start == 37 && destination == 58)
			price = 4;
		else
		if(start == 37 && destination == 59)
			price = 3;
		else
		if(start == 37 && destination == 60)
			price = 3;
		else
		if(start == 37 && destination == 61)
			price = 3;
		else
		if(start == 37 && destination == 62)
			price = 3;
		else
		if(start == 37 && destination == 63)
			price = 3;
		else
		if(start == 37 && destination == 64)
			price = 3;
		else
		if(start == 37 && destination == 65)
			price = 4;
		else
		if(start == 37 && destination == 66)
			price = 4;
		else
		if(start == 37 && destination == 67)
			price = 4;
		else
		if(start == 37 && destination == 68)
			price = 4;
		else
		if(start == 37 && destination == 69)
			price = 4;
		else
		if(start == 37 && destination == 70)
			price = 5;
		else
		if(start == 37 && destination == 71)
			price = 5;
		else
		if(start == 37 && destination == 72)
			price = 5;
		else
		if(start == 37 && destination == 73)
			price = 6;
		else
		if(start == 37 && destination == 74)
			price = 6;
		else
		if(start == 37 && destination == 75)
			price = 6;
		else
		if(start == 37 && destination == 76)
			price = 6;
		else
		if(start == 37 && destination == 77)
			price = 4;
		else
		if(start == 37 && destination == 78)
			price = 4;
		else
		if(start == 37 && destination == 79)
			price = 3;
		else
		if(start == 37 && destination == 80)
			price = 3;
		else
		if(start == 37 && destination == 81)
			price = 3;
		else
		if(start == 37 && destination == 82)
			price = 3;
		else
		if(start == 37 && destination == 83)
			price = 4;
		else
		if(start == 37 && destination == 84)
			price = 4;
		else
		if(start == 37 && destination == 85)
			price = 4;
		else
		if(start == 37 && destination == 86)
			price = 4;
		else
		if(start == 37 && destination == 87)
			price = 4;
		else
		if(start == 37 && destination == 88)
			price = 4;
		else
		if(start == 37 && destination == 89)
			price = 5;
		else
		if(start == 37 && destination == 90)
			price = 5;
		else
		if(start == 37 && destination == 91)
			price = 5;
		else
		if(start == 37 && destination == 92)
			price = 6;
		else
		if(start == 38 && destination == 0)
			price = 5;
		else
		if(start == 38 && destination == 1)
			price = 4;
		else
		if(start == 38 && destination == 2)
			price = 4;
		else
		if(start == 38 && destination == 3)
			price = 4;
		else
		if(start == 38 && destination == 4)
			price = 3;
		else
		if(start == 38 && destination == 5)
			price = 3;
		else
		if(start == 38 && destination == 6)
			price = 4;
		else
		if(start == 38 && destination == 7)
			price = 4;
		else
		if(start == 38 && destination == 8)
			price = 4;
		else
		if(start == 38 && destination == 9)
			price = 5;
		else
		if(start == 38 && destination == 10)
			price = 5;
		else
		if(start == 38 && destination == 11)
			price = 5;
		else
		if(start == 38 && destination == 12)
			price = 5;
		else
		if(start == 38 && destination == 13)
			price = 5;
		else
		if(start == 38 && destination == 14)
			price = 5;
		else
		if(start == 38 && destination == 15)
			price = 5;
		else
		if(start == 38 && destination == 16)
			price = 6;
		else
		if(start == 38 && destination == 17)
			price = 6;
		else
		if(start == 38 && destination == 18)
			price = 6;
		else
		if(start == 38 && destination == 19)
			price = 6;
		else
		if(start == 38 && destination == 20)
			price = 7;
		else
		if(start == 38 && destination == 21)
			price = 7;
		else
		if(start == 38 && destination == 22)
			price = 7;
		else
		if(start == 38 && destination == 23)
			price = 5;
		else
		if(start == 38 && destination == 24)
			price = 5;
		else
		if(start == 38 && destination == 25)
			price = 5;
		else
		if(start == 38 && destination == 26)
			price = 5;
		else
		if(start == 38 && destination == 27)
			price = 4;
		else
		if(start == 38 && destination == 28)
			price = 4;
		else
		if(start == 38 && destination == 29)
			price = 4;
		else
		if(start == 38 && destination == 30)
			price = 4;
		else
		if(start == 38 && destination == 31)
			price = 3;
		else
		if(start == 38 && destination == 32)
			price = 3;
		else
		if(start == 38 && destination == 33)
			price = 3;
		else
		if(start == 38 && destination == 34)
			price = 3;
		else
		if(start == 38 && destination == 35)
			price = 2;
		else
		if(start == 38 && destination == 36)
			price = 2;
		else
		if(start == 38 && destination == 37)
			price = 2;
		else
		if(start == 38 && destination == 38)
			price = 0;
		else
		if(start == 38 && destination == 39)
			price = 2;
		else
		if(start == 38 && destination == 40)
			price = 2;
		else
		if(start == 38 && destination == 41)
			price = 3;
		else
		if(start == 38 && destination == 42)
			price = 3;
		else
		if(start == 38 && destination == 43)
			price = 4;
		else
		if(start == 38 && destination == 44)
			price = 4;
		else
		if(start == 38 && destination == 45)
			price = 4;
		else
		if(start == 38 && destination == 46)
			price = 5;
		else
		if(start == 38 && destination == 47)
			price = 5;
		else
		if(start == 38 && destination == 48)
			price = 7;
		else
		if(start == 38 && destination == 49)
			price = 6;
		else
		if(start == 38 && destination == 50)
			price = 6;
		else
		if(start == 38 && destination == 51)
			price = 6;
		else
		if(start == 38 && destination == 52)
			price = 6;
		else
		if(start == 38 && destination == 53)
			price = 5;
		else
		if(start == 38 && destination == 54)
			price = 5;
		else
		if(start == 38 && destination == 55)
			price = 5;
		else
		if(start == 38 && destination == 56)
			price = 4;
		else
		if(start == 38 && destination == 57)
			price = 4;
		else
		if(start == 38 && destination == 58)
			price = 4;
		else
		if(start == 38 && destination == 59)
			price = 3;
		else
		if(start == 38 && destination == 60)
			price = 3;
		else
		if(start == 38 && destination == 61)
			price = 3;
		else
		if(start == 38 && destination == 62)
			price = 3;
		else
		if(start == 38 && destination == 63)
			price = 3;
		else
		if(start == 38 && destination == 64)
			price = 4;
		else
		if(start == 38 && destination == 65)
			price = 4;
		else
		if(start == 38 && destination == 66)
			price = 4;
		else
		if(start == 38 && destination == 67)
			price = 4;
		else
		if(start == 38 && destination == 68)
			price = 4;
		else
		if(start == 38 && destination == 69)
			price = 5;
		else
		if(start == 38 && destination == 70)
			price = 5;
		else
		if(start == 38 && destination == 71)
			price = 5;
		else
		if(start == 38 && destination == 72)
			price = 5;
		else
		if(start == 38 && destination == 73)
			price = 6;
		else
		if(start == 38 && destination == 74)
			price = 6;
		else
		if(start == 38 && destination == 75)
			price = 6;
		else
		if(start == 38 && destination == 76)
			price = 6;
		else
		if(start == 38 && destination == 77)
			price = 4;
		else
		if(start == 38 && destination == 78)
			price = 4;
		else
		if(start == 38 && destination == 79)
			price = 4;
		else
		if(start == 38 && destination == 80)
			price = 4;
		else
		if(start == 38 && destination == 81)
			price = 3;
		else
		if(start == 38 && destination == 82)
			price = 4;
		else
		if(start == 38 && destination == 83)
			price = 4;
		else
		if(start == 38 && destination == 84)
			price = 4;
		else
		if(start == 38 && destination == 85)
			price = 4;
		else
		if(start == 38 && destination == 86)
			price = 4;
		else
		if(start == 38 && destination == 87)
			price = 4;
		else
		if(start == 38 && destination == 88)
			price = 4;
		else
		if(start == 38 && destination == 89)
			price = 4;
		else
		if(start == 38 && destination == 90)
			price = 5;
		else
		if(start == 38 && destination == 91)
			price = 5;
		else
		if(start == 38 && destination == 92)
			price = 6;
		else
		if(start == 39 && destination == 0)
			price = 5;
		else
		if(start == 39 && destination == 1)
			price = 5;
		else
		if(start == 39 && destination == 2)
			price = 4;
		else
		if(start == 39 && destination == 3)
			price = 4;
		else
		if(start == 39 && destination == 4)
			price = 4;
		else
		if(start == 39 && destination == 5)
			price = 4;
		else
		if(start == 39 && destination == 6)
			price = 4;
		else
		if(start == 39 && destination == 7)
			price = 4;
		else
		if(start == 39 && destination == 8)
			price = 5;
		else
		if(start == 39 && destination == 9)
			price = 5;
		else
		if(start == 39 && destination == 10)
			price = 5;
		else
		if(start == 39 && destination == 11)
			price = 5;
		else
		if(start == 39 && destination == 12)
			price = 5;
		else
		if(start == 39 && destination == 13)
			price = 5;
		else
		if(start == 39 && destination == 14)
			price = 5;
		else
		if(start == 39 && destination == 15)
			price = 6;
		else
		if(start == 39 && destination == 16)
			price = 6;
		else
		if(start == 39 && destination == 17)
			price = 6;
		else
		if(start == 39 && destination == 18)
			price = 6;
		else
		if(start == 39 && destination == 19)
			price = 6;
		else
		if(start == 39 && destination == 20)
			price = 7;
		else
		if(start == 39 && destination == 21)
			price = 7;
		else
		if(start == 39 && destination == 22)
			price = 7;
		else
		if(start == 39 && destination == 23)
			price = 6;
		else
		if(start == 39 && destination == 24)
			price = 5;
		else
		if(start == 39 && destination == 25)
			price = 5;
		else
		if(start == 39 && destination == 26)
			price = 5;
		else
		if(start == 39 && destination == 27)
			price = 5;
		else
		if(start == 39 && destination == 28)
			price = 4;
		else
		if(start == 39 && destination == 29)
			price = 4;
		else
		if(start == 39 && destination == 30)
			price = 4;
		else
		if(start == 39 && destination == 31)
			price = 4;
		else
		if(start == 39 && destination == 32)
			price = 3;
		else
		if(start == 39 && destination == 33)
			price = 3;
		else
		if(start == 39 && destination == 34)
			price = 3;
		else
		if(start == 39 && destination == 35)
			price = 3;
		else
		if(start == 39 && destination == 36)
			price = 2;
		else
		if(start == 39 && destination == 37)
			price = 2;
		else
		if(start == 39 && destination == 38)
			price = 2;
		else
		if(start == 39 && destination == 39)
			price = 0;
		else
		if(start == 39 && destination == 40)
			price = 2;
		else
		if(start == 39 && destination == 41)
			price = 3;
		else
		if(start == 39 && destination == 42)
			price = 3;
		else
		if(start == 39 && destination == 43)
			price = 3;
		else
		if(start == 39 && destination == 44)
			price = 4;
		else
		if(start == 39 && destination == 45)
			price = 4;
		else
		if(start == 39 && destination == 46)
			price = 4;
		else
		if(start == 39 && destination == 47)
			price = 5;
		else
		if(start == 39 && destination == 48)
			price = 7;
		else
		if(start == 39 && destination == 49)
			price = 6;
		else
		if(start == 39 && destination == 50)
			price = 6;
		else
		if(start == 39 && destination == 51)
			price = 6;
		else
		if(start == 39 && destination == 52)
			price = 6;
		else
		if(start == 39 && destination == 53)
			price = 6;
		else
		if(start == 39 && destination == 54)
			price = 5;
		else
		if(start == 39 && destination == 55)
			price = 5;
		else
		if(start == 39 && destination == 56)
			price = 5;
		else
		if(start == 39 && destination == 57)
			price = 4;
		else
		if(start == 39 && destination == 58)
			price = 4;
		else
		if(start == 39 && destination == 59)
			price = 3;
		else
		if(start == 39 && destination == 60)
			price = 3;
		else
		if(start == 39 && destination == 61)
			price = 3;
		else
		if(start == 39 && destination == 62)
			price = 3;
		else
		if(start == 39 && destination == 63)
			price = 4;
		else
		if(start == 39 && destination == 64)
			price = 4;
		else
		if(start == 39 && destination == 65)
			price = 4;
		else
		if(start == 39 && destination == 66)
			price = 4;
		else
		if(start == 39 && destination == 67)
			price = 4;
		else
		if(start == 39 && destination == 68)
			price = 5;
		else
		if(start == 39 && destination == 69)
			price = 5;
		else
		if(start == 39 && destination == 70)
			price = 5;
		else
		if(start == 39 && destination == 71)
			price = 5;
		else
		if(start == 39 && destination == 72)
			price = 5;
		else
		if(start == 39 && destination == 73)
			price = 6;
		else
		if(start == 39 && destination == 74)
			price = 6;
		else
		if(start == 39 && destination == 75)
			price = 6;
		else
		if(start == 39 && destination == 76)
			price = 7;
		else
		if(start == 39 && destination == 77)
			price = 5;
		else
		if(start == 39 && destination == 78)
			price = 4;
		else
		if(start == 39 && destination == 79)
			price = 4;
		else
		if(start == 39 && destination == 80)
			price = 4;
		else
		if(start == 39 && destination == 81)
			price = 4;
		else
		if(start == 39 && destination == 82)
			price = 4;
		else
		if(start == 39 && destination == 83)
			price = 4;
		else
		if(start == 39 && destination == 84)
			price = 4;
		else
		if(start == 39 && destination == 85)
			price = 4;
		else
		if(start == 39 && destination == 86)
			price = 3;
		else
		if(start == 39 && destination == 87)
			price = 3;
		else
		if(start == 39 && destination == 88)
			price = 4;
		else
		if(start == 39 && destination == 89)
			price = 4;
		else
		if(start == 39 && destination == 90)
			price = 5;
		else
		if(start == 39 && destination == 91)
			price = 5;
		else
		if(start == 39 && destination == 92)
			price = 5;
		else
		if(start == 40 && destination == 0)
			price = 5;
		else
		if(start == 40 && destination == 1)
			price = 5;
		else
		if(start == 40 && destination == 2)
			price = 5;
		else
		if(start == 40 && destination == 3)
			price = 5;
		else
		if(start == 40 && destination == 4)
			price = 4;
		else
		if(start == 40 && destination == 5)
			price = 4;
		else
		if(start == 40 && destination == 6)
			price = 4;
		else
		if(start == 40 && destination == 7)
			price = 5;
		else
		if(start == 40 && destination == 8)
			price = 5;
		else
		if(start == 40 && destination == 9)
			price = 5;
		else
		if(start == 40 && destination == 10)
			price = 5;
		else
		if(start == 40 && destination == 11)
			price = 5;
		else
		if(start == 40 && destination == 12)
			price = 6;
		else
		if(start == 40 && destination == 13)
			price = 6;
		else
		if(start == 40 && destination == 14)
			price = 6;
		else
		if(start == 40 && destination == 15)
			price = 6;
		else
		if(start == 40 && destination == 16)
			price = 6;
		else
		if(start == 40 && destination == 17)
			price = 6;
		else
		if(start == 40 && destination == 18)
			price = 7;
		else
		if(start == 40 && destination == 19)
			price = 7;
		else
		if(start == 40 && destination == 20)
			price = 7;
		else
		if(start == 40 && destination == 21)
			price = 7;
		else
		if(start == 40 && destination == 22)
			price = 7;
		else
		if(start == 40 && destination == 23)
			price = 6;
		else
		if(start == 40 && destination == 24)
			price = 6;
		else
		if(start == 40 && destination == 25)
			price = 5;
		else
		if(start == 40 && destination == 26)
			price = 5;
		else
		if(start == 40 && destination == 27)
			price = 5;
		else
		if(start == 40 && destination == 28)
			price = 5;
		else
		if(start == 40 && destination == 29)
			price = 5;
		else
		if(start == 40 && destination == 30)
			price = 4;
		else
		if(start == 40 && destination == 31)
			price = 4;
		else
		if(start == 40 && destination == 32)
			price = 4;
		else
		if(start == 40 && destination == 33)
			price = 4;
		else
		if(start == 40 && destination == 34)
			price = 3;
		else
		if(start == 40 && destination == 35)
			price = 3;
		else
		if(start == 40 && destination == 36)
			price = 3;
		else
		if(start == 40 && destination == 37)
			price = 3;
		else
		if(start == 40 && destination == 38)
			price = 2;
		else
		if(start == 40 && destination == 39)
			price = 2;
		else
		if(start == 40 && destination == 40)
			price = 0;
		else
		if(start == 40 && destination == 41)
			price = 2;
		else
		if(start == 40 && destination == 42)
			price = 3;
		else
		if(start == 40 && destination == 43)
			price = 3;
		else
		if(start == 40 && destination == 44)
			price = 3;
		else
		if(start == 40 && destination == 45)
			price = 3;
		else
		if(start == 40 && destination == 46)
			price = 4;
		else
		if(start == 40 && destination == 47)
			price = 4;
		else
		if(start == 40 && destination == 48)
			price = 7;
		else
		if(start == 40 && destination == 49)
			price = 7;
		else
		if(start == 40 && destination == 50)
			price = 7;
		else
		if(start == 40 && destination == 51)
			price = 6;
		else
		if(start == 40 && destination == 52)
			price = 6;
		else
		if(start == 40 && destination == 53)
			price = 6;
		else
		if(start == 40 && destination == 54)
			price = 5;
		else
		if(start == 40 && destination == 55)
			price = 5;
		else
		if(start == 40 && destination == 56)
			price = 5;
		else
		if(start == 40 && destination == 57)
			price = 5;
		else
		if(start == 40 && destination == 58)
			price = 5;
		else
		if(start == 40 && destination == 59)
			price = 4;
		else
		if(start == 40 && destination == 60)
			price = 4;
		else
		if(start == 40 && destination == 61)
			price = 4;
		else
		if(start == 40 && destination == 62)
			price = 4;
		else
		if(start == 40 && destination == 63)
			price = 4;
		else
		if(start == 40 && destination == 64)
			price = 4;
		else
		if(start == 40 && destination == 65)
			price = 5;
		else
		if(start == 40 && destination == 66)
			price = 5;
		else
		if(start == 40 && destination == 67)
			price = 5;
		else
		if(start == 40 && destination == 68)
			price = 5;
		else
		if(start == 40 && destination == 69)
			price = 5;
		else
		if(start == 40 && destination == 70)
			price = 5;
		else
		if(start == 40 && destination == 71)
			price = 6;
		else
		if(start == 40 && destination == 72)
			price = 6;
		else
		if(start == 40 && destination == 73)
			price = 6;
		else
		if(start == 40 && destination == 74)
			price = 6;
		else
		if(start == 40 && destination == 75)
			price = 7;
		else
		if(start == 40 && destination == 76)
			price = 7;
		else
		if(start == 40 && destination == 77)
			price = 5;
		else
		if(start == 40 && destination == 78)
			price = 5;
		else
		if(start == 40 && destination == 79)
			price = 4;
		else
		if(start == 40 && destination == 80)
			price = 4;
		else
		if(start == 40 && destination == 81)
			price = 4;
		else
		if(start == 40 && destination == 82)
			price = 4;
		else
		if(start == 40 && destination == 83)
			price = 4;
		else
		if(start == 40 && destination == 84)
			price = 4;
		else
		if(start == 40 && destination == 85)
			price = 3;
		else
		if(start == 40 && destination == 86)
			price = 3;
		else
		if(start == 40 && destination == 87)
			price = 3;
		else
		if(start == 40 && destination == 88)
			price = 3;
		else
		if(start == 40 && destination == 89)
			price = 4;
		else
		if(start == 40 && destination == 90)
			price = 4;
		else
		if(start == 40 && destination == 91)
			price = 4;
		else
		if(start == 40 && destination == 92)
			price = 5;
		else
		if(start == 41 && destination == 0)
			price = 5;
		else
		if(start == 41 && destination == 1)
			price = 5;
		else
		if(start == 41 && destination == 2)
			price = 5;
		else
		if(start == 41 && destination == 3)
			price = 5;
		else
		if(start == 41 && destination == 4)
			price = 5;
		else
		if(start == 41 && destination == 5)
			price = 5;
		else
		if(start == 41 && destination == 6)
			price = 5;
		else
		if(start == 41 && destination == 7)
			price = 5;
		else
		if(start == 41 && destination == 8)
			price = 5;
		else
		if(start == 41 && destination == 9)
			price = 6;
		else
		if(start == 41 && destination == 10)
			price = 6;
		else
		if(start == 41 && destination == 11)
			price = 6;
		else
		if(start == 41 && destination == 12)
			price = 6;
		else
		if(start == 41 && destination == 13)
			price = 6;
		else
		if(start == 41 && destination == 14)
			price = 6;
		else
		if(start == 41 && destination == 15)
			price = 6;
		else
		if(start == 41 && destination == 16)
			price = 7;
		else
		if(start == 41 && destination == 17)
			price = 7;
		else
		if(start == 41 && destination == 18)
			price = 7;
		else
		if(start == 41 && destination == 19)
			price = 7;
		else
		if(start == 41 && destination == 20)
			price = 7;
		else
		if(start == 41 && destination == 21)
			price = 8;
		else
		if(start == 41 && destination == 22)
			price = 8;
		else
		if(start == 41 && destination == 23)
			price = 6;
		else
		if(start == 41 && destination == 24)
			price = 6;
		else
		if(start == 41 && destination == 25)
			price = 6;
		else
		if(start == 41 && destination == 26)
			price = 6;
		else
		if(start == 41 && destination == 27)
			price = 5;
		else
		if(start == 41 && destination == 28)
			price = 5;
		else
		if(start == 41 && destination == 29)
			price = 5;
		else
		if(start == 41 && destination == 30)
			price = 5;
		else
		if(start == 41 && destination == 31)
			price = 5;
		else
		if(start == 41 && destination == 32)
			price = 5;
		else
		if(start == 41 && destination == 33)
			price = 4;
		else
		if(start == 41 && destination == 34)
			price = 4;
		else
		if(start == 41 && destination == 35)
			price = 4;
		else
		if(start == 41 && destination == 36)
			price = 4;
		else
		if(start == 41 && destination == 37)
			price = 3;
		else
		if(start == 41 && destination == 38)
			price = 3;
		else
		if(start == 41 && destination == 39)
			price = 3;
		else
		if(start == 41 && destination == 40)
			price = 2;
		else
		if(start == 41 && destination == 41)
			price = 0;
		else
		if(start == 41 && destination == 42)
			price = 2;
		else
		if(start == 41 && destination == 43)
			price = 2;
		else
		if(start == 41 && destination == 44)
			price = 3;
		else
		if(start == 41 && destination == 45)
			price = 3;
		else
		if(start == 41 && destination == 46)
			price = 3;
		else
		if(start == 41 && destination == 47)
			price = 4;
		else
		if(start == 41 && destination == 48)
			price = 7;
		else
		if(start == 41 && destination == 49)
			price = 7;
		else
		if(start == 41 && destination == 50)
			price = 7;
		else
		if(start == 41 && destination == 51)
			price = 7;
		else
		if(start == 41 && destination == 52)
			price = 6;
		else
		if(start == 41 && destination == 53)
			price = 6;
		else
		if(start == 41 && destination == 54)
			price = 6;
		else
		if(start == 41 && destination == 55)
			price = 6;
		else
		if(start == 41 && destination == 56)
			price = 5;
		else
		if(start == 41 && destination == 57)
			price = 5;
		else
		if(start == 41 && destination == 58)
			price = 5;
		else
		if(start == 41 && destination == 59)
			price = 4;
		else
		if(start == 41 && destination == 60)
			price = 4;
		else
		if(start == 41 && destination == 61)
			price = 4;
		else
		if(start == 41 && destination == 62)
			price = 4;
		else
		if(start == 41 && destination == 63)
			price = 5;
		else
		if(start == 41 && destination == 64)
			price = 5;
		else
		if(start == 41 && destination == 65)
			price = 5;
		else
		if(start == 41 && destination == 66)
			price = 5;
		else
		if(start == 41 && destination == 67)
			price = 5;
		else
		if(start == 41 && destination == 68)
			price = 5;
		else
		if(start == 41 && destination == 69)
			price = 6;
		else
		if(start == 41 && destination == 70)
			price = 6;
		else
		if(start == 41 && destination == 71)
			price = 6;
		else
		if(start == 41 && destination == 72)
			price = 6;
		else
		if(start == 41 && destination == 73)
			price = 7;
		else
		if(start == 41 && destination == 74)
			price = 7;
		else
		if(start == 41 && destination == 75)
			price = 7;
		else
		if(start == 41 && destination == 76)
			price = 7;
		else
		if(start == 41 && destination == 77)
			price = 5;
		else
		if(start == 41 && destination == 78)
			price = 5;
		else
		if(start == 41 && destination == 79)
			price = 5;
		else
		if(start == 41 && destination == 80)
			price = 5;
		else
		if(start == 41 && destination == 81)
			price = 4;
		else
		if(start == 41 && destination == 82)
			price = 4;
		else
		if(start == 41 && destination == 83)
			price = 3;
		else
		if(start == 41 && destination == 84)
			price = 3;
		else
		if(start == 41 && destination == 85)
			price = 3;
		else
		if(start == 41 && destination == 86)
			price = 2;
		else
		if(start == 41 && destination == 87)
			price = 2;
		else
		if(start == 41 && destination == 88)
			price = 3;
		else
		if(start == 41 && destination == 89)
			price = 3;
		else
		if(start == 41 && destination == 90)
			price = 3;
		else
		if(start == 41 && destination == 91)
			price = 4;
		else
		if(start == 41 && destination == 92)
			price = 5;
		else
		if(start == 42 && destination == 0)
			price = 6;
		else
		if(start == 42 && destination == 1)
			price = 5;
		else
		if(start == 42 && destination == 2)
			price = 5;
		else
		if(start == 42 && destination == 3)
			price = 5;
		else
		if(start == 42 && destination == 4)
			price = 5;
		else
		if(start == 42 && destination == 5)
			price = 5;
		else
		if(start == 42 && destination == 6)
			price = 5;
		else
		if(start == 42 && destination == 7)
			price = 5;
		else
		if(start == 42 && destination == 8)
			price = 6;
		else
		if(start == 42 && destination == 9)
			price = 6;
		else
		if(start == 42 && destination == 10)
			price = 6;
		else
		if(start == 42 && destination == 11)
			price = 6;
		else
		if(start == 42 && destination == 12)
			price = 6;
		else
		if(start == 42 && destination == 13)
			price = 6;
		else
		if(start == 42 && destination == 14)
			price = 7;
		else
		if(start == 42 && destination == 15)
			price = 7;
		else
		if(start == 42 && destination == 16)
			price = 7;
		else
		if(start == 42 && destination == 17)
			price = 7;
		else
		if(start == 42 && destination == 18)
			price = 7;
		else
		if(start == 42 && destination == 19)
			price = 7;
		else
		if(start == 42 && destination == 20)
			price = 7;
		else
		if(start == 42 && destination == 21)
			price = 8;
		else
		if(start == 42 && destination == 22)
			price = 8;
		else
		if(start == 42 && destination == 23)
			price = 7;
		else
		if(start == 42 && destination == 24)
			price = 6;
		else
		if(start == 42 && destination == 25)
			price = 6;
		else
		if(start == 42 && destination == 26)
			price = 6;
		else
		if(start == 42 && destination == 27)
			price = 6;
		else
		if(start == 42 && destination == 28)
			price = 5;
		else
		if(start == 42 && destination == 29)
			price = 5;
		else
		if(start == 42 && destination == 30)
			price = 5;
		else
		if(start == 42 && destination == 31)
			price = 5;
		else
		if(start == 42 && destination == 32)
			price = 5;
		else
		if(start == 42 && destination == 33)
			price = 5;
		else
		if(start == 42 && destination == 34)
			price = 4;
		else
		if(start == 42 && destination == 35)
			price = 4;
		else
		if(start == 42 && destination == 36)
			price = 4;
		else
		if(start == 42 && destination == 37)
			price = 4;
		else
		if(start == 42 && destination == 38)
			price = 3;
		else
		if(start == 42 && destination == 39)
			price = 3;
		else
		if(start == 42 && destination == 40)
			price = 3;
		else
		if(start == 42 && destination == 41)
			price = 2;
		else
		if(start == 42 && destination == 42)
			price = 0;
		else
		if(start == 42 && destination == 43)
			price = 2;
		else
		if(start == 42 && destination == 44)
			price = 2;
		else
		if(start == 42 && destination == 45)
			price = 2;
		else
		if(start == 42 && destination == 46)
			price = 3;
		else
		if(start == 42 && destination == 47)
			price = 3;
		else
		if(start == 42 && destination == 48)
			price = 7;
		else
		if(start == 42 && destination == 49)
			price = 7;
		else
		if(start == 42 && destination == 50)
			price = 7;
		else
		if(start == 42 && destination == 51)
			price = 7;
		else
		if(start == 42 && destination == 52)
			price = 7;
		else
		if(start == 42 && destination == 53)
			price = 6;
		else
		if(start == 42 && destination == 54)
			price = 6;
		else
		if(start == 42 && destination == 55)
			price = 6;
		else
		if(start == 42 && destination == 56)
			price = 6;
		else
		if(start == 42 && destination == 57)
			price = 5;
		else
		if(start == 42 && destination == 58)
			price = 5;
		else
		if(start == 42 && destination == 59)
			price = 5;
		else
		if(start == 42 && destination == 60)
			price = 5;
		else
		if(start == 42 && destination == 61)
			price = 5;
		else
		if(start == 42 && destination == 62)
			price = 5;
		else
		if(start == 42 && destination == 63)
			price = 5;
		else
		if(start == 42 && destination == 64)
			price = 5;
		else
		if(start == 42 && destination == 65)
			price = 5;
		else
		if(start == 42 && destination == 66)
			price = 5;
		else
		if(start == 42 && destination == 67)
			price = 6;
		else
		if(start == 42 && destination == 68)
			price = 6;
		else
		if(start == 42 && destination == 69)
			price = 6;
		else
		if(start == 42 && destination == 70)
			price = 6;
		else
		if(start == 42 && destination == 71)
			price = 6;
		else
		if(start == 42 && destination == 72)
			price = 7;
		else
		if(start == 42 && destination == 73)
			price = 7;
		else
		if(start == 42 && destination == 74)
			price = 7;
		else
		if(start == 42 && destination == 75)
			price = 7;
		else
		if(start == 42 && destination == 76)
			price = 7;
		else
		if(start == 42 && destination == 77)
			price = 5;
		else
		if(start == 42 && destination == 78)
			price = 5;
		else
		if(start == 42 && destination == 79)
			price = 5;
		else
		if(start == 42 && destination == 80)
			price = 5;
		else
		if(start == 42 && destination == 81)
			price = 4;
		else
		if(start == 42 && destination == 82)
			price = 4;
		else
		if(start == 42 && destination == 83)
			price = 4;
		else
		if(start == 42 && destination == 84)
			price = 4;
		else
		if(start == 42 && destination == 85)
			price = 3;
		else
		if(start == 42 && destination == 86)
			price = 3;
		else
		if(start == 42 && destination == 87)
			price = 3;
		else
		if(start == 42 && destination == 88)
			price = 3;
		else
		if(start == 42 && destination == 89)
			price = 3;
		else
		if(start == 42 && destination == 90)
			price = 4;
		else
		if(start == 42 && destination == 91)
			price = 4;
		else
		if(start == 42 && destination == 92)
			price = 5;
		else
		if(start == 43 && destination == 0)
			price = 6;
		else
		if(start == 43 && destination == 1)
			price = 6;
		else
		if(start == 43 && destination == 2)
			price = 5;
		else
		if(start == 43 && destination == 3)
			price = 5;
		else
		if(start == 43 && destination == 4)
			price = 5;
		else
		if(start == 43 && destination == 5)
			price = 5;
		else
		if(start == 43 && destination == 6)
			price = 5;
		else
		if(start == 43 && destination == 7)
			price = 5;
		else
		if(start == 43 && destination == 8)
			price = 6;
		else
		if(start == 43 && destination == 9)
			price = 6;
		else
		if(start == 43 && destination == 10)
			price = 6;
		else
		if(start == 43 && destination == 11)
			price = 6;
		else
		if(start == 43 && destination == 12)
			price = 6;
		else
		if(start == 43 && destination == 13)
			price = 7;
		else
		if(start == 43 && destination == 14)
			price = 7;
		else
		if(start == 43 && destination == 15)
			price = 7;
		else
		if(start == 43 && destination == 16)
			price = 7;
		else
		if(start == 43 && destination == 17)
			price = 7;
		else
		if(start == 43 && destination == 18)
			price = 7;
		else
		if(start == 43 && destination == 19)
			price = 7;
		else
		if(start == 43 && destination == 20)
			price = 8;
		else
		if(start == 43 && destination == 21)
			price = 8;
		else
		if(start == 43 && destination == 22)
			price = 8;
		else
		if(start == 43 && destination == 23)
			price = 7;
		else
		if(start == 43 && destination == 24)
			price = 6;
		else
		if(start == 43 && destination == 25)
			price = 6;
		else
		if(start == 43 && destination == 26)
			price = 6;
		else
		if(start == 43 && destination == 27)
			price = 6;
		else
		if(start == 43 && destination == 28)
			price = 6;
		else
		if(start == 43 && destination == 29)
			price = 5;
		else
		if(start == 43 && destination == 30)
			price = 5;
		else
		if(start == 43 && destination == 31)
			price = 5;
		else
		if(start == 43 && destination == 32)
			price = 5;
		else
		if(start == 43 && destination == 33)
			price = 5;
		else
		if(start == 43 && destination == 34)
			price = 5;
		else
		if(start == 43 && destination == 35)
			price = 4;
		else
		if(start == 43 && destination == 36)
			price = 4;
		else
		if(start == 43 && destination == 37)
			price = 4;
		else
		if(start == 43 && destination == 38)
			price = 4;
		else
		if(start == 43 && destination == 39)
			price = 3;
		else
		if(start == 43 && destination == 40)
			price = 3;
		else
		if(start == 43 && destination == 41)
			price = 2;
		else
		if(start == 43 && destination == 42)
			price = 2;
		else
		if(start == 43 && destination == 43)
			price = 0;
		else
		if(start == 43 && destination == 44)
			price = 2;
		else
		if(start == 43 && destination == 45)
			price = 2;
		else
		if(start == 43 && destination == 46)
			price = 3;
		else
		if(start == 43 && destination == 47)
			price = 3;
		else
		if(start == 43 && destination == 48)
			price = 7;
		else
		if(start == 43 && destination == 49)
			price = 7;
		else
		if(start == 43 && destination == 50)
			price = 7;
		else
		if(start == 43 && destination == 51)
			price = 7;
		else
		if(start == 43 && destination == 52)
			price = 7;
		else
		if(start == 43 && destination == 53)
			price = 7;
		else
		if(start == 43 && destination == 54)
			price = 6;
		else
		if(start == 43 && destination == 55)
			price = 6;
		else
		if(start == 43 && destination == 56)
			price = 6;
		else
		if(start == 43 && destination == 57)
			price = 5;
		else
		if(start == 43 && destination == 58)
			price = 5;
		else
		if(start == 43 && destination == 59)
			price = 5;
		else
		if(start == 43 && destination == 60)
			price = 5;
		else
		if(start == 43 && destination == 61)
			price = 5;
		else
		if(start == 43 && destination == 62)
			price = 5;
		else
		if(start == 43 && destination == 63)
			price = 5;
		else
		if(start == 43 && destination == 64)
			price = 5;
		else
		if(start == 43 && destination == 65)
			price = 5;
		else
		if(start == 43 && destination == 66)
			price = 6;
		else
		if(start == 43 && destination == 67)
			price = 6;
		else
		if(start == 43 && destination == 68)
			price = 6;
		else
		if(start == 43 && destination == 69)
			price = 6;
		else
		if(start == 43 && destination == 70)
			price = 6;
		else
		if(start == 43 && destination == 71)
			price = 6;
		else
		if(start == 43 && destination == 72)
			price = 7;
		else
		if(start == 43 && destination == 73)
			price = 7;
		else
		if(start == 43 && destination == 74)
			price = 7;
		else
		if(start == 43 && destination == 75)
			price = 7;
		else
		if(start == 43 && destination == 76)
			price = 8;
		else
		if(start == 43 && destination == 77)
			price = 6;
		else
		if(start == 43 && destination == 78)
			price = 5;
		else
		if(start == 43 && destination == 79)
			price = 5;
		else
		if(start == 43 && destination == 80)
			price = 5;
		else
		if(start == 43 && destination == 81)
			price = 5;
		else
		if(start == 43 && destination == 82)
			price = 4;
		else
		if(start == 43 && destination == 83)
			price = 4;
		else
		if(start == 43 && destination == 84)
			price = 4;
		else
		if(start == 43 && destination == 85)
			price = 3;
		else
		if(start == 43 && destination == 86)
			price = 3;
		else
		if(start == 43 && destination == 87)
			price = 3;
		else
		if(start == 43 && destination == 88)
			price = 3;
		else
		if(start == 43 && destination == 89)
			price = 4;
		else
		if(start == 43 && destination == 90)
			price = 4;
		else
		if(start == 43 && destination == 91)
			price = 4;
		else
		if(start == 43 && destination == 92)
			price = 5;
		else
		if(start == 44 && destination == 0)
			price = 6;
		else
		if(start == 44 && destination == 1)
			price = 6;
		else
		if(start == 44 && destination == 2)
			price = 6;
		else
		if(start == 44 && destination == 3)
			price = 5;
		else
		if(start == 44 && destination == 4)
			price = 5;
		else
		if(start == 44 && destination == 5)
			price = 5;
		else
		if(start == 44 && destination == 6)
			price = 5;
		else
		if(start == 44 && destination == 7)
			price = 6;
		else
		if(start == 44 && destination == 8)
			price = 6;
		else
		if(start == 44 && destination == 9)
			price = 6;
		else
		if(start == 44 && destination == 10)
			price = 6;
		else
		if(start == 44 && destination == 11)
			price = 7;
		else
		if(start == 44 && destination == 12)
			price = 7;
		else
		if(start == 44 && destination == 13)
			price = 7;
		else
		if(start == 44 && destination == 14)
			price = 7;
		else
		if(start == 44 && destination == 15)
			price = 7;
		else
		if(start == 44 && destination == 16)
			price = 7;
		else
		if(start == 44 && destination == 17)
			price = 7;
		else
		if(start == 44 && destination == 18)
			price = 7;
		else
		if(start == 44 && destination == 19)
			price = 8;
		else
		if(start == 44 && destination == 20)
			price = 8;
		else
		if(start == 44 && destination == 21)
			price = 8;
		else
		if(start == 44 && destination == 22)
			price = 8;
		else
		if(start == 44 && destination == 23)
			price = 7;
		else
		if(start == 44 && destination == 24)
			price = 7;
		else
		if(start == 44 && destination == 25)
			price = 6;
		else
		if(start == 44 && destination == 26)
			price = 6;
		else
		if(start == 44 && destination == 27)
			price = 6;
		else
		if(start == 44 && destination == 28)
			price = 6;
		else
		if(start == 44 && destination == 29)
			price = 6;
		else
		if(start == 44 && destination == 30)
			price = 6;
		else
		if(start == 44 && destination == 31)
			price = 5;
		else
		if(start == 44 && destination == 32)
			price = 5;
		else
		if(start == 44 && destination == 33)
			price = 5;
		else
		if(start == 44 && destination == 34)
			price = 5;
		else
		if(start == 44 && destination == 35)
			price = 5;
		else
		if(start == 44 && destination == 36)
			price = 4;
		else
		if(start == 44 && destination == 37)
			price = 4;
		else
		if(start == 44 && destination == 38)
			price = 4;
		else
		if(start == 44 && destination == 39)
			price = 4;
		else
		if(start == 44 && destination == 40)
			price = 3;
		else
		if(start == 44 && destination == 41)
			price = 3;
		else
		if(start == 44 && destination == 42)
			price = 2;
		else
		if(start == 44 && destination == 43)
			price = 2;
		else
		if(start == 44 && destination == 44)
			price = 0;
		else
		if(start == 44 && destination == 45)
			price = 2;
		else
		if(start == 44 && destination == 46)
			price = 2;
		else
		if(start == 44 && destination == 47)
			price = 3;
		else
		if(start == 44 && destination == 48)
			price = 8;
		else
		if(start == 44 && destination == 49)
			price = 7;
		else
		if(start == 44 && destination == 50)
			price = 7;
		else
		if(start == 44 && destination == 51)
			price = 7;
		else
		if(start == 44 && destination == 52)
			price = 7;
		else
		if(start == 44 && destination == 53)
			price = 7;
		else
		if(start == 44 && destination == 54)
			price = 6;
		else
		if(start == 44 && destination == 55)
			price = 6;
		else
		if(start == 44 && destination == 56)
			price = 6;
		else
		if(start == 44 && destination == 57)
			price = 6;
		else
		if(start == 44 && destination == 58)
			price = 5;
		else
		if(start == 44 && destination == 59)
			price = 5;
		else
		if(start == 44 && destination == 60)
			price = 5;
		else
		if(start == 44 && destination == 61)
			price = 5;
		else
		if(start == 44 && destination == 62)
			price = 5;
		else
		if(start == 44 && destination == 63)
			price = 5;
		else
		if(start == 44 && destination == 64)
			price = 5;
		else
		if(start == 44 && destination == 65)
			price = 6;
		else
		if(start == 44 && destination == 66)
			price = 6;
		else
		if(start == 44 && destination == 67)
			price = 6;
		else
		if(start == 44 && destination == 68)
			price = 6;
		else
		if(start == 44 && destination == 69)
			price = 6;
		else
		if(start == 44 && destination == 70)
			price = 6;
		else
		if(start == 44 && destination == 71)
			price = 7;
		else
		if(start == 44 && destination == 72)
			price = 7;
		else
		if(start == 44 && destination == 73)
			price = 7;
		else
		if(start == 44 && destination == 74)
			price = 7;
		else
		if(start == 44 && destination == 75)
			price = 7;
		else
		if(start == 44 && destination == 76)
			price = 8;
		else
		if(start == 44 && destination == 77)
			price = 6;
		else
		if(start == 44 && destination == 78)
			price = 6;
		else
		if(start == 44 && destination == 79)
			price = 5;
		else
		if(start == 44 && destination == 80)
			price = 5;
		else
		if(start == 44 && destination == 81)
			price = 5;
		else
		if(start == 44 && destination == 82)
			price = 5;
		else
		if(start == 44 && destination == 83)
			price = 4;
		else
		if(start == 44 && destination == 84)
			price = 4;
		else
		if(start == 44 && destination == 85)
			price = 4;
		else
		if(start == 44 && destination == 86)
			price = 3;
		else
		if(start == 44 && destination == 87)
			price = 3;
		else
		if(start == 44 && destination == 88)
			price = 3;
		else
		if(start == 44 && destination == 89)
			price = 4;
		else
		if(start == 44 && destination == 90)
			price = 4;
		else
		if(start == 44 && destination == 91)
			price = 5;
		else
		if(start == 44 && destination == 92)
			price = 5;
		else
		if(start == 45 && destination == 0)
			price = 6;
		else
		if(start == 45 && destination == 1)
			price = 6;
		else
		if(start == 45 && destination == 2)
			price = 6;
		else
		if(start == 45 && destination == 3)
			price = 6;
		else
		if(start == 45 && destination == 4)
			price = 5;
		else
		if(start == 45 && destination == 5)
			price = 5;
		else
		if(start == 45 && destination == 6)
			price = 6;
		else
		if(start == 45 && destination == 7)
			price = 6;
		else
		if(start == 45 && destination == 8)
			price = 6;
		else
		if(start == 45 && destination == 9)
			price = 6;
		else
		if(start == 45 && destination == 10)
			price = 7;
		else
		if(start == 45 && destination == 11)
			price = 7;
		else
		if(start == 45 && destination == 12)
			price = 7;
		else
		if(start == 45 && destination == 13)
			price = 7;
		else
		if(start == 45 && destination == 14)
			price = 7;
		else
		if(start == 45 && destination == 15)
			price = 7;
		else
		if(start == 45 && destination == 16)
			price = 7;
		else
		if(start == 45 && destination == 17)
			price = 7;
		else
		if(start == 45 && destination == 18)
			price = 8;
		else
		if(start == 45 && destination == 19)
			price = 8;
		else
		if(start == 45 && destination == 20)
			price = 8;
		else
		if(start == 45 && destination == 21)
			price = 8;
		else
		if(start == 45 && destination == 22)
			price = 8;
		else
		if(start == 45 && destination == 23)
			price = 7;
		else
		if(start == 45 && destination == 24)
			price = 7;
		else
		if(start == 45 && destination == 25)
			price = 7;
		else
		if(start == 45 && destination == 26)
			price = 6;
		else
		if(start == 45 && destination == 27)
			price = 6;
		else
		if(start == 45 && destination == 28)
			price = 6;
		else
		if(start == 45 && destination == 29)
			price = 6;
		else
		if(start == 45 && destination == 30)
			price = 6;
		else
		if(start == 45 && destination == 31)
			price = 6;
		else
		if(start == 45 && destination == 32)
			price = 5;
		else
		if(start == 45 && destination == 33)
			price = 5;
		else
		if(start == 45 && destination == 34)
			price = 5;
		else
		if(start == 45 && destination == 35)
			price = 5;
		else
		if(start == 45 && destination == 36)
			price = 5;
		else
		if(start == 45 && destination == 37)
			price = 4;
		else
		if(start == 45 && destination == 38)
			price = 4;
		else
		if(start == 45 && destination == 39)
			price = 4;
		else
		if(start == 45 && destination == 40)
			price = 3;
		else
		if(start == 45 && destination == 41)
			price = 3;
		else
		if(start == 45 && destination == 42)
			price = 2;
		else
		if(start == 45 && destination == 43)
			price = 2;
		else
		if(start == 45 && destination == 44)
			price = 2;
		else
		if(start == 45 && destination == 45)
			price = 0;
		else
		if(start == 45 && destination == 46)
			price = 2;
		else
		if(start == 45 && destination == 47)
			price = 2;
		else
		if(start == 45 && destination == 48)
			price = 8;
		else
		if(start == 45 && destination == 49)
			price = 7;
		else
		if(start == 45 && destination == 50)
			price = 7;
		else
		if(start == 45 && destination == 51)
			price = 7;
		else
		if(start == 45 && destination == 52)
			price = 7;
		else
		if(start == 45 && destination == 53)
			price = 7;
		else
		if(start == 45 && destination == 54)
			price = 6;
		else
		if(start == 45 && destination == 55)
			price = 6;
		else
		if(start == 45 && destination == 56)
			price = 6;
		else
		if(start == 45 && destination == 57)
			price = 6;
		else
		if(start == 45 && destination == 58)
			price = 6;
		else
		if(start == 45 && destination == 59)
			price = 5;
		else
		if(start == 45 && destination == 60)
			price = 5;
		else
		if(start == 45 && destination == 61)
			price = 5;
		else
		if(start == 45 && destination == 62)
			price = 5;
		else
		if(start == 45 && destination == 63)
			price = 5;
		else
		if(start == 45 && destination == 64)
			price = 6;
		else
		if(start == 45 && destination == 65)
			price = 6;
		else
		if(start == 45 && destination == 66)
			price = 6;
		else
		if(start == 45 && destination == 67)
			price = 6;
		else
		if(start == 45 && destination == 68)
			price = 6;
		else
		if(start == 45 && destination == 69)
			price = 6;
		else
		if(start == 45 && destination == 70)
			price = 7;
		else
		if(start == 45 && destination == 71)
			price = 7;
		else
		if(start == 45 && destination == 72)
			price = 7;
		else
		if(start == 45 && destination == 73)
			price = 7;
		else
		if(start == 45 && destination == 74)
			price = 7;
		else
		if(start == 45 && destination == 75)
			price = 8;
		else
		if(start == 45 && destination == 76)
			price = 8;
		else
		if(start == 45 && destination == 77)
			price = 6;
		else
		if(start == 45 && destination == 78)
			price = 6;
		else
		if(start == 45 && destination == 79)
			price = 5;
		else
		if(start == 45 && destination == 80)
			price = 5;
		else
		if(start == 45 && destination == 81)
			price = 5;
		else
		if(start == 45 && destination == 82)
			price = 5;
		else
		if(start == 45 && destination == 83)
			price = 5;
		else
		if(start == 45 && destination == 84)
			price = 4;
		else
		if(start == 45 && destination == 85)
			price = 4;
		else
		if(start == 45 && destination == 86)
			price = 3;
		else
		if(start == 45 && destination == 87)
			price = 3;
		else
		if(start == 45 && destination == 88)
			price = 4;
		else
		if(start == 45 && destination == 89)
			price = 4;
		else
		if(start == 45 && destination == 90)
			price = 5;
		else
		if(start == 45 && destination == 91)
			price = 5;
		else
		if(start == 45 && destination == 92)
			price = 5;
		else
		if(start == 46 && destination == 0)
			price = 6;
		else
		if(start == 46 && destination == 1)
			price = 6;
		else
		if(start == 46 && destination == 2)
			price = 6;
		else
		if(start == 46 && destination == 3)
			price = 6;
		else
		if(start == 46 && destination == 4)
			price = 6;
		else
		if(start == 46 && destination == 5)
			price = 6;
		else
		if(start == 46 && destination == 6)
			price = 6;
		else
		if(start == 46 && destination == 7)
			price = 6;
		else
		if(start == 46 && destination == 8)
			price = 6;
		else
		if(start == 46 && destination == 9)
			price = 7;
		else
		if(start == 46 && destination == 10)
			price = 7;
		else
		if(start == 46 && destination == 11)
			price = 7;
		else
		if(start == 46 && destination == 12)
			price = 7;
		else
		if(start == 46 && destination == 13)
			price = 7;
		else
		if(start == 46 && destination == 14)
			price = 7;
		else
		if(start == 46 && destination == 15)
			price = 7;
		else
		if(start == 46 && destination == 16)
			price = 7;
		else
		if(start == 46 && destination == 17)
			price = 8;
		else
		if(start == 46 && destination == 18)
			price = 8;
		else
		if(start == 46 && destination == 19)
			price = 8;
		else
		if(start == 46 && destination == 20)
			price = 8;
		else
		if(start == 46 && destination == 21)
			price = 8;
		else
		if(start == 46 && destination == 22)
			price = 8;
		else
		if(start == 46 && destination == 23)
			price = 7;
		else
		if(start == 46 && destination == 24)
			price = 7;
		else
		if(start == 46 && destination == 25)
			price = 7;
		else
		if(start == 46 && destination == 26)
			price = 7;
		else
		if(start == 46 && destination == 27)
			price = 7;
		else
		if(start == 46 && destination == 28)
			price = 6;
		else
		if(start == 46 && destination == 29)
			price = 6;
		else
		if(start == 46 && destination == 30)
			price = 6;
		else
		if(start == 46 && destination == 31)
			price = 6;
		else
		if(start == 46 && destination == 32)
			price = 6;
		else
		if(start == 46 && destination == 33)
			price = 6;
		else
		if(start == 46 && destination == 34)
			price = 5;
		else
		if(start == 46 && destination == 35)
			price = 5;
		else
		if(start == 46 && destination == 36)
			price = 5;
		else
		if(start == 46 && destination == 37)
			price = 5;
		else
		if(start == 46 && destination == 38)
			price = 5;
		else
		if(start == 46 && destination == 39)
			price = 4;
		else
		if(start == 46 && destination == 40)
			price = 4;
		else
		if(start == 46 && destination == 41)
			price = 3;
		else
		if(start == 46 && destination == 42)
			price = 3;
		else
		if(start == 46 && destination == 43)
			price = 3;
		else
		if(start == 46 && destination == 44)
			price = 2;
		else
		if(start == 46 && destination == 45)
			price = 2;
		else
		if(start == 46 && destination == 46)
			price = 0;
		else
		if(start == 46 && destination == 47)
			price = 2;
		else
		if(start == 46 && destination == 48)
			price = 8;
		else
		if(start == 46 && destination == 49)
			price = 8;
		else
		if(start == 46 && destination == 50)
			price = 8;
		else
		if(start == 46 && destination == 51)
			price = 7;
		else
		if(start == 46 && destination == 52)
			price = 7;
		else
		if(start == 46 && destination == 53)
			price = 7;
		else
		if(start == 46 && destination == 54)
			price = 7;
		else
		if(start == 46 && destination == 55)
			price = 7;
		else
		if(start == 46 && destination == 56)
			price = 6;
		else
		if(start == 46 && destination == 57)
			price = 6;
		else
		if(start == 46 && destination == 58)
			price = 6;
		else
		if(start == 46 && destination == 59)
			price = 5;
		else
		if(start == 46 && destination == 60)
			price = 6;
		else
		if(start == 46 && destination == 61)
			price = 5;
		else
		if(start == 46 && destination == 62)
			price = 6;
		else
		if(start == 46 && destination == 63)
			price = 6;
		else
		if(start == 46 && destination == 64)
			price = 6;
		else
		if(start == 46 && destination == 65)
			price = 6;
		else
		if(start == 46 && destination == 66)
			price = 6;
		else
		if(start == 46 && destination == 67)
			price = 6;
		else
		if(start == 46 && destination == 68)
			price = 7;
		else
		if(start == 46 && destination == 69)
			price = 7;
		else
		if(start == 46 && destination == 70)
			price = 7;
		else
		if(start == 46 && destination == 71)
			price = 7;
		else
		if(start == 46 && destination == 72)
			price = 7;
		else
		if(start == 46 && destination == 73)
			price = 7;
		else
		if(start == 46 && destination == 74)
			price = 8;
		else
		if(start == 46 && destination == 75)
			price = 8;
		else
		if(start == 46 && destination == 76)
			price = 8;
		else
		if(start == 46 && destination == 77)
			price = 6;
		else
		if(start == 46 && destination == 78)
			price = 6;
		else
		if(start == 46 && destination == 79)
			price = 6;
		else
		if(start == 46 && destination == 80)
			price = 6;
		else
		if(start == 46 && destination == 81)
			price = 5;
		else
		if(start == 46 && destination == 82)
			price = 5;
		else
		if(start == 46 && destination == 83)
			price = 5;
		else
		if(start == 46 && destination == 84)
			price = 5;
		else
		if(start == 46 && destination == 85)
			price = 4;
		else
		if(start == 46 && destination == 86)
			price = 4;
		else
		if(start == 46 && destination == 87)
			price = 4;
		else
		if(start == 46 && destination == 88)
			price = 4;
		else
		if(start == 46 && destination == 89)
			price = 4;
		else
		if(start == 46 && destination == 90)
			price = 5;
		else
		if(start == 46 && destination == 91)
			price = 5;
		else
		if(start == 46 && destination == 92)
			price = 6;
		else
		if(start == 47 && destination == 0)
			price = 7;
		else
		if(start == 47 && destination == 1)
			price = 7;
		else
		if(start == 47 && destination == 2)
			price = 6;
		else
		if(start == 47 && destination == 3)
			price = 6;
		else
		if(start == 47 && destination == 4)
			price = 6;
		else
		if(start == 47 && destination == 5)
			price = 6;
		else
		if(start == 47 && destination == 6)
			price = 6;
		else
		if(start == 47 && destination == 7)
			price = 6;
		else
		if(start == 47 && destination == 8)
			price = 7;
		else
		if(start == 47 && destination == 9)
			price = 7;
		else
		if(start == 47 && destination == 10)
			price = 7;
		else
		if(start == 47 && destination == 11)
			price = 7;
		else
		if(start == 47 && destination == 12)
			price = 7;
		else
		if(start == 47 && destination == 13)
			price = 7;
		else
		if(start == 47 && destination == 14)
			price = 7;
		else
		if(start == 47 && destination == 15)
			price = 8;
		else
		if(start == 47 && destination == 16)
			price = 8;
		else
		if(start == 47 && destination == 17)
			price = 8;
		else
		if(start == 47 && destination == 18)
			price = 8;
		else
		if(start == 47 && destination == 19)
			price = 8;
		else
		if(start == 47 && destination == 20)
			price = 8;
		else
		if(start == 47 && destination == 21)
			price = 8;
		else
		if(start == 47 && destination == 22)
			price = 9;
		else
		if(start == 47 && destination == 23)
			price = 7;
		else
		if(start == 47 && destination == 24)
			price = 7;
		else
		if(start == 47 && destination == 25)
			price = 7;
		else
		if(start == 47 && destination == 26)
			price = 7;
		else
		if(start == 47 && destination == 27)
			price = 7;
		else
		if(start == 47 && destination == 28)
			price = 7;
		else
		if(start == 47 && destination == 29)
			price = 6;
		else
		if(start == 47 && destination == 30)
			price = 6;
		else
		if(start == 47 && destination == 31)
			price = 6;
		else
		if(start == 47 && destination == 32)
			price = 6;
		else
		if(start == 47 && destination == 33)
			price = 6;
		else
		if(start == 47 && destination == 34)
			price = 6;
		else
		if(start == 47 && destination == 35)
			price = 5;
		else
		if(start == 47 && destination == 36)
			price = 5;
		else
		if(start == 47 && destination == 37)
			price = 5;
		else
		if(start == 47 && destination == 38)
			price = 5;
		else
		if(start == 47 && destination == 39)
			price = 5;
		else
		if(start == 47 && destination == 40)
			price = 4;
		else
		if(start == 47 && destination == 41)
			price = 4;
		else
		if(start == 47 && destination == 42)
			price = 3;
		else
		if(start == 47 && destination == 43)
			price = 3;
		else
		if(start == 47 && destination == 44)
			price = 3;
		else
		if(start == 47 && destination == 45)
			price = 2;
		else
		if(start == 47 && destination == 46)
			price = 2;
		else
		if(start == 47 && destination == 47)
			price = 0;
		else
		if(start == 47 && destination == 48)
			price = 8;
		else
		if(start == 47 && destination == 49)
			price = 8;
		else
		if(start == 47 && destination == 50)
			price = 8;
		else
		if(start == 47 && destination == 51)
			price = 8;
		else
		if(start == 47 && destination == 52)
			price = 7;
		else
		if(start == 47 && destination == 53)
			price = 7;
		else
		if(start == 47 && destination == 54)
			price = 7;
		else
		if(start == 47 && destination == 55)
			price = 7;
		else
		if(start == 47 && destination == 56)
			price = 7;
		else
		if(start == 47 && destination == 57)
			price = 6;
		else
		if(start == 47 && destination == 58)
			price = 6;
		else
		if(start == 47 && destination == 59)
			price = 6;
		else
		if(start == 47 && destination == 60)
			price = 6;
		else
		if(start == 47 && destination == 61)
			price = 6;
		else
		if(start == 47 && destination == 62)
			price = 6;
		else
		if(start == 47 && destination == 63)
			price = 6;
		else
		if(start == 47 && destination == 64)
			price = 6;
		else
		if(start == 47 && destination == 65)
			price = 6;
		else
		if(start == 47 && destination == 66)
			price = 6;
		else
		if(start == 47 && destination == 67)
			price = 7;
		else
		if(start == 47 && destination == 68)
			price = 7;
		else
		if(start == 47 && destination == 69)
			price = 7;
		else
		if(start == 47 && destination == 70)
			price = 7;
		else
		if(start == 47 && destination == 71)
			price = 7;
		else
		if(start == 47 && destination == 72)
			price = 7;
		else
		if(start == 47 && destination == 73)
			price = 8;
		else
		if(start == 47 && destination == 74)
			price = 8;
		else
		if(start == 47 && destination == 75)
			price = 8;
		else
		if(start == 47 && destination == 76)
			price = 8;
		else
		if(start == 47 && destination == 77)
			price = 7;
		else
		if(start == 47 && destination == 78)
			price = 6;
		else
		if(start == 47 && destination == 79)
			price = 6;
		else
		if(start == 47 && destination == 80)
			price = 6;
		else
		if(start == 47 && destination == 81)
			price = 6;
		else
		if(start == 47 && destination == 82)
			price = 5;
		else
		if(start == 47 && destination == 83)
			price = 5;
		else
		if(start == 47 && destination == 84)
			price = 5;
		else
		if(start == 47 && destination == 85)
			price = 5;
		else
		if(start == 47 && destination == 86)
			price = 4;
		else
		if(start == 47 && destination == 87)
			price = 4;
		else
		if(start == 47 && destination == 88)
			price = 4;
		else
		if(start == 47 && destination == 89)
			price = 5;
		else
		if(start == 47 && destination == 90)
			price = 5;
		else
		if(start == 47 && destination == 91)
			price = 5;
		else
		if(start == 47 && destination == 92)
			price = 6;
		else
		if(start == 48 && destination == 0)
			price = 5;
		else
		if(start == 48 && destination == 1)
			price = 5;
		else
		if(start == 48 && destination == 2)
			price = 5;
		else
		if(start == 48 && destination == 3)
			price = 5;
		else
		if(start == 48 && destination == 4)
			price = 5;
		else
		if(start == 48 && destination == 5)
			price = 6;
		else
		if(start == 48 && destination == 6)
			price = 6;
		else
		if(start == 48 && destination == 7)
			price = 6;
		else
		if(start == 48 && destination == 8)
			price = 6;
		else
		if(start == 48 && destination == 9)
			price = 7;
		else
		if(start == 48 && destination == 10)
			price = 7;
		else
		if(start == 48 && destination == 11)
			price = 7;
		else
		if(start == 48 && destination == 12)
			price = 7;
		else
		if(start == 48 && destination == 13)
			price = 7;
		else
		if(start == 48 && destination == 14)
			price = 7;
		else
		if(start == 48 && destination == 15)
			price = 7;
		else
		if(start == 48 && destination == 16)
			price = 8;
		else
		if(start == 48 && destination == 17)
			price = 8;
		else
		if(start == 48 && destination == 18)
			price = 8;
		else
		if(start == 48 && destination == 19)
			price = 8;
		else
		if(start == 48 && destination == 20)
			price = 8;
		else
		if(start == 48 && destination == 21)
			price = 8;
		else
		if(start == 48 && destination == 22)
			price = 9;
		else
		if(start == 48 && destination == 23)
			price = 7;
		else
		if(start == 48 && destination == 24)
			price = 7;
		else
		if(start == 48 && destination == 25)
			price = 7;
		else
		if(start == 48 && destination == 26)
			price = 7;
		else
		if(start == 48 && destination == 27)
			price = 7;
		else
		if(start == 48 && destination == 28)
			price = 6;
		else
		if(start == 48 && destination == 29)
			price = 6;
		else
		if(start == 48 && destination == 30)
			price = 6;
		else
		if(start == 48 && destination == 31)
			price = 6;
		else
		if(start == 48 && destination == 32)
			price = 6;
		else
		if(start == 48 && destination == 33)
			price = 6;
		else
		if(start == 48 && destination == 34)
			price = 6;
		else
		if(start == 48 && destination == 35)
			price = 6;
		else
		if(start == 48 && destination == 36)
			price = 6;
		else
		if(start == 48 && destination == 37)
			price = 6;
		else
		if(start == 48 && destination == 38)
			price = 7;
		else
		if(start == 48 && destination == 39)
			price = 7;
		else
		if(start == 48 && destination == 40)
			price = 7;
		else
		if(start == 48 && destination == 41)
			price = 7;
		else
		if(start == 48 && destination == 42)
			price = 7;
		else
		if(start == 48 && destination == 43)
			price = 7;
		else
		if(start == 48 && destination == 44)
			price = 8;
		else
		if(start == 48 && destination == 45)
			price = 8;
		else
		if(start == 48 && destination == 46)
			price = 8;
		else
		if(start == 48 && destination == 47)
			price = 8;
		else
		if(start == 48 && destination == 48)
			price = 0;
		else
		if(start == 48 && destination == 49)
			price = 2;
		else
		if(start == 48 && destination == 50)
			price = 2;
		else
		if(start == 48 && destination == 51)
			price = 3;
		else
		if(start == 48 && destination == 52)
			price = 3;
		else
		if(start == 48 && destination == 53)
			price = 3;
		else
		if(start == 48 && destination == 54)
			price = 4;
		else
		if(start == 48 && destination == 55)
			price = 4;
		else
		if(start == 48 && destination == 56)
			price = 5;
		else
		if(start == 48 && destination == 57)
			price = 5;
		else
		if(start == 48 && destination == 58)
			price = 5;
		else
		if(start == 48 && destination == 59)
			price = 5;
		else
		if(start == 48 && destination == 60)
			price = 6;
		else
		if(start == 48 && destination == 61)
			price = 6;
		else
		if(start == 48 && destination == 62)
			price = 6;
		else
		if(start == 48 && destination == 63)
			price = 6;
		else
		if(start == 48 && destination == 64)
			price = 6;
		else
		if(start == 48 && destination == 65)
			price = 6;
		else
		if(start == 48 && destination == 66)
			price = 6;
		else
		if(start == 48 && destination == 67)
			price = 7;
		else
		if(start == 48 && destination == 68)
			price = 7;
		else
		if(start == 48 && destination == 69)
			price = 7;
		else
		if(start == 48 && destination == 70)
			price = 7;
		else
		if(start == 48 && destination == 71)
			price = 7;
		else
		if(start == 48 && destination == 72)
			price = 7;
		else
		if(start == 48 && destination == 73)
			price = 8;
		else
		if(start == 48 && destination == 74)
			price = 8;
		else
		if(start == 48 && destination == 75)
			price = 8;
		else
		if(start == 48 && destination == 76)
			price = 8;
		else
		if(start == 48 && destination == 77)
			price = 6;
		else
		if(start == 48 && destination == 78)
			price = 6;
		else
		if(start == 48 && destination == 79)
			price = 5;
		else
		if(start == 48 && destination == 80)
			price = 5;
		else
		if(start == 48 && destination == 81)
			price = 6;
		else
		if(start == 48 && destination == 82)
			price = 6;
		else
		if(start == 48 && destination == 83)
			price = 6;
		else
		if(start == 48 && destination == 84)
			price = 6;
		else
		if(start == 48 && destination == 85)
			price = 7;
		else
		if(start == 48 && destination == 86)
			price = 7;
		else
		if(start == 48 && destination == 87)
			price = 7;
		else
		if(start == 48 && destination == 88)
			price = 8;
		else
		if(start == 48 && destination == 89)
			price = 8;
		else
		if(start == 48 && destination == 90)
			price = 8;
		else
		if(start == 48 && destination == 91)
			price = 8;
		else
		if(start == 48 && destination == 92)
			price = 8;
		else
		if(start == 49 && destination == 0)
			price = 5;
		else
		if(start == 49 && destination == 1)
			price = 5;
		else
		if(start == 49 && destination == 2)
			price = 5;
		else
		if(start == 49 && destination == 3)
			price = 5;
		else
		if(start == 49 && destination == 4)
			price = 5;
		else
		if(start == 49 && destination == 5)
			price = 5;
		else
		if(start == 49 && destination == 6)
			price = 6;
		else
		if(start == 49 && destination == 7)
			price = 6;
		else
		if(start == 49 && destination == 8)
			price = 6;
		else
		if(start == 49 && destination == 9)
			price = 6;
		else
		if(start == 49 && destination == 10)
			price = 6;
		else
		if(start == 49 && destination == 11)
			price = 7;
		else
		if(start == 49 && destination == 12)
			price = 7;
		else
		if(start == 49 && destination == 13)
			price = 7;
		else
		if(start == 49 && destination == 14)
			price = 7;
		else
		if(start == 49 && destination == 15)
			price = 7;
		else
		if(start == 49 && destination == 16)
			price = 7;
		else
		if(start == 49 && destination == 17)
			price = 8;
		else
		if(start == 49 && destination == 18)
			price = 8;
		else
		if(start == 49 && destination == 19)
			price = 8;
		else
		if(start == 49 && destination == 20)
			price = 8;
		else
		if(start == 49 && destination == 21)
			price = 8;
		else
		if(start == 49 && destination == 22)
			price = 8;
		else
		if(start == 49 && destination == 23)
			price = 7;
		else
		if(start == 49 && destination == 24)
			price = 7;
		else
		if(start == 49 && destination == 25)
			price = 7;
		else
		if(start == 49 && destination == 26)
			price = 6;
		else
		if(start == 49 && destination == 27)
			price = 6;
		else
		if(start == 49 && destination == 28)
			price = 6;
		else
		if(start == 49 && destination == 29)
			price = 6;
		else
		if(start == 49 && destination == 30)
			price = 6;
		else
		if(start == 49 && destination == 31)
			price = 5;
		else
		if(start == 49 && destination == 32)
			price = 5;
		else
		if(start == 49 && destination == 33)
			price = 5;
		else
		if(start == 49 && destination == 34)
			price = 5;
		else
		if(start == 49 && destination == 35)
			price = 6;
		else
		if(start == 49 && destination == 36)
			price = 6;
		else
		if(start == 49 && destination == 37)
			price = 6;
		else
		if(start == 49 && destination == 38)
			price = 6;
		else
		if(start == 49 && destination == 39)
			price = 6;
		else
		if(start == 49 && destination == 40)
			price = 7;
		else
		if(start == 49 && destination == 41)
			price = 7;
		else
		if(start == 49 && destination == 42)
			price = 7;
		else
		if(start == 49 && destination == 43)
			price = 7;
		else
		if(start == 49 && destination == 44)
			price = 7;
		else
		if(start == 49 && destination == 45)
			price = 7;
		else
		if(start == 49 && destination == 46)
			price = 8;
		else
		if(start == 49 && destination == 47)
			price = 8;
		else
		if(start == 49 && destination == 48)
			price = 2;
		else
		if(start == 49 && destination == 49)
			price = 0;
		else
		if(start == 49 && destination == 50)
			price = 2;
		else
		if(start == 49 && destination == 51)
			price = 2;
		else
		if(start == 49 && destination == 52)
			price = 2;
		else
		if(start == 49 && destination == 53)
			price = 3;
		else
		if(start == 49 && destination == 54)
			price = 3;
		else
		if(start == 49 && destination == 55)
			price = 4;
		else
		if(start == 49 && destination == 56)
			price = 4;
		else
		if(start == 49 && destination == 57)
			price = 4;
		else
		if(start == 49 && destination == 58)
			price = 5;
		else
		if(start == 49 && destination == 59)
			price = 5;
		else
		if(start == 49 && destination == 60)
			price = 5;
		else
		if(start == 49 && destination == 61)
			price = 5;
		else
		if(start == 49 && destination == 62)
			price = 5;
		else
		if(start == 49 && destination == 63)
			price = 6;
		else
		if(start == 49 && destination == 64)
			price = 6;
		else
		if(start == 49 && destination == 65)
			price = 6;
		else
		if(start == 49 && destination == 66)
			price = 6;
		else
		if(start == 49 && destination == 67)
			price = 6;
		else
		if(start == 49 && destination == 68)
			price = 6;
		else
		if(start == 49 && destination == 69)
			price = 7;
		else
		if(start == 49 && destination == 70)
			price = 7;
		else
		if(start == 49 && destination == 71)
			price = 7;
		else
		if(start == 49 && destination == 72)
			price = 7;
		else
		if(start == 49 && destination == 73)
			price = 7;
		else
		if(start == 49 && destination == 74)
			price = 8;
		else
		if(start == 49 && destination == 75)
			price = 8;
		else
		if(start == 49 && destination == 76)
			price = 8;
		else
		if(start == 49 && destination == 77)
			price = 6;
		else
		if(start == 49 && destination == 78)
			price = 5;
		else
		if(start == 49 && destination == 79)
			price = 5;
		else
		if(start == 49 && destination == 80)
			price = 5;
		else
		if(start == 49 && destination == 81)
			price = 5;
		else
		if(start == 49 && destination == 82)
			price = 5;
		else
		if(start == 49 && destination == 83)
			price = 6;
		else
		if(start == 49 && destination == 84)
			price = 6;
		else
		if(start == 49 && destination == 85)
			price = 6;
		else
		if(start == 49 && destination == 86)
			price = 7;
		else
		if(start == 49 && destination == 87)
			price = 7;
		else
		if(start == 49 && destination == 88)
			price = 7;
		else
		if(start == 49 && destination == 89)
			price = 8;
		else
		if(start == 49 && destination == 90)
			price = 8;
		else
		if(start == 49 && destination == 91)
			price = 8;
		else
		if(start == 49 && destination == 92)
			price = 8;
		else
		if(start == 50 && destination == 0)
			price = 5;
		else
		if(start == 50 && destination == 1)
			price = 4;
		else
		if(start == 50 && destination == 2)
			price = 4;
		else
		if(start == 50 && destination == 3)
			price = 5;
		else
		if(start == 50 && destination == 4)
			price = 5;
		else
		if(start == 50 && destination == 5)
			price = 5;
		else
		if(start == 50 && destination == 6)
			price = 5;
		else
		if(start == 50 && destination == 7)
			price = 6;
		else
		if(start == 50 && destination == 8)
			price = 6;
		else
		if(start == 50 && destination == 9)
			price = 6;
		else
		if(start == 50 && destination == 10)
			price = 6;
		else
		if(start == 50 && destination == 11)
			price = 6;
		else
		if(start == 50 && destination == 12)
			price = 7;
		else
		if(start == 50 && destination == 13)
			price = 7;
		else
		if(start == 50 && destination == 14)
			price = 7;
		else
		if(start == 50 && destination == 15)
			price = 7;
		else
		if(start == 50 && destination == 16)
			price = 7;
		else
		if(start == 50 && destination == 17)
			price = 7;
		else
		if(start == 50 && destination == 18)
			price = 8;
		else
		if(start == 50 && destination == 19)
			price = 8;
		else
		if(start == 50 && destination == 20)
			price = 8;
		else
		if(start == 50 && destination == 21)
			price = 8;
		else
		if(start == 50 && destination == 22)
			price = 8;
		else
		if(start == 50 && destination == 23)
			price = 7;
		else
		if(start == 50 && destination == 24)
			price = 7;
		else
		if(start == 50 && destination == 25)
			price = 6;
		else
		if(start == 50 && destination == 26)
			price = 6;
		else
		if(start == 50 && destination == 27)
			price = 6;
		else
		if(start == 50 && destination == 28)
			price = 6;
		else
		if(start == 50 && destination == 29)
			price = 6;
		else
		if(start == 50 && destination == 30)
			price = 5;
		else
		if(start == 50 && destination == 31)
			price = 5;
		else
		if(start == 50 && destination == 32)
			price = 5;
		else
		if(start == 50 && destination == 33)
			price = 5;
		else
		if(start == 50 && destination == 34)
			price = 5;
		else
		if(start == 50 && destination == 35)
			price = 5;
		else
		if(start == 50 && destination == 36)
			price = 6;
		else
		if(start == 50 && destination == 37)
			price = 6;
		else
		if(start == 50 && destination == 38)
			price = 6;
		else
		if(start == 50 && destination == 39)
			price = 6;
		else
		if(start == 50 && destination == 40)
			price = 7;
		else
		if(start == 50 && destination == 41)
			price = 7;
		else
		if(start == 50 && destination == 42)
			price = 7;
		else
		if(start == 50 && destination == 43)
			price = 7;
		else
		if(start == 50 && destination == 44)
			price = 7;
		else
		if(start == 50 && destination == 45)
			price = 7;
		else
		if(start == 50 && destination == 46)
			price = 8;
		else
		if(start == 50 && destination == 47)
			price = 8;
		else
		if(start == 50 && destination == 48)
			price = 2;
		else
		if(start == 50 && destination == 49)
			price = 2;
		else
		if(start == 50 && destination == 50)
			price = 0;
		else
		if(start == 50 && destination == 51)
			price = 2;
		else
		if(start == 50 && destination == 52)
			price = 2;
		else
		if(start == 50 && destination == 53)
			price = 3;
		else
		if(start == 50 && destination == 54)
			price = 3;
		else
		if(start == 50 && destination == 55)
			price = 3;
		else
		if(start == 50 && destination == 56)
			price = 4;
		else
		if(start == 50 && destination == 57)
			price = 4;
		else
		if(start == 50 && destination == 58)
			price = 5;
		else
		if(start == 50 && destination == 59)
			price = 5;
		else
		if(start == 50 && destination == 60)
			price = 5;
		else
		if(start == 50 && destination == 61)
			price = 5;
		else
		if(start == 50 && destination == 62)
			price = 5;
		else
		if(start == 50 && destination == 63)
			price = 5;
		else
		if(start == 50 && destination == 64)
			price = 6;
		else
		if(start == 50 && destination == 65)
			price = 6;
		else
		if(start == 50 && destination == 66)
			price = 6;
		else
		if(start == 50 && destination == 67)
			price = 6;
		else
		if(start == 50 && destination == 68)
			price = 6;
		else
		if(start == 50 && destination == 69)
			price = 6;
		else
		if(start == 50 && destination == 70)
			price = 7;
		else
		if(start == 50 && destination == 71)
			price = 7;
		else
		if(start == 50 && destination == 72)
			price = 7;
		else
		if(start == 50 && destination == 73)
			price = 7;
		else
		if(start == 50 && destination == 74)
			price = 7;
		else
		if(start == 50 && destination == 75)
			price = 8;
		else
		if(start == 50 && destination == 76)
			price = 8;
		else
		if(start == 50 && destination == 77)
			price = 5;
		else
		if(start == 50 && destination == 78)
			price = 5;
		else
		if(start == 50 && destination == 79)
			price = 5;
		else
		if(start == 50 && destination == 80)
			price = 5;
		else
		if(start == 50 && destination == 81)
			price = 5;
		else
		if(start == 50 && destination == 82)
			price = 5;
		else
		if(start == 50 && destination == 83)
			price = 6;
		else
		if(start == 50 && destination == 84)
			price = 6;
		else
		if(start == 50 && destination == 85)
			price = 6;
		else
		if(start == 50 && destination == 86)
			price = 6;
		else
		if(start == 50 && destination == 87)
			price = 7;
		else
		if(start == 50 && destination == 88)
			price = 7;
		else
		if(start == 50 && destination == 89)
			price = 7;
		else
		if(start == 50 && destination == 90)
			price = 8;
		else
		if(start == 50 && destination == 91)
			price = 8;
		else
		if(start == 50 && destination == 92)
			price = 8;
		else
		if(start == 51 && destination == 0)
			price = 4;
		else
		if(start == 51 && destination == 1)
			price = 4;
		else
		if(start == 51 && destination == 2)
			price = 4;
		else
		if(start == 51 && destination == 3)
			price = 4;
		else
		if(start == 51 && destination == 4)
			price = 5;
		else
		if(start == 51 && destination == 5)
			price = 5;
		else
		if(start == 51 && destination == 6)
			price = 5;
		else
		if(start == 51 && destination == 7)
			price = 5;
		else
		if(start == 51 && destination == 8)
			price = 6;
		else
		if(start == 51 && destination == 9)
			price = 6;
		else
		if(start == 51 && destination == 10)
			price = 6;
		else
		if(start == 51 && destination == 11)
			price = 6;
		else
		if(start == 51 && destination == 12)
			price = 7;
		else
		if(start == 51 && destination == 13)
			price = 7;
		else
		if(start == 51 && destination == 14)
			price = 7;
		else
		if(start == 51 && destination == 15)
			price = 7;
		else
		if(start == 51 && destination == 16)
			price = 7;
		else
		if(start == 51 && destination == 17)
			price = 7;
		else
		if(start == 51 && destination == 18)
			price = 7;
		else
		if(start == 51 && destination == 19)
			price = 8;
		else
		if(start == 51 && destination == 20)
			price = 8;
		else
		if(start == 51 && destination == 21)
			price = 8;
		else
		if(start == 51 && destination == 22)
			price = 8;
		else
		if(start == 51 && destination == 23)
			price = 7;
		else
		if(start == 51 && destination == 24)
			price = 6;
		else
		if(start == 51 && destination == 25)
			price = 6;
		else
		if(start == 51 && destination == 26)
			price = 6;
		else
		if(start == 51 && destination == 27)
			price = 6;
		else
		if(start == 51 && destination == 28)
			price = 6;
		else
		if(start == 51 && destination == 29)
			price = 5;
		else
		if(start == 51 && destination == 30)
			price = 5;
		else
		if(start == 51 && destination == 31)
			price = 5;
		else
		if(start == 51 && destination == 32)
			price = 5;
		else
		if(start == 51 && destination == 33)
			price = 5;
		else
		if(start == 51 && destination == 34)
			price = 5;
		else
		if(start == 51 && destination == 35)
			price = 5;
		else
		if(start == 51 && destination == 36)
			price = 6;
		else
		if(start == 51 && destination == 37)
			price = 6;
		else
		if(start == 51 && destination == 38)
			price = 6;
		else
		if(start == 51 && destination == 39)
			price = 6;
		else
		if(start == 51 && destination == 40)
			price = 6;
		else
		if(start == 51 && destination == 41)
			price = 7;
		else
		if(start == 51 && destination == 42)
			price = 7;
		else
		if(start == 51 && destination == 43)
			price = 7;
		else
		if(start == 51 && destination == 44)
			price = 7;
		else
		if(start == 51 && destination == 45)
			price = 7;
		else
		if(start == 51 && destination == 46)
			price = 7;
		else
		if(start == 51 && destination == 47)
			price = 8;
		else
		if(start == 51 && destination == 48)
			price = 3;
		else
		if(start == 51 && destination == 49)
			price = 2;
		else
		if(start == 51 && destination == 50)
			price = 2;
		else
		if(start == 51 && destination == 51)
			price = 0;
		else
		if(start == 51 && destination == 52)
			price = 2;
		else
		if(start == 51 && destination == 53)
			price = 2;
		else
		if(start == 51 && destination == 54)
			price = 3;
		else
		if(start == 51 && destination == 55)
			price = 3;
		else
		if(start == 51 && destination == 56)
			price = 4;
		else
		if(start == 51 && destination == 57)
			price = 4;
		else
		if(start == 51 && destination == 58)
			price = 4;
		else
		if(start == 51 && destination == 59)
			price = 5;
		else
		if(start == 51 && destination == 60)
			price = 5;
		else
		if(start == 51 && destination == 61)
			price = 5;
		else
		if(start == 51 && destination == 62)
			price = 5;
		else
		if(start == 51 && destination == 63)
			price = 5;
		else
		if(start == 51 && destination == 64)
			price = 5;
		else
		if(start == 51 && destination == 65)
			price = 6;
		else
		if(start == 51 && destination == 66)
			price = 6;
		else
		if(start == 51 && destination == 67)
			price = 6;
		else
		if(start == 51 && destination == 68)
			price = 6;
		else
		if(start == 51 && destination == 69)
			price = 6;
		else
		if(start == 51 && destination == 70)
			price = 6;
		else
		if(start == 51 && destination == 71)
			price = 7;
		else
		if(start == 51 && destination == 72)
			price = 7;
		else
		if(start == 51 && destination == 73)
			price = 7;
		else
		if(start == 51 && destination == 74)
			price = 7;
		else
		if(start == 51 && destination == 75)
			price = 7;
		else
		if(start == 51 && destination == 76)
			price = 8;
		else
		if(start == 51 && destination == 77)
			price = 5;
		else
		if(start == 51 && destination == 78)
			price = 5;
		else
		if(start == 51 && destination == 79)
			price = 5;
		else
		if(start == 51 && destination == 80)
			price = 5;
		else
		if(start == 51 && destination == 81)
			price = 5;
		else
		if(start == 51 && destination == 82)
			price = 5;
		else
		if(start == 51 && destination == 83)
			price = 5;
		else
		if(start == 51 && destination == 84)
			price = 6;
		else
		if(start == 51 && destination == 85)
			price = 6;
		else
		if(start == 51 && destination == 86)
			price = 6;
		else
		if(start == 51 && destination == 87)
			price = 7;
		else
		if(start == 51 && destination == 88)
			price = 7;
		else
		if(start == 51 && destination == 89)
			price = 7;
		else
		if(start == 51 && destination == 90)
			price = 8;
		else
		if(start == 51 && destination == 91)
			price = 8;
		else
		if(start == 51 && destination == 92)
			price = 8;
		else
		if(start == 52 && destination == 0)
			price = 4;
		else
		if(start == 52 && destination == 1)
			price = 4;
		else
		if(start == 52 && destination == 2)
			price = 4;
		else
		if(start == 52 && destination == 3)
			price = 4;
		else
		if(start == 52 && destination == 4)
			price = 5;
		else
		if(start == 52 && destination == 5)
			price = 5;
		else
		if(start == 52 && destination == 6)
			price = 5;
		else
		if(start == 52 && destination == 7)
			price = 5;
		else
		if(start == 52 && destination == 8)
			price = 6;
		else
		if(start == 52 && destination == 9)
			price = 6;
		else
		if(start == 52 && destination == 10)
			price = 6;
		else
		if(start == 52 && destination == 11)
			price = 6;
		else
		if(start == 52 && destination == 12)
			price = 6;
		else
		if(start == 52 && destination == 13)
			price = 7;
		else
		if(start == 52 && destination == 14)
			price = 7;
		else
		if(start == 52 && destination == 15)
			price = 7;
		else
		if(start == 52 && destination == 16)
			price = 7;
		else
		if(start == 52 && destination == 17)
			price = 7;
		else
		if(start == 52 && destination == 18)
			price = 7;
		else
		if(start == 52 && destination == 19)
			price = 7;
		else
		if(start == 52 && destination == 20)
			price = 8;
		else
		if(start == 52 && destination == 21)
			price = 8;
		else
		if(start == 52 && destination == 22)
			price = 8;
		else
		if(start == 52 && destination == 23)
			price = 7;
		else
		if(start == 52 && destination == 24)
			price = 6;
		else
		if(start == 52 && destination == 25)
			price = 6;
		else
		if(start == 52 && destination == 26)
			price = 6;
		else
		if(start == 52 && destination == 27)
			price = 6;
		else
		if(start == 52 && destination == 28)
			price = 5;
		else
		if(start == 52 && destination == 29)
			price = 5;
		else
		if(start == 52 && destination == 30)
			price = 5;
		else
		if(start == 52 && destination == 31)
			price = 5;
		else
		if(start == 52 && destination == 32)
			price = 5;
		else
		if(start == 52 && destination == 33)
			price = 5;
		else
		if(start == 52 && destination == 34)
			price = 5;
		else
		if(start == 52 && destination == 35)
			price = 5;
		else
		if(start == 52 && destination == 36)
			price = 5;
		else
		if(start == 52 && destination == 37)
			price = 6;
		else
		if(start == 52 && destination == 38)
			price = 6;
		else
		if(start == 52 && destination == 39)
			price = 6;
		else
		if(start == 52 && destination == 40)
			price = 6;
		else
		if(start == 52 && destination == 41)
			price = 6;
		else
		if(start == 52 && destination == 42)
			price = 7;
		else
		if(start == 52 && destination == 43)
			price = 7;
		else
		if(start == 52 && destination == 44)
			price = 7;
		else
		if(start == 52 && destination == 45)
			price = 7;
		else
		if(start == 52 && destination == 46)
			price = 7;
		else
		if(start == 52 && destination == 47)
			price = 7;
		else
		if(start == 52 && destination == 48)
			price = 3;
		else
		if(start == 52 && destination == 49)
			price = 2;
		else
		if(start == 52 && destination == 50)
			price = 2;
		else
		if(start == 52 && destination == 51)
			price = 2;
		else
		if(start == 52 && destination == 52)
			price = 0;
		else
		if(start == 52 && destination == 53)
			price = 2;
		else
		if(start == 52 && destination == 54)
			price = 3;
		else
		if(start == 52 && destination == 55)
			price = 3;
		else
		if(start == 52 && destination == 56)
			price = 3;
		else
		if(start == 52 && destination == 57)
			price = 4;
		else
		if(start == 52 && destination == 58)
			price = 4;
		else
		if(start == 52 && destination == 59)
			price = 5;
		else
		if(start == 52 && destination == 60)
			price = 5;
		else
		if(start == 52 && destination == 61)
			price = 5;
		else
		if(start == 52 && destination == 62)
			price = 5;
		else
		if(start == 52 && destination == 63)
			price = 5;
		else
		if(start == 52 && destination == 64)
			price = 5;
		else
		if(start == 52 && destination == 65)
			price = 5;
		else
		if(start == 52 && destination == 66)
			price = 6;
		else
		if(start == 52 && destination == 67)
			price = 6;
		else
		if(start == 52 && destination == 68)
			price = 6;
		else
		if(start == 52 && destination == 69)
			price = 6;
		else
		if(start == 52 && destination == 70)
			price = 6;
		else
		if(start == 52 && destination == 71)
			price = 6;
		else
		if(start == 52 && destination == 72)
			price = 7;
		else
		if(start == 52 && destination == 73)
			price = 7;
		else
		if(start == 52 && destination == 74)
			price = 7;
		else
		if(start == 52 && destination == 75)
			price = 7;
		else
		if(start == 52 && destination == 76)
			price = 8;
		else
		if(start == 52 && destination == 77)
			price = 5;
		else
		if(start == 52 && destination == 78)
			price = 5;
		else
		if(start == 52 && destination == 79)
			price = 5;
		else
		if(start == 52 && destination == 80)
			price = 4;
		else
		if(start == 52 && destination == 81)
			price = 5;
		else
		if(start == 52 && destination == 82)
			price = 5;
		else
		if(start == 52 && destination == 83)
			price = 5;
		else
		if(start == 52 && destination == 84)
			price = 5;
		else
		if(start == 52 && destination == 85)
			price = 6;
		else
		if(start == 52 && destination == 86)
			price = 6;
		else
		if(start == 52 && destination == 87)
			price = 7;
		else
		if(start == 52 && destination == 88)
			price = 7;
		else
		if(start == 52 && destination == 89)
			price = 7;
		else
		if(start == 52 && destination == 90)
			price = 7;
		else
		if(start == 52 && destination == 91)
			price = 8;
		else
		if(start == 52 && destination == 92)
			price = 8;
		else
		if(start == 53 && destination == 0)
			price = 4;
		else
		if(start == 53 && destination == 1)
			price = 3;
		else
		if(start == 53 && destination == 2)
			price = 4;
		else
		if(start == 53 && destination == 3)
			price = 4;
		else
		if(start == 53 && destination == 4)
			price = 4;
		else
		if(start == 53 && destination == 5)
			price = 5;
		else
		if(start == 53 && destination == 6)
			price = 5;
		else
		if(start == 53 && destination == 7)
			price = 5;
		else
		if(start == 53 && destination == 8)
			price = 5;
		else
		if(start == 53 && destination == 9)
			price = 6;
		else
		if(start == 53 && destination == 10)
			price = 6;
		else
		if(start == 53 && destination == 11)
			price = 6;
		else
		if(start == 53 && destination == 12)
			price = 6;
		else
		if(start == 53 && destination == 13)
			price = 6;
		else
		if(start == 53 && destination == 14)
			price = 6;
		else
		if(start == 53 && destination == 15)
			price = 7;
		else
		if(start == 53 && destination == 16)
			price = 7;
		else
		if(start == 53 && destination == 17)
			price = 7;
		else
		if(start == 53 && destination == 18)
			price = 7;
		else
		if(start == 53 && destination == 19)
			price = 7;
		else
		if(start == 53 && destination == 20)
			price = 7;
		else
		if(start == 53 && destination == 21)
			price = 8;
		else
		if(start == 53 && destination == 22)
			price = 8;
		else
		if(start == 53 && destination == 23)
			price = 6;
		else
		if(start == 53 && destination == 24)
			price = 6;
		else
		if(start == 53 && destination == 25)
			price = 6;
		else
		if(start == 53 && destination == 26)
			price = 6;
		else
		if(start == 53 && destination == 27)
			price = 5;
		else
		if(start == 53 && destination == 28)
			price = 5;
		else
		if(start == 53 && destination == 29)
			price = 5;
		else
		if(start == 53 && destination == 30)
			price = 5;
		else
		if(start == 53 && destination == 31)
			price = 5;
		else
		if(start == 53 && destination == 32)
			price = 5;
		else
		if(start == 53 && destination == 33)
			price = 4;
		else
		if(start == 53 && destination == 34)
			price = 5;
		else
		if(start == 53 && destination == 35)
			price = 5;
		else
		if(start == 53 && destination == 36)
			price = 5;
		else
		if(start == 53 && destination == 37)
			price = 5;
		else
		if(start == 53 && destination == 38)
			price = 5;
		else
		if(start == 53 && destination == 39)
			price = 6;
		else
		if(start == 53 && destination == 40)
			price = 6;
		else
		if(start == 53 && destination == 41)
			price = 6;
		else
		if(start == 53 && destination == 42)
			price = 6;
		else
		if(start == 53 && destination == 43)
			price = 7;
		else
		if(start == 53 && destination == 44)
			price = 7;
		else
		if(start == 53 && destination == 45)
			price = 7;
		else
		if(start == 53 && destination == 46)
			price = 7;
		else
		if(start == 53 && destination == 47)
			price = 7;
		else
		if(start == 53 && destination == 48)
			price = 3;
		else
		if(start == 53 && destination == 49)
			price = 3;
		else
		if(start == 53 && destination == 50)
			price = 3;
		else
		if(start == 53 && destination == 51)
			price = 2;
		else
		if(start == 53 && destination == 52)
			price = 2;
		else
		if(start == 53 && destination == 53)
			price = 0;
		else
		if(start == 53 && destination == 54)
			price = 2;
		else
		if(start == 53 && destination == 55)
			price = 3;
		else
		if(start == 53 && destination == 56)
			price = 3;
		else
		if(start == 53 && destination == 57)
			price = 3;
		else
		if(start == 53 && destination == 58)
			price = 4;
		else
		if(start == 53 && destination == 59)
			price = 4;
		else
		if(start == 53 && destination == 60)
			price = 4;
		else
		if(start == 53 && destination == 61)
			price = 5;
		else
		if(start == 53 && destination == 62)
			price = 5;
		else
		if(start == 53 && destination == 63)
			price = 5;
		else
		if(start == 53 && destination == 64)
			price = 5;
		else
		if(start == 53 && destination == 65)
			price = 5;
		else
		if(start == 53 && destination == 66)
			price = 5;
		else
		if(start == 53 && destination == 67)
			price = 5;
		else
		if(start == 53 && destination == 68)
			price = 6;
		else
		if(start == 53 && destination == 69)
			price = 6;
		else
		if(start == 53 && destination == 70)
			price = 6;
		else
		if(start == 53 && destination == 71)
			price = 6;
		else
		if(start == 53 && destination == 72)
			price = 6;
		else
		if(start == 53 && destination == 73)
			price = 7;
		else
		if(start == 53 && destination == 74)
			price = 7;
		else
		if(start == 53 && destination == 75)
			price = 7;
		else
		if(start == 53 && destination == 76)
			price = 7;
		else
		if(start == 53 && destination == 77)
			price = 5;
		else
		if(start == 53 && destination == 78)
			price = 5;
		else
		if(start == 53 && destination == 79)
			price = 4;
		else
		if(start == 53 && destination == 80)
			price = 4;
		else
		if(start == 53 && destination == 81)
			price = 4;
		else
		if(start == 53 && destination == 82)
			price = 5;
		else
		if(start == 53 && destination == 83)
			price = 5;
		else
		if(start == 53 && destination == 84)
			price = 5;
		else
		if(start == 53 && destination == 85)
			price = 5;
		else
		if(start == 53 && destination == 86)
			price = 6;
		else
		if(start == 53 && destination == 87)
			price = 7;
		else
		if(start == 53 && destination == 88)
			price = 7;
		else
		if(start == 53 && destination == 89)
			price = 7;
		else
		if(start == 53 && destination == 90)
			price = 7;
		else
		if(start == 53 && destination == 91)
			price = 7;
		else
		if(start == 53 && destination == 92)
			price = 8;
		else
		if(start == 54 && destination == 0)
			price = 3;
		else
		if(start == 54 && destination == 1)
			price = 3;
		else
		if(start == 54 && destination == 2)
			price = 3;
		else
		if(start == 54 && destination == 3)
			price = 3;
		else
		if(start == 54 && destination == 4)
			price = 3;
		else
		if(start == 54 && destination == 5)
			price = 4;
		else
		if(start == 54 && destination == 6)
			price = 4;
		else
		if(start == 54 && destination == 7)
			price = 5;
		else
		if(start == 54 && destination == 8)
			price = 5;
		else
		if(start == 54 && destination == 9)
			price = 5;
		else
		if(start == 54 && destination == 10)
			price = 5;
		else
		if(start == 54 && destination == 11)
			price = 5;
		else
		if(start == 54 && destination == 12)
			price = 6;
		else
		if(start == 54 && destination == 13)
			price = 6;
		else
		if(start == 54 && destination == 14)
			price = 6;
		else
		if(start == 54 && destination == 15)
			price = 6;
		else
		if(start == 54 && destination == 16)
			price = 6;
		else
		if(start == 54 && destination == 17)
			price = 7;
		else
		if(start == 54 && destination == 18)
			price = 7;
		else
		if(start == 54 && destination == 19)
			price = 7;
		else
		if(start == 54 && destination == 20)
			price = 7;
		else
		if(start == 54 && destination == 21)
			price = 7;
		else
		if(start == 54 && destination == 22)
			price = 8;
		else
		if(start == 54 && destination == 23)
			price = 6;
		else
		if(start == 54 && destination == 24)
			price = 6;
		else
		if(start == 54 && destination == 25)
			price = 5;
		else
		if(start == 54 && destination == 26)
			price = 5;
		else
		if(start == 54 && destination == 27)
			price = 5;
		else
		if(start == 54 && destination == 28)
			price = 5;
		else
		if(start == 54 && destination == 29)
			price = 4;
		else
		if(start == 54 && destination == 30)
			price = 4;
		else
		if(start == 54 && destination == 31)
			price = 4;
		else
		if(start == 54 && destination == 32)
			price = 4;
		else
		if(start == 54 && destination == 33)
			price = 4;
		else
		if(start == 54 && destination == 34)
			price = 4;
		else
		if(start == 54 && destination == 35)
			price = 4;
		else
		if(start == 54 && destination == 36)
			price = 5;
		else
		if(start == 54 && destination == 37)
			price = 5;
		else
		if(start == 54 && destination == 38)
			price = 5;
		else
		if(start == 54 && destination == 39)
			price = 5;
		else
		if(start == 54 && destination == 40)
			price = 5;
		else
		if(start == 54 && destination == 41)
			price = 6;
		else
		if(start == 54 && destination == 42)
			price = 6;
		else
		if(start == 54 && destination == 43)
			price = 6;
		else
		if(start == 54 && destination == 44)
			price = 6;
		else
		if(start == 54 && destination == 45)
			price = 6;
		else
		if(start == 54 && destination == 46)
			price = 7;
		else
		if(start == 54 && destination == 47)
			price = 7;
		else
		if(start == 54 && destination == 48)
			price = 4;
		else
		if(start == 54 && destination == 49)
			price = 3;
		else
		if(start == 54 && destination == 50)
			price = 3;
		else
		if(start == 54 && destination == 51)
			price = 3;
		else
		if(start == 54 && destination == 52)
			price = 3;
		else
		if(start == 54 && destination == 53)
			price = 2;
		else
		if(start == 54 && destination == 54)
			price = 0;
		else
		if(start == 54 && destination == 55)
			price = 2;
		else
		if(start == 54 && destination == 56)
			price = 2;
		else
		if(start == 54 && destination == 57)
			price = 3;
		else
		if(start == 54 && destination == 58)
			price = 3;
		else
		if(start == 54 && destination == 59)
			price = 3;
		else
		if(start == 54 && destination == 60)
			price = 4;
		else
		if(start == 54 && destination == 61)
			price = 4;
		else
		if(start == 54 && destination == 62)
			price = 4;
		else
		if(start == 54 && destination == 63)
			price = 4;
		else
		if(start == 54 && destination == 64)
			price = 4;
		else
		if(start == 54 && destination == 65)
			price = 5;
		else
		if(start == 54 && destination == 66)
			price = 5;
		else
		if(start == 54 && destination == 67)
			price = 5;
		else
		if(start == 54 && destination == 68)
			price = 5;
		else
		if(start == 54 && destination == 69)
			price = 5;
		else
		if(start == 54 && destination == 70)
			price = 5;
		else
		if(start == 54 && destination == 71)
			price = 6;
		else
		if(start == 54 && destination == 72)
			price = 6;
		else
		if(start == 54 && destination == 73)
			price = 6;
		else
		if(start == 54 && destination == 74)
			price = 7;
		else
		if(start == 54 && destination == 75)
			price = 7;
		else
		if(start == 54 && destination == 76)
			price = 7;
		else
		if(start == 54 && destination == 77)
			price = 4;
		else
		if(start == 54 && destination == 78)
			price = 4;
		else
		if(start == 54 && destination == 79)
			price = 3;
		else
		if(start == 54 && destination == 80)
			price = 3;
		else
		if(start == 54 && destination == 81)
			price = 4;
		else
		if(start == 54 && destination == 82)
			price = 4;
		else
		if(start == 54 && destination == 83)
			price = 4;
		else
		if(start == 54 && destination == 84)
			price = 5;
		else
		if(start == 54 && destination == 85)
			price = 5;
		else
		if(start == 54 && destination == 86)
			price = 5;
		else
		if(start == 54 && destination == 87)
			price = 6;
		else
		if(start == 54 && destination == 88)
			price = 6;
		else
		if(start == 54 && destination == 89)
			price = 7;
		else
		if(start == 54 && destination == 90)
			price = 7;
		else
		if(start == 54 && destination == 91)
			price = 7;
		else
		if(start == 54 && destination == 92)
			price = 7;
		else
		if(start == 55 && destination == 0)
			price = 3;
		else
		if(start == 55 && destination == 1)
			price = 3;
		else
		if(start == 55 && destination == 2)
			price = 3;
		else
		if(start == 55 && destination == 3)
			price = 3;
		else
		if(start == 55 && destination == 4)
			price = 3;
		else
		if(start == 55 && destination == 5)
			price = 4;
		else
		if(start == 55 && destination == 6)
			price = 4;
		else
		if(start == 55 && destination == 7)
			price = 4;
		else
		if(start == 55 && destination == 8)
			price = 5;
		else
		if(start == 55 && destination == 9)
			price = 5;
		else
		if(start == 55 && destination == 10)
			price = 5;
		else
		if(start == 55 && destination == 11)
			price = 5;
		else
		if(start == 55 && destination == 12)
			price = 5;
		else
		if(start == 55 && destination == 13)
			price = 6;
		else
		if(start == 55 && destination == 14)
			price = 6;
		else
		if(start == 55 && destination == 15)
			price = 6;
		else
		if(start == 55 && destination == 16)
			price = 6;
		else
		if(start == 55 && destination == 17)
			price = 6;
		else
		if(start == 55 && destination == 18)
			price = 7;
		else
		if(start == 55 && destination == 19)
			price = 7;
		else
		if(start == 55 && destination == 20)
			price = 7;
		else
		if(start == 55 && destination == 21)
			price = 7;
		else
		if(start == 55 && destination == 22)
			price = 7;
		else
		if(start == 55 && destination == 23)
			price = 6;
		else
		if(start == 55 && destination == 24)
			price = 5;
		else
		if(start == 55 && destination == 25)
			price = 5;
		else
		if(start == 55 && destination == 26)
			price = 5;
		else
		if(start == 55 && destination == 27)
			price = 5;
		else
		if(start == 55 && destination == 28)
			price = 5;
		else
		if(start == 55 && destination == 29)
			price = 4;
		else
		if(start == 55 && destination == 30)
			price = 4;
		else
		if(start == 55 && destination == 31)
			price = 4;
		else
		if(start == 55 && destination == 32)
			price = 4;
		else
		if(start == 55 && destination == 33)
			price = 4;
		else
		if(start == 55 && destination == 34)
			price = 4;
		else
		if(start == 55 && destination == 35)
			price = 4;
		else
		if(start == 55 && destination == 36)
			price = 4;
		else
		if(start == 55 && destination == 37)
			price = 5;
		else
		if(start == 55 && destination == 38)
			price = 5;
		else
		if(start == 55 && destination == 39)
			price = 5;
		else
		if(start == 55 && destination == 40)
			price = 5;
		else
		if(start == 55 && destination == 41)
			price = 6;
		else
		if(start == 55 && destination == 42)
			price = 6;
		else
		if(start == 55 && destination == 43)
			price = 6;
		else
		if(start == 55 && destination == 44)
			price = 6;
		else
		if(start == 55 && destination == 45)
			price = 6;
		else
		if(start == 55 && destination == 46)
			price = 7;
		else
		if(start == 55 && destination == 47)
			price = 7;
		else
		if(start == 55 && destination == 48)
			price = 4;
		else
		if(start == 55 && destination == 49)
			price = 4;
		else
		if(start == 55 && destination == 50)
			price = 3;
		else
		if(start == 55 && destination == 51)
			price = 3;
		else
		if(start == 55 && destination == 52)
			price = 3;
		else
		if(start == 55 && destination == 53)
			price = 3;
		else
		if(start == 55 && destination == 54)
			price = 2;
		else
		if(start == 55 && destination == 55)
			price = 0;
		else
		if(start == 55 && destination == 56)
			price = 2;
		else
		if(start == 55 && destination == 57)
			price = 2;
		else
		if(start == 55 && destination == 58)
			price = 3;
		else
		if(start == 55 && destination == 59)
			price = 3;
		else
		if(start == 55 && destination == 60)
			price = 3;
		else
		if(start == 55 && destination == 61)
			price = 4;
		else
		if(start == 55 && destination == 62)
			price = 4;
		else
		if(start == 55 && destination == 63)
			price = 4;
		else
		if(start == 55 && destination == 64)
			price = 4;
		else
		if(start == 55 && destination == 65)
			price = 5;
		else
		if(start == 55 && destination == 66)
			price = 5;
		else
		if(start == 55 && destination == 67)
			price = 5;
		else
		if(start == 55 && destination == 68)
			price = 5;
		else
		if(start == 55 && destination == 69)
			price = 5;
		else
		if(start == 55 && destination == 70)
			price = 5;
		else
		if(start == 55 && destination == 71)
			price = 6;
		else
		if(start == 55 && destination == 72)
			price = 6;
		else
		if(start == 55 && destination == 73)
			price = 6;
		else
		if(start == 55 && destination == 74)
			price = 6;
		else
		if(start == 55 && destination == 75)
			price = 7;
		else
		if(start == 55 && destination == 76)
			price = 7;
		else
		if(start == 55 && destination == 77)
			price = 4;
		else
		if(start == 55 && destination == 78)
			price = 4;
		else
		if(start == 55 && destination == 79)
			price = 3;
		else
		if(start == 55 && destination == 80)
			price = 3;
		else
		if(start == 55 && destination == 81)
			price = 3;
		else
		if(start == 55 && destination == 82)
			price = 4;
		else
		if(start == 55 && destination == 83)
			price = 4;
		else
		if(start == 55 && destination == 84)
			price = 4;
		else
		if(start == 55 && destination == 85)
			price = 5;
		else
		if(start == 55 && destination == 86)
			price = 5;
		else
		if(start == 55 && destination == 87)
			price = 6;
		else
		if(start == 55 && destination == 88)
			price = 6;
		else
		if(start == 55 && destination == 89)
			price = 6;
		else
		if(start == 55 && destination == 90)
			price = 7;
		else
		if(start == 55 && destination == 91)
			price = 7;
		else
		if(start == 55 && destination == 92)
			price = 7;
		else
		if(start == 56 && destination == 0)
			price = 2;
		else
		if(start == 56 && destination == 1)
			price = 2;
		else
		if(start == 56 && destination == 2)
			price = 2;
		else
		if(start == 56 && destination == 3)
			price = 3;
		else
		if(start == 56 && destination == 4)
			price = 3;
		else
		if(start == 56 && destination == 5)
			price = 3;
		else
		if(start == 56 && destination == 6)
			price = 4;
		else
		if(start == 56 && destination == 7)
			price = 4;
		else
		if(start == 56 && destination == 8)
			price = 4;
		else
		if(start == 56 && destination == 9)
			price = 5;
		else
		if(start == 56 && destination == 10)
			price = 5;
		else
		if(start == 56 && destination == 11)
			price = 5;
		else
		if(start == 56 && destination == 12)
			price = 5;
		else
		if(start == 56 && destination == 13)
			price = 5;
		else
		if(start == 56 && destination == 14)
			price = 6;
		else
		if(start == 56 && destination == 15)
			price = 6;
		else
		if(start == 56 && destination == 16)
			price = 6;
		else
		if(start == 56 && destination == 17)
			price = 6;
		else
		if(start == 56 && destination == 18)
			price = 6;
		else
		if(start == 56 && destination == 19)
			price = 7;
		else
		if(start == 56 && destination == 20)
			price = 7;
		else
		if(start == 56 && destination == 21)
			price = 7;
		else
		if(start == 56 && destination == 22)
			price = 7;
		else
		if(start == 56 && destination == 23)
			price = 5;
		else
		if(start == 56 && destination == 24)
			price = 5;
		else
		if(start == 56 && destination == 25)
			price = 5;
		else
		if(start == 56 && destination == 26)
			price = 5;
		else
		if(start == 56 && destination == 27)
			price = 4;
		else
		if(start == 56 && destination == 28)
			price = 4;
		else
		if(start == 56 && destination == 29)
			price = 4;
		else
		if(start == 56 && destination == 30)
			price = 4;
		else
		if(start == 56 && destination == 31)
			price = 3;
		else
		if(start == 56 && destination == 32)
			price = 3;
		else
		if(start == 56 && destination == 33)
			price = 3;
		else
		if(start == 56 && destination == 34)
			price = 3;
		else
		if(start == 56 && destination == 35)
			price = 4;
		else
		if(start == 56 && destination == 36)
			price = 4;
		else
		if(start == 56 && destination == 37)
			price = 4;
		else
		if(start == 56 && destination == 38)
			price = 4;
		else
		if(start == 56 && destination == 39)
			price = 5;
		else
		if(start == 56 && destination == 40)
			price = 5;
		else
		if(start == 56 && destination == 41)
			price = 5;
		else
		if(start == 56 && destination == 42)
			price = 6;
		else
		if(start == 56 && destination == 43)
			price = 6;
		else
		if(start == 56 && destination == 44)
			price = 6;
		else
		if(start == 56 && destination == 45)
			price = 6;
		else
		if(start == 56 && destination == 46)
			price = 6;
		else
		if(start == 56 && destination == 47)
			price = 7;
		else
		if(start == 56 && destination == 48)
			price = 5;
		else
		if(start == 56 && destination == 49)
			price = 4;
		else
		if(start == 56 && destination == 50)
			price = 4;
		else
		if(start == 56 && destination == 51)
			price = 4;
		else
		if(start == 56 && destination == 52)
			price = 3;
		else
		if(start == 56 && destination == 53)
			price = 3;
		else
		if(start == 56 && destination == 54)
			price = 2;
		else
		if(start == 56 && destination == 55)
			price = 2;
		else
		if(start == 56 && destination == 56)
			price = 0;
		else
		if(start == 56 && destination == 57)
			price = 2;
		else
		if(start == 56 && destination == 58)
			price = 2;
		else
		if(start == 56 && destination == 59)
			price = 3;
		else
		if(start == 56 && destination == 60)
			price = 3;
		else
		if(start == 56 && destination == 61)
			price = 3;
		else
		if(start == 56 && destination == 62)
			price = 3;
		else
		if(start == 56 && destination == 63)
			price = 4;
		else
		if(start == 56 && destination == 64)
			price = 4;
		else
		if(start == 56 && destination == 65)
			price = 4;
		else
		if(start == 56 && destination == 66)
			price = 4;
		else
		if(start == 56 && destination == 67)
			price = 5;
		else
		if(start == 56 && destination == 68)
			price = 5;
		else
		if(start == 56 && destination == 69)
			price = 5;
		else
		if(start == 56 && destination == 70)
			price = 5;
		else
		if(start == 56 && destination == 71)
			price = 5;
		else
		if(start == 56 && destination == 72)
			price = 6;
		else
		if(start == 56 && destination == 73)
			price = 6;
		else
		if(start == 56 && destination == 74)
			price = 6;
		else
		if(start == 56 && destination == 75)
			price = 6;
		else
		if(start == 56 && destination == 76)
			price = 7;
		else
		if(start == 56 && destination == 77)
			price = 4;
		else
		if(start == 56 && destination == 78)
			price = 3;
		else
		if(start == 56 && destination == 79)
			price = 3;
		else
		if(start == 56 && destination == 80)
			price = 3;
		else
		if(start == 56 && destination == 81)
			price = 3;
		else
		if(start == 56 && destination == 82)
			price = 3;
		else
		if(start == 56 && destination == 83)
			price = 4;
		else
		if(start == 56 && destination == 84)
			price = 4;
		else
		if(start == 56 && destination == 85)
			price = 5;
		else
		if(start == 56 && destination == 86)
			price = 5;
		else
		if(start == 56 && destination == 87)
			price = 6;
		else
		if(start == 56 && destination == 88)
			price = 6;
		else
		if(start == 56 && destination == 89)
			price = 6;
		else
		if(start == 56 && destination == 90)
			price = 7;
		else
		if(start == 56 && destination == 91)
			price = 7;
		else
		if(start == 56 && destination == 92)
			price = 7;
		else
		if(start == 57 && destination == 0)
			price = 2;
		else
		if(start == 57 && destination == 1)
			price = 2;
		else
		if(start == 57 && destination == 2)
			price = 2;
		else
		if(start == 57 && destination == 3)
			price = 2;
		else
		if(start == 57 && destination == 4)
			price = 3;
		else
		if(start == 57 && destination == 5)
			price = 3;
		else
		if(start == 57 && destination == 6)
			price = 3;
		else
		if(start == 57 && destination == 7)
			price = 4;
		else
		if(start == 57 && destination == 8)
			price = 4;
		else
		if(start == 57 && destination == 9)
			price = 4;
		else
		if(start == 57 && destination == 10)
			price = 5;
		else
		if(start == 57 && destination == 11)
			price = 5;
		else
		if(start == 57 && destination == 12)
			price = 5;
		else
		if(start == 57 && destination == 13)
			price = 5;
		else
		if(start == 57 && destination == 14)
			price = 5;
		else
		if(start == 57 && destination == 15)
			price = 6;
		else
		if(start == 57 && destination == 16)
			price = 6;
		else
		if(start == 57 && destination == 17)
			price = 6;
		else
		if(start == 57 && destination == 18)
			price = 6;
		else
		if(start == 57 && destination == 19)
			price = 6;
		else
		if(start == 57 && destination == 20)
			price = 7;
		else
		if(start == 57 && destination == 21)
			price = 7;
		else
		if(start == 57 && destination == 22)
			price = 7;
		else
		if(start == 57 && destination == 23)
			price = 5;
		else
		if(start == 57 && destination == 24)
			price = 5;
		else
		if(start == 57 && destination == 25)
			price = 5;
		else
		if(start == 57 && destination == 26)
			price = 4;
		else
		if(start == 57 && destination == 27)
			price = 4;
		else
		if(start == 57 && destination == 28)
			price = 4;
		else
		if(start == 57 && destination == 29)
			price = 4;
		else
		if(start == 57 && destination == 30)
			price = 3;
		else
		if(start == 57 && destination == 31)
			price = 3;
		else
		if(start == 57 && destination == 32)
			price = 3;
		else
		if(start == 57 && destination == 33)
			price = 3;
		else
		if(start == 57 && destination == 34)
			price = 3;
		else
		if(start == 57 && destination == 35)
			price = 3;
		else
		if(start == 57 && destination == 36)
			price = 4;
		else
		if(start == 57 && destination == 37)
			price = 4;
		else
		if(start == 57 && destination == 38)
			price = 4;
		else
		if(start == 57 && destination == 39)
			price = 4;
		else
		if(start == 57 && destination == 40)
			price = 5;
		else
		if(start == 57 && destination == 41)
			price = 5;
		else
		if(start == 57 && destination == 42)
			price = 5;
		else
		if(start == 57 && destination == 43)
			price = 5;
		else
		if(start == 57 && destination == 44)
			price = 6;
		else
		if(start == 57 && destination == 45)
			price = 6;
		else
		if(start == 57 && destination == 46)
			price = 6;
		else
		if(start == 57 && destination == 47)
			price = 6;
		else
		if(start == 57 && destination == 48)
			price = 5;
		else
		if(start == 57 && destination == 49)
			price = 4;
		else
		if(start == 57 && destination == 50)
			price = 4;
		else
		if(start == 57 && destination == 51)
			price = 4;
		else
		if(start == 57 && destination == 52)
			price = 4;
		else
		if(start == 57 && destination == 53)
			price = 3;
		else
		if(start == 57 && destination == 54)
			price = 3;
		else
		if(start == 57 && destination == 55)
			price = 2;
		else
		if(start == 57 && destination == 56)
			price = 2;
		else
		if(start == 57 && destination == 57)
			price = 0;
		else
		if(start == 57 && destination == 58)
			price = 2;
		else
		if(start == 57 && destination == 59)
			price = 3;
		else
		if(start == 57 && destination == 60)
			price = 3;
		else
		if(start == 57 && destination == 61)
			price = 3;
		else
		if(start == 57 && destination == 62)
			price = 3;
		else
		if(start == 57 && destination == 63)
			price = 3;
		else
		if(start == 57 && destination == 64)
			price = 4;
		else
		if(start == 57 && destination == 65)
			price = 4;
		else
		if(start == 57 && destination == 66)
			price = 4;
		else
		if(start == 57 && destination == 67)
			price = 4;
		else
		if(start == 57 && destination == 68)
			price = 5;
		else
		if(start == 57 && destination == 69)
			price = 5;
		else
		if(start == 57 && destination == 70)
			price = 5;
		else
		if(start == 57 && destination == 71)
			price = 5;
		else
		if(start == 57 && destination == 72)
			price = 5;
		else
		if(start == 57 && destination == 73)
			price = 6;
		else
		if(start == 57 && destination == 74)
			price = 6;
		else
		if(start == 57 && destination == 75)
			price = 6;
		else
		if(start == 57 && destination == 76)
			price = 7;
		else
		if(start == 57 && destination == 77)
			price = 3;
		else
		if(start == 57 && destination == 78)
			price = 3;
		else
		if(start == 57 && destination == 79)
			price = 3;
		else
		if(start == 57 && destination == 80)
			price = 2;
		else
		if(start == 57 && destination == 81)
			price = 3;
		else
		if(start == 57 && destination == 82)
			price = 3;
		else
		if(start == 57 && destination == 83)
			price = 3;
		else
		if(start == 57 && destination == 84)
			price = 4;
		else
		if(start == 57 && destination == 85)
			price = 4;
		else
		if(start == 57 && destination == 86)
			price = 5;
		else
		if(start == 57 && destination == 87)
			price = 6;
		else
		if(start == 57 && destination == 88)
			price = 6;
		else
		if(start == 57 && destination == 89)
			price = 6;
		else
		if(start == 57 && destination == 90)
			price = 6;
		else
		if(start == 57 && destination == 91)
			price = 7;
		else
		if(start == 57 && destination == 92)
			price = 7;
		else
		if(start == 58 && destination == 0)
			price = 3;
		else
		if(start == 58 && destination == 1)
			price = 2;
		else
		if(start == 58 && destination == 2)
			price = 2;
		else
		if(start == 58 && destination == 3)
			price = 3;
		else
		if(start == 58 && destination == 4)
			price = 3;
		else
		if(start == 58 && destination == 5)
			price = 3;
		else
		if(start == 58 && destination == 6)
			price = 3;
		else
		if(start == 58 && destination == 7)
			price = 4;
		else
		if(start == 58 && destination == 8)
			price = 4;
		else
		if(start == 58 && destination == 9)
			price = 4;
		else
		if(start == 58 && destination == 10)
			price = 5;
		else
		if(start == 58 && destination == 11)
			price = 5;
		else
		if(start == 58 && destination == 12)
			price = 5;
		else
		if(start == 58 && destination == 13)
			price = 5;
		else
		if(start == 58 && destination == 14)
			price = 5;
		else
		if(start == 58 && destination == 15)
			price = 5;
		else
		if(start == 58 && destination == 16)
			price = 5;
		else
		if(start == 58 && destination == 17)
			price = 6;
		else
		if(start == 58 && destination == 18)
			price = 6;
		else
		if(start == 58 && destination == 19)
			price = 6;
		else
		if(start == 58 && destination == 20)
			price = 6;
		else
		if(start == 58 && destination == 21)
			price = 7;
		else
		if(start == 58 && destination == 22)
			price = 7;
		else
		if(start == 58 && destination == 23)
			price = 5;
		else
		if(start == 58 && destination == 24)
			price = 5;
		else
		if(start == 58 && destination == 25)
			price = 5;
		else
		if(start == 58 && destination == 26)
			price = 4;
		else
		if(start == 58 && destination == 27)
			price = 4;
		else
		if(start == 58 && destination == 28)
			price = 4;
		else
		if(start == 58 && destination == 29)
			price = 4;
		else
		if(start == 58 && destination == 30)
			price = 3;
		else
		if(start == 58 && destination == 31)
			price = 3;
		else
		if(start == 58 && destination == 32)
			price = 3;
		else
		if(start == 58 && destination == 33)
			price = 3;
		else
		if(start == 58 && destination == 34)
			price = 3;
		else
		if(start == 58 && destination == 35)
			price = 3;
		else
		if(start == 58 && destination == 36)
			price = 3;
		else
		if(start == 58 && destination == 37)
			price = 4;
		else
		if(start == 58 && destination == 38)
			price = 4;
		else
		if(start == 58 && destination == 39)
			price = 4;
		else
		if(start == 58 && destination == 40)
			price = 5;
		else
		if(start == 58 && destination == 41)
			price = 5;
		else
		if(start == 58 && destination == 42)
			price = 5;
		else
		if(start == 58 && destination == 43)
			price = 5;
		else
		if(start == 58 && destination == 44)
			price = 5;
		else
		if(start == 58 && destination == 45)
			price = 6;
		else
		if(start == 58 && destination == 46)
			price = 6;
		else
		if(start == 58 && destination == 47)
			price = 6;
		else
		if(start == 58 && destination == 48)
			price = 5;
		else
		if(start == 58 && destination == 49)
			price = 5;
		else
		if(start == 58 && destination == 50)
			price = 5;
		else
		if(start == 58 && destination == 51)
			price = 4;
		else
		if(start == 58 && destination == 52)
			price = 4;
		else
		if(start == 58 && destination == 53)
			price = 4;
		else
		if(start == 58 && destination == 54)
			price = 3;
		else
		if(start == 58 && destination == 55)
			price = 3;
		else
		if(start == 58 && destination == 56)
			price = 2;
		else
		if(start == 58 && destination == 57)
			price = 2;
		else
		if(start == 58 && destination == 58)
			price = 0;
		else
		if(start == 58 && destination == 59)
			price = 2;
		else
		if(start == 58 && destination == 60)
			price = 2;
		else
		if(start == 58 && destination == 61)
			price = 3;
		else
		if(start == 58 && destination == 62)
			price = 3;
		else
		if(start == 58 && destination == 63)
			price = 3;
		else
		if(start == 58 && destination == 64)
			price = 3;
		else
		if(start == 58 && destination == 65)
			price = 3;
		else
		if(start == 58 && destination == 66)
			price = 4;
		else
		if(start == 58 && destination == 67)
			price = 4;
		else
		if(start == 58 && destination == 68)
			price = 4;
		else
		if(start == 58 && destination == 69)
			price = 4;
		else
		if(start == 58 && destination == 70)
			price = 5;
		else
		if(start == 58 && destination == 71)
			price = 5;
		else
		if(start == 58 && destination == 72)
			price = 5;
		else
		if(start == 58 && destination == 73)
			price = 5;
		else
		if(start == 58 && destination == 74)
			price = 6;
		else
		if(start == 58 && destination == 75)
			price = 6;
		else
		if(start == 58 && destination == 76)
			price = 6;
		else
		if(start == 58 && destination == 77)
			price = 3;
		else
		if(start == 58 && destination == 78)
			price = 3;
		else
		if(start == 58 && destination == 79)
			price = 3;
		else
		if(start == 58 && destination == 80)
			price = 3;
		else
		if(start == 58 && destination == 81)
			price = 2;
		else
		if(start == 58 && destination == 82)
			price = 3;
		else
		if(start == 58 && destination == 83)
			price = 3;
		else
		if(start == 58 && destination == 84)
			price = 3;
		else
		if(start == 58 && destination == 85)
			price = 4;
		else
		if(start == 58 && destination == 86)
			price = 4;
		else
		if(start == 58 && destination == 87)
			price = 5;
		else
		if(start == 58 && destination == 88)
			price = 5;
		else
		if(start == 58 && destination == 89)
			price = 6;
		else
		if(start == 58 && destination == 90)
			price = 6;
		else
		if(start == 58 && destination == 91)
			price = 6;
		else
		if(start == 58 && destination == 92)
			price = 7;
		else
		if(start == 59 && destination == 0)
			price = 3;
		else
		if(start == 59 && destination == 1)
			price = 3;
		else
		if(start == 59 && destination == 2)
			price = 2;
		else
		if(start == 59 && destination == 3)
			price = 2;
		else
		if(start == 59 && destination == 4)
			price = 2;
		else
		if(start == 59 && destination == 5)
			price = 2;
		else
		if(start == 59 && destination == 6)
			price = 3;
		else
		if(start == 59 && destination == 7)
			price = 3;
		else
		if(start == 59 && destination == 8)
			price = 3;
		else
		if(start == 59 && destination == 9)
			price = 4;
		else
		if(start == 59 && destination == 10)
			price = 4;
		else
		if(start == 59 && destination == 11)
			price = 4;
		else
		if(start == 59 && destination == 12)
			price = 4;
		else
		if(start == 59 && destination == 13)
			price = 5;
		else
		if(start == 59 && destination == 14)
			price = 5;
		else
		if(start == 59 && destination == 15)
			price = 5;
		else
		if(start == 59 && destination == 16)
			price = 5;
		else
		if(start == 59 && destination == 17)
			price = 5;
		else
		if(start == 59 && destination == 18)
			price = 5;
		else
		if(start == 59 && destination == 19)
			price = 6;
		else
		if(start == 59 && destination == 20)
			price = 6;
		else
		if(start == 59 && destination == 21)
			price = 6;
		else
		if(start == 59 && destination == 22)
			price = 7;
		else
		if(start == 59 && destination == 23)
			price = 5;
		else
		if(start == 59 && destination == 24)
			price = 4;
		else
		if(start == 59 && destination == 25)
			price = 4;
		else
		if(start == 59 && destination == 26)
			price = 4;
		else
		if(start == 59 && destination == 27)
			price = 4;
		else
		if(start == 59 && destination == 28)
			price = 3;
		else
		if(start == 59 && destination == 29)
			price = 3;
		else
		if(start == 59 && destination == 30)
			price = 3;
		else
		if(start == 59 && destination == 31)
			price = 3;
		else
		if(start == 59 && destination == 32)
			price = 2;
		else
		if(start == 59 && destination == 33)
			price = 2;
		else
		if(start == 59 && destination == 34)
			price = 2;
		else
		if(start == 59 && destination == 35)
			price = 2;
		else
		if(start == 59 && destination == 36)
			price = 3;
		else
		if(start == 59 && destination == 37)
			price = 3;
		else
		if(start == 59 && destination == 38)
			price = 3;
		else
		if(start == 59 && destination == 39)
			price = 3;
		else
		if(start == 59 && destination == 40)
			price = 4;
		else
		if(start == 59 && destination == 41)
			price = 4;
		else
		if(start == 59 && destination == 42)
			price = 5;
		else
		if(start == 59 && destination == 43)
			price = 5;
		else
		if(start == 59 && destination == 44)
			price = 5;
		else
		if(start == 59 && destination == 45)
			price = 5;
		else
		if(start == 59 && destination == 46)
			price = 5;
		else
		if(start == 59 && destination == 47)
			price = 6;
		else
		if(start == 59 && destination == 48)
			price = 5;
		else
		if(start == 59 && destination == 49)
			price = 5;
		else
		if(start == 59 && destination == 50)
			price = 5;
		else
		if(start == 59 && destination == 51)
			price = 5;
		else
		if(start == 59 && destination == 52)
			price = 5;
		else
		if(start == 59 && destination == 53)
			price = 4;
		else
		if(start == 59 && destination == 54)
			price = 3;
		else
		if(start == 59 && destination == 55)
			price = 3;
		else
		if(start == 59 && destination == 56)
			price = 3;
		else
		if(start == 59 && destination == 57)
			price = 3;
		else
		if(start == 59 && destination == 58)
			price = 2;
		else
		if(start == 59 && destination == 59)
			price = 0;
		else
		if(start == 59 && destination == 60)
			price = 2;
		else
		if(start == 59 && destination == 61)
			price = 2;
		else
		if(start == 59 && destination == 62)
			price = 2;
		else
		if(start == 59 && destination == 63)
			price = 2;
		else
		if(start == 59 && destination == 64)
			price = 3;
		else
		if(start == 59 && destination == 65)
			price = 3;
		else
		if(start == 59 && destination == 66)
			price = 3;
		else
		if(start == 59 && destination == 67)
			price = 3;
		else
		if(start == 59 && destination == 68)
			price = 4;
		else
		if(start == 59 && destination == 69)
			price = 4;
		else
		if(start == 59 && destination == 70)
			price = 4;
		else
		if(start == 59 && destination == 71)
			price = 4;
		else
		if(start == 59 && destination == 72)
			price = 5;
		else
		if(start == 59 && destination == 73)
			price = 5;
		else
		if(start == 59 && destination == 74)
			price = 5;
		else
		if(start == 59 && destination == 75)
			price = 5;
		else
		if(start == 59 && destination == 76)
			price = 6;
		else
		if(start == 59 && destination == 77)
			price = 3;
		else
		if(start == 59 && destination == 78)
			price = 2;
		else
		if(start == 59 && destination == 79)
			price = 2;
		else
		if(start == 59 && destination == 80)
			price = 2;
		else
		if(start == 59 && destination == 81)
			price = 2;
		else
		if(start == 59 && destination == 82)
			price = 2;
		else
		if(start == 59 && destination == 83)
			price = 3;
		else
		if(start == 59 && destination == 84)
			price = 3;
		else
		if(start == 59 && destination == 85)
			price = 3;
		else
		if(start == 59 && destination == 86)
			price = 4;
		else
		if(start == 59 && destination == 87)
			price = 5;
		else
		if(start == 59 && destination == 88)
			price = 5;
		else
		if(start == 59 && destination == 89)
			price = 5;
		else
		if(start == 59 && destination == 90)
			price = 6;
		else
		if(start == 59 && destination == 91)
			price = 6;
		else
		if(start == 59 && destination == 92)
			price = 6;
		else
		if(start == 60 && destination == 0)
			price = 3;
		else
		if(start == 60 && destination == 1)
			price = 3;
		else
		if(start == 60 && destination == 2)
			price = 3;
		else
		if(start == 60 && destination == 3)
			price = 2;
		else
		if(start == 60 && destination == 4)
			price = 2;
		else
		if(start == 60 && destination == 5)
			price = 2;
		else
		if(start == 60 && destination == 6)
			price = 2;
		else
		if(start == 60 && destination == 7)
			price = 3;
		else
		if(start == 60 && destination == 8)
			price = 3;
		else
		if(start == 60 && destination == 9)
			price = 4;
		else
		if(start == 60 && destination == 10)
			price = 4;
		else
		if(start == 60 && destination == 11)
			price = 4;
		else
		if(start == 60 && destination == 12)
			price = 4;
		else
		if(start == 60 && destination == 13)
			price = 4;
		else
		if(start == 60 && destination == 14)
			price = 5;
		else
		if(start == 60 && destination == 15)
			price = 5;
		else
		if(start == 60 && destination == 16)
			price = 5;
		else
		if(start == 60 && destination == 17)
			price = 5;
		else
		if(start == 60 && destination == 18)
			price = 5;
		else
		if(start == 60 && destination == 19)
			price = 6;
		else
		if(start == 60 && destination == 20)
			price = 6;
		else
		if(start == 60 && destination == 21)
			price = 6;
		else
		if(start == 60 && destination == 22)
			price = 6;
		else
		if(start == 60 && destination == 23)
			price = 5;
		else
		if(start == 60 && destination == 24)
			price = 4;
		else
		if(start == 60 && destination == 25)
			price = 4;
		else
		if(start == 60 && destination == 26)
			price = 4;
		else
		if(start == 60 && destination == 27)
			price = 3;
		else
		if(start == 60 && destination == 28)
			price = 3;
		else
		if(start == 60 && destination == 29)
			price = 3;
		else
		if(start == 60 && destination == 30)
			price = 3;
		else
		if(start == 60 && destination == 31)
			price = 2;
		else
		if(start == 60 && destination == 32)
			price = 2;
		else
		if(start == 60 && destination == 33)
			price = 2;
		else
		if(start == 60 && destination == 34)
			price = 2;
		else
		if(start == 60 && destination == 35)
			price = 2;
		else
		if(start == 60 && destination == 36)
			price = 3;
		else
		if(start == 60 && destination == 37)
			price = 3;
		else
		if(start == 60 && destination == 38)
			price = 3;
		else
		if(start == 60 && destination == 39)
			price = 3;
		else
		if(start == 60 && destination == 40)
			price = 4;
		else
		if(start == 60 && destination == 41)
			price = 4;
		else
		if(start == 60 && destination == 42)
			price = 5;
		else
		if(start == 60 && destination == 43)
			price = 5;
		else
		if(start == 60 && destination == 44)
			price = 5;
		else
		if(start == 60 && destination == 45)
			price = 5;
		else
		if(start == 60 && destination == 46)
			price = 6;
		else
		if(start == 60 && destination == 47)
			price = 6;
		else
		if(start == 60 && destination == 48)
			price = 6;
		else
		if(start == 60 && destination == 49)
			price = 5;
		else
		if(start == 60 && destination == 50)
			price = 5;
		else
		if(start == 60 && destination == 51)
			price = 5;
		else
		if(start == 60 && destination == 52)
			price = 5;
		else
		if(start == 60 && destination == 53)
			price = 4;
		else
		if(start == 60 && destination == 54)
			price = 4;
		else
		if(start == 60 && destination == 55)
			price = 3;
		else
		if(start == 60 && destination == 56)
			price = 3;
		else
		if(start == 60 && destination == 57)
			price = 3;
		else
		if(start == 60 && destination == 58)
			price = 2;
		else
		if(start == 60 && destination == 59)
			price = 2;
		else
		if(start == 60 && destination == 60)
			price = 0;
		else
		if(start == 60 && destination == 61)
			price = 2;
		else
		if(start == 60 && destination == 62)
			price = 2;
		else
		if(start == 60 && destination == 63)
			price = 2;
		else
		if(start == 60 && destination == 64)
			price = 3;
		else
		if(start == 60 && destination == 65)
			price = 3;
		else
		if(start == 60 && destination == 66)
			price = 3;
		else
		if(start == 60 && destination == 67)
			price = 3;
		else
		if(start == 60 && destination == 68)
			price = 3;
		else
		if(start == 60 && destination == 69)
			price = 4;
		else
		if(start == 60 && destination == 70)
			price = 4;
		else
		if(start == 60 && destination == 71)
			price = 4;
		else
		if(start == 60 && destination == 72)
			price = 5;
		else
		if(start == 60 && destination == 73)
			price = 5;
		else
		if(start == 60 && destination == 74)
			price = 5;
		else
		if(start == 60 && destination == 75)
			price = 5;
		else
		if(start == 60 && destination == 76)
			price = 6;
		else
		if(start == 60 && destination == 77)
			price = 3;
		else
		if(start == 60 && destination == 78)
			price = 3;
		else
		if(start == 60 && destination == 79)
			price = 2;
		else
		if(start == 60 && destination == 80)
			price = 2;
		else
		if(start == 60 && destination == 81)
			price = 2;
		else
		if(start == 60 && destination == 82)
			price = 2;
		else
		if(start == 60 && destination == 83)
			price = 3;
		else
		if(start == 60 && destination == 84)
			price = 3;
		else
		if(start == 60 && destination == 85)
			price = 3;
		else
		if(start == 60 && destination == 86)
			price = 4;
		else
		if(start == 60 && destination == 87)
			price = 5;
		else
		if(start == 60 && destination == 88)
			price = 5;
		else
		if(start == 60 && destination == 89)
			price = 5;
		else
		if(start == 60 && destination == 90)
			price = 6;
		else
		if(start == 60 && destination == 91)
			price = 6;
		else
		if(start == 60 && destination == 92)
			price = 7;
		else
		if(start == 61 && destination == 0)
			price = 3;
		else
		if(start == 61 && destination == 1)
			price = 3;
		else
		if(start == 61 && destination == 2)
			price = 3;
		else
		if(start == 61 && destination == 3)
			price = 3;
		else
		if(start == 61 && destination == 4)
			price = 2;
		else
		if(start == 61 && destination == 5)
			price = 2;
		else
		if(start == 61 && destination == 6)
			price = 2;
		else
		if(start == 61 && destination == 7)
			price = 3;
		else
		if(start == 61 && destination == 8)
			price = 3;
		else
		if(start == 61 && destination == 9)
			price = 3;
		else
		if(start == 61 && destination == 10)
			price = 4;
		else
		if(start == 61 && destination == 11)
			price = 4;
		else
		if(start == 61 && destination == 12)
			price = 4;
		else
		if(start == 61 && destination == 13)
			price = 4;
		else
		if(start == 61 && destination == 14)
			price = 4;
		else
		if(start == 61 && destination == 15)
			price = 5;
		else
		if(start == 61 && destination == 16)
			price = 5;
		else
		if(start == 61 && destination == 17)
			price = 5;
		else
		if(start == 61 && destination == 18)
			price = 5;
		else
		if(start == 61 && destination == 19)
			price = 5;
		else
		if(start == 61 && destination == 20)
			price = 6;
		else
		if(start == 61 && destination == 21)
			price = 6;
		else
		if(start == 61 && destination == 22)
			price = 6;
		else
		if(start == 61 && destination == 23)
			price = 5;
		else
		if(start == 61 && destination == 24)
			price = 4;
		else
		if(start == 61 && destination == 25)
			price = 4;
		else
		if(start == 61 && destination == 26)
			price = 3;
		else
		if(start == 61 && destination == 27)
			price = 3;
		else
		if(start == 61 && destination == 28)
			price = 3;
		else
		if(start == 61 && destination == 29)
			price = 3;
		else
		if(start == 61 && destination == 30)
			price = 2;
		else
		if(start == 61 && destination == 31)
			price = 2;
		else
		if(start == 61 && destination == 32)
			price = 2;
		else
		if(start == 61 && destination == 33)
			price = 2;
		else
		if(start == 61 && destination == 34)
			price = 2;
		else
		if(start == 61 && destination == 35)
			price = 2;
		else
		if(start == 61 && destination == 36)
			price = 2;
		else
		if(start == 61 && destination == 37)
			price = 3;
		else
		if(start == 61 && destination == 38)
			price = 3;
		else
		if(start == 61 && destination == 39)
			price = 3;
		else
		if(start == 61 && destination == 40)
			price = 4;
		else
		if(start == 61 && destination == 41)
			price = 4;
		else
		if(start == 61 && destination == 42)
			price = 5;
		else
		if(start == 61 && destination == 43)
			price = 5;
		else
		if(start == 61 && destination == 44)
			price = 5;
		else
		if(start == 61 && destination == 45)
			price = 5;
		else
		if(start == 61 && destination == 46)
			price = 5;
		else
		if(start == 61 && destination == 47)
			price = 6;
		else
		if(start == 61 && destination == 48)
			price = 6;
		else
		if(start == 61 && destination == 49)
			price = 5;
		else
		if(start == 61 && destination == 50)
			price = 5;
		else
		if(start == 61 && destination == 51)
			price = 5;
		else
		if(start == 61 && destination == 52)
			price = 5;
		else
		if(start == 61 && destination == 53)
			price = 5;
		else
		if(start == 61 && destination == 54)
			price = 4;
		else
		if(start == 61 && destination == 55)
			price = 4;
		else
		if(start == 61 && destination == 56)
			price = 3;
		else
		if(start == 61 && destination == 57)
			price = 3;
		else
		if(start == 61 && destination == 58)
			price = 3;
		else
		if(start == 61 && destination == 59)
			price = 2;
		else
		if(start == 61 && destination == 60)
			price = 2;
		else
		if(start == 61 && destination == 61)
			price = 0;
		else
		if(start == 61 && destination == 62)
			price = 2;
		else
		if(start == 61 && destination == 63)
			price = 2;
		else
		if(start == 61 && destination == 64)
			price = 2;
		else
		if(start == 61 && destination == 65)
			price = 3;
		else
		if(start == 61 && destination == 66)
			price = 3;
		else
		if(start == 61 && destination == 67)
			price = 3;
		else
		if(start == 61 && destination == 68)
			price = 3;
		else
		if(start == 61 && destination == 69)
			price = 3;
		else
		if(start == 61 && destination == 70)
			price = 4;
		else
		if(start == 61 && destination == 71)
			price = 4;
		else
		if(start == 61 && destination == 72)
			price = 4;
		else
		if(start == 61 && destination == 73)
			price = 5;
		else
		if(start == 61 && destination == 74)
			price = 5;
		else
		if(start == 61 && destination == 75)
			price = 5;
		else
		if(start == 61 && destination == 76)
			price = 6;
		else
		if(start == 61 && destination == 77)
			price = 3;
		else
		if(start == 61 && destination == 78)
			price = 3;
		else
		if(start == 61 && destination == 79)
			price = 2;
		else
		if(start == 61 && destination == 80)
			price = 2;
		else
		if(start == 61 && destination == 81)
			price = 2;
		else
		if(start == 61 && destination == 82)
			price = 2;
		else
		if(start == 61 && destination == 83)
			price = 3;
		else
		if(start == 61 && destination == 84)
			price = 3;
		else
		if(start == 61 && destination == 85)
			price = 4;
		else
		if(start == 61 && destination == 86)
			price = 4;
		else
		if(start == 61 && destination == 87)
			price = 5;
		else
		if(start == 61 && destination == 88)
			price = 5;
		else
		if(start == 61 && destination == 89)
			price = 5;
		else
		if(start == 61 && destination == 90)
			price = 6;
		else
		if(start == 61 && destination == 91)
			price = 6;
		else
		if(start == 61 && destination == 92)
			price = 6;
		else
		if(start == 62 && destination == 0)
			price = 4;
		else
		if(start == 62 && destination == 1)
			price = 3;
		else
		if(start == 62 && destination == 2)
			price = 3;
		else
		if(start == 62 && destination == 3)
			price = 3;
		else
		if(start == 62 && destination == 4)
			price = 2;
		else
		if(start == 62 && destination == 5)
			price = 2;
		else
		if(start == 62 && destination == 6)
			price = 2;
		else
		if(start == 62 && destination == 7)
			price = 3;
		else
		if(start == 62 && destination == 8)
			price = 3;
		else
		if(start == 62 && destination == 9)
			price = 4;
		else
		if(start == 62 && destination == 10)
			price = 4;
		else
		if(start == 62 && destination == 11)
			price = 4;
		else
		if(start == 62 && destination == 12)
			price = 4;
		else
		if(start == 62 && destination == 13)
			price = 4;
		else
		if(start == 62 && destination == 14)
			price = 4;
		else
		if(start == 62 && destination == 15)
			price = 4;
		else
		if(start == 62 && destination == 16)
			price = 5;
		else
		if(start == 62 && destination == 17)
			price = 5;
		else
		if(start == 62 && destination == 18)
			price = 5;
		else
		if(start == 62 && destination == 19)
			price = 5;
		else
		if(start == 62 && destination == 20)
			price = 6;
		else
		if(start == 62 && destination == 21)
			price = 6;
		else
		if(start == 62 && destination == 22)
			price = 6;
		else
		if(start == 62 && destination == 23)
			price = 5;
		else
		if(start == 62 && destination == 24)
			price = 4;
		else
		if(start == 62 && destination == 25)
			price = 4;
		else
		if(start == 62 && destination == 26)
			price = 4;
		else
		if(start == 62 && destination == 27)
			price = 3;
		else
		if(start == 62 && destination == 28)
			price = 3;
		else
		if(start == 62 && destination == 29)
			price = 3;
		else
		if(start == 62 && destination == 30)
			price = 3;
		else
		if(start == 62 && destination == 31)
			price = 2;
		else
		if(start == 62 && destination == 32)
			price = 2;
		else
		if(start == 62 && destination == 33)
			price = 2;
		else
		if(start == 62 && destination == 34)
			price = 2;
		else
		if(start == 62 && destination == 35)
			price = 2;
		else
		if(start == 62 && destination == 36)
			price = 3;
		else
		if(start == 62 && destination == 37)
			price = 3;
		else
		if(start == 62 && destination == 38)
			price = 3;
		else
		if(start == 62 && destination == 39)
			price = 3;
		else
		if(start == 62 && destination == 40)
			price = 4;
		else
		if(start == 62 && destination == 41)
			price = 4;
		else
		if(start == 62 && destination == 42)
			price = 5;
		else
		if(start == 62 && destination == 43)
			price = 5;
		else
		if(start == 62 && destination == 44)
			price = 5;
		else
		if(start == 62 && destination == 45)
			price = 5;
		else
		if(start == 62 && destination == 46)
			price = 6;
		else
		if(start == 62 && destination == 47)
			price = 6;
		else
		if(start == 62 && destination == 48)
			price = 6;
		else
		if(start == 62 && destination == 49)
			price = 5;
		else
		if(start == 62 && destination == 50)
			price = 5;
		else
		if(start == 62 && destination == 51)
			price = 5;
		else
		if(start == 62 && destination == 52)
			price = 5;
		else
		if(start == 62 && destination == 53)
			price = 5;
		else
		if(start == 62 && destination == 54)
			price = 4;
		else
		if(start == 62 && destination == 55)
			price = 4;
		else
		if(start == 62 && destination == 56)
			price = 3;
		else
		if(start == 62 && destination == 57)
			price = 3;
		else
		if(start == 62 && destination == 58)
			price = 3;
		else
		if(start == 62 && destination == 59)
			price = 2;
		else
		if(start == 62 && destination == 60)
			price = 2;
		else
		if(start == 62 && destination == 61)
			price = 2;
		else
		if(start == 62 && destination == 62)
			price = 0;
		else
		if(start == 62 && destination == 63)
			price = 2;
		else
		if(start == 62 && destination == 64)
			price = 2;
		else
		if(start == 62 && destination == 65)
			price = 2;
		else
		if(start == 62 && destination == 66)
			price = 3;
		else
		if(start == 62 && destination == 67)
			price = 3;
		else
		if(start == 62 && destination == 68)
			price = 3;
		else
		if(start == 62 && destination == 69)
			price = 3;
		else
		if(start == 62 && destination == 70)
			price = 4;
		else
		if(start == 62 && destination == 71)
			price = 4;
		else
		if(start == 62 && destination == 72)
			price = 4;
		else
		if(start == 62 && destination == 73)
			price = 5;
		else
		if(start == 62 && destination == 74)
			price = 5;
		else
		if(start == 62 && destination == 75)
			price = 5;
		else
		if(start == 62 && destination == 76)
			price = 5;
		else
		if(start == 62 && destination == 77)
			price = 3;
		else
		if(start == 62 && destination == 78)
			price = 3;
		else
		if(start == 62 && destination == 79)
			price = 3;
		else
		if(start == 62 && destination == 80)
			price = 2;
		else
		if(start == 62 && destination == 81)
			price = 2;
		else
		if(start == 62 && destination == 82)
			price = 3;
		else
		if(start == 62 && destination == 83)
			price = 3;
		else
		if(start == 62 && destination == 84)
			price = 3;
		else
		if(start == 62 && destination == 85)
			price = 4;
		else
		if(start == 62 && destination == 86)
			price = 4;
		else
		if(start == 62 && destination == 87)
			price = 5;
		else
		if(start == 62 && destination == 88)
			price = 5;
		else
		if(start == 62 && destination == 89)
			price = 5;
		else
		if(start == 62 && destination == 90)
			price = 6;
		else
		if(start == 62 && destination == 91)
			price = 6;
		else
		if(start == 62 && destination == 92)
			price = 7;
		else
		if(start == 63 && destination == 0)
			price = 4;
		else
		if(start == 63 && destination == 1)
			price = 4;
		else
		if(start == 63 && destination == 2)
			price = 3;
		else
		if(start == 63 && destination == 3)
			price = 3;
		else
		if(start == 63 && destination == 4)
			price = 3;
		else
		if(start == 63 && destination == 5)
			price = 3;
		else
		if(start == 63 && destination == 6)
			price = 3;
		else
		if(start == 63 && destination == 7)
			price = 3;
		else
		if(start == 63 && destination == 8)
			price = 3;
		else
		if(start == 63 && destination == 9)
			price = 4;
		else
		if(start == 63 && destination == 10)
			price = 4;
		else
		if(start == 63 && destination == 11)
			price = 3;
		else
		if(start == 63 && destination == 12)
			price = 4;
		else
		if(start == 63 && destination == 13)
			price = 4;
		else
		if(start == 63 && destination == 14)
			price = 4;
		else
		if(start == 63 && destination == 15)
			price = 4;
		else
		if(start == 63 && destination == 16)
			price = 5;
		else
		if(start == 63 && destination == 17)
			price = 5;
		else
		if(start == 63 && destination == 18)
			price = 5;
		else
		if(start == 63 && destination == 19)
			price = 5;
		else
		if(start == 63 && destination == 20)
			price = 5;
		else
		if(start == 63 && destination == 21)
			price = 6;
		else
		if(start == 63 && destination == 22)
			price = 6;
		else
		if(start == 63 && destination == 23)
			price = 5;
		else
		if(start == 63 && destination == 24)
			price = 4;
		else
		if(start == 63 && destination == 25)
			price = 4;
		else
		if(start == 63 && destination == 26)
			price = 4;
		else
		if(start == 63 && destination == 27)
			price = 4;
		else
		if(start == 63 && destination == 28)
			price = 3;
		else
		if(start == 63 && destination == 29)
			price = 3;
		else
		if(start == 63 && destination == 30)
			price = 3;
		else
		if(start == 63 && destination == 31)
			price = 3;
		else
		if(start == 63 && destination == 32)
			price = 2;
		else
		if(start == 63 && destination == 33)
			price = 2;
		else
		if(start == 63 && destination == 34)
			price = 2;
		else
		if(start == 63 && destination == 35)
			price = 3;
		else
		if(start == 63 && destination == 36)
			price = 3;
		else
		if(start == 63 && destination == 37)
			price = 3;
		else
		if(start == 63 && destination == 38)
			price = 3;
		else
		if(start == 63 && destination == 39)
			price = 4;
		else
		if(start == 63 && destination == 40)
			price = 4;
		else
		if(start == 63 && destination == 41)
			price = 5;
		else
		if(start == 63 && destination == 42)
			price = 5;
		else
		if(start == 63 && destination == 43)
			price = 5;
		else
		if(start == 63 && destination == 44)
			price = 5;
		else
		if(start == 63 && destination == 45)
			price = 5;
		else
		if(start == 63 && destination == 46)
			price = 6;
		else
		if(start == 63 && destination == 47)
			price = 6;
		else
		if(start == 63 && destination == 48)
			price = 6;
		else
		if(start == 63 && destination == 49)
			price = 6;
		else
		if(start == 63 && destination == 50)
			price = 5;
		else
		if(start == 63 && destination == 51)
			price = 5;
		else
		if(start == 63 && destination == 52)
			price = 5;
		else
		if(start == 63 && destination == 53)
			price = 5;
		else
		if(start == 63 && destination == 54)
			price = 4;
		else
		if(start == 63 && destination == 55)
			price = 4;
		else
		if(start == 63 && destination == 56)
			price = 4;
		else
		if(start == 63 && destination == 57)
			price = 3;
		else
		if(start == 63 && destination == 58)
			price = 3;
		else
		if(start == 63 && destination == 59)
			price = 2;
		else
		if(start == 63 && destination == 60)
			price = 2;
		else
		if(start == 63 && destination == 61)
			price = 2;
		else
		if(start == 63 && destination == 62)
			price = 2;
		else
		if(start == 63 && destination == 63)
			price = 0;
		else
		if(start == 63 && destination == 64)
			price = 2;
		else
		if(start == 63 && destination == 65)
			price = 2;
		else
		if(start == 63 && destination == 66)
			price = 2;
		else
		if(start == 63 && destination == 67)
			price = 3;
		else
		if(start == 63 && destination == 68)
			price = 3;
		else
		if(start == 63 && destination == 69)
			price = 3;
		else
		if(start == 63 && destination == 70)
			price = 3;
		else
		if(start == 63 && destination == 71)
			price = 4;
		else
		if(start == 63 && destination == 72)
			price = 4;
		else
		if(start == 63 && destination == 73)
			price = 4;
		else
		if(start == 63 && destination == 74)
			price = 5;
		else
		if(start == 63 && destination == 75)
			price = 5;
		else
		if(start == 63 && destination == 76)
			price = 5;
		else
		if(start == 63 && destination == 77)
			price = 4;
		else
		if(start == 63 && destination == 78)
			price = 3;
		else
		if(start == 63 && destination == 79)
			price = 3;
		else
		if(start == 63 && destination == 80)
			price = 3;
		else
		if(start == 63 && destination == 81)
			price = 3;
		else
		if(start == 63 && destination == 82)
			price = 3;
		else
		if(start == 63 && destination == 83)
			price = 3;
		else
		if(start == 63 && destination == 84)
			price = 3;
		else
		if(start == 63 && destination == 85)
			price = 4;
		else
		if(start == 63 && destination == 86)
			price = 5;
		else
		if(start == 63 && destination == 87)
			price = 5;
		else
		if(start == 63 && destination == 88)
			price = 5;
		else
		if(start == 63 && destination == 89)
			price = 6;
		else
		if(start == 63 && destination == 90)
			price = 6;
		else
		if(start == 63 && destination == 91)
			price = 6;
		else
		if(start == 63 && destination == 92)
			price = 7;
		else
		if(start == 64 && destination == 0)
			price = 4;
		else
		if(start == 64 && destination == 1)
			price = 4;
		else
		if(start == 64 && destination == 2)
			price = 3;
		else
		if(start == 64 && destination == 3)
			price = 3;
		else
		if(start == 64 && destination == 4)
			price = 3;
		else
		if(start == 64 && destination == 5)
			price = 3;
		else
		if(start == 64 && destination == 6)
			price = 3;
		else
		if(start == 64 && destination == 7)
			price = 3;
		else
		if(start == 64 && destination == 8)
			price = 4;
		else
		if(start == 64 && destination == 9)
			price = 4;
		else
		if(start == 64 && destination == 10)
			price = 3;
		else
		if(start == 64 && destination == 11)
			price = 3;
		else
		if(start == 64 && destination == 12)
			price = 3;
		else
		if(start == 64 && destination == 13)
			price = 4;
		else
		if(start == 64 && destination == 14)
			price = 4;
		else
		if(start == 64 && destination == 15)
			price = 4;
		else
		if(start == 64 && destination == 16)
			price = 4;
		else
		if(start == 64 && destination == 17)
			price = 4;
		else
		if(start == 64 && destination == 18)
			price = 5;
		else
		if(start == 64 && destination == 19)
			price = 5;
		else
		if(start == 64 && destination == 20)
			price = 5;
		else
		if(start == 64 && destination == 21)
			price = 6;
		else
		if(start == 64 && destination == 22)
			price = 6;
		else
		if(start == 64 && destination == 23)
			price = 4;
		else
		if(start == 64 && destination == 24)
			price = 5;
		else
		if(start == 64 && destination == 25)
			price = 4;
		else
		if(start == 64 && destination == 26)
			price = 4;
		else
		if(start == 64 && destination == 27)
			price = 4;
		else
		if(start == 64 && destination == 28)
			price = 4;
		else
		if(start == 64 && destination == 29)
			price = 3;
		else
		if(start == 64 && destination == 30)
			price = 3;
		else
		if(start == 64 && destination == 31)
			price = 3;
		else
		if(start == 64 && destination == 32)
			price = 3;
		else
		if(start == 64 && destination == 33)
			price = 3;
		else
		if(start == 64 && destination == 34)
			price = 3;
		else
		if(start == 64 && destination == 35)
			price = 3;
		else
		if(start == 64 && destination == 36)
			price = 3;
		else
		if(start == 64 && destination == 37)
			price = 3;
		else
		if(start == 64 && destination == 38)
			price = 4;
		else
		if(start == 64 && destination == 39)
			price = 4;
		else
		if(start == 64 && destination == 40)
			price = 4;
		else
		if(start == 64 && destination == 41)
			price = 5;
		else
		if(start == 64 && destination == 42)
			price = 5;
		else
		if(start == 64 && destination == 43)
			price = 5;
		else
		if(start == 64 && destination == 44)
			price = 5;
		else
		if(start == 64 && destination == 45)
			price = 6;
		else
		if(start == 64 && destination == 46)
			price = 6;
		else
		if(start == 64 && destination == 47)
			price = 6;
		else
		if(start == 64 && destination == 48)
			price = 6;
		else
		if(start == 64 && destination == 49)
			price = 6;
		else
		if(start == 64 && destination == 50)
			price = 6;
		else
		if(start == 64 && destination == 51)
			price = 5;
		else
		if(start == 64 && destination == 52)
			price = 5;
		else
		if(start == 64 && destination == 53)
			price = 5;
		else
		if(start == 64 && destination == 54)
			price = 4;
		else
		if(start == 64 && destination == 55)
			price = 4;
		else
		if(start == 64 && destination == 56)
			price = 4;
		else
		if(start == 64 && destination == 57)
			price = 4;
		else
		if(start == 64 && destination == 58)
			price = 3;
		else
		if(start == 64 && destination == 59)
			price = 3;
		else
		if(start == 64 && destination == 60)
			price = 3;
		else
		if(start == 64 && destination == 61)
			price = 2;
		else
		if(start == 64 && destination == 62)
			price = 2;
		else
		if(start == 64 && destination == 63)
			price = 2;
		else
		if(start == 64 && destination == 64)
			price = 0;
		else
		if(start == 64 && destination == 65)
			price = 2;
		else
		if(start == 64 && destination == 66)
			price = 2;
		else
		if(start == 64 && destination == 67)
			price = 2;
		else
		if(start == 64 && destination == 68)
			price = 3;
		else
		if(start == 64 && destination == 69)
			price = 3;
		else
		if(start == 64 && destination == 70)
			price = 3;
		else
		if(start == 64 && destination == 71)
			price = 3;
		else
		if(start == 64 && destination == 72)
			price = 4;
		else
		if(start == 64 && destination == 73)
			price = 4;
		else
		if(start == 64 && destination == 74)
			price = 5;
		else
		if(start == 64 && destination == 75)
			price = 5;
		else
		if(start == 64 && destination == 76)
			price = 5;
		else
		if(start == 64 && destination == 77)
			price = 4;
		else
		if(start == 64 && destination == 78)
			price = 3;
		else
		if(start == 64 && destination == 79)
			price = 3;
		else
		if(start == 64 && destination == 80)
			price = 3;
		else
		if(start == 64 && destination == 81)
			price = 3;
		else
		if(start == 64 && destination == 82)
			price = 3;
		else
		if(start == 64 && destination == 83)
			price = 4;
		else
		if(start == 64 && destination == 84)
			price = 4;
		else
		if(start == 64 && destination == 85)
			price = 4;
		else
		if(start == 64 && destination == 86)
			price = 5;
		else
		if(start == 64 && destination == 87)
			price = 5;
		else
		if(start == 64 && destination == 88)
			price = 5;
		else
		if(start == 64 && destination == 89)
			price = 6;
		else
		if(start == 64 && destination == 90)
			price = 6;
		else
		if(start == 64 && destination == 91)
			price = 6;
		else
		if(start == 64 && destination == 92)
			price = 7;
		else
		if(start == 65 && destination == 0)
			price = 4;
		else
		if(start == 65 && destination == 1)
			price = 4;
		else
		if(start == 65 && destination == 2)
			price = 4;
		else
		if(start == 65 && destination == 3)
			price = 3;
		else
		if(start == 65 && destination == 4)
			price = 3;
		else
		if(start == 65 && destination == 5)
			price = 3;
		else
		if(start == 65 && destination == 6)
			price = 3;
		else
		if(start == 65 && destination == 7)
			price = 4;
		else
		if(start == 65 && destination == 8)
			price = 4;
		else
		if(start == 65 && destination == 9)
			price = 3;
		else
		if(start == 65 && destination == 10)
			price = 3;
		else
		if(start == 65 && destination == 11)
			price = 3;
		else
		if(start == 65 && destination == 12)
			price = 3;
		else
		if(start == 65 && destination == 13)
			price = 3;
		else
		if(start == 65 && destination == 14)
			price = 3;
		else
		if(start == 65 && destination == 15)
			price = 4;
		else
		if(start == 65 && destination == 16)
			price = 4;
		else
		if(start == 65 && destination == 17)
			price = 4;
		else
		if(start == 65 && destination == 18)
			price = 5;
		else
		if(start == 65 && destination == 19)
			price = 5;
		else
		if(start == 65 && destination == 20)
			price = 5;
		else
		if(start == 65 && destination == 21)
			price = 5;
		else
		if(start == 65 && destination == 22)
			price = 6;
		else
		if(start == 65 && destination == 23)
			price = 4;
		else
		if(start == 65 && destination == 24)
			price = 5;
		else
		if(start == 65 && destination == 25)
			price = 5;
		else
		if(start == 65 && destination == 26)
			price = 4;
		else
		if(start == 65 && destination == 27)
			price = 4;
		else
		if(start == 65 && destination == 28)
			price = 4;
		else
		if(start == 65 && destination == 29)
			price = 4;
		else
		if(start == 65 && destination == 30)
			price = 3;
		else
		if(start == 65 && destination == 31)
			price = 3;
		else
		if(start == 65 && destination == 32)
			price = 3;
		else
		if(start == 65 && destination == 33)
			price = 3;
		else
		if(start == 65 && destination == 34)
			price = 3;
		else
		if(start == 65 && destination == 35)
			price = 3;
		else
		if(start == 65 && destination == 36)
			price = 3;
		else
		if(start == 65 && destination == 37)
			price = 4;
		else
		if(start == 65 && destination == 38)
			price = 4;
		else
		if(start == 65 && destination == 39)
			price = 4;
		else
		if(start == 65 && destination == 40)
			price = 5;
		else
		if(start == 65 && destination == 41)
			price = 5;
		else
		if(start == 65 && destination == 42)
			price = 5;
		else
		if(start == 65 && destination == 43)
			price = 5;
		else
		if(start == 65 && destination == 44)
			price = 6;
		else
		if(start == 65 && destination == 45)
			price = 6;
		else
		if(start == 65 && destination == 46)
			price = 6;
		else
		if(start == 65 && destination == 47)
			price = 6;
		else
		if(start == 65 && destination == 48)
			price = 6;
		else
		if(start == 65 && destination == 49)
			price = 6;
		else
		if(start == 65 && destination == 50)
			price = 6;
		else
		if(start == 65 && destination == 51)
			price = 6;
		else
		if(start == 65 && destination == 52)
			price = 5;
		else
		if(start == 65 && destination == 53)
			price = 5;
		else
		if(start == 65 && destination == 54)
			price = 5;
		else
		if(start == 65 && destination == 55)
			price = 5;
		else
		if(start == 65 && destination == 56)
			price = 4;
		else
		if(start == 65 && destination == 57)
			price = 4;
		else
		if(start == 65 && destination == 58)
			price = 3;
		else
		if(start == 65 && destination == 59)
			price = 3;
		else
		if(start == 65 && destination == 60)
			price = 3;
		else
		if(start == 65 && destination == 61)
			price = 3;
		else
		if(start == 65 && destination == 62)
			price = 2;
		else
		if(start == 65 && destination == 63)
			price = 2;
		else
		if(start == 65 && destination == 64)
			price = 2;
		else
		if(start == 65 && destination == 65)
			price = 0;
		else
		if(start == 65 && destination == 66)
			price = 2;
		else
		if(start == 65 && destination == 67)
			price = 2;
		else
		if(start == 65 && destination == 68)
			price = 2;
		else
		if(start == 65 && destination == 69)
			price = 3;
		else
		if(start == 65 && destination == 70)
			price = 3;
		else
		if(start == 65 && destination == 71)
			price = 3;
		else
		if(start == 65 && destination == 72)
			price = 4;
		else
		if(start == 65 && destination == 73)
			price = 4;
		else
		if(start == 65 && destination == 74)
			price = 4;
		else
		if(start == 65 && destination == 75)
			price = 5;
		else
		if(start == 65 && destination == 76)
			price = 5;
		else
		if(start == 65 && destination == 77)
			price = 4;
		else
		if(start == 65 && destination == 78)
			price = 4;
		else
		if(start == 65 && destination == 79)
			price = 3;
		else
		if(start == 65 && destination == 80)
			price = 3;
		else
		if(start == 65 && destination == 81)
			price = 3;
		else
		if(start == 65 && destination == 82)
			price = 3;
		else
		if(start == 65 && destination == 83)
			price = 4;
		else
		if(start == 65 && destination == 84)
			price = 4;
		else
		if(start == 65 && destination == 85)
			price = 5;
		else
		if(start == 65 && destination == 86)
			price = 5;
		else
		if(start == 65 && destination == 87)
			price = 5;
		else
		if(start == 65 && destination == 88)
			price = 6;
		else
		if(start == 65 && destination == 89)
			price = 6;
		else
		if(start == 65 && destination == 90)
			price = 6;
		else
		if(start == 65 && destination == 91)
			price = 7;
		else
		if(start == 65 && destination == 92)
			price = 7;
		else
		if(start == 66 && destination == 0)
			price = 5;
		else
		if(start == 66 && destination == 1)
			price = 4;
		else
		if(start == 66 && destination == 2)
			price = 4;
		else
		if(start == 66 && destination == 3)
			price = 4;
		else
		if(start == 66 && destination == 4)
			price = 3;
		else
		if(start == 66 && destination == 5)
			price = 3;
		else
		if(start == 66 && destination == 6)
			price = 3;
		else
		if(start == 66 && destination == 7)
			price = 4;
		else
		if(start == 66 && destination == 8)
			price = 4;
		else
		if(start == 66 && destination == 9)
			price = 3;
		else
		if(start == 66 && destination == 10)
			price = 3;
		else
		if(start == 66 && destination == 11)
			price = 3;
		else
		if(start == 66 && destination == 12)
			price = 3;
		else
		if(start == 66 && destination == 13)
			price = 3;
		else
		if(start == 66 && destination == 14)
			price = 3;
		else
		if(start == 66 && destination == 15)
			price = 4;
		else
		if(start == 66 && destination == 16)
			price = 4;
		else
		if(start == 66 && destination == 17)
			price = 4;
		else
		if(start == 66 && destination == 18)
			price = 4;
		else
		if(start == 66 && destination == 19)
			price = 5;
		else
		if(start == 66 && destination == 20)
			price = 5;
		else
		if(start == 66 && destination == 21)
			price = 5;
		else
		if(start == 66 && destination == 22)
			price = 6;
		else
		if(start == 66 && destination == 23)
			price = 4;
		else
		if(start == 66 && destination == 24)
			price = 5;
		else
		if(start == 66 && destination == 25)
			price = 4;
		else
		if(start == 66 && destination == 26)
			price = 5;
		else
		if(start == 66 && destination == 27)
			price = 4;
		else
		if(start == 66 && destination == 28)
			price = 4;
		else
		if(start == 66 && destination == 29)
			price = 4;
		else
		if(start == 66 && destination == 30)
			price = 3;
		else
		if(start == 66 && destination == 31)
			price = 3;
		else
		if(start == 66 && destination == 32)
			price = 3;
		else
		if(start == 66 && destination == 33)
			price = 3;
		else
		if(start == 66 && destination == 34)
			price = 3;
		else
		if(start == 66 && destination == 35)
			price = 3;
		else
		if(start == 66 && destination == 36)
			price = 4;
		else
		if(start == 66 && destination == 37)
			price = 4;
		else
		if(start == 66 && destination == 38)
			price = 4;
		else
		if(start == 66 && destination == 39)
			price = 4;
		else
		if(start == 66 && destination == 40)
			price = 5;
		else
		if(start == 66 && destination == 41)
			price = 5;
		else
		if(start == 66 && destination == 42)
			price = 5;
		else
		if(start == 66 && destination == 43)
			price = 6;
		else
		if(start == 66 && destination == 44)
			price = 6;
		else
		if(start == 66 && destination == 45)
			price = 6;
		else
		if(start == 66 && destination == 46)
			price = 6;
		else
		if(start == 66 && destination == 47)
			price = 6;
		else
		if(start == 66 && destination == 48)
			price = 6;
		else
		if(start == 66 && destination == 49)
			price = 6;
		else
		if(start == 66 && destination == 50)
			price = 6;
		else
		if(start == 66 && destination == 51)
			price = 6;
		else
		if(start == 66 && destination == 52)
			price = 6;
		else
		if(start == 66 && destination == 53)
			price = 5;
		else
		if(start == 66 && destination == 54)
			price = 5;
		else
		if(start == 66 && destination == 55)
			price = 5;
		else
		if(start == 66 && destination == 56)
			price = 4;
		else
		if(start == 66 && destination == 57)
			price = 4;
		else
		if(start == 66 && destination == 58)
			price = 4;
		else
		if(start == 66 && destination == 59)
			price = 3;
		else
		if(start == 66 && destination == 60)
			price = 3;
		else
		if(start == 66 && destination == 61)
			price = 3;
		else
		if(start == 66 && destination == 62)
			price = 3;
		else
		if(start == 66 && destination == 63)
			price = 2;
		else
		if(start == 66 && destination == 64)
			price = 2;
		else
		if(start == 66 && destination == 65)
			price = 2;
		else
		if(start == 66 && destination == 66)
			price = 0;
		else
		if(start == 66 && destination == 67)
			price = 2;
		else
		if(start == 66 && destination == 68)
			price = 2;
		else
		if(start == 66 && destination == 69)
			price = 2;
		else
		if(start == 66 && destination == 70)
			price = 3;
		else
		if(start == 66 && destination == 71)
			price = 3;
		else
		if(start == 66 && destination == 72)
			price = 3;
		else
		if(start == 66 && destination == 73)
			price = 4;
		else
		if(start == 66 && destination == 74)
			price = 4;
		else
		if(start == 66 && destination == 75)
			price = 4;
		else
		if(start == 66 && destination == 76)
			price = 5;
		else
		if(start == 66 && destination == 77)
			price = 4;
		else
		if(start == 66 && destination == 78)
			price = 4;
		else
		if(start == 66 && destination == 79)
			price = 4;
		else
		if(start == 66 && destination == 80)
			price = 3;
		else
		if(start == 66 && destination == 81)
			price = 3;
		else
		if(start == 66 && destination == 82)
			price = 4;
		else
		if(start == 66 && destination == 83)
			price = 4;
		else
		if(start == 66 && destination == 84)
			price = 4;
		else
		if(start == 66 && destination == 85)
			price = 5;
		else
		if(start == 66 && destination == 86)
			price = 5;
		else
		if(start == 66 && destination == 87)
			price = 6;
		else
		if(start == 66 && destination == 88)
			price = 6;
		else
		if(start == 66 && destination == 89)
			price = 6;
		else
		if(start == 66 && destination == 90)
			price = 6;
		else
		if(start == 66 && destination == 91)
			price = 7;
		else
		if(start == 66 && destination == 92)
			price = 7;
		else
		if(start == 67 && destination == 0)
			price = 5;
		else
		if(start == 67 && destination == 1)
			price = 5;
		else
		if(start == 67 && destination == 2)
			price = 4;
		else
		if(start == 67 && destination == 3)
			price = 4;
		else
		if(start == 67 && destination == 4)
			price = 3;
		else
		if(start == 67 && destination == 5)
			price = 3;
		else
		if(start == 67 && destination == 6)
			price = 4;
		else
		if(start == 67 && destination == 7)
			price = 4;
		else
		if(start == 67 && destination == 8)
			price = 3;
		else
		if(start == 67 && destination == 9)
			price = 3;
		else
		if(start == 67 && destination == 10)
			price = 3;
		else
		if(start == 67 && destination == 11)
			price = 3;
		else
		if(start == 67 && destination == 12)
			price = 3;
		else
		if(start == 67 && destination == 13)
			price = 3;
		else
		if(start == 67 && destination == 14)
			price = 3;
		else
		if(start == 67 && destination == 15)
			price = 3;
		else
		if(start == 67 && destination == 16)
			price = 4;
		else
		if(start == 67 && destination == 17)
			price = 4;
		else
		if(start == 67 && destination == 18)
			price = 4;
		else
		if(start == 67 && destination == 19)
			price = 4;
		else
		if(start == 67 && destination == 20)
			price = 5;
		else
		if(start == 67 && destination == 21)
			price = 5;
		else
		if(start == 67 && destination == 22)
			price = 5;
		else
		if(start == 67 && destination == 23)
			price = 4;
		else
		if(start == 67 && destination == 24)
			price = 4;
		else
		if(start == 67 && destination == 25)
			price = 4;
		else
		if(start == 67 && destination == 26)
			price = 5;
		else
		if(start == 67 && destination == 27)
			price = 5;
		else
		if(start == 67 && destination == 28)
			price = 4;
		else
		if(start == 67 && destination == 29)
			price = 4;
		else
		if(start == 67 && destination == 30)
			price = 4;
		else
		if(start == 67 && destination == 31)
			price = 4;
		else
		if(start == 67 && destination == 32)
			price = 3;
		else
		if(start == 67 && destination == 33)
			price = 3;
		else
		if(start == 67 && destination == 34)
			price = 3;
		else
		if(start == 67 && destination == 35)
			price = 3;
		else
		if(start == 67 && destination == 36)
			price = 4;
		else
		if(start == 67 && destination == 37)
			price = 4;
		else
		if(start == 67 && destination == 38)
			price = 4;
		else
		if(start == 67 && destination == 39)
			price = 4;
		else
		if(start == 67 && destination == 40)
			price = 5;
		else
		if(start == 67 && destination == 41)
			price = 5;
		else
		if(start == 67 && destination == 42)
			price = 6;
		else
		if(start == 67 && destination == 43)
			price = 6;
		else
		if(start == 67 && destination == 44)
			price = 6;
		else
		if(start == 67 && destination == 45)
			price = 6;
		else
		if(start == 67 && destination == 46)
			price = 6;
		else
		if(start == 67 && destination == 47)
			price = 7;
		else
		if(start == 67 && destination == 48)
			price = 7;
		else
		if(start == 67 && destination == 49)
			price = 6;
		else
		if(start == 67 && destination == 50)
			price = 6;
		else
		if(start == 67 && destination == 51)
			price = 6;
		else
		if(start == 67 && destination == 52)
			price = 6;
		else
		if(start == 67 && destination == 53)
			price = 5;
		else
		if(start == 67 && destination == 54)
			price = 5;
		else
		if(start == 67 && destination == 55)
			price = 5;
		else
		if(start == 67 && destination == 56)
			price = 5;
		else
		if(start == 67 && destination == 57)
			price = 4;
		else
		if(start == 67 && destination == 58)
			price = 4;
		else
		if(start == 67 && destination == 59)
			price = 3;
		else
		if(start == 67 && destination == 60)
			price = 3;
		else
		if(start == 67 && destination == 61)
			price = 3;
		else
		if(start == 67 && destination == 62)
			price = 3;
		else
		if(start == 67 && destination == 63)
			price = 3;
		else
		if(start == 67 && destination == 64)
			price = 2;
		else
		if(start == 67 && destination == 65)
			price = 2;
		else
		if(start == 67 && destination == 66)
			price = 2;
		else
		if(start == 67 && destination == 67)
			price = 0;
		else
		if(start == 67 && destination == 68)
			price = 2;
		else
		if(start == 67 && destination == 69)
			price = 2;
		else
		if(start == 67 && destination == 70)
			price = 2;
		else
		if(start == 67 && destination == 71)
			price = 3;
		else
		if(start == 67 && destination == 72)
			price = 3;
		else
		if(start == 67 && destination == 73)
			price = 4;
		else
		if(start == 67 && destination == 74)
			price = 4;
		else
		if(start == 67 && destination == 75)
			price = 4;
		else
		if(start == 67 && destination == 76)
			price = 5;
		else
		if(start == 67 && destination == 77)
			price = 4;
		else
		if(start == 67 && destination == 78)
			price = 4;
		else
		if(start == 67 && destination == 79)
			price = 4;
		else
		if(start == 67 && destination == 80)
			price = 4;
		else
		if(start == 67 && destination == 81)
			price = 4;
		else
		if(start == 67 && destination == 82)
			price = 4;
		else
		if(start == 67 && destination == 83)
			price = 4;
		else
		if(start == 67 && destination == 84)
			price = 4;
		else
		if(start == 67 && destination == 85)
			price = 5;
		else
		if(start == 67 && destination == 86)
			price = 5;
		else
		if(start == 67 && destination == 87)
			price = 6;
		else
		if(start == 67 && destination == 88)
			price = 6;
		else
		if(start == 67 && destination == 89)
			price = 6;
		else
		if(start == 67 && destination == 90)
			price = 7;
		else
		if(start == 67 && destination == 91)
			price = 7;
		else
		if(start == 67 && destination == 92)
			price = 7;
		else
		if(start == 68 && destination == 0)
			price = 5;
		else
		if(start == 68 && destination == 1)
			price = 5;
		else
		if(start == 68 && destination == 2)
			price = 4;
		else
		if(start == 68 && destination == 3)
			price = 4;
		else
		if(start == 68 && destination == 4)
			price = 4;
		else
		if(start == 68 && destination == 5)
			price = 4;
		else
		if(start == 68 && destination == 6)
			price = 4;
		else
		if(start == 68 && destination == 7)
			price = 3;
		else
		if(start == 68 && destination == 8)
			price = 3;
		else
		if(start == 68 && destination == 9)
			price = 3;
		else
		if(start == 68 && destination == 10)
			price = 3;
		else
		if(start == 68 && destination == 11)
			price = 2;
		else
		if(start == 68 && destination == 12)
			price = 2;
		else
		if(start == 68 && destination == 13)
			price = 3;
		else
		if(start == 68 && destination == 14)
			price = 3;
		else
		if(start == 68 && destination == 15)
			price = 3;
		else
		if(start == 68 && destination == 16)
			price = 3;
		else
		if(start == 68 && destination == 17)
			price = 4;
		else
		if(start == 68 && destination == 18)
			price = 4;
		else
		if(start == 68 && destination == 19)
			price = 4;
		else
		if(start == 68 && destination == 20)
			price = 5;
		else
		if(start == 68 && destination == 21)
			price = 5;
		else
		if(start == 68 && destination == 22)
			price = 5;
		else
		if(start == 68 && destination == 23)
			price = 4;
		else
		if(start == 68 && destination == 24)
			price = 4;
		else
		if(start == 68 && destination == 25)
			price = 4;
		else
		if(start == 68 && destination == 26)
			price = 4;
		else
		if(start == 68 && destination == 27)
			price = 5;
		else
		if(start == 68 && destination == 28)
			price = 4;
		else
		if(start == 68 && destination == 29)
			price = 4;
		else
		if(start == 68 && destination == 30)
			price = 4;
		else
		if(start == 68 && destination == 31)
			price = 4;
		else
		if(start == 68 && destination == 32)
			price = 4;
		else
		if(start == 68 && destination == 33)
			price = 3;
		else
		if(start == 68 && destination == 34)
			price = 3;
		else
		if(start == 68 && destination == 35)
			price = 4;
		else
		if(start == 68 && destination == 36)
			price = 4;
		else
		if(start == 68 && destination == 37)
			price = 4;
		else
		if(start == 68 && destination == 38)
			price = 4;
		else
		if(start == 68 && destination == 39)
			price = 5;
		else
		if(start == 68 && destination == 40)
			price = 5;
		else
		if(start == 68 && destination == 41)
			price = 5;
		else
		if(start == 68 && destination == 42)
			price = 6;
		else
		if(start == 68 && destination == 43)
			price = 6;
		else
		if(start == 68 && destination == 44)
			price = 6;
		else
		if(start == 68 && destination == 45)
			price = 6;
		else
		if(start == 68 && destination == 46)
			price = 7;
		else
		if(start == 68 && destination == 47)
			price = 7;
		else
		if(start == 68 && destination == 48)
			price = 7;
		else
		if(start == 68 && destination == 49)
			price = 6;
		else
		if(start == 68 && destination == 50)
			price = 6;
		else
		if(start == 68 && destination == 51)
			price = 6;
		else
		if(start == 68 && destination == 52)
			price = 6;
		else
		if(start == 68 && destination == 53)
			price = 6;
		else
		if(start == 68 && destination == 54)
			price = 5;
		else
		if(start == 68 && destination == 55)
			price = 5;
		else
		if(start == 68 && destination == 56)
			price = 5;
		else
		if(start == 68 && destination == 57)
			price = 5;
		else
		if(start == 68 && destination == 58)
			price = 4;
		else
		if(start == 68 && destination == 59)
			price = 4;
		else
		if(start == 68 && destination == 60)
			price = 3;
		else
		if(start == 68 && destination == 61)
			price = 3;
		else
		if(start == 68 && destination == 62)
			price = 3;
		else
		if(start == 68 && destination == 63)
			price = 3;
		else
		if(start == 68 && destination == 64)
			price = 3;
		else
		if(start == 68 && destination == 65)
			price = 2;
		else
		if(start == 68 && destination == 66)
			price = 2;
		else
		if(start == 68 && destination == 67)
			price = 2;
		else
		if(start == 68 && destination == 68)
			price = 0;
		else
		if(start == 68 && destination == 69)
			price = 2;
		else
		if(start == 68 && destination == 70)
			price = 2;
		else
		if(start == 68 && destination == 71)
			price = 3;
		else
		if(start == 68 && destination == 72)
			price = 3;
		else
		if(start == 68 && destination == 73)
			price = 3;
		else
		if(start == 68 && destination == 74)
			price = 4;
		else
		if(start == 68 && destination == 75)
			price = 4;
		else
		if(start == 68 && destination == 76)
			price = 5;
		else
		if(start == 68 && destination == 77)
			price = 5;
		else
		if(start == 68 && destination == 78)
			price = 4;
		else
		if(start == 68 && destination == 79)
			price = 4;
		else
		if(start == 68 && destination == 80)
			price = 4;
		else
		if(start == 68 && destination == 81)
			price = 4;
		else
		if(start == 68 && destination == 82)
			price = 4;
		else
		if(start == 68 && destination == 83)
			price = 4;
		else
		if(start == 68 && destination == 84)
			price = 5;
		else
		if(start == 68 && destination == 85)
			price = 5;
		else
		if(start == 68 && destination == 86)
			price = 5;
		else
		if(start == 68 && destination == 87)
			price = 6;
		else
		if(start == 68 && destination == 88)
			price = 6;
		else
		if(start == 68 && destination == 89)
			price = 6;
		else
		if(start == 68 && destination == 90)
			price = 7;
		else
		if(start == 68 && destination == 91)
			price = 7;
		else
		if(start == 68 && destination == 92)
			price = 7;
		else
		if(start == 69 && destination == 0)
			price = 5;
		else
		if(start == 69 && destination == 1)
			price = 5;
		else
		if(start == 69 && destination == 2)
			price = 5;
		else
		if(start == 69 && destination == 3)
			price = 4;
		else
		if(start == 69 && destination == 4)
			price = 4;
		else
		if(start == 69 && destination == 5)
			price = 4;
		else
		if(start == 69 && destination == 6)
			price = 4;
		else
		if(start == 69 && destination == 7)
			price = 3;
		else
		if(start == 69 && destination == 8)
			price = 3;
		else
		if(start == 69 && destination == 9)
			price = 3;
		else
		if(start == 69 && destination == 10)
			price = 2;
		else
		if(start == 69 && destination == 11)
			price = 2;
		else
		if(start == 69 && destination == 12)
			price = 2;
		else
		if(start == 69 && destination == 13)
			price = 2;
		else
		if(start == 69 && destination == 14)
			price = 3;
		else
		if(start == 69 && destination == 15)
			price = 3;
		else
		if(start == 69 && destination == 16)
			price = 3;
		else
		if(start == 69 && destination == 17)
			price = 3;
		else
		if(start == 69 && destination == 18)
			price = 4;
		else
		if(start == 69 && destination == 19)
			price = 4;
		else
		if(start == 69 && destination == 20)
			price = 4;
		else
		if(start == 69 && destination == 21)
			price = 5;
		else
		if(start == 69 && destination == 22)
			price = 5;
		else
		if(start == 69 && destination == 23)
			price = 3;
		else
		if(start == 69 && destination == 24)
			price = 4;
		else
		if(start == 69 && destination == 25)
			price = 4;
		else
		if(start == 69 && destination == 26)
			price = 4;
		else
		if(start == 69 && destination == 27)
			price = 4;
		else
		if(start == 69 && destination == 28)
			price = 5;
		else
		if(start == 69 && destination == 29)
			price = 4;
		else
		if(start == 69 && destination == 30)
			price = 4;
		else
		if(start == 69 && destination == 31)
			price = 4;
		else
		if(start == 69 && destination == 32)
			price = 4;
		else
		if(start == 69 && destination == 33)
			price = 4;
		else
		if(start == 69 && destination == 34)
			price = 4;
		else
		if(start == 69 && destination == 35)
			price = 4;
		else
		if(start == 69 && destination == 36)
			price = 4;
		else
		if(start == 69 && destination == 37)
			price = 4;
		else
		if(start == 69 && destination == 38)
			price = 5;
		else
		if(start == 69 && destination == 39)
			price = 5;
		else
		if(start == 69 && destination == 40)
			price = 5;
		else
		if(start == 69 && destination == 41)
			price = 6;
		else
		if(start == 69 && destination == 42)
			price = 6;
		else
		if(start == 69 && destination == 43)
			price = 6;
		else
		if(start == 69 && destination == 44)
			price = 6;
		else
		if(start == 69 && destination == 45)
			price = 6;
		else
		if(start == 69 && destination == 46)
			price = 7;
		else
		if(start == 69 && destination == 47)
			price = 7;
		else
		if(start == 69 && destination == 48)
			price = 7;
		else
		if(start == 69 && destination == 49)
			price = 7;
		else
		if(start == 69 && destination == 50)
			price = 6;
		else
		if(start == 69 && destination == 51)
			price = 6;
		else
		if(start == 69 && destination == 52)
			price = 6;
		else
		if(start == 69 && destination == 53)
			price = 6;
		else
		if(start == 69 && destination == 54)
			price = 5;
		else
		if(start == 69 && destination == 55)
			price = 5;
		else
		if(start == 69 && destination == 56)
			price = 5;
		else
		if(start == 69 && destination == 57)
			price = 5;
		else
		if(start == 69 && destination == 58)
			price = 4;
		else
		if(start == 69 && destination == 59)
			price = 4;
		else
		if(start == 69 && destination == 60)
			price = 4;
		else
		if(start == 69 && destination == 61)
			price = 3;
		else
		if(start == 69 && destination == 62)
			price = 3;
		else
		if(start == 69 && destination == 63)
			price = 3;
		else
		if(start == 69 && destination == 64)
			price = 3;
		else
		if(start == 69 && destination == 65)
			price = 3;
		else
		if(start == 69 && destination == 66)
			price = 2;
		else
		if(start == 69 && destination == 67)
			price = 2;
		else
		if(start == 69 && destination == 68)
			price = 2;
		else
		if(start == 69 && destination == 69)
			price = 0;
		else
		if(start == 69 && destination == 70)
			price = 2;
		else
		if(start == 69 && destination == 71)
			price = 2;
		else
		if(start == 69 && destination == 72)
			price = 3;
		else
		if(start == 69 && destination == 73)
			price = 3;
		else
		if(start == 69 && destination == 74)
			price = 3;
		else
		if(start == 69 && destination == 75)
			price = 4;
		else
		if(start == 69 && destination == 76)
			price = 4;
		else
		if(start == 69 && destination == 77)
			price = 5;
		else
		if(start == 69 && destination == 78)
			price = 5;
		else
		if(start == 69 && destination == 79)
			price = 4;
		else
		if(start == 69 && destination == 80)
			price = 4;
		else
		if(start == 69 && destination == 81)
			price = 4;
		else
		if(start == 69 && destination == 82)
			price = 4;
		else
		if(start == 69 && destination == 83)
			price = 5;
		else
		if(start == 69 && destination == 84)
			price = 5;
		else
		if(start == 69 && destination == 85)
			price = 5;
		else
		if(start == 69 && destination == 86)
			price = 6;
		else
		if(start == 69 && destination == 87)
			price = 6;
		else
		if(start == 69 && destination == 88)
			price = 6;
		else
		if(start == 69 && destination == 89)
			price = 7;
		else
		if(start == 69 && destination == 90)
			price = 7;
		else
		if(start == 69 && destination == 91)
			price = 7;
		else
		if(start == 69 && destination == 92)
			price = 7;
		else
		if(start == 70 && destination == 0)
			price = 5;
		else
		if(start == 70 && destination == 1)
			price = 5;
		else
		if(start == 70 && destination == 2)
			price = 5;
		else
		if(start == 70 && destination == 3)
			price = 5;
		else
		if(start == 70 && destination == 4)
			price = 4;
		else
		if(start == 70 && destination == 5)
			price = 4;
		else
		if(start == 70 && destination == 6)
			price = 4;
		else
		if(start == 70 && destination == 7)
			price = 3;
		else
		if(start == 70 && destination == 8)
			price = 3;
		else
		if(start == 70 && destination == 9)
			price = 3;
		else
		if(start == 70 && destination == 10)
			price = 2;
		else
		if(start == 70 && destination == 11)
			price = 2;
		else
		if(start == 70 && destination == 12)
			price = 2;
		else
		if(start == 70 && destination == 13)
			price = 3;
		else
		if(start == 70 && destination == 14)
			price = 3;
		else
		if(start == 70 && destination == 15)
			price = 3;
		else
		if(start == 70 && destination == 16)
			price = 3;
		else
		if(start == 70 && destination == 17)
			price = 4;
		else
		if(start == 70 && destination == 18)
			price = 4;
		else
		if(start == 70 && destination == 19)
			price = 4;
		else
		if(start == 70 && destination == 20)
			price = 5;
		else
		if(start == 70 && destination == 21)
			price = 5;
		else
		if(start == 70 && destination == 22)
			price = 5;
		else
		if(start == 70 && destination == 23)
			price = 3;
		else
		if(start == 70 && destination == 24)
			price = 4;
		else
		if(start == 70 && destination == 25)
			price = 4;
		else
		if(start == 70 && destination == 26)
			price = 4;
		else
		if(start == 70 && destination == 27)
			price = 5;
		else
		if(start == 70 && destination == 28)
			price = 5;
		else
		if(start == 70 && destination == 29)
			price = 5;
		else
		if(start == 70 && destination == 30)
			price = 4;
		else
		if(start == 70 && destination == 31)
			price = 4;
		else
		if(start == 70 && destination == 32)
			price = 4;
		else
		if(start == 70 && destination == 33)
			price = 4;
		else
		if(start == 70 && destination == 34)
			price = 4;
		else
		if(start == 70 && destination == 35)
			price = 4;
		else
		if(start == 70 && destination == 36)
			price = 4;
		else
		if(start == 70 && destination == 37)
			price = 5;
		else
		if(start == 70 && destination == 38)
			price = 5;
		else
		if(start == 70 && destination == 39)
			price = 5;
		else
		if(start == 70 && destination == 40)
			price = 5;
		else
		if(start == 70 && destination == 41)
			price = 6;
		else
		if(start == 70 && destination == 42)
			price = 6;
		else
		if(start == 70 && destination == 43)
			price = 6;
		else
		if(start == 70 && destination == 44)
			price = 6;
		else
		if(start == 70 && destination == 45)
			price = 7;
		else
		if(start == 70 && destination == 46)
			price = 7;
		else
		if(start == 70 && destination == 47)
			price = 7;
		else
		if(start == 70 && destination == 48)
			price = 7;
		else
		if(start == 70 && destination == 49)
			price = 7;
		else
		if(start == 70 && destination == 50)
			price = 7;
		else
		if(start == 70 && destination == 51)
			price = 6;
		else
		if(start == 70 && destination == 52)
			price = 6;
		else
		if(start == 70 && destination == 53)
			price = 6;
		else
		if(start == 70 && destination == 54)
			price = 5;
		else
		if(start == 70 && destination == 55)
			price = 5;
		else
		if(start == 70 && destination == 56)
			price = 5;
		else
		if(start == 70 && destination == 57)
			price = 5;
		else
		if(start == 70 && destination == 58)
			price = 5;
		else
		if(start == 70 && destination == 59)
			price = 4;
		else
		if(start == 70 && destination == 60)
			price = 4;
		else
		if(start == 70 && destination == 61)
			price = 4;
		else
		if(start == 70 && destination == 62)
			price = 4;
		else
		if(start == 70 && destination == 63)
			price = 3;
		else
		if(start == 70 && destination == 64)
			price = 3;
		else
		if(start == 70 && destination == 65)
			price = 3;
		else
		if(start == 70 && destination == 66)
			price = 3;
		else
		if(start == 70 && destination == 67)
			price = 2;
		else
		if(start == 70 && destination == 68)
			price = 2;
		else
		if(start == 70 && destination == 69)
			price = 2;
		else
		if(start == 70 && destination == 70)
			price = 0;
		else
		if(start == 70 && destination == 71)
			price = 2;
		else
		if(start == 70 && destination == 72)
			price = 2;
		else
		if(start == 70 && destination == 73)
			price = 3;
		else
		if(start == 70 && destination == 74)
			price = 3;
		else
		if(start == 70 && destination == 75)
			price = 3;
		else
		if(start == 70 && destination == 76)
			price = 4;
		else
		if(start == 70 && destination == 77)
			price = 5;
		else
		if(start == 70 && destination == 78)
			price = 5;
		else
		if(start == 70 && destination == 79)
			price = 4;
		else
		if(start == 70 && destination == 80)
			price = 4;
		else
		if(start == 70 && destination == 81)
			price = 4;
		else
		if(start == 70 && destination == 82)
			price = 4;
		else
		if(start == 70 && destination == 83)
			price = 5;
		else
		if(start == 70 && destination == 84)
			price = 5;
		else
		if(start == 70 && destination == 85)
			price = 5;
		else
		if(start == 70 && destination == 86)
			price = 6;
		else
		if(start == 70 && destination == 87)
			price = 6;
		else
		if(start == 70 && destination == 88)
			price = 6;
		else
		if(start == 70 && destination == 89)
			price = 7;
		else
		if(start == 70 && destination == 90)
			price = 7;
		else
		if(start == 70 && destination == 91)
			price = 7;
		else
		if(start == 70 && destination == 92)
			price = 8;
		else
		if(start == 71 && destination == 0)
			price = 5;
		else
		if(start == 71 && destination == 1)
			price = 5;
		else
		if(start == 71 && destination == 2)
			price = 5;
		else
		if(start == 71 && destination == 3)
			price = 5;
		else
		if(start == 71 && destination == 4)
			price = 4;
		else
		if(start == 71 && destination == 5)
			price = 4;
		else
		if(start == 71 && destination == 6)
			price = 4;
		else
		if(start == 71 && destination == 7)
			price = 4;
		else
		if(start == 71 && destination == 8)
			price = 3;
		else
		if(start == 71 && destination == 9)
			price = 3;
		else
		if(start == 71 && destination == 10)
			price = 3;
		else
		if(start == 71 && destination == 11)
			price = 3;
		else
		if(start == 71 && destination == 12)
			price = 3;
		else
		if(start == 71 && destination == 13)
			price = 3;
		else
		if(start == 71 && destination == 14)
			price = 3;
		else
		if(start == 71 && destination == 15)
			price = 3;
		else
		if(start == 71 && destination == 16)
			price = 4;
		else
		if(start == 71 && destination == 17)
			price = 4;
		else
		if(start == 71 && destination == 18)
			price = 4;
		else
		if(start == 71 && destination == 19)
			price = 5;
		else
		if(start == 71 && destination == 20)
			price = 5;
		else
		if(start == 71 && destination == 21)
			price = 5;
		else
		if(start == 71 && destination == 22)
			price = 5;
		else
		if(start == 71 && destination == 23)
			price = 4;
		else
		if(start == 71 && destination == 24)
			price = 4;
		else
		if(start == 71 && destination == 25)
			price = 4;
		else
		if(start == 71 && destination == 26)
			price = 5;
		else
		if(start == 71 && destination == 27)
			price = 5;
		else
		if(start == 71 && destination == 28)
			price = 5;
		else
		if(start == 71 && destination == 29)
			price = 5;
		else
		if(start == 71 && destination == 30)
			price = 5;
		else
		if(start == 71 && destination == 31)
			price = 5;
		else
		if(start == 71 && destination == 32)
			price = 4;
		else
		if(start == 71 && destination == 33)
			price = 4;
		else
		if(start == 71 && destination == 34)
			price = 4;
		else
		if(start == 71 && destination == 35)
			price = 5;
		else
		if(start == 71 && destination == 36)
			price = 5;
		else
		if(start == 71 && destination == 37)
			price = 5;
		else
		if(start == 71 && destination == 38)
			price = 5;
		else
		if(start == 71 && destination == 39)
			price = 5;
		else
		if(start == 71 && destination == 40)
			price = 6;
		else
		if(start == 71 && destination == 41)
			price = 6;
		else
		if(start == 71 && destination == 42)
			price = 6;
		else
		if(start == 71 && destination == 43)
			price = 6;
		else
		if(start == 71 && destination == 44)
			price = 7;
		else
		if(start == 71 && destination == 45)
			price = 7;
		else
		if(start == 71 && destination == 46)
			price = 7;
		else
		if(start == 71 && destination == 47)
			price = 7;
		else
		if(start == 71 && destination == 48)
			price = 7;
		else
		if(start == 71 && destination == 49)
			price = 7;
		else
		if(start == 71 && destination == 50)
			price = 7;
		else
		if(start == 71 && destination == 51)
			price = 7;
		else
		if(start == 71 && destination == 52)
			price = 6;
		else
		if(start == 71 && destination == 53)
			price = 6;
		else
		if(start == 71 && destination == 54)
			price = 6;
		else
		if(start == 71 && destination == 55)
			price = 6;
		else
		if(start == 71 && destination == 56)
			price = 5;
		else
		if(start == 71 && destination == 57)
			price = 5;
		else
		if(start == 71 && destination == 58)
			price = 5;
		else
		if(start == 71 && destination == 59)
			price = 4;
		else
		if(start == 71 && destination == 60)
			price = 4;
		else
		if(start == 71 && destination == 61)
			price = 4;
		else
		if(start == 71 && destination == 62)
			price = 4;
		else
		if(start == 71 && destination == 63)
			price = 4;
		else
		if(start == 71 && destination == 64)
			price = 3;
		else
		if(start == 71 && destination == 65)
			price = 3;
		else
		if(start == 71 && destination == 66)
			price = 3;
		else
		if(start == 71 && destination == 67)
			price = 3;
		else
		if(start == 71 && destination == 68)
			price = 3;
		else
		if(start == 71 && destination == 69)
			price = 2;
		else
		if(start == 71 && destination == 70)
			price = 2;
		else
		if(start == 71 && destination == 71)
			price = 0;
		else
		if(start == 71 && destination == 72)
			price = 2;
		else
		if(start == 71 && destination == 73)
			price = 3;
		else
		if(start == 71 && destination == 74)
			price = 3;
		else
		if(start == 71 && destination == 75)
			price = 3;
		else
		if(start == 71 && destination == 76)
			price = 4;
		else
		if(start == 71 && destination == 77)
			price = 5;
		else
		if(start == 71 && destination == 78)
			price = 5;
		else
		if(start == 71 && destination == 79)
			price = 5;
		else
		if(start == 71 && destination == 80)
			price = 5;
		else
		if(start == 71 && destination == 81)
			price = 5;
		else
		if(start == 71 && destination == 82)
			price = 5;
		else
		if(start == 71 && destination == 83)
			price = 5;
		else
		if(start == 71 && destination == 84)
			price = 5;
		else
		if(start == 71 && destination == 85)
			price = 6;
		else
		if(start == 71 && destination == 86)
			price = 6;
		else
		if(start == 71 && destination == 87)
			price = 7;
		else
		if(start == 71 && destination == 88)
			price = 7;
		else
		if(start == 71 && destination == 89)
			price = 7;
		else
		if(start == 71 && destination == 90)
			price = 7;
		else
		if(start == 71 && destination == 91)
			price = 7;
		else
		if(start == 71 && destination == 92)
			price = 8;
		else
		if(start == 72 && destination == 0)
			price = 6;
		else
		if(start == 72 && destination == 1)
			price = 6;
		else
		if(start == 72 && destination == 2)
			price = 5;
		else
		if(start == 72 && destination == 3)
			price = 5;
		else
		if(start == 72 && destination == 4)
			price = 5;
		else
		if(start == 72 && destination == 5)
			price = 5;
		else
		if(start == 72 && destination == 6)
			price = 5;
		else
		if(start == 72 && destination == 7)
			price = 4;
		else
		if(start == 72 && destination == 8)
			price = 4;
		else
		if(start == 72 && destination == 9)
			price = 3;
		else
		if(start == 72 && destination == 10)
			price = 3;
		else
		if(start == 72 && destination == 11)
			price = 3;
		else
		if(start == 72 && destination == 12)
			price = 3;
		else
		if(start == 72 && destination == 13)
			price = 3;
		else
		if(start == 72 && destination == 14)
			price = 4;
		else
		if(start == 72 && destination == 15)
			price = 4;
		else
		if(start == 72 && destination == 16)
			price = 4;
		else
		if(start == 72 && destination == 17)
			price = 4;
		else
		if(start == 72 && destination == 18)
			price = 5;
		else
		if(start == 72 && destination == 19)
			price = 5;
		else
		if(start == 72 && destination == 20)
			price = 5;
		else
		if(start == 72 && destination == 21)
			price = 5;
		else
		if(start == 72 && destination == 22)
			price = 6;
		else
		if(start == 72 && destination == 23)
			price = 4;
		else
		if(start == 72 && destination == 24)
			price = 5;
		else
		if(start == 72 && destination == 25)
			price = 5;
		else
		if(start == 72 && destination == 26)
			price = 5;
		else
		if(start == 72 && destination == 27)
			price = 5;
		else
		if(start == 72 && destination == 28)
			price = 5;
		else
		if(start == 72 && destination == 29)
			price = 5;
		else
		if(start == 72 && destination == 30)
			price = 5;
		else
		if(start == 72 && destination == 31)
			price = 5;
		else
		if(start == 72 && destination == 32)
			price = 5;
		else
		if(start == 72 && destination == 33)
			price = 5;
		else
		if(start == 72 && destination == 34)
			price = 5;
		else
		if(start == 72 && destination == 35)
			price = 5;
		else
		if(start == 72 && destination == 36)
			price = 5;
		else
		if(start == 72 && destination == 37)
			price = 5;
		else
		if(start == 72 && destination == 38)
			price = 5;
		else
		if(start == 72 && destination == 39)
			price = 5;
		else
		if(start == 72 && destination == 40)
			price = 6;
		else
		if(start == 72 && destination == 41)
			price = 6;
		else
		if(start == 72 && destination == 42)
			price = 7;
		else
		if(start == 72 && destination == 43)
			price = 7;
		else
		if(start == 72 && destination == 44)
			price = 7;
		else
		if(start == 72 && destination == 45)
			price = 7;
		else
		if(start == 72 && destination == 46)
			price = 7;
		else
		if(start == 72 && destination == 47)
			price = 7;
		else
		if(start == 72 && destination == 48)
			price = 7;
		else
		if(start == 72 && destination == 49)
			price = 7;
		else
		if(start == 72 && destination == 50)
			price = 7;
		else
		if(start == 72 && destination == 51)
			price = 7;
		else
		if(start == 72 && destination == 52)
			price = 7;
		else
		if(start == 72 && destination == 53)
			price = 6;
		else
		if(start == 72 && destination == 54)
			price = 6;
		else
		if(start == 72 && destination == 55)
			price = 6;
		else
		if(start == 72 && destination == 56)
			price = 6;
		else
		if(start == 72 && destination == 57)
			price = 5;
		else
		if(start == 72 && destination == 58)
			price = 5;
		else
		if(start == 72 && destination == 59)
			price = 5;
		else
		if(start == 72 && destination == 60)
			price = 5;
		else
		if(start == 72 && destination == 61)
			price = 4;
		else
		if(start == 72 && destination == 62)
			price = 4;
		else
		if(start == 72 && destination == 63)
			price = 4;
		else
		if(start == 72 && destination == 64)
			price = 4;
		else
		if(start == 72 && destination == 65)
			price = 4;
		else
		if(start == 72 && destination == 66)
			price = 3;
		else
		if(start == 72 && destination == 67)
			price = 3;
		else
		if(start == 72 && destination == 68)
			price = 3;
		else
		if(start == 72 && destination == 69)
			price = 3;
		else
		if(start == 72 && destination == 70)
			price = 2;
		else
		if(start == 72 && destination == 71)
			price = 2;
		else
		if(start == 72 && destination == 72)
			price = 0;
		else
		if(start == 72 && destination == 73)
			price = 2;
		else
		if(start == 72 && destination == 74)
			price = 2;
		else
		if(start == 72 && destination == 75)
			price = 3;
		else
		if(start == 72 && destination == 76)
			price = 3;
		else
		if(start == 72 && destination == 77)
			price = 5;
		else
		if(start == 72 && destination == 78)
			price = 5;
		else
		if(start == 72 && destination == 79)
			price = 5;
		else
		if(start == 72 && destination == 80)
			price = 5;
		else
		if(start == 72 && destination == 81)
			price = 5;
		else
		if(start == 72 && destination == 82)
			price = 5;
		else
		if(start == 72 && destination == 83)
			price = 5;
		else
		if(start == 72 && destination == 84)
			price = 5;
		else
		if(start == 72 && destination == 85)
			price = 6;
		else
		if(start == 72 && destination == 86)
			price = 6;
		else
		if(start == 72 && destination == 87)
			price = 7;
		else
		if(start == 72 && destination == 88)
			price = 7;
		else
		if(start == 72 && destination == 89)
			price = 7;
		else
		if(start == 72 && destination == 90)
			price = 7;
		else
		if(start == 72 && destination == 91)
			price = 8;
		else
		if(start == 72 && destination == 92)
			price = 8;
		else
		if(start == 73 && destination == 0)
			price = 6;
		else
		if(start == 73 && destination == 1)
			price = 6;
		else
		if(start == 73 && destination == 2)
			price = 6;
		else
		if(start == 73 && destination == 3)
			price = 5;
		else
		if(start == 73 && destination == 4)
			price = 5;
		else
		if(start == 73 && destination == 5)
			price = 5;
		else
		if(start == 73 && destination == 6)
			price = 5;
		else
		if(start == 73 && destination == 7)
			price = 5;
		else
		if(start == 73 && destination == 8)
			price = 4;
		else
		if(start == 73 && destination == 9)
			price = 4;
		else
		if(start == 73 && destination == 10)
			price = 4;
		else
		if(start == 73 && destination == 11)
			price = 3;
		else
		if(start == 73 && destination == 12)
			price = 4;
		else
		if(start == 73 && destination == 13)
			price = 4;
		else
		if(start == 73 && destination == 14)
			price = 4;
		else
		if(start == 73 && destination == 15)
			price = 4;
		else
		if(start == 73 && destination == 16)
			price = 5;
		else
		if(start == 73 && destination == 17)
			price = 5;
		else
		if(start == 73 && destination == 18)
			price = 5;
		else
		if(start == 73 && destination == 19)
			price = 5;
		else
		if(start == 73 && destination == 20)
			price = 5;
		else
		if(start == 73 && destination == 21)
			price = 6;
		else
		if(start == 73 && destination == 22)
			price = 6;
		else
		if(start == 73 && destination == 23)
			price = 5;
		else
		if(start == 73 && destination == 24)
			price = 5;
		else
		if(start == 73 && destination == 25)
			price = 5;
		else
		if(start == 73 && destination == 26)
			price = 5;
		else
		if(start == 73 && destination == 27)
			price = 5;
		else
		if(start == 73 && destination == 28)
			price = 6;
		else
		if(start == 73 && destination == 29)
			price = 5;
		else
		if(start == 73 && destination == 30)
			price = 5;
		else
		if(start == 73 && destination == 31)
			price = 5;
		else
		if(start == 73 && destination == 32)
			price = 5;
		else
		if(start == 73 && destination == 33)
			price = 5;
		else
		if(start == 73 && destination == 34)
			price = 5;
		else
		if(start == 73 && destination == 35)
			price = 5;
		else
		if(start == 73 && destination == 36)
			price = 5;
		else
		if(start == 73 && destination == 37)
			price = 6;
		else
		if(start == 73 && destination == 38)
			price = 6;
		else
		if(start == 73 && destination == 39)
			price = 6;
		else
		if(start == 73 && destination == 40)
			price = 6;
		else
		if(start == 73 && destination == 41)
			price = 7;
		else
		if(start == 73 && destination == 42)
			price = 7;
		else
		if(start == 73 && destination == 43)
			price = 7;
		else
		if(start == 73 && destination == 44)
			price = 7;
		else
		if(start == 73 && destination == 45)
			price = 7;
		else
		if(start == 73 && destination == 46)
			price = 7;
		else
		if(start == 73 && destination == 47)
			price = 8;
		else
		if(start == 73 && destination == 48)
			price = 8;
		else
		if(start == 73 && destination == 49)
			price = 7;
		else
		if(start == 73 && destination == 50)
			price = 7;
		else
		if(start == 73 && destination == 51)
			price = 7;
		else
		if(start == 73 && destination == 52)
			price = 7;
		else
		if(start == 73 && destination == 53)
			price = 7;
		else
		if(start == 73 && destination == 54)
			price = 6;
		else
		if(start == 73 && destination == 55)
			price = 6;
		else
		if(start == 73 && destination == 56)
			price = 6;
		else
		if(start == 73 && destination == 57)
			price = 6;
		else
		if(start == 73 && destination == 58)
			price = 5;
		else
		if(start == 73 && destination == 59)
			price = 5;
		else
		if(start == 73 && destination == 60)
			price = 5;
		else
		if(start == 73 && destination == 61)
			price = 5;
		else
		if(start == 73 && destination == 62)
			price = 5;
		else
		if(start == 73 && destination == 63)
			price = 4;
		else
		if(start == 73 && destination == 64)
			price = 4;
		else
		if(start == 73 && destination == 65)
			price = 4;
		else
		if(start == 73 && destination == 66)
			price = 4;
		else
		if(start == 73 && destination == 67)
			price = 4;
		else
		if(start == 73 && destination == 68)
			price = 3;
		else
		if(start == 73 && destination == 69)
			price = 3;
		else
		if(start == 73 && destination == 70)
			price = 3;
		else
		if(start == 73 && destination == 71)
			price = 3;
		else
		if(start == 73 && destination == 72)
			price = 2;
		else
		if(start == 73 && destination == 73)
			price = 0;
		else
		if(start == 73 && destination == 74)
			price = 2;
		else
		if(start == 73 && destination == 75)
			price = 2;
		else
		if(start == 73 && destination == 76)
			price = 3;
		else
		if(start == 73 && destination == 77)
			price = 6;
		else
		if(start == 73 && destination == 78)
			price = 6;
		else
		if(start == 73 && destination == 79)
			price = 5;
		else
		if(start == 73 && destination == 80)
			price = 5;
		else
		if(start == 73 && destination == 81)
			price = 5;
		else
		if(start == 73 && destination == 82)
			price = 5;
		else
		if(start == 73 && destination == 83)
			price = 6;
		else
		if(start == 73 && destination == 84)
			price = 6;
		else
		if(start == 73 && destination == 85)
			price = 6;
		else
		if(start == 73 && destination == 86)
			price = 7;
		else
		if(start == 73 && destination == 87)
			price = 7;
		else
		if(start == 73 && destination == 88)
			price = 7;
		else
		if(start == 73 && destination == 89)
			price = 7;
		else
		if(start == 73 && destination == 90)
			price = 8;
		else
		if(start == 73 && destination == 91)
			price = 8;
		else
		if(start == 73 && destination == 92)
			price = 8;
		else
		if(start == 74 && destination == 0)
			price = 6;
		else
		if(start == 74 && destination == 1)
			price = 6;
		else
		if(start == 74 && destination == 2)
			price = 6;
		else
		if(start == 74 && destination == 3)
			price = 6;
		else
		if(start == 74 && destination == 4)
			price = 5;
		else
		if(start == 74 && destination == 5)
			price = 5;
		else
		if(start == 74 && destination == 6)
			price = 5;
		else
		if(start == 74 && destination == 7)
			price = 5;
		else
		if(start == 74 && destination == 8)
			price = 5;
		else
		if(start == 74 && destination == 9)
			price = 4;
		else
		if(start == 74 && destination == 10)
			price = 4;
		else
		if(start == 74 && destination == 11)
			price = 4;
		else
		if(start == 74 && destination == 12)
			price = 4;
		else
		if(start == 74 && destination == 13)
			price = 4;
		else
		if(start == 74 && destination == 14)
			price = 4;
		else
		if(start == 74 && destination == 15)
			price = 5;
		else
		if(start == 74 && destination == 16)
			price = 5;
		else
		if(start == 74 && destination == 17)
			price = 5;
		else
		if(start == 74 && destination == 18)
			price = 5;
		else
		if(start == 74 && destination == 19)
			price = 5;
		else
		if(start == 74 && destination == 20)
			price = 6;
		else
		if(start == 74 && destination == 21)
			price = 6;
		else
		if(start == 74 && destination == 22)
			price = 6;
		else
		if(start == 74 && destination == 23)
			price = 5;
		else
		if(start == 74 && destination == 24)
			price = 5;
		else
		if(start == 74 && destination == 25)
			price = 5;
		else
		if(start == 74 && destination == 26)
			price = 5;
		else
		if(start == 74 && destination == 27)
			price = 6;
		else
		if(start == 74 && destination == 28)
			price = 6;
		else
		if(start == 74 && destination == 29)
			price = 6;
		else
		if(start == 74 && destination == 30)
			price = 6;
		else
		if(start == 74 && destination == 31)
			price = 5;
		else
		if(start == 74 && destination == 32)
			price = 5;
		else
		if(start == 74 && destination == 33)
			price = 5;
		else
		if(start == 74 && destination == 34)
			price = 5;
		else
		if(start == 74 && destination == 35)
			price = 5;
		else
		if(start == 74 && destination == 36)
			price = 6;
		else
		if(start == 74 && destination == 37)
			price = 6;
		else
		if(start == 74 && destination == 38)
			price = 6;
		else
		if(start == 74 && destination == 39)
			price = 6;
		else
		if(start == 74 && destination == 40)
			price = 6;
		else
		if(start == 74 && destination == 41)
			price = 7;
		else
		if(start == 74 && destination == 42)
			price = 7;
		else
		if(start == 74 && destination == 43)
			price = 7;
		else
		if(start == 74 && destination == 44)
			price = 7;
		else
		if(start == 74 && destination == 45)
			price = 7;
		else
		if(start == 74 && destination == 46)
			price = 8;
		else
		if(start == 74 && destination == 47)
			price = 8;
		else
		if(start == 74 && destination == 48)
			price = 8;
		else
		if(start == 74 && destination == 49)
			price = 8;
		else
		if(start == 74 && destination == 50)
			price = 7;
		else
		if(start == 74 && destination == 51)
			price = 7;
		else
		if(start == 74 && destination == 52)
			price = 7;
		else
		if(start == 74 && destination == 53)
			price = 7;
		else
		if(start == 74 && destination == 54)
			price = 7;
		else
		if(start == 74 && destination == 55)
			price = 6;
		else
		if(start == 74 && destination == 56)
			price = 6;
		else
		if(start == 74 && destination == 57)
			price = 6;
		else
		if(start == 74 && destination == 58)
			price = 6;
		else
		if(start == 74 && destination == 59)
			price = 5;
		else
		if(start == 74 && destination == 60)
			price = 5;
		else
		if(start == 74 && destination == 61)
			price = 5;
		else
		if(start == 74 && destination == 62)
			price = 5;
		else
		if(start == 74 && destination == 63)
			price = 5;
		else
		if(start == 74 && destination == 64)
			price = 5;
		else
		if(start == 74 && destination == 65)
			price = 4;
		else
		if(start == 74 && destination == 66)
			price = 4;
		else
		if(start == 74 && destination == 67)
			price = 4;
		else
		if(start == 74 && destination == 68)
			price = 4;
		else
		if(start == 74 && destination == 69)
			price = 3;
		else
		if(start == 74 && destination == 70)
			price = 3;
		else
		if(start == 74 && destination == 71)
			price = 3;
		else
		if(start == 74 && destination == 72)
			price = 2;
		else
		if(start == 74 && destination == 73)
			price = 2;
		else
		if(start == 74 && destination == 74)
			price = 0;
		else
		if(start == 74 && destination == 75)
			price = 2;
		else
		if(start == 74 && destination == 76)
			price = 3;
		else
		if(start == 74 && destination == 77)
			price = 6;
		else
		if(start == 74 && destination == 78)
			price = 6;
		else
		if(start == 74 && destination == 79)
			price = 6;
		else
		if(start == 74 && destination == 80)
			price = 5;
		else
		if(start == 74 && destination == 81)
			price = 5;
		else
		if(start == 74 && destination == 82)
			price = 6;
		else
		if(start == 74 && destination == 83)
			price = 6;
		else
		if(start == 74 && destination == 84)
			price = 6;
		else
		if(start == 74 && destination == 85)
			price = 6;
		else
		if(start == 74 && destination == 86)
			price = 7;
		else
		if(start == 74 && destination == 87)
			price = 7;
		else
		if(start == 74 && destination == 88)
			price = 7;
		else
		if(start == 74 && destination == 89)
			price = 7;
		else
		if(start == 74 && destination == 90)
			price = 8;
		else
		if(start == 74 && destination == 91)
			price = 8;
		else
		if(start == 74 && destination == 92)
			price = 8;
		else
		if(start == 75 && destination == 0)
			price = 6;
		else
		if(start == 75 && destination == 1)
			price = 6;
		else
		if(start == 75 && destination == 2)
			price = 6;
		else
		if(start == 75 && destination == 3)
			price = 6;
		else
		if(start == 75 && destination == 4)
			price = 5;
		else
		if(start == 75 && destination == 5)
			price = 5;
		else
		if(start == 75 && destination == 6)
			price = 5;
		else
		if(start == 75 && destination == 7)
			price = 5;
		else
		if(start == 75 && destination == 8)
			price = 5;
		else
		if(start == 75 && destination == 9)
			price = 5;
		else
		if(start == 75 && destination == 10)
			price = 4;
		else
		if(start == 75 && destination == 11)
			price = 4;
		else
		if(start == 75 && destination == 12)
			price = 4;
		else
		if(start == 75 && destination == 13)
			price = 4;
		else
		if(start == 75 && destination == 14)
			price = 5;
		else
		if(start == 75 && destination == 15)
			price = 5;
		else
		if(start == 75 && destination == 16)
			price = 5;
		else
		if(start == 75 && destination == 17)
			price = 5;
		else
		if(start == 75 && destination == 18)
			price = 5;
		else
		if(start == 75 && destination == 19)
			price = 6;
		else
		if(start == 75 && destination == 20)
			price = 6;
		else
		if(start == 75 && destination == 21)
			price = 6;
		else
		if(start == 75 && destination == 22)
			price = 6;
		else
		if(start == 75 && destination == 23)
			price = 5;
		else
		if(start == 75 && destination == 24)
			price = 5;
		else
		if(start == 75 && destination == 25)
			price = 5;
		else
		if(start == 75 && destination == 26)
			price = 6;
		else
		if(start == 75 && destination == 27)
			price = 6;
		else
		if(start == 75 && destination == 28)
			price = 6;
		else
		if(start == 75 && destination == 29)
			price = 6;
		else
		if(start == 75 && destination == 30)
			price = 6;
		else
		if(start == 75 && destination == 31)
			price = 6;
		else
		if(start == 75 && destination == 32)
			price = 5;
		else
		if(start == 75 && destination == 33)
			price = 5;
		else
		if(start == 75 && destination == 34)
			price = 5;
		else
		if(start == 75 && destination == 35)
			price = 6;
		else
		if(start == 75 && destination == 36)
			price = 6;
		else
		if(start == 75 && destination == 37)
			price = 6;
		else
		if(start == 75 && destination == 38)
			price = 6;
		else
		if(start == 75 && destination == 39)
			price = 6;
		else
		if(start == 75 && destination == 40)
			price = 7;
		else
		if(start == 75 && destination == 41)
			price = 7;
		else
		if(start == 75 && destination == 42)
			price = 7;
		else
		if(start == 75 && destination == 43)
			price = 7;
		else
		if(start == 75 && destination == 44)
			price = 7;
		else
		if(start == 75 && destination == 45)
			price = 8;
		else
		if(start == 75 && destination == 46)
			price = 8;
		else
		if(start == 75 && destination == 47)
			price = 8;
		else
		if(start == 75 && destination == 48)
			price = 8;
		else
		if(start == 75 && destination == 49)
			price = 8;
		else
		if(start == 75 && destination == 50)
			price = 8;
		else
		if(start == 75 && destination == 51)
			price = 7;
		else
		if(start == 75 && destination == 52)
			price = 7;
		else
		if(start == 75 && destination == 53)
			price = 7;
		else
		if(start == 75 && destination == 54)
			price = 7;
		else
		if(start == 75 && destination == 55)
			price = 7;
		else
		if(start == 75 && destination == 56)
			price = 6;
		else
		if(start == 75 && destination == 57)
			price = 6;
		else
		if(start == 75 && destination == 58)
			price = 6;
		else
		if(start == 75 && destination == 59)
			price = 5;
		else
		if(start == 75 && destination == 60)
			price = 5;
		else
		if(start == 75 && destination == 61)
			price = 5;
		else
		if(start == 75 && destination == 62)
			price = 5;
		else
		if(start == 75 && destination == 63)
			price = 5;
		else
		if(start == 75 && destination == 64)
			price = 5;
		else
		if(start == 75 && destination == 65)
			price = 5;
		else
		if(start == 75 && destination == 66)
			price = 4;
		else
		if(start == 75 && destination == 67)
			price = 4;
		else
		if(start == 75 && destination == 68)
			price = 4;
		else
		if(start == 75 && destination == 69)
			price = 4;
		else
		if(start == 75 && destination == 70)
			price = 3;
		else
		if(start == 75 && destination == 71)
			price = 3;
		else
		if(start == 75 && destination == 72)
			price = 3;
		else
		if(start == 75 && destination == 73)
			price = 2;
		else
		if(start == 75 && destination == 74)
			price = 2;
		else
		if(start == 75 && destination == 75)
			price = 0;
		else
		if(start == 75 && destination == 76)
			price = 2;
		else
		if(start == 75 && destination == 77)
			price = 6;
		else
		if(start == 75 && destination == 78)
			price = 6;
		else
		if(start == 75 && destination == 79)
			price = 6;
		else
		if(start == 75 && destination == 80)
			price = 6;
		else
		if(start == 75 && destination == 81)
			price = 6;
		else
		if(start == 75 && destination == 82)
			price = 6;
		else
		if(start == 75 && destination == 83)
			price = 6;
		else
		if(start == 75 && destination == 84)
			price = 6;
		else
		if(start == 75 && destination == 85)
			price = 7;
		else
		if(start == 75 && destination == 86)
			price = 7;
		else
		if(start == 75 && destination == 87)
			price = 7;
		else
		if(start == 75 && destination == 88)
			price = 7;
		else
		if(start == 75 && destination == 89)
			price = 8;
		else
		if(start == 75 && destination == 90)
			price = 8;
		else
		if(start == 75 && destination == 91)
			price = 8;
		else
		if(start == 75 && destination == 92)
			price = 8;
		else
		if(start == 76 && destination == 0)
			price = 7;
		else
		if(start == 76 && destination == 1)
			price = 7;
		else
		if(start == 76 && destination == 2)
			price = 6;
		else
		if(start == 76 && destination == 3)
			price = 6;
		else
		if(start == 76 && destination == 4)
			price = 6;
		else
		if(start == 76 && destination == 5)
			price = 6;
		else
		if(start == 76 && destination == 6)
			price = 6;
		else
		if(start == 76 && destination == 7)
			price = 5;
		else
		if(start == 76 && destination == 8)
			price = 5;
		else
		if(start == 76 && destination == 9)
			price = 5;
		else
		if(start == 76 && destination == 10)
			price = 5;
		else
		if(start == 76 && destination == 11)
			price = 5;
		else
		if(start == 76 && destination == 12)
			price = 5;
		else
		if(start == 76 && destination == 13)
			price = 5;
		else
		if(start == 76 && destination == 14)
			price = 5;
		else
		if(start == 76 && destination == 15)
			price = 5;
		else
		if(start == 76 && destination == 16)
			price = 5;
		else
		if(start == 76 && destination == 17)
			price = 6;
		else
		if(start == 76 && destination == 18)
			price = 6;
		else
		if(start == 76 && destination == 19)
			price = 6;
		else
		if(start == 76 && destination == 20)
			price = 6;
		else
		if(start == 76 && destination == 21)
			price = 7;
		else
		if(start == 76 && destination == 22)
			price = 7;
		else
		if(start == 76 && destination == 23)
			price = 5;
		else
		if(start == 76 && destination == 24)
			price = 6;
		else
		if(start == 76 && destination == 25)
			price = 6;
		else
		if(start == 76 && destination == 26)
			price = 6;
		else
		if(start == 76 && destination == 27)
			price = 6;
		else
		if(start == 76 && destination == 28)
			price = 6;
		else
		if(start == 76 && destination == 29)
			price = 6;
		else
		if(start == 76 && destination == 30)
			price = 6;
		else
		if(start == 76 && destination == 31)
			price = 6;
		else
		if(start == 76 && destination == 32)
			price = 6;
		else
		if(start == 76 && destination == 33)
			price = 6;
		else
		if(start == 76 && destination == 34)
			price = 6;
		else
		if(start == 76 && destination == 35)
			price = 6;
		else
		if(start == 76 && destination == 36)
			price = 6;
		else
		if(start == 76 && destination == 37)
			price = 6;
		else
		if(start == 76 && destination == 38)
			price = 6;
		else
		if(start == 76 && destination == 39)
			price = 7;
		else
		if(start == 76 && destination == 40)
			price = 7;
		else
		if(start == 76 && destination == 41)
			price = 7;
		else
		if(start == 76 && destination == 42)
			price = 7;
		else
		if(start == 76 && destination == 43)
			price = 8;
		else
		if(start == 76 && destination == 44)
			price = 8;
		else
		if(start == 76 && destination == 45)
			price = 8;
		else
		if(start == 76 && destination == 46)
			price = 8;
		else
		if(start == 76 && destination == 47)
			price = 8;
		else
		if(start == 76 && destination == 48)
			price = 8;
		else
		if(start == 76 && destination == 49)
			price = 8;
		else
		if(start == 76 && destination == 50)
			price = 8;
		else
		if(start == 76 && destination == 51)
			price = 8;
		else
		if(start == 76 && destination == 52)
			price = 8;
		else
		if(start == 76 && destination == 53)
			price = 7;
		else
		if(start == 76 && destination == 54)
			price = 7;
		else
		if(start == 76 && destination == 55)
			price = 7;
		else
		if(start == 76 && destination == 56)
			price = 7;
		else
		if(start == 76 && destination == 57)
			price = 7;
		else
		if(start == 76 && destination == 58)
			price = 6;
		else
		if(start == 76 && destination == 59)
			price = 6;
		else
		if(start == 76 && destination == 60)
			price = 6;
		else
		if(start == 76 && destination == 61)
			price = 6;
		else
		if(start == 76 && destination == 62)
			price = 5;
		else
		if(start == 76 && destination == 63)
			price = 5;
		else
		if(start == 76 && destination == 64)
			price = 5;
		else
		if(start == 76 && destination == 65)
			price = 5;
		else
		if(start == 76 && destination == 66)
			price = 5;
		else
		if(start == 76 && destination == 67)
			price = 5;
		else
		if(start == 76 && destination == 68)
			price = 5;
		else
		if(start == 76 && destination == 69)
			price = 4;
		else
		if(start == 76 && destination == 70)
			price = 4;
		else
		if(start == 76 && destination == 71)
			price = 4;
		else
		if(start == 76 && destination == 72)
			price = 3;
		else
		if(start == 76 && destination == 73)
			price = 3;
		else
		if(start == 76 && destination == 74)
			price = 3;
		else
		if(start == 76 && destination == 75)
			price = 2;
		else
		if(start == 76 && destination == 76)
			price = 0;
		else
		if(start == 76 && destination == 77)
			price = 7;
		else
		if(start == 76 && destination == 78)
			price = 6;
		else
		if(start == 76 && destination == 79)
			price = 6;
		else
		if(start == 76 && destination == 80)
			price = 6;
		else
		if(start == 76 && destination == 81)
			price = 6;
		else
		if(start == 76 && destination == 82)
			price = 6;
		else
		if(start == 76 && destination == 83)
			price = 6;
		else
		if(start == 76 && destination == 84)
			price = 7;
		else
		if(start == 76 && destination == 85)
			price = 7;
		else
		if(start == 76 && destination == 86)
			price = 7;
		else
		if(start == 76 && destination == 87)
			price = 8;
		else
		if(start == 76 && destination == 88)
			price = 8;
		else
		if(start == 76 && destination == 89)
			price = 8;
		else
		if(start == 76 && destination == 90)
			price = 8;
		else
		if(start == 76 && destination == 91)
			price = 8;
		else
		if(start == 76 && destination == 92)
			price = 9;
		else
		if(start == 77 && destination == 0)
			price = 4;
		else
		if(start == 77 && destination == 1)
			price = 4;
		else
		if(start == 77 && destination == 2)
			price = 3;
		else
		if(start == 77 && destination == 3)
			price = 3;
		else
		if(start == 77 && destination == 4)
			price = 3;
		else
		if(start == 77 && destination == 5)
			price = 3;
		else
		if(start == 77 && destination == 6)
			price = 3;
		else
		if(start == 77 && destination == 7)
			price = 4;
		else
		if(start == 77 && destination == 8)
			price = 4;
		else
		if(start == 77 && destination == 9)
			price = 4;
		else
		if(start == 77 && destination == 10)
			price = 5;
		else
		if(start == 77 && destination == 11)
			price = 5;
		else
		if(start == 77 && destination == 12)
			price = 5;
		else
		if(start == 77 && destination == 13)
			price = 5;
		else
		if(start == 77 && destination == 14)
			price = 5;
		else
		if(start == 77 && destination == 15)
			price = 6;
		else
		if(start == 77 && destination == 16)
			price = 6;
		else
		if(start == 77 && destination == 17)
			price = 6;
		else
		if(start == 77 && destination == 18)
			price = 6;
		else
		if(start == 77 && destination == 19)
			price = 6;
		else
		if(start == 77 && destination == 20)
			price = 7;
		else
		if(start == 77 && destination == 21)
			price = 7;
		else
		if(start == 77 && destination == 22)
			price = 7;
		else
		if(start == 77 && destination == 23)
			price = 5;
		else
		if(start == 77 && destination == 24)
			price = 5;
		else
		if(start == 77 && destination == 25)
			price = 5;
		else
		if(start == 77 && destination == 26)
			price = 5;
		else
		if(start == 77 && destination == 27)
			price = 4;
		else
		if(start == 77 && destination == 28)
			price = 4;
		else
		if(start == 77 && destination == 29)
			price = 4;
		else
		if(start == 77 && destination == 30)
			price = 3;
		else
		if(start == 77 && destination == 31)
			price = 3;
		else
		if(start == 77 && destination == 32)
			price = 3;
		else
		if(start == 77 && destination == 33)
			price = 3;
		else
		if(start == 77 && destination == 34)
			price = 3;
		else
		if(start == 77 && destination == 35)
			price = 4;
		else
		if(start == 77 && destination == 36)
			price = 4;
		else
		if(start == 77 && destination == 37)
			price = 4;
		else
		if(start == 77 && destination == 38)
			price = 4;
		else
		if(start == 77 && destination == 39)
			price = 5;
		else
		if(start == 77 && destination == 40)
			price = 5;
		else
		if(start == 77 && destination == 41)
			price = 5;
		else
		if(start == 77 && destination == 42)
			price = 5;
		else
		if(start == 77 && destination == 43)
			price = 6;
		else
		if(start == 77 && destination == 44)
			price = 6;
		else
		if(start == 77 && destination == 45)
			price = 6;
		else
		if(start == 77 && destination == 46)
			price = 6;
		else
		if(start == 77 && destination == 47)
			price = 7;
		else
		if(start == 77 && destination == 48)
			price = 6;
		else
		if(start == 77 && destination == 49)
			price = 6;
		else
		if(start == 77 && destination == 50)
			price = 5;
		else
		if(start == 77 && destination == 51)
			price = 5;
		else
		if(start == 77 && destination == 52)
			price = 5;
		else
		if(start == 77 && destination == 53)
			price = 5;
		else
		if(start == 77 && destination == 54)
			price = 4;
		else
		if(start == 77 && destination == 55)
			price = 4;
		else
		if(start == 77 && destination == 56)
			price = 4;
		else
		if(start == 77 && destination == 57)
			price = 3;
		else
		if(start == 77 && destination == 58)
			price = 3;
		else
		if(start == 77 && destination == 59)
			price = 3;
		else
		if(start == 77 && destination == 60)
			price = 3;
		else
		if(start == 77 && destination == 61)
			price = 3;
		else
		if(start == 77 && destination == 62)
			price = 3;
		else
		if(start == 77 && destination == 63)
			price = 4;
		else
		if(start == 77 && destination == 64)
			price = 4;
		else
		if(start == 77 && destination == 65)
			price = 4;
		else
		if(start == 77 && destination == 66)
			price = 4;
		else
		if(start == 77 && destination == 67)
			price = 4;
		else
		if(start == 77 && destination == 68)
			price = 5;
		else
		if(start == 77 && destination == 69)
			price = 5;
		else
		if(start == 77 && destination == 70)
			price = 5;
		else
		if(start == 77 && destination == 71)
			price = 5;
		else
		if(start == 77 && destination == 72)
			price = 5;
		else
		if(start == 77 && destination == 73)
			price = 6;
		else
		if(start == 77 && destination == 74)
			price = 6;
		else
		if(start == 77 && destination == 75)
			price = 6;
		else
		if(start == 77 && destination == 76)
			price = 7;
		else
		if(start == 77 && destination == 77)
			price = 0;
		else
		if(start == 77 && destination == 78)
			price = 2;
		else
		if(start == 77 && destination == 79)
			price = 2;
		else
		if(start == 77 && destination == 80)
			price = 3;
		else
		if(start == 77 && destination == 81)
			price = 3;
		else
		if(start == 77 && destination == 82)
			price = 3;
		else
		if(start == 77 && destination == 83)
			price = 4;
		else
		if(start == 77 && destination == 84)
			price = 4;
		else
		if(start == 77 && destination == 85)
			price = 4;
		else
		if(start == 77 && destination == 86)
			price = 5;
		else
		if(start == 77 && destination == 87)
			price = 6;
		else
		if(start == 77 && destination == 88)
			price = 6;
		else
		if(start == 77 && destination == 89)
			price = 6;
		else
		if(start == 77 && destination == 90)
			price = 6;
		else
		if(start == 77 && destination == 91)
			price = 7;
		else
		if(start == 77 && destination == 92)
			price = 7;
		else
		if(start == 78 && destination == 0)
			price = 3;
		else
		if(start == 78 && destination == 1)
			price = 3;
		else
		if(start == 78 && destination == 2)
			price = 3;
		else
		if(start == 78 && destination == 3)
			price = 2;
		else
		if(start == 78 && destination == 4)
			price = 2;
		else
		if(start == 78 && destination == 5)
			price = 3;
		else
		if(start == 78 && destination == 6)
			price = 3;
		else
		if(start == 78 && destination == 7)
			price = 3;
		else
		if(start == 78 && destination == 8)
			price = 4;
		else
		if(start == 78 && destination == 9)
			price = 4;
		else
		if(start == 78 && destination == 10)
			price = 4;
		else
		if(start == 78 && destination == 11)
			price = 5;
		else
		if(start == 78 && destination == 12)
			price = 5;
		else
		if(start == 78 && destination == 13)
			price = 5;
		else
		if(start == 78 && destination == 14)
			price = 5;
		else
		if(start == 78 && destination == 15)
			price = 5;
		else
		if(start == 78 && destination == 16)
			price = 6;
		else
		if(start == 78 && destination == 17)
			price = 6;
		else
		if(start == 78 && destination == 18)
			price = 6;
		else
		if(start == 78 && destination == 19)
			price = 6;
		else
		if(start == 78 && destination == 20)
			price = 6;
		else
		if(start == 78 && destination == 21)
			price = 7;
		else
		if(start == 78 && destination == 22)
			price = 7;
		else
		if(start == 78 && destination == 23)
			price = 5;
		else
		if(start == 78 && destination == 24)
			price = 5;
		else
		if(start == 78 && destination == 25)
			price = 4;
		else
		if(start == 78 && destination == 26)
			price = 4;
		else
		if(start == 78 && destination == 27)
			price = 4;
		else
		if(start == 78 && destination == 28)
			price = 4;
		else
		if(start == 78 && destination == 29)
			price = 3;
		else
		if(start == 78 && destination == 30)
			price = 3;
		else
		if(start == 78 && destination == 31)
			price = 3;
		else
		if(start == 78 && destination == 32)
			price = 3;
		else
		if(start == 78 && destination == 33)
			price = 3;
		else
		if(start == 78 && destination == 34)
			price = 3;
		else
		if(start == 78 && destination == 35)
			price = 3;
		else
		if(start == 78 && destination == 36)
			price = 4;
		else
		if(start == 78 && destination == 37)
			price = 4;
		else
		if(start == 78 && destination == 38)
			price = 4;
		else
		if(start == 78 && destination == 39)
			price = 4;
		else
		if(start == 78 && destination == 40)
			price = 5;
		else
		if(start == 78 && destination == 41)
			price = 5;
		else
		if(start == 78 && destination == 42)
			price = 5;
		else
		if(start == 78 && destination == 43)
			price = 5;
		else
		if(start == 78 && destination == 44)
			price = 6;
		else
		if(start == 78 && destination == 45)
			price = 6;
		else
		if(start == 78 && destination == 46)
			price = 6;
		else
		if(start == 78 && destination == 47)
			price = 6;
		else
		if(start == 78 && destination == 48)
			price = 6;
		else
		if(start == 78 && destination == 49)
			price = 5;
		else
		if(start == 78 && destination == 50)
			price = 5;
		else
		if(start == 78 && destination == 51)
			price = 5;
		else
		if(start == 78 && destination == 52)
			price = 5;
		else
		if(start == 78 && destination == 53)
			price = 5;
		else
		if(start == 78 && destination == 54)
			price = 4;
		else
		if(start == 78 && destination == 55)
			price = 4;
		else
		if(start == 78 && destination == 56)
			price = 3;
		else
		if(start == 78 && destination == 57)
			price = 3;
		else
		if(start == 78 && destination == 58)
			price = 3;
		else
		if(start == 78 && destination == 59)
			price = 2;
		else
		if(start == 78 && destination == 60)
			price = 3;
		else
		if(start == 78 && destination == 61)
			price = 3;
		else
		if(start == 78 && destination == 62)
			price = 3;
		else
		if(start == 78 && destination == 63)
			price = 3;
		else
		if(start == 78 && destination == 64)
			price = 3;
		else
		if(start == 78 && destination == 65)
			price = 4;
		else
		if(start == 78 && destination == 66)
			price = 4;
		else
		if(start == 78 && destination == 67)
			price = 4;
		else
		if(start == 78 && destination == 68)
			price = 4;
		else
		if(start == 78 && destination == 69)
			price = 5;
		else
		if(start == 78 && destination == 70)
			price = 5;
		else
		if(start == 78 && destination == 71)
			price = 5;
		else
		if(start == 78 && destination == 72)
			price = 5;
		else
		if(start == 78 && destination == 73)
			price = 6;
		else
		if(start == 78 && destination == 74)
			price = 6;
		else
		if(start == 78 && destination == 75)
			price = 6;
		else
		if(start == 78 && destination == 76)
			price = 6;
		else
		if(start == 78 && destination == 77)
			price = 2;
		else
		if(start == 78 && destination == 78)
			price = 0;
		else
		if(start == 78 && destination == 79)
			price = 2;
		else
		if(start == 78 && destination == 80)
			price = 2;
		else
		if(start == 78 && destination == 81)
			price = 3;
		else
		if(start == 78 && destination == 82)
			price = 3;
		else
		if(start == 78 && destination == 83)
			price = 3;
		else
		if(start == 78 && destination == 84)
			price = 4;
		else
		if(start == 78 && destination == 85)
			price = 4;
		else
		if(start == 78 && destination == 86)
			price = 5;
		else
		if(start == 78 && destination == 87)
			price = 5;
		else
		if(start == 78 && destination == 88)
			price = 6;
		else
		if(start == 78 && destination == 89)
			price = 6;
		else
		if(start == 78 && destination == 90)
			price = 6;
		else
		if(start == 78 && destination == 91)
			price = 7;
		else
		if(start == 78 && destination == 92)
			price = 7;
		else
		if(start == 79 && destination == 0)
			price = 3;
		else
		if(start == 79 && destination == 1)
			price = 3;
		else
		if(start == 79 && destination == 2)
			price = 2;
		else
		if(start == 79 && destination == 3)
			price = 2;
		else
		if(start == 79 && destination == 4)
			price = 2;
		else
		if(start == 79 && destination == 5)
			price = 2;
		else
		if(start == 79 && destination == 6)
			price = 3;
		else
		if(start == 79 && destination == 7)
			price = 3;
		else
		if(start == 79 && destination == 8)
			price = 3;
		else
		if(start == 79 && destination == 9)
			price = 4;
		else
		if(start == 79 && destination == 10)
			price = 4;
		else
		if(start == 79 && destination == 11)
			price = 4;
		else
		if(start == 79 && destination == 12)
			price = 5;
		else
		if(start == 79 && destination == 13)
			price = 5;
		else
		if(start == 79 && destination == 14)
			price = 5;
		else
		if(start == 79 && destination == 15)
			price = 5;
		else
		if(start == 79 && destination == 16)
			price = 5;
		else
		if(start == 79 && destination == 17)
			price = 6;
		else
		if(start == 79 && destination == 18)
			price = 6;
		else
		if(start == 79 && destination == 19)
			price = 6;
		else
		if(start == 79 && destination == 20)
			price = 6;
		else
		if(start == 79 && destination == 21)
			price = 7;
		else
		if(start == 79 && destination == 22)
			price = 7;
		else
		if(start == 79 && destination == 23)
			price = 5;
		else
		if(start == 79 && destination == 24)
			price = 4;
		else
		if(start == 79 && destination == 25)
			price = 4;
		else
		if(start == 79 && destination == 26)
			price = 4;
		else
		if(start == 79 && destination == 27)
			price = 4;
		else
		if(start == 79 && destination == 28)
			price = 3;
		else
		if(start == 79 && destination == 29)
			price = 3;
		else
		if(start == 79 && destination == 30)
			price = 3;
		else
		if(start == 79 && destination == 31)
			price = 3;
		else
		if(start == 79 && destination == 32)
			price = 2;
		else
		if(start == 79 && destination == 33)
			price = 2;
		else
		if(start == 79 && destination == 34)
			price = 3;
		else
		if(start == 79 && destination == 35)
			price = 3;
		else
		if(start == 79 && destination == 36)
			price = 3;
		else
		if(start == 79 && destination == 37)
			price = 3;
		else
		if(start == 79 && destination == 38)
			price = 4;
		else
		if(start == 79 && destination == 39)
			price = 4;
		else
		if(start == 79 && destination == 40)
			price = 4;
		else
		if(start == 79 && destination == 41)
			price = 5;
		else
		if(start == 79 && destination == 42)
			price = 5;
		else
		if(start == 79 && destination == 43)
			price = 5;
		else
		if(start == 79 && destination == 44)
			price = 5;
		else
		if(start == 79 && destination == 45)
			price = 5;
		else
		if(start == 79 && destination == 46)
			price = 6;
		else
		if(start == 79 && destination == 47)
			price = 6;
		else
		if(start == 79 && destination == 48)
			price = 5;
		else
		if(start == 79 && destination == 49)
			price = 5;
		else
		if(start == 79 && destination == 50)
			price = 5;
		else
		if(start == 79 && destination == 51)
			price = 5;
		else
		if(start == 79 && destination == 52)
			price = 5;
		else
		if(start == 79 && destination == 53)
			price = 4;
		else
		if(start == 79 && destination == 54)
			price = 3;
		else
		if(start == 79 && destination == 55)
			price = 3;
		else
		if(start == 79 && destination == 56)
			price = 3;
		else
		if(start == 79 && destination == 57)
			price = 3;
		else
		if(start == 79 && destination == 58)
			price = 3;
		else
		if(start == 79 && destination == 59)
			price = 2;
		else
		if(start == 79 && destination == 60)
			price = 2;
		else
		if(start == 79 && destination == 61)
			price = 2;
		else
		if(start == 79 && destination == 62)
			price = 3;
		else
		if(start == 79 && destination == 63)
			price = 3;
		else
		if(start == 79 && destination == 64)
			price = 3;
		else
		if(start == 79 && destination == 65)
			price = 3;
		else
		if(start == 79 && destination == 66)
			price = 4;
		else
		if(start == 79 && destination == 67)
			price = 4;
		else
		if(start == 79 && destination == 68)
			price = 4;
		else
		if(start == 79 && destination == 69)
			price = 4;
		else
		if(start == 79 && destination == 70)
			price = 4;
		else
		if(start == 79 && destination == 71)
			price = 5;
		else
		if(start == 79 && destination == 72)
			price = 5;
		else
		if(start == 79 && destination == 73)
			price = 5;
		else
		if(start == 79 && destination == 74)
			price = 6;
		else
		if(start == 79 && destination == 75)
			price = 6;
		else
		if(start == 79 && destination == 76)
			price = 6;
		else
		if(start == 79 && destination == 77)
			price = 2;
		else
		if(start == 79 && destination == 78)
			price = 2;
		else
		if(start == 79 && destination == 79)
			price = 0;
		else
		if(start == 79 && destination == 80)
			price = 2;
		else
		if(start == 79 && destination == 81)
			price = 2;
		else
		if(start == 79 && destination == 82)
			price = 3;
		else
		if(start == 79 && destination == 83)
			price = 3;
		else
		if(start == 79 && destination == 84)
			price = 3;
		else
		if(start == 79 && destination == 85)
			price = 4;
		else
		if(start == 79 && destination == 86)
			price = 4;
		else
		if(start == 79 && destination == 87)
			price = 5;
		else
		if(start == 79 && destination == 88)
			price = 5;
		else
		if(start == 79 && destination == 89)
			price = 6;
		else
		if(start == 79 && destination == 90)
			price = 6;
		else
		if(start == 79 && destination == 91)
			price = 6;
		else
		if(start == 79 && destination == 92)
			price = 7;
		else
		if(start == 80 && destination == 0)
			price = 3;
		else
		if(start == 80 && destination == 1)
			price = 3;
		else
		if(start == 80 && destination == 2)
			price = 2;
		else
		if(start == 80 && destination == 3)
			price = 2;
		else
		if(start == 80 && destination == 4)
			price = 2;
		else
		if(start == 80 && destination == 5)
			price = 2;
		else
		if(start == 80 && destination == 6)
			price = 2;
		else
		if(start == 80 && destination == 7)
			price = 3;
		else
		if(start == 80 && destination == 8)
			price = 3;
		else
		if(start == 80 && destination == 9)
			price = 4;
		else
		if(start == 80 && destination == 10)
			price = 4;
		else
		if(start == 80 && destination == 11)
			price = 4;
		else
		if(start == 80 && destination == 12)
			price = 5;
		else
		if(start == 80 && destination == 13)
			price = 5;
		else
		if(start == 80 && destination == 14)
			price = 5;
		else
		if(start == 80 && destination == 15)
			price = 5;
		else
		if(start == 80 && destination == 16)
			price = 5;
		else
		if(start == 80 && destination == 17)
			price = 5;
		else
		if(start == 80 && destination == 18)
			price = 6;
		else
		if(start == 80 && destination == 19)
			price = 6;
		else
		if(start == 80 && destination == 20)
			price = 6;
		else
		if(start == 80 && destination == 21)
			price = 6;
		else
		if(start == 80 && destination == 22)
			price = 7;
		else
		if(start == 80 && destination == 23)
			price = 5;
		else
		if(start == 80 && destination == 24)
			price = 4;
		else
		if(start == 80 && destination == 25)
			price = 4;
		else
		if(start == 80 && destination == 26)
			price = 4;
		else
		if(start == 80 && destination == 27)
			price = 3;
		else
		if(start == 80 && destination == 28)
			price = 3;
		else
		if(start == 80 && destination == 29)
			price = 3;
		else
		if(start == 80 && destination == 30)
			price = 3;
		else
		if(start == 80 && destination == 31)
			price = 2;
		else
		if(start == 80 && destination == 32)
			price = 2;
		else
		if(start == 80 && destination == 33)
			price = 2;
		else
		if(start == 80 && destination == 34)
			price = 2;
		else
		if(start == 80 && destination == 35)
			price = 3;
		else
		if(start == 80 && destination == 36)
			price = 3;
		else
		if(start == 80 && destination == 37)
			price = 3;
		else
		if(start == 80 && destination == 38)
			price = 4;
		else
		if(start == 80 && destination == 39)
			price = 4;
		else
		if(start == 80 && destination == 40)
			price = 4;
		else
		if(start == 80 && destination == 41)
			price = 5;
		else
		if(start == 80 && destination == 42)
			price = 5;
		else
		if(start == 80 && destination == 43)
			price = 5;
		else
		if(start == 80 && destination == 44)
			price = 5;
		else
		if(start == 80 && destination == 45)
			price = 5;
		else
		if(start == 80 && destination == 46)
			price = 6;
		else
		if(start == 80 && destination == 47)
			price = 6;
		else
		if(start == 80 && destination == 48)
			price = 5;
		else
		if(start == 80 && destination == 49)
			price = 5;
		else
		if(start == 80 && destination == 50)
			price = 5;
		else
		if(start == 80 && destination == 51)
			price = 5;
		else
		if(start == 80 && destination == 52)
			price = 4;
		else
		if(start == 80 && destination == 53)
			price = 4;
		else
		if(start == 80 && destination == 54)
			price = 3;
		else
		if(start == 80 && destination == 55)
			price = 3;
		else
		if(start == 80 && destination == 56)
			price = 3;
		else
		if(start == 80 && destination == 57)
			price = 2;
		else
		if(start == 80 && destination == 58)
			price = 3;
		else
		if(start == 80 && destination == 59)
			price = 2;
		else
		if(start == 80 && destination == 60)
			price = 2;
		else
		if(start == 80 && destination == 61)
			price = 2;
		else
		if(start == 80 && destination == 62)
			price = 2;
		else
		if(start == 80 && destination == 63)
			price = 3;
		else
		if(start == 80 && destination == 64)
			price = 3;
		else
		if(start == 80 && destination == 65)
			price = 3;
		else
		if(start == 80 && destination == 66)
			price = 3;
		else
		if(start == 80 && destination == 67)
			price = 4;
		else
		if(start == 80 && destination == 68)
			price = 4;
		else
		if(start == 80 && destination == 69)
			price = 4;
		else
		if(start == 80 && destination == 70)
			price = 4;
		else
		if(start == 80 && destination == 71)
			price = 5;
		else
		if(start == 80 && destination == 72)
			price = 5;
		else
		if(start == 80 && destination == 73)
			price = 5;
		else
		if(start == 80 && destination == 74)
			price = 5;
		else
		if(start == 80 && destination == 75)
			price = 6;
		else
		if(start == 80 && destination == 76)
			price = 6;
		else
		if(start == 80 && destination == 77)
			price = 3;
		else
		if(start == 80 && destination == 78)
			price = 2;
		else
		if(start == 80 && destination == 79)
			price = 2;
		else
		if(start == 80 && destination == 80)
			price = 0;
		else
		if(start == 80 && destination == 81)
			price = 2;
		else
		if(start == 80 && destination == 82)
			price = 2;
		else
		if(start == 80 && destination == 83)
			price = 3;
		else
		if(start == 80 && destination == 84)
			price = 3;
		else
		if(start == 80 && destination == 85)
			price = 4;
		else
		if(start == 80 && destination == 86)
			price = 4;
		else
		if(start == 80 && destination == 87)
			price = 5;
		else
		if(start == 80 && destination == 88)
			price = 5;
		else
		if(start == 80 && destination == 89)
			price = 5;
		else
		if(start == 80 && destination == 90)
			price = 6;
		else
		if(start == 80 && destination == 91)
			price = 6;
		else
		if(start == 80 && destination == 92)
			price = 7;
		else
		if(start == 81 && destination == 0)
			price = 3;
		else
		if(start == 81 && destination == 1)
			price = 3;
		else
		if(start == 81 && destination == 2)
			price = 3;
		else
		if(start == 81 && destination == 3)
			price = 2;
		else
		if(start == 81 && destination == 4)
			price = 2;
		else
		if(start == 81 && destination == 5)
			price = 3;
		else
		if(start == 81 && destination == 6)
			price = 3;
		else
		if(start == 81 && destination == 7)
			price = 3;
		else
		if(start == 81 && destination == 8)
			price = 4;
		else
		if(start == 81 && destination == 9)
			price = 4;
		else
		if(start == 81 && destination == 10)
			price = 4;
		else
		if(start == 81 && destination == 11)
			price = 4;
		else
		if(start == 81 && destination == 12)
			price = 4;
		else
		if(start == 81 && destination == 13)
			price = 5;
		else
		if(start == 81 && destination == 14)
			price = 5;
		else
		if(start == 81 && destination == 15)
			price = 5;
		else
		if(start == 81 && destination == 16)
			price = 5;
		else
		if(start == 81 && destination == 17)
			price = 5;
		else
		if(start == 81 && destination == 18)
			price = 6;
		else
		if(start == 81 && destination == 19)
			price = 6;
		else
		if(start == 81 && destination == 20)
			price = 6;
		else
		if(start == 81 && destination == 21)
			price = 6;
		else
		if(start == 81 && destination == 22)
			price = 7;
		else
		if(start == 81 && destination == 23)
			price = 5;
		else
		if(start == 81 && destination == 24)
			price = 5;
		else
		if(start == 81 && destination == 25)
			price = 4;
		else
		if(start == 81 && destination == 26)
			price = 4;
		else
		if(start == 81 && destination == 27)
			price = 4;
		else
		if(start == 81 && destination == 28)
			price = 3;
		else
		if(start == 81 && destination == 29)
			price = 3;
		else
		if(start == 81 && destination == 30)
			price = 3;
		else
		if(start == 81 && destination == 31)
			price = 3;
		else
		if(start == 81 && destination == 32)
			price = 3;
		else
		if(start == 81 && destination == 33)
			price = 2;
		else
		if(start == 81 && destination == 34)
			price = 2;
		else
		if(start == 81 && destination == 35)
			price = 3;
		else
		if(start == 81 && destination == 36)
			price = 3;
		else
		if(start == 81 && destination == 37)
			price = 3;
		else
		if(start == 81 && destination == 38)
			price = 3;
		else
		if(start == 81 && destination == 39)
			price = 4;
		else
		if(start == 81 && destination == 40)
			price = 4;
		else
		if(start == 81 && destination == 41)
			price = 4;
		else
		if(start == 81 && destination == 42)
			price = 4;
		else
		if(start == 81 && destination == 43)
			price = 5;
		else
		if(start == 81 && destination == 44)
			price = 5;
		else
		if(start == 81 && destination == 45)
			price = 5;
		else
		if(start == 81 && destination == 46)
			price = 5;
		else
		if(start == 81 && destination == 47)
			price = 6;
		else
		if(start == 81 && destination == 48)
			price = 6;
		else
		if(start == 81 && destination == 49)
			price = 5;
		else
		if(start == 81 && destination == 50)
			price = 5;
		else
		if(start == 81 && destination == 51)
			price = 5;
		else
		if(start == 81 && destination == 52)
			price = 5;
		else
		if(start == 81 && destination == 53)
			price = 4;
		else
		if(start == 81 && destination == 54)
			price = 4;
		else
		if(start == 81 && destination == 55)
			price = 3;
		else
		if(start == 81 && destination == 56)
			price = 3;
		else
		if(start == 81 && destination == 57)
			price = 3;
		else
		if(start == 81 && destination == 58)
			price = 2;
		else
		if(start == 81 && destination == 59)
			price = 2;
		else
		if(start == 81 && destination == 60)
			price = 2;
		else
		if(start == 81 && destination == 61)
			price = 2;
		else
		if(start == 81 && destination == 62)
			price = 2;
		else
		if(start == 81 && destination == 63)
			price = 3;
		else
		if(start == 81 && destination == 64)
			price = 3;
		else
		if(start == 81 && destination == 65)
			price = 3;
		else
		if(start == 81 && destination == 66)
			price = 3;
		else
		if(start == 81 && destination == 67)
			price = 4;
		else
		if(start == 81 && destination == 68)
			price = 4;
		else
		if(start == 81 && destination == 69)
			price = 4;
		else
		if(start == 81 && destination == 70)
			price = 4;
		else
		if(start == 81 && destination == 71)
			price = 5;
		else
		if(start == 81 && destination == 72)
			price = 5;
		else
		if(start == 81 && destination == 73)
			price = 5;
		else
		if(start == 81 && destination == 74)
			price = 5;
		else
		if(start == 81 && destination == 75)
			price = 6;
		else
		if(start == 81 && destination == 76)
			price = 6;
		else
		if(start == 81 && destination == 77)
			price = 3;
		else
		if(start == 81 && destination == 78)
			price = 3;
		else
		if(start == 81 && destination == 79)
			price = 2;
		else
		if(start == 81 && destination == 80)
			price = 2;
		else
		if(start == 81 && destination == 81)
			price = 0;
		else
		if(start == 81 && destination == 82)
			price = 2;
		else
		if(start == 81 && destination == 83)
			price = 2;
		else
		if(start == 81 && destination == 84)
			price = 3;
		else
		if(start == 81 && destination == 85)
			price = 3;
		else
		if(start == 81 && destination == 86)
			price = 4;
		else
		if(start == 81 && destination == 87)
			price = 5;
		else
		if(start == 81 && destination == 88)
			price = 5;
		else
		if(start == 81 && destination == 89)
			price = 5;
		else
		if(start == 81 && destination == 90)
			price = 6;
		else
		if(start == 81 && destination == 91)
			price = 6;
		else
		if(start == 81 && destination == 92)
			price = 6;
		else
		if(start == 82 && destination == 0)
			price = 4;
		else
		if(start == 82 && destination == 1)
			price = 3;
		else
		if(start == 82 && destination == 2)
			price = 3;
		else
		if(start == 82 && destination == 3)
			price = 3;
		else
		if(start == 82 && destination == 4)
			price = 3;
		else
		if(start == 82 && destination == 5)
			price = 3;
		else
		if(start == 82 && destination == 6)
			price = 3;
		else
		if(start == 82 && destination == 7)
			price = 3;
		else
		if(start == 82 && destination == 8)
			price = 4;
		else
		if(start == 82 && destination == 9)
			price = 4;
		else
		if(start == 82 && destination == 10)
			price = 4;
		else
		if(start == 82 && destination == 11)
			price = 5;
		else
		if(start == 82 && destination == 12)
			price = 5;
		else
		if(start == 82 && destination == 13)
			price = 5;
		else
		if(start == 82 && destination == 14)
			price = 5;
		else
		if(start == 82 && destination == 15)
			price = 5;
		else
		if(start == 82 && destination == 16)
			price = 5;
		else
		if(start == 82 && destination == 17)
			price = 6;
		else
		if(start == 82 && destination == 18)
			price = 6;
		else
		if(start == 82 && destination == 19)
			price = 6;
		else
		if(start == 82 && destination == 20)
			price = 6;
		else
		if(start == 82 && destination == 21)
			price = 7;
		else
		if(start == 82 && destination == 22)
			price = 7;
		else
		if(start == 82 && destination == 23)
			price = 5;
		else
		if(start == 82 && destination == 24)
			price = 5;
		else
		if(start == 82 && destination == 25)
			price = 5;
		else
		if(start == 82 && destination == 26)
			price = 4;
		else
		if(start == 82 && destination == 27)
			price = 4;
		else
		if(start == 82 && destination == 28)
			price = 4;
		else
		if(start == 82 && destination == 29)
			price = 3;
		else
		if(start == 82 && destination == 30)
			price = 3;
		else
		if(start == 82 && destination == 31)
			price = 3;
		else
		if(start == 82 && destination == 32)
			price = 3;
		else
		if(start == 82 && destination == 33)
			price = 3;
		else
		if(start == 82 && destination == 34)
			price = 3;
		else
		if(start == 82 && destination == 35)
			price = 3;
		else
		if(start == 82 && destination == 36)
			price = 3;
		else
		if(start == 82 && destination == 37)
			price = 3;
		else
		if(start == 82 && destination == 38)
			price = 4;
		else
		if(start == 82 && destination == 39)
			price = 4;
		else
		if(start == 82 && destination == 40)
			price = 4;
		else
		if(start == 82 && destination == 41)
			price = 4;
		else
		if(start == 82 && destination == 42)
			price = 4;
		else
		if(start == 82 && destination == 43)
			price = 4;
		else
		if(start == 82 && destination == 44)
			price = 5;
		else
		if(start == 82 && destination == 45)
			price = 5;
		else
		if(start == 82 && destination == 46)
			price = 5;
		else
		if(start == 82 && destination == 47)
			price = 5;
		else
		if(start == 82 && destination == 48)
			price = 6;
		else
		if(start == 82 && destination == 49)
			price = 5;
		else
		if(start == 82 && destination == 50)
			price = 5;
		else
		if(start == 82 && destination == 51)
			price = 5;
		else
		if(start == 82 && destination == 52)
			price = 5;
		else
		if(start == 82 && destination == 53)
			price = 5;
		else
		if(start == 82 && destination == 54)
			price = 4;
		else
		if(start == 82 && destination == 55)
			price = 4;
		else
		if(start == 82 && destination == 56)
			price = 3;
		else
		if(start == 82 && destination == 57)
			price = 3;
		else
		if(start == 82 && destination == 58)
			price = 3;
		else
		if(start == 82 && destination == 59)
			price = 2;
		else
		if(start == 82 && destination == 60)
			price = 2;
		else
		if(start == 82 && destination == 61)
			price = 2;
		else
		if(start == 82 && destination == 62)
			price = 3;
		else
		if(start == 82 && destination == 63)
			price = 3;
		else
		if(start == 82 && destination == 64)
			price = 3;
		else
		if(start == 82 && destination == 65)
			price = 3;
		else
		if(start == 82 && destination == 66)
			price = 4;
		else
		if(start == 82 && destination == 67)
			price = 4;
		else
		if(start == 82 && destination == 68)
			price = 4;
		else
		if(start == 82 && destination == 69)
			price = 4;
		else
		if(start == 82 && destination == 70)
			price = 4;
		else
		if(start == 82 && destination == 71)
			price = 5;
		else
		if(start == 82 && destination == 72)
			price = 5;
		else
		if(start == 82 && destination == 73)
			price = 5;
		else
		if(start == 82 && destination == 74)
			price = 6;
		else
		if(start == 82 && destination == 75)
			price = 6;
		else
		if(start == 82 && destination == 76)
			price = 6;
		else
		if(start == 82 && destination == 77)
			price = 3;
		else
		if(start == 82 && destination == 78)
			price = 3;
		else
		if(start == 82 && destination == 79)
			price = 3;
		else
		if(start == 82 && destination == 80)
			price = 2;
		else
		if(start == 82 && destination == 81)
			price = 2;
		else
		if(start == 82 && destination == 82)
			price = 0;
		else
		if(start == 82 && destination == 83)
			price = 2;
		else
		if(start == 82 && destination == 84)
			price = 2;
		else
		if(start == 82 && destination == 85)
			price = 3;
		else
		if(start == 82 && destination == 86)
			price = 3;
		else
		if(start == 82 && destination == 87)
			price = 5;
		else
		if(start == 82 && destination == 88)
			price = 5;
		else
		if(start == 82 && destination == 89)
			price = 5;
		else
		if(start == 82 && destination == 90)
			price = 5;
		else
		if(start == 82 && destination == 91)
			price = 6;
		else
		if(start == 82 && destination == 92)
			price = 6;
		else
		if(start == 83 && destination == 0)
			price = 4;
		else
		if(start == 83 && destination == 1)
			price = 4;
		else
		if(start == 83 && destination == 2)
			price = 3;
		else
		if(start == 83 && destination == 3)
			price = 3;
		else
		if(start == 83 && destination == 4)
			price = 3;
		else
		if(start == 83 && destination == 5)
			price = 3;
		else
		if(start == 83 && destination == 6)
			price = 3;
		else
		if(start == 83 && destination == 7)
			price = 4;
		else
		if(start == 83 && destination == 8)
			price = 4;
		else
		if(start == 83 && destination == 9)
			price = 5;
		else
		if(start == 83 && destination == 10)
			price = 5;
		else
		if(start == 83 && destination == 11)
			price = 5;
		else
		if(start == 83 && destination == 12)
			price = 5;
		else
		if(start == 83 && destination == 13)
			price = 5;
		else
		if(start == 83 && destination == 14)
			price = 5;
		else
		if(start == 83 && destination == 15)
			price = 5;
		else
		if(start == 83 && destination == 16)
			price = 6;
		else
		if(start == 83 && destination == 17)
			price = 6;
		else
		if(start == 83 && destination == 18)
			price = 6;
		else
		if(start == 83 && destination == 19)
			price = 6;
		else
		if(start == 83 && destination == 20)
			price = 7;
		else
		if(start == 83 && destination == 21)
			price = 7;
		else
		if(start == 83 && destination == 22)
			price = 7;
		else
		if(start == 83 && destination == 23)
			price = 5;
		else
		if(start == 83 && destination == 24)
			price = 5;
		else
		if(start == 83 && destination == 25)
			price = 5;
		else
		if(start == 83 && destination == 26)
			price = 5;
		else
		if(start == 83 && destination == 27)
			price = 4;
		else
		if(start == 83 && destination == 28)
			price = 4;
		else
		if(start == 83 && destination == 29)
			price = 4;
		else
		if(start == 83 && destination == 30)
			price = 4;
		else
		if(start == 83 && destination == 31)
			price = 3;
		else
		if(start == 83 && destination == 32)
			price = 3;
		else
		if(start == 83 && destination == 33)
			price = 3;
		else
		if(start == 83 && destination == 34)
			price = 3;
		else
		if(start == 83 && destination == 35)
			price = 3;
		else
		if(start == 83 && destination == 36)
			price = 4;
		else
		if(start == 83 && destination == 37)
			price = 4;
		else
		if(start == 83 && destination == 38)
			price = 4;
		else
		if(start == 83 && destination == 39)
			price = 4;
		else
		if(start == 83 && destination == 40)
			price = 4;
		else
		if(start == 83 && destination == 41)
			price = 3;
		else
		if(start == 83 && destination == 42)
			price = 4;
		else
		if(start == 83 && destination == 43)
			price = 4;
		else
		if(start == 83 && destination == 44)
			price = 4;
		else
		if(start == 83 && destination == 45)
			price = 5;
		else
		if(start == 83 && destination == 46)
			price = 5;
		else
		if(start == 83 && destination == 47)
			price = 5;
		else
		if(start == 83 && destination == 48)
			price = 6;
		else
		if(start == 83 && destination == 49)
			price = 6;
		else
		if(start == 83 && destination == 50)
			price = 6;
		else
		if(start == 83 && destination == 51)
			price = 5;
		else
		if(start == 83 && destination == 52)
			price = 5;
		else
		if(start == 83 && destination == 53)
			price = 5;
		else
		if(start == 83 && destination == 54)
			price = 4;
		else
		if(start == 83 && destination == 55)
			price = 4;
		else
		if(start == 83 && destination == 56)
			price = 4;
		else
		if(start == 83 && destination == 57)
			price = 3;
		else
		if(start == 83 && destination == 58)
			price = 3;
		else
		if(start == 83 && destination == 59)
			price = 3;
		else
		if(start == 83 && destination == 60)
			price = 3;
		else
		if(start == 83 && destination == 61)
			price = 3;
		else
		if(start == 83 && destination == 62)
			price = 3;
		else
		if(start == 83 && destination == 63)
			price = 3;
		else
		if(start == 83 && destination == 64)
			price = 4;
		else
		if(start == 83 && destination == 65)
			price = 4;
		else
		if(start == 83 && destination == 66)
			price = 4;
		else
		if(start == 83 && destination == 67)
			price = 4;
		else
		if(start == 83 && destination == 68)
			price = 4;
		else
		if(start == 83 && destination == 69)
			price = 5;
		else
		if(start == 83 && destination == 70)
			price = 5;
		else
		if(start == 83 && destination == 71)
			price = 5;
		else
		if(start == 83 && destination == 72)
			price = 5;
		else
		if(start == 83 && destination == 73)
			price = 6;
		else
		if(start == 83 && destination == 74)
			price = 6;
		else
		if(start == 83 && destination == 75)
			price = 6;
		else
		if(start == 83 && destination == 76)
			price = 6;
		else
		if(start == 83 && destination == 77)
			price = 4;
		else
		if(start == 83 && destination == 78)
			price = 3;
		else
		if(start == 83 && destination == 79)
			price = 3;
		else
		if(start == 83 && destination == 80)
			price = 3;
		else
		if(start == 83 && destination == 81)
			price = 2;
		else
		if(start == 83 && destination == 82)
			price = 2;
		else
		if(start == 83 && destination == 83)
			price = 0;
		else
		if(start == 83 && destination == 84)
			price = 2;
		else
		if(start == 83 && destination == 85)
			price = 2;
		else
		if(start == 83 && destination == 86)
			price = 3;
		else
		if(start == 83 && destination == 87)
			price = 4;
		else
		if(start == 83 && destination == 88)
			price = 4;
		else
		if(start == 83 && destination == 89)
			price = 5;
		else
		if(start == 83 && destination == 90)
			price = 5;
		else
		if(start == 83 && destination == 91)
			price = 5;
		else
		if(start == 83 && destination == 92)
			price = 6;
		else
		if(start == 84 && destination == 0)
			price = 4;
		else
		if(start == 84 && destination == 1)
			price = 4;
		else
		if(start == 84 && destination == 2)
			price = 3;
		else
		if(start == 84 && destination == 3)
			price = 3;
		else
		if(start == 84 && destination == 4)
			price = 3;
		else
		if(start == 84 && destination == 5)
			price = 4;
		else
		if(start == 84 && destination == 6)
			price = 4;
		else
		if(start == 84 && destination == 7)
			price = 4;
		else
		if(start == 84 && destination == 8)
			price = 5;
		else
		if(start == 84 && destination == 9)
			price = 5;
		else
		if(start == 84 && destination == 10)
			price = 5;
		else
		if(start == 84 && destination == 11)
			price = 5;
		else
		if(start == 84 && destination == 12)
			price = 5;
		else
		if(start == 84 && destination == 13)
			price = 5;
		else
		if(start == 84 && destination == 14)
			price = 5;
		else
		if(start == 84 && destination == 15)
			price = 6;
		else
		if(start == 84 && destination == 16)
			price = 6;
		else
		if(start == 84 && destination == 17)
			price = 6;
		else
		if(start == 84 && destination == 18)
			price = 6;
		else
		if(start == 84 && destination == 19)
			price = 6;
		else
		if(start == 84 && destination == 20)
			price = 7;
		else
		if(start == 84 && destination == 21)
			price = 7;
		else
		if(start == 84 && destination == 22)
			price = 7;
		else
		if(start == 84 && destination == 23)
			price = 6;
		else
		if(start == 84 && destination == 24)
			price = 5;
		else
		if(start == 84 && destination == 25)
			price = 5;
		else
		if(start == 84 && destination == 26)
			price = 5;
		else
		if(start == 84 && destination == 27)
			price = 5;
		else
		if(start == 84 && destination == 28)
			price = 4;
		else
		if(start == 84 && destination == 29)
			price = 4;
		else
		if(start == 84 && destination == 30)
			price = 4;
		else
		if(start == 84 && destination == 31)
			price = 4;
		else
		if(start == 84 && destination == 32)
			price = 3;
		else
		if(start == 84 && destination == 33)
			price = 3;
		else
		if(start == 84 && destination == 34)
			price = 3;
		else
		if(start == 84 && destination == 35)
			price = 4;
		else
		if(start == 84 && destination == 36)
			price = 4;
		else
		if(start == 84 && destination == 37)
			price = 4;
		else
		if(start == 84 && destination == 38)
			price = 4;
		else
		if(start == 84 && destination == 39)
			price = 4;
		else
		if(start == 84 && destination == 40)
			price = 4;
		else
		if(start == 84 && destination == 41)
			price = 3;
		else
		if(start == 84 && destination == 42)
			price = 4;
		else
		if(start == 84 && destination == 43)
			price = 4;
		else
		if(start == 84 && destination == 44)
			price = 4;
		else
		if(start == 84 && destination == 45)
			price = 4;
		else
		if(start == 84 && destination == 46)
			price = 5;
		else
		if(start == 84 && destination == 47)
			price = 5;
		else
		if(start == 84 && destination == 48)
			price = 6;
		else
		if(start == 84 && destination == 49)
			price = 6;
		else
		if(start == 84 && destination == 50)
			price = 6;
		else
		if(start == 84 && destination == 51)
			price = 6;
		else
		if(start == 84 && destination == 52)
			price = 5;
		else
		if(start == 84 && destination == 53)
			price = 5;
		else
		if(start == 84 && destination == 54)
			price = 5;
		else
		if(start == 84 && destination == 55)
			price = 4;
		else
		if(start == 84 && destination == 56)
			price = 4;
		else
		if(start == 84 && destination == 57)
			price = 4;
		else
		if(start == 84 && destination == 58)
			price = 3;
		else
		if(start == 84 && destination == 59)
			price = 3;
		else
		if(start == 84 && destination == 60)
			price = 3;
		else
		if(start == 84 && destination == 61)
			price = 3;
		else
		if(start == 84 && destination == 62)
			price = 3;
		else
		if(start == 84 && destination == 63)
			price = 3;
		else
		if(start == 84 && destination == 64)
			price = 4;
		else
		if(start == 84 && destination == 65)
			price = 4;
		else
		if(start == 84 && destination == 66)
			price = 4;
		else
		if(start == 84 && destination == 67)
			price = 4;
		else
		if(start == 84 && destination == 68)
			price = 5;
		else
		if(start == 84 && destination == 69)
			price = 5;
		else
		if(start == 84 && destination == 70)
			price = 5;
		else
		if(start == 84 && destination == 71)
			price = 5;
		else
		if(start == 84 && destination == 72)
			price = 5;
		else
		if(start == 84 && destination == 73)
			price = 6;
		else
		if(start == 84 && destination == 74)
			price = 6;
		else
		if(start == 84 && destination == 75)
			price = 6;
		else
		if(start == 84 && destination == 76)
			price = 7;
		else
		if(start == 84 && destination == 77)
			price = 4;
		else
		if(start == 84 && destination == 78)
			price = 4;
		else
		if(start == 84 && destination == 79)
			price = 3;
		else
		if(start == 84 && destination == 80)
			price = 3;
		else
		if(start == 84 && destination == 81)
			price = 3;
		else
		if(start == 84 && destination == 82)
			price = 2;
		else
		if(start == 84 && destination == 83)
			price = 2;
		else
		if(start == 84 && destination == 84)
			price = 0;
		else
		if(start == 84 && destination == 85)
			price = 2;
		else
		if(start == 84 && destination == 86)
			price = 3;
		else
		if(start == 84 && destination == 87)
			price = 4;
		else
		if(start == 84 && destination == 88)
			price = 4;
		else
		if(start == 84 && destination == 89)
			price = 5;
		else
		if(start == 84 && destination == 90)
			price = 5;
		else
		if(start == 84 && destination == 91)
			price = 5;
		else
		if(start == 84 && destination == 92)
			price = 6;
		else
		if(start == 85 && destination == 0)
			price = 5;
		else
		if(start == 85 && destination == 1)
			price = 4;
		else
		if(start == 85 && destination == 2)
			price = 4;
		else
		if(start == 85 && destination == 3)
			price = 4;
		else
		if(start == 85 && destination == 4)
			price = 4;
		else
		if(start == 85 && destination == 5)
			price = 4;
		else
		if(start == 85 && destination == 6)
			price = 4;
		else
		if(start == 85 && destination == 7)
			price = 5;
		else
		if(start == 85 && destination == 8)
			price = 5;
		else
		if(start == 85 && destination == 9)
			price = 5;
		else
		if(start == 85 && destination == 10)
			price = 5;
		else
		if(start == 85 && destination == 11)
			price = 5;
		else
		if(start == 85 && destination == 12)
			price = 5;
		else
		if(start == 85 && destination == 13)
			price = 6;
		else
		if(start == 85 && destination == 14)
			price = 6;
		else
		if(start == 85 && destination == 15)
			price = 6;
		else
		if(start == 85 && destination == 16)
			price = 6;
		else
		if(start == 85 && destination == 17)
			price = 6;
		else
		if(start == 85 && destination == 18)
			price = 7;
		else
		if(start == 85 && destination == 19)
			price = 7;
		else
		if(start == 85 && destination == 20)
			price = 7;
		else
		if(start == 85 && destination == 21)
			price = 7;
		else
		if(start == 85 && destination == 22)
			price = 7;
		else
		if(start == 85 && destination == 23)
			price = 6;
		else
		if(start == 85 && destination == 24)
			price = 6;
		else
		if(start == 85 && destination == 25)
			price = 5;
		else
		if(start == 85 && destination == 26)
			price = 5;
		else
		if(start == 85 && destination == 27)
			price = 5;
		else
		if(start == 85 && destination == 28)
			price = 5;
		else
		if(start == 85 && destination == 29)
			price = 5;
		else
		if(start == 85 && destination == 30)
			price = 4;
		else
		if(start == 85 && destination == 31)
			price = 4;
		else
		if(start == 85 && destination == 32)
			price = 4;
		else
		if(start == 85 && destination == 33)
			price = 4;
		else
		if(start == 85 && destination == 34)
			price = 4;
		else
		if(start == 85 && destination == 35)
			price = 4;
		else
		if(start == 85 && destination == 36)
			price = 4;
		else
		if(start == 85 && destination == 37)
			price = 4;
		else
		if(start == 85 && destination == 38)
			price = 4;
		else
		if(start == 85 && destination == 39)
			price = 4;
		else
		if(start == 85 && destination == 40)
			price = 3;
		else
		if(start == 85 && destination == 41)
			price = 3;
		else
		if(start == 85 && destination == 42)
			price = 3;
		else
		if(start == 85 && destination == 43)
			price = 3;
		else
		if(start == 85 && destination == 44)
			price = 4;
		else
		if(start == 85 && destination == 45)
			price = 4;
		else
		if(start == 85 && destination == 46)
			price = 4;
		else
		if(start == 85 && destination == 47)
			price = 5;
		else
		if(start == 85 && destination == 48)
			price = 7;
		else
		if(start == 85 && destination == 49)
			price = 6;
		else
		if(start == 85 && destination == 50)
			price = 6;
		else
		if(start == 85 && destination == 51)
			price = 6;
		else
		if(start == 85 && destination == 52)
			price = 6;
		else
		if(start == 85 && destination == 53)
			price = 5;
		else
		if(start == 85 && destination == 54)
			price = 5;
		else
		if(start == 85 && destination == 55)
			price = 5;
		else
		if(start == 85 && destination == 56)
			price = 5;
		else
		if(start == 85 && destination == 57)
			price = 4;
		else
		if(start == 85 && destination == 58)
			price = 4;
		else
		if(start == 85 && destination == 59)
			price = 3;
		else
		if(start == 85 && destination == 60)
			price = 3;
		else
		if(start == 85 && destination == 61)
			price = 4;
		else
		if(start == 85 && destination == 62)
			price = 4;
		else
		if(start == 85 && destination == 63)
			price = 4;
		else
		if(start == 85 && destination == 64)
			price = 4;
		else
		if(start == 85 && destination == 65)
			price = 5;
		else
		if(start == 85 && destination == 66)
			price = 5;
		else
		if(start == 85 && destination == 67)
			price = 5;
		else
		if(start == 85 && destination == 68)
			price = 5;
		else
		if(start == 85 && destination == 69)
			price = 5;
		else
		if(start == 85 && destination == 70)
			price = 5;
		else
		if(start == 85 && destination == 71)
			price = 6;
		else
		if(start == 85 && destination == 72)
			price = 6;
		else
		if(start == 85 && destination == 73)
			price = 6;
		else
		if(start == 85 && destination == 74)
			price = 6;
		else
		if(start == 85 && destination == 75)
			price = 7;
		else
		if(start == 85 && destination == 76)
			price = 7;
		else
		if(start == 85 && destination == 77)
			price = 4;
		else
		if(start == 85 && destination == 78)
			price = 4;
		else
		if(start == 85 && destination == 79)
			price = 4;
		else
		if(start == 85 && destination == 80)
			price = 4;
		else
		if(start == 85 && destination == 81)
			price = 3;
		else
		if(start == 85 && destination == 82)
			price = 3;
		else
		if(start == 85 && destination == 83)
			price = 2;
		else
		if(start == 85 && destination == 84)
			price = 2;
		else
		if(start == 85 && destination == 85)
			price = 0;
		else
		if(start == 85 && destination == 86)
			price = 2;
		else
		if(start == 85 && destination == 87)
			price = 3;
		else
		if(start == 85 && destination == 88)
			price = 4;
		else
		if(start == 85 && destination == 89)
			price = 4;
		else
		if(start == 85 && destination == 90)
			price = 4;
		else
		if(start == 85 && destination == 91)
			price = 5;
		else
		if(start == 85 && destination == 92)
			price = 5;
		else
		if(start == 86 && destination == 0)
			price = 5;
		else
		if(start == 86 && destination == 1)
			price = 5;
		else
		if(start == 86 && destination == 2)
			price = 5;
		else
		if(start == 86 && destination == 3)
			price = 4;
		else
		if(start == 86 && destination == 4)
			price = 4;
		else
		if(start == 86 && destination == 5)
			price = 5;
		else
		if(start == 86 && destination == 6)
			price = 5;
		else
		if(start == 86 && destination == 7)
			price = 5;
		else
		if(start == 86 && destination == 8)
			price = 5;
		else
		if(start == 86 && destination == 9)
			price = 5;
		else
		if(start == 86 && destination == 10)
			price = 6;
		else
		if(start == 86 && destination == 11)
			price = 6;
		else
		if(start == 86 && destination == 12)
			price = 6;
		else
		if(start == 86 && destination == 13)
			price = 6;
		else
		if(start == 86 && destination == 14)
			price = 6;
		else
		if(start == 86 && destination == 15)
			price = 6;
		else
		if(start == 86 && destination == 16)
			price = 7;
		else
		if(start == 86 && destination == 17)
			price = 7;
		else
		if(start == 86 && destination == 18)
			price = 7;
		else
		if(start == 86 && destination == 19)
			price = 7;
		else
		if(start == 86 && destination == 20)
			price = 7;
		else
		if(start == 86 && destination == 21)
			price = 8;
		else
		if(start == 86 && destination == 22)
			price = 8;
		else
		if(start == 86 && destination == 23)
			price = 6;
		else
		if(start == 86 && destination == 24)
			price = 6;
		else
		if(start == 86 && destination == 25)
			price = 6;
		else
		if(start == 86 && destination == 26)
			price = 6;
		else
		if(start == 86 && destination == 27)
			price = 5;
		else
		if(start == 86 && destination == 28)
			price = 5;
		else
		if(start == 86 && destination == 29)
			price = 5;
		else
		if(start == 86 && destination == 30)
			price = 5;
		else
		if(start == 86 && destination == 31)
			price = 5;
		else
		if(start == 86 && destination == 32)
			price = 5;
		else
		if(start == 86 && destination == 33)
			price = 4;
		else
		if(start == 86 && destination == 34)
			price = 4;
		else
		if(start == 86 && destination == 35)
			price = 4;
		else
		if(start == 86 && destination == 36)
			price = 4;
		else
		if(start == 86 && destination == 37)
			price = 4;
		else
		if(start == 86 && destination == 38)
			price = 4;
		else
		if(start == 86 && destination == 39)
			price = 3;
		else
		if(start == 86 && destination == 40)
			price = 3;
		else
		if(start == 86 && destination == 41)
			price = 2;
		else
		if(start == 86 && destination == 42)
			price = 3;
		else
		if(start == 86 && destination == 43)
			price = 3;
		else
		if(start == 86 && destination == 44)
			price = 3;
		else
		if(start == 86 && destination == 45)
			price = 3;
		else
		if(start == 86 && destination == 46)
			price = 4;
		else
		if(start == 86 && destination == 47)
			price = 4;
		else
		if(start == 86 && destination == 48)
			price = 7;
		else
		if(start == 86 && destination == 49)
			price = 7;
		else
		if(start == 86 && destination == 50)
			price = 6;
		else
		if(start == 86 && destination == 51)
			price = 6;
		else
		if(start == 86 && destination == 52)
			price = 6;
		else
		if(start == 86 && destination == 53)
			price = 6;
		else
		if(start == 86 && destination == 54)
			price = 5;
		else
		if(start == 86 && destination == 55)
			price = 5;
		else
		if(start == 86 && destination == 56)
			price = 5;
		else
		if(start == 86 && destination == 57)
			price = 5;
		else
		if(start == 86 && destination == 58)
			price = 4;
		else
		if(start == 86 && destination == 59)
			price = 4;
		else
		if(start == 86 && destination == 60)
			price = 4;
		else
		if(start == 86 && destination == 61)
			price = 4;
		else
		if(start == 86 && destination == 62)
			price = 4;
		else
		if(start == 86 && destination == 63)
			price = 5;
		else
		if(start == 86 && destination == 64)
			price = 5;
		else
		if(start == 86 && destination == 65)
			price = 5;
		else
		if(start == 86 && destination == 66)
			price = 5;
		else
		if(start == 86 && destination == 67)
			price = 5;
		else
		if(start == 86 && destination == 68)
			price = 5;
		else
		if(start == 86 && destination == 69)
			price = 6;
		else
		if(start == 86 && destination == 70)
			price = 6;
		else
		if(start == 86 && destination == 71)
			price = 6;
		else
		if(start == 86 && destination == 72)
			price = 6;
		else
		if(start == 86 && destination == 73)
			price = 7;
		else
		if(start == 86 && destination == 74)
			price = 7;
		else
		if(start == 86 && destination == 75)
			price = 7;
		else
		if(start == 86 && destination == 76)
			price = 7;
		else
		if(start == 86 && destination == 77)
			price = 5;
		else
		if(start == 86 && destination == 78)
			price = 5;
		else
		if(start == 86 && destination == 79)
			price = 4;
		else
		if(start == 86 && destination == 80)
			price = 4;
		else
		if(start == 86 && destination == 81)
			price = 4;
		else
		if(start == 86 && destination == 82)
			price = 3;
		else
		if(start == 86 && destination == 83)
			price = 3;
		else
		if(start == 86 && destination == 84)
			price = 3;
		else
		if(start == 86 && destination == 85)
			price = 2;
		else
		if(start == 86 && destination == 86)
			price = 0;
		else
		if(start == 86 && destination == 87)
			price = 3;
		else
		if(start == 86 && destination == 88)
			price = 3;
		else
		if(start == 86 && destination == 89)
			price = 3;
		else
		if(start == 86 && destination == 90)
			price = 4;
		else
		if(start == 86 && destination == 91)
			price = 4;
		else
		if(start == 86 && destination == 92)
			price = 5;
		else
		if(start == 87 && destination == 0)
			price = 6;
		else
		if(start == 87 && destination == 1)
			price = 6;
		else
		if(start == 87 && destination == 2)
			price = 5;
		else
		if(start == 87 && destination == 3)
			price = 5;
		else
		if(start == 87 && destination == 4)
			price = 5;
		else
		if(start == 87 && destination == 5)
			price = 5;
		else
		if(start == 87 && destination == 6)
			price = 5;
		else
		if(start == 87 && destination == 7)
			price = 6;
		else
		if(start == 87 && destination == 8)
			price = 6;
		else
		if(start == 87 && destination == 9)
			price = 6;
		else
		if(start == 87 && destination == 10)
			price = 6;
		else
		if(start == 87 && destination == 11)
			price = 6;
		else
		if(start == 87 && destination == 12)
			price = 6;
		else
		if(start == 87 && destination == 13)
			price = 7;
		else
		if(start == 87 && destination == 14)
			price = 7;
		else
		if(start == 87 && destination == 15)
			price = 7;
		else
		if(start == 87 && destination == 16)
			price = 7;
		else
		if(start == 87 && destination == 17)
			price = 7;
		else
		if(start == 87 && destination == 18)
			price = 7;
		else
		if(start == 87 && destination == 19)
			price = 7;
		else
		if(start == 87 && destination == 20)
			price = 8;
		else
		if(start == 87 && destination == 21)
			price = 8;
		else
		if(start == 87 && destination == 22)
			price = 8;
		else
		if(start == 87 && destination == 23)
			price = 7;
		else
		if(start == 87 && destination == 24)
			price = 7;
		else
		if(start == 87 && destination == 25)
			price = 6;
		else
		if(start == 87 && destination == 26)
			price = 6;
		else
		if(start == 87 && destination == 27)
			price = 6;
		else
		if(start == 87 && destination == 28)
			price = 6;
		else
		if(start == 87 && destination == 29)
			price = 6;
		else
		if(start == 87 && destination == 30)
			price = 5;
		else
		if(start == 87 && destination == 31)
			price = 5;
		else
		if(start == 87 && destination == 32)
			price = 5;
		else
		if(start == 87 && destination == 33)
			price = 5;
		else
		if(start == 87 && destination == 34)
			price = 5;
		else
		if(start == 87 && destination == 35)
			price = 4;
		else
		if(start == 87 && destination == 36)
			price = 4;
		else
		if(start == 87 && destination == 37)
			price = 4;
		else
		if(start == 87 && destination == 38)
			price = 4;
		else
		if(start == 87 && destination == 39)
			price = 3;
		else
		if(start == 87 && destination == 40)
			price = 3;
		else
		if(start == 87 && destination == 41)
			price = 2;
		else
		if(start == 87 && destination == 42)
			price = 3;
		else
		if(start == 87 && destination == 43)
			price = 3;
		else
		if(start == 87 && destination == 44)
			price = 3;
		else
		if(start == 87 && destination == 45)
			price = 3;
		else
		if(start == 87 && destination == 46)
			price = 4;
		else
		if(start == 87 && destination == 47)
			price = 4;
		else
		if(start == 87 && destination == 48)
			price = 7;
		else
		if(start == 87 && destination == 49)
			price = 7;
		else
		if(start == 87 && destination == 50)
			price = 7;
		else
		if(start == 87 && destination == 51)
			price = 7;
		else
		if(start == 87 && destination == 52)
			price = 7;
		else
		if(start == 87 && destination == 53)
			price = 7;
		else
		if(start == 87 && destination == 54)
			price = 6;
		else
		if(start == 87 && destination == 55)
			price = 6;
		else
		if(start == 87 && destination == 56)
			price = 6;
		else
		if(start == 87 && destination == 57)
			price = 6;
		else
		if(start == 87 && destination == 58)
			price = 5;
		else
		if(start == 87 && destination == 59)
			price = 5;
		else
		if(start == 87 && destination == 60)
			price = 5;
		else
		if(start == 87 && destination == 61)
			price = 5;
		else
		if(start == 87 && destination == 62)
			price = 5;
		else
		if(start == 87 && destination == 63)
			price = 5;
		else
		if(start == 87 && destination == 64)
			price = 5;
		else
		if(start == 87 && destination == 65)
			price = 5;
		else
		if(start == 87 && destination == 66)
			price = 6;
		else
		if(start == 87 && destination == 67)
			price = 6;
		else
		if(start == 87 && destination == 68)
			price = 6;
		else
		if(start == 87 && destination == 69)
			price = 6;
		else
		if(start == 87 && destination == 70)
			price = 6;
		else
		if(start == 87 && destination == 71)
			price = 7;
		else
		if(start == 87 && destination == 72)
			price = 7;
		else
		if(start == 87 && destination == 73)
			price = 7;
		else
		if(start == 87 && destination == 74)
			price = 7;
		else
		if(start == 87 && destination == 75)
			price = 7;
		else
		if(start == 87 && destination == 76)
			price = 8;
		else
		if(start == 87 && destination == 77)
			price = 6;
		else
		if(start == 87 && destination == 78)
			price = 5;
		else
		if(start == 87 && destination == 79)
			price = 5;
		else
		if(start == 87 && destination == 80)
			price = 5;
		else
		if(start == 87 && destination == 81)
			price = 5;
		else
		if(start == 87 && destination == 82)
			price = 5;
		else
		if(start == 87 && destination == 83)
			price = 4;
		else
		if(start == 87 && destination == 84)
			price = 4;
		else
		if(start == 87 && destination == 85)
			price = 3;
		else
		if(start == 87 && destination == 86)
			price = 3;
		else
		if(start == 87 && destination == 87)
			price = 0;
		else
		if(start == 87 && destination == 88)
			price = 2;
		else
		if(start == 87 && destination == 89)
			price = 2;
		else
		if(start == 87 && destination == 90)
			price = 3;
		else
		if(start == 87 && destination == 91)
			price = 3;
		else
		if(start == 87 && destination == 92)
			price = 4;
		else
		if(start == 88 && destination == 0)
			price = 6;
		else
		if(start == 88 && destination == 1)
			price = 6;
		else
		if(start == 88 && destination == 2)
			price = 6;
		else
		if(start == 88 && destination == 3)
			price = 5;
		else
		if(start == 88 && destination == 4)
			price = 5;
		else
		if(start == 88 && destination == 5)
			price = 5;
		else
		if(start == 88 && destination == 6)
			price = 5;
		else
		if(start == 88 && destination == 7)
			price = 6;
		else
		if(start == 88 && destination == 8)
			price = 6;
		else
		if(start == 88 && destination == 9)
			price = 6;
		else
		if(start == 88 && destination == 10)
			price = 6;
		else
		if(start == 88 && destination == 11)
			price = 7;
		else
		if(start == 88 && destination == 12)
			price = 7;
		else
		if(start == 88 && destination == 13)
			price = 7;
		else
		if(start == 88 && destination == 14)
			price = 7;
		else
		if(start == 88 && destination == 15)
			price = 7;
		else
		if(start == 88 && destination == 16)
			price = 7;
		else
		if(start == 88 && destination == 17)
			price = 7;
		else
		if(start == 88 && destination == 18)
			price = 7;
		else
		if(start == 88 && destination == 19)
			price = 8;
		else
		if(start == 88 && destination == 20)
			price = 8;
		else
		if(start == 88 && destination == 21)
			price = 8;
		else
		if(start == 88 && destination == 22)
			price = 8;
		else
		if(start == 88 && destination == 23)
			price = 7;
		else
		if(start == 88 && destination == 24)
			price = 7;
		else
		if(start == 88 && destination == 25)
			price = 6;
		else
		if(start == 88 && destination == 26)
			price = 6;
		else
		if(start == 88 && destination == 27)
			price = 6;
		else
		if(start == 88 && destination == 28)
			price = 6;
		else
		if(start == 88 && destination == 29)
			price = 6;
		else
		if(start == 88 && destination == 30)
			price = 6;
		else
		if(start == 88 && destination == 31)
			price = 5;
		else
		if(start == 88 && destination == 32)
			price = 5;
		else
		if(start == 88 && destination == 33)
			price = 5;
		else
		if(start == 88 && destination == 34)
			price = 5;
		else
		if(start == 88 && destination == 35)
			price = 5;
		else
		if(start == 88 && destination == 36)
			price = 4;
		else
		if(start == 88 && destination == 37)
			price = 4;
		else
		if(start == 88 && destination == 38)
			price = 4;
		else
		if(start == 88 && destination == 39)
			price = 4;
		else
		if(start == 88 && destination == 40)
			price = 3;
		else
		if(start == 88 && destination == 41)
			price = 3;
		else
		if(start == 88 && destination == 42)
			price = 3;
		else
		if(start == 88 && destination == 43)
			price = 3;
		else
		if(start == 88 && destination == 44)
			price = 3;
		else
		if(start == 88 && destination == 45)
			price = 4;
		else
		if(start == 88 && destination == 46)
			price = 4;
		else
		if(start == 88 && destination == 47)
			price = 4;
		else
		if(start == 88 && destination == 48)
			price = 8;
		else
		if(start == 88 && destination == 49)
			price = 7;
		else
		if(start == 88 && destination == 50)
			price = 7;
		else
		if(start == 88 && destination == 51)
			price = 7;
		else
		if(start == 88 && destination == 52)
			price = 7;
		else
		if(start == 88 && destination == 53)
			price = 7;
		else
		if(start == 88 && destination == 54)
			price = 6;
		else
		if(start == 88 && destination == 55)
			price = 6;
		else
		if(start == 88 && destination == 56)
			price = 6;
		else
		if(start == 88 && destination == 57)
			price = 6;
		else
		if(start == 88 && destination == 58)
			price = 5;
		else
		if(start == 88 && destination == 59)
			price = 5;
		else
		if(start == 88 && destination == 60)
			price = 5;
		else
		if(start == 88 && destination == 61)
			price = 5;
		else
		if(start == 88 && destination == 62)
			price = 5;
		else
		if(start == 88 && destination == 63)
			price = 5;
		else
		if(start == 88 && destination == 64)
			price = 5;
		else
		if(start == 88 && destination == 65)
			price = 6;
		else
		if(start == 88 && destination == 66)
			price = 6;
		else
		if(start == 88 && destination == 67)
			price = 6;
		else
		if(start == 88 && destination == 68)
			price = 6;
		else
		if(start == 88 && destination == 69)
			price = 6;
		else
		if(start == 88 && destination == 70)
			price = 6;
		else
		if(start == 88 && destination == 71)
			price = 7;
		else
		if(start == 88 && destination == 72)
			price = 7;
		else
		if(start == 88 && destination == 73)
			price = 7;
		else
		if(start == 88 && destination == 74)
			price = 7;
		else
		if(start == 88 && destination == 75)
			price = 7;
		else
		if(start == 88 && destination == 76)
			price = 8;
		else
		if(start == 88 && destination == 77)
			price = 6;
		else
		if(start == 88 && destination == 78)
			price = 6;
		else
		if(start == 88 && destination == 79)
			price = 5;
		else
		if(start == 88 && destination == 80)
			price = 5;
		else
		if(start == 88 && destination == 81)
			price = 5;
		else
		if(start == 88 && destination == 82)
			price = 5;
		else
		if(start == 88 && destination == 83)
			price = 4;
		else
		if(start == 88 && destination == 84)
			price = 4;
		else
		if(start == 88 && destination == 85)
			price = 4;
		else
		if(start == 88 && destination == 86)
			price = 3;
		else
		if(start == 88 && destination == 87)
			price = 2;
		else
		if(start == 88 && destination == 88)
			price = 0;
		else
		if(start == 88 && destination == 89)
			price = 2;
		else
		if(start == 88 && destination == 90)
			price = 3;
		else
		if(start == 88 && destination == 91)
			price = 3;
		else
		if(start == 88 && destination == 92)
			price = 4;
		else
		if(start == 89 && destination == 0)
			price = 6;
		else
		if(start == 89 && destination == 1)
			price = 6;
		else
		if(start == 89 && destination == 2)
			price = 6;
		else
		if(start == 89 && destination == 3)
			price = 6;
		else
		if(start == 89 && destination == 4)
			price = 6;
		else
		if(start == 89 && destination == 5)
			price = 6;
		else
		if(start == 89 && destination == 6)
			price = 6;
		else
		if(start == 89 && destination == 7)
			price = 6;
		else
		if(start == 89 && destination == 8)
			price = 6;
		else
		if(start == 89 && destination == 9)
			price = 6;
		else
		if(start == 89 && destination == 10)
			price = 7;
		else
		if(start == 89 && destination == 11)
			price = 7;
		else
		if(start == 89 && destination == 12)
			price = 7;
		else
		if(start == 89 && destination == 13)
			price = 7;
		else
		if(start == 89 && destination == 14)
			price = 7;
		else
		if(start == 89 && destination == 15)
			price = 7;
		else
		if(start == 89 && destination == 16)
			price = 7;
		else
		if(start == 89 && destination == 17)
			price = 7;
		else
		if(start == 89 && destination == 18)
			price = 8;
		else
		if(start == 89 && destination == 19)
			price = 8;
		else
		if(start == 89 && destination == 20)
			price = 8;
		else
		if(start == 89 && destination == 21)
			price = 8;
		else
		if(start == 89 && destination == 22)
			price = 8;
		else
		if(start == 89 && destination == 23)
			price = 7;
		else
		if(start == 89 && destination == 24)
			price = 7;
		else
		if(start == 89 && destination == 25)
			price = 7;
		else
		if(start == 89 && destination == 26)
			price = 7;
		else
		if(start == 89 && destination == 27)
			price = 6;
		else
		if(start == 89 && destination == 28)
			price = 6;
		else
		if(start == 89 && destination == 29)
			price = 6;
		else
		if(start == 89 && destination == 30)
			price = 6;
		else
		if(start == 89 && destination == 31)
			price = 6;
		else
		if(start == 89 && destination == 32)
			price = 6;
		else
		if(start == 89 && destination == 33)
			price = 5;
		else
		if(start == 89 && destination == 34)
			price = 5;
		else
		if(start == 89 && destination == 35)
			price = 5;
		else
		if(start == 89 && destination == 36)
			price = 5;
		else
		if(start == 89 && destination == 37)
			price = 5;
		else
		if(start == 89 && destination == 38)
			price = 4;
		else
		if(start == 89 && destination == 39)
			price = 4;
		else
		if(start == 89 && destination == 40)
			price = 4;
		else
		if(start == 89 && destination == 41)
			price = 3;
		else
		if(start == 89 && destination == 42)
			price = 3;
		else
		if(start == 89 && destination == 43)
			price = 4;
		else
		if(start == 89 && destination == 44)
			price = 4;
		else
		if(start == 89 && destination == 45)
			price = 4;
		else
		if(start == 89 && destination == 46)
			price = 4;
		else
		if(start == 89 && destination == 47)
			price = 5;
		else
		if(start == 89 && destination == 48)
			price = 8;
		else
		if(start == 89 && destination == 49)
			price = 8;
		else
		if(start == 89 && destination == 50)
			price = 7;
		else
		if(start == 89 && destination == 51)
			price = 7;
		else
		if(start == 89 && destination == 52)
			price = 7;
		else
		if(start == 89 && destination == 53)
			price = 7;
		else
		if(start == 89 && destination == 54)
			price = 7;
		else
		if(start == 89 && destination == 55)
			price = 6;
		else
		if(start == 89 && destination == 56)
			price = 6;
		else
		if(start == 89 && destination == 57)
			price = 6;
		else
		if(start == 89 && destination == 58)
			price = 6;
		else
		if(start == 89 && destination == 59)
			price = 5;
		else
		if(start == 89 && destination == 60)
			price = 5;
		else
		if(start == 89 && destination == 61)
			price = 5;
		else
		if(start == 89 && destination == 62)
			price = 5;
		else
		if(start == 89 && destination == 63)
			price = 6;
		else
		if(start == 89 && destination == 64)
			price = 6;
		else
		if(start == 89 && destination == 65)
			price = 6;
		else
		if(start == 89 && destination == 66)
			price = 6;
		else
		if(start == 89 && destination == 67)
			price = 6;
		else
		if(start == 89 && destination == 68)
			price = 6;
		else
		if(start == 89 && destination == 69)
			price = 7;
		else
		if(start == 89 && destination == 70)
			price = 7;
		else
		if(start == 89 && destination == 71)
			price = 7;
		else
		if(start == 89 && destination == 72)
			price = 7;
		else
		if(start == 89 && destination == 73)
			price = 7;
		else
		if(start == 89 && destination == 74)
			price = 7;
		else
		if(start == 89 && destination == 75)
			price = 8;
		else
		if(start == 89 && destination == 76)
			price = 8;
		else
		if(start == 89 && destination == 77)
			price = 6;
		else
		if(start == 89 && destination == 78)
			price = 6;
		else
		if(start == 89 && destination == 79)
			price = 6;
		else
		if(start == 89 && destination == 80)
			price = 5;
		else
		if(start == 89 && destination == 81)
			price = 5;
		else
		if(start == 89 && destination == 82)
			price = 5;
		else
		if(start == 89 && destination == 83)
			price = 5;
		else
		if(start == 89 && destination == 84)
			price = 5;
		else
		if(start == 89 && destination == 85)
			price = 4;
		else
		if(start == 89 && destination == 86)
			price = 3;
		else
		if(start == 89 && destination == 87)
			price = 2;
		else
		if(start == 89 && destination == 88)
			price = 2;
		else
		if(start == 89 && destination == 89)
			price = 0;
		else
		if(start == 89 && destination == 90)
			price = 2;
		else
		if(start == 89 && destination == 91)
			price = 3;
		else
		if(start == 89 && destination == 92)
			price = 3;
		else
		if(start == 90 && destination == 0)
			price = 7;
		else
		if(start == 90 && destination == 1)
			price = 6;
		else
		if(start == 90 && destination == 2)
			price = 6;
		else
		if(start == 90 && destination == 3)
			price = 6;
		else
		if(start == 90 && destination == 4)
			price = 6;
		else
		if(start == 90 && destination == 5)
			price = 6;
		else
		if(start == 90 && destination == 6)
			price = 6;
		else
		if(start == 90 && destination == 7)
			price = 6;
		else
		if(start == 90 && destination == 8)
			price = 7;
		else
		if(start == 90 && destination == 9)
			price = 7;
		else
		if(start == 90 && destination == 10)
			price = 7;
		else
		if(start == 90 && destination == 11)
			price = 7;
		else
		if(start == 90 && destination == 12)
			price = 7;
		else
		if(start == 90 && destination == 13)
			price = 7;
		else
		if(start == 90 && destination == 14)
			price = 7;
		else
		if(start == 90 && destination == 15)
			price = 7;
		else
		if(start == 90 && destination == 16)
			price = 8;
		else
		if(start == 90 && destination == 17)
			price = 8;
		else
		if(start == 90 && destination == 18)
			price = 8;
		else
		if(start == 90 && destination == 19)
			price = 8;
		else
		if(start == 90 && destination == 20)
			price = 8;
		else
		if(start == 90 && destination == 21)
			price = 8;
		else
		if(start == 90 && destination == 22)
			price = 9;
		else
		if(start == 90 && destination == 23)
			price = 7;
		else
		if(start == 90 && destination == 24)
			price = 7;
		else
		if(start == 90 && destination == 25)
			price = 7;
		else
		if(start == 90 && destination == 26)
			price = 7;
		else
		if(start == 90 && destination == 27)
			price = 7;
		else
		if(start == 90 && destination == 28)
			price = 6;
		else
		if(start == 90 && destination == 29)
			price = 6;
		else
		if(start == 90 && destination == 30)
			price = 6;
		else
		if(start == 90 && destination == 31)
			price = 6;
		else
		if(start == 90 && destination == 32)
			price = 6;
		else
		if(start == 90 && destination == 33)
			price = 6;
		else
		if(start == 90 && destination == 34)
			price = 5;
		else
		if(start == 90 && destination == 35)
			price = 5;
		else
		if(start == 90 && destination == 36)
			price = 5;
		else
		if(start == 90 && destination == 37)
			price = 5;
		else
		if(start == 90 && destination == 38)
			price = 5;
		else
		if(start == 90 && destination == 39)
			price = 5;
		else
		if(start == 90 && destination == 40)
			price = 4;
		else
		if(start == 90 && destination == 41)
			price = 3;
		else
		if(start == 90 && destination == 42)
			price = 4;
		else
		if(start == 90 && destination == 43)
			price = 4;
		else
		if(start == 90 && destination == 44)
			price = 4;
		else
		if(start == 90 && destination == 45)
			price = 5;
		else
		if(start == 90 && destination == 46)
			price = 5;
		else
		if(start == 90 && destination == 47)
			price = 5;
		else
		if(start == 90 && destination == 48)
			price = 8;
		else
		if(start == 90 && destination == 49)
			price = 8;
		else
		if(start == 90 && destination == 50)
			price = 8;
		else
		if(start == 90 && destination == 51)
			price = 8;
		else
		if(start == 90 && destination == 52)
			price = 7;
		else
		if(start == 90 && destination == 53)
			price = 7;
		else
		if(start == 90 && destination == 54)
			price = 7;
		else
		if(start == 90 && destination == 55)
			price = 7;
		else
		if(start == 90 && destination == 56)
			price = 7;
		else
		if(start == 90 && destination == 57)
			price = 6;
		else
		if(start == 90 && destination == 58)
			price = 6;
		else
		if(start == 90 && destination == 59)
			price = 6;
		else
		if(start == 90 && destination == 60)
			price = 6;
		else
		if(start == 90 && destination == 61)
			price = 6;
		else
		if(start == 90 && destination == 62)
			price = 6;
		else
		if(start == 90 && destination == 63)
			price = 6;
		else
		if(start == 90 && destination == 64)
			price = 6;
		else
		if(start == 90 && destination == 65)
			price = 6;
		else
		if(start == 90 && destination == 66)
			price = 6;
		else
		if(start == 90 && destination == 67)
			price = 7;
		else
		if(start == 90 && destination == 68)
			price = 7;
		else
		if(start == 90 && destination == 69)
			price = 7;
		else
		if(start == 90 && destination == 70)
			price = 7;
		else
		if(start == 90 && destination == 71)
			price = 7;
		else
		if(start == 90 && destination == 72)
			price = 7;
		else
		if(start == 90 && destination == 73)
			price = 8;
		else
		if(start == 90 && destination == 74)
			price = 8;
		else
		if(start == 90 && destination == 75)
			price = 8;
		else
		if(start == 90 && destination == 76)
			price = 8;
		else
		if(start == 90 && destination == 77)
			price = 6;
		else
		if(start == 90 && destination == 78)
			price = 6;
		else
		if(start == 90 && destination == 79)
			price = 6;
		else
		if(start == 90 && destination == 80)
			price = 6;
		else
		if(start == 90 && destination == 81)
			price = 6;
		else
		if(start == 90 && destination == 82)
			price = 5;
		else
		if(start == 90 && destination == 83)
			price = 5;
		else
		if(start == 90 && destination == 84)
			price = 5;
		else
		if(start == 90 && destination == 85)
			price = 4;
		else
		if(start == 90 && destination == 86)
			price = 4;
		else
		if(start == 90 && destination == 87)
			price = 3;
		else
		if(start == 90 && destination == 88)
			price = 3;
		else
		if(start == 90 && destination == 89)
			price = 2;
		else
		if(start == 90 && destination == 90)
			price = 0;
		else
		if(start == 90 && destination == 91)
			price = 2;
		else
		if(start == 90 && destination == 92)
			price = 3;
		else
		if(start == 91 && destination == 0)
			price = 7;
		else
		if(start == 91 && destination == 1)
			price = 7;
		else
		if(start == 91 && destination == 2)
			price = 6;
		else
		if(start == 91 && destination == 3)
			price = 6;
		else
		if(start == 91 && destination == 4)
			price = 6;
		else
		if(start == 91 && destination == 5)
			price = 6;
		else
		if(start == 91 && destination == 6)
			price = 6;
		else
		if(start == 91 && destination == 7)
			price = 7;
		else
		if(start == 91 && destination == 8)
			price = 7;
		else
		if(start == 91 && destination == 9)
			price = 7;
		else
		if(start == 91 && destination == 10)
			price = 7;
		else
		if(start == 91 && destination == 11)
			price = 7;
		else
		if(start == 91 && destination == 12)
			price = 7;
		else
		if(start == 91 && destination == 13)
			price = 7;
		else
		if(start == 91 && destination == 14)
			price = 8;
		else
		if(start == 91 && destination == 15)
			price = 8;
		else
		if(start == 91 && destination == 16)
			price = 8;
		else
		if(start == 91 && destination == 17)
			price = 8;
		else
		if(start == 91 && destination == 18)
			price = 8;
		else
		if(start == 91 && destination == 19)
			price = 8;
		else
		if(start == 91 && destination == 20)
			price = 8;
		else
		if(start == 91 && destination == 21)
			price = 9;
		else
		if(start == 91 && destination == 22)
			price = 9;
		else
		if(start == 91 && destination == 23)
			price = 8;
		else
		if(start == 91 && destination == 24)
			price = 7;
		else
		if(start == 91 && destination == 25)
			price = 7;
		else
		if(start == 91 && destination == 26)
			price = 7;
		else
		if(start == 91 && destination == 27)
			price = 7;
		else
		if(start == 91 && destination == 28)
			price = 7;
		else
		if(start == 91 && destination == 29)
			price = 7;
		else
		if(start == 91 && destination == 30)
			price = 6;
		else
		if(start == 91 && destination == 31)
			price = 6;
		else
		if(start == 91 && destination == 32)
			price = 6;
		else
		if(start == 91 && destination == 33)
			price = 6;
		else
		if(start == 91 && destination == 34)
			price = 6;
		else
		if(start == 91 && destination == 35)
			price = 6;
		else
		if(start == 91 && destination == 36)
			price = 5;
		else
		if(start == 91 && destination == 37)
			price = 5;
		else
		if(start == 91 && destination == 38)
			price = 5;
		else
		if(start == 91 && destination == 39)
			price = 5;
		else
		if(start == 91 && destination == 40)
			price = 4;
		else
		if(start == 91 && destination == 41)
			price = 4;
		else
		if(start == 91 && destination == 42)
			price = 4;
		else
		if(start == 91 && destination == 43)
			price = 4;
		else
		if(start == 91 && destination == 44)
			price = 5;
		else
		if(start == 91 && destination == 45)
			price = 5;
		else
		if(start == 91 && destination == 46)
			price = 5;
		else
		if(start == 91 && destination == 47)
			price = 5;
		else
		if(start == 91 && destination == 48)
			price = 8;
		else
		if(start == 91 && destination == 49)
			price = 8;
		else
		if(start == 91 && destination == 50)
			price = 8;
		else
		if(start == 91 && destination == 51)
			price = 8;
		else
		if(start == 91 && destination == 52)
			price = 8;
		else
		if(start == 91 && destination == 53)
			price = 7;
		else
		if(start == 91 && destination == 54)
			price = 7;
		else
		if(start == 91 && destination == 55)
			price = 7;
		else
		if(start == 91 && destination == 56)
			price = 7;
		else
		if(start == 91 && destination == 57)
			price = 7;
		else
		if(start == 91 && destination == 58)
			price = 6;
		else
		if(start == 91 && destination == 59)
			price = 6;
		else
		if(start == 91 && destination == 60)
			price = 6;
		else
		if(start == 91 && destination == 61)
			price = 6;
		else
		if(start == 91 && destination == 62)
			price = 6;
		else
		if(start == 91 && destination == 63)
			price = 6;
		else
		if(start == 91 && destination == 64)
			price = 6;
		else
		if(start == 91 && destination == 65)
			price = 7;
		else
		if(start == 91 && destination == 66)
			price = 7;
		else
		if(start == 91 && destination == 67)
			price = 7;
		else
		if(start == 91 && destination == 68)
			price = 7;
		else
		if(start == 91 && destination == 69)
			price = 7;
		else
		if(start == 91 && destination == 70)
			price = 7;
		else
		if(start == 91 && destination == 71)
			price = 7;
		else
		if(start == 91 && destination == 72)
			price = 8;
		else
		if(start == 91 && destination == 73)
			price = 8;
		else
		if(start == 91 && destination == 74)
			price = 8;
		else
		if(start == 91 && destination == 75)
			price = 8;
		else
		if(start == 91 && destination == 76)
			price = 8;
		else
		if(start == 91 && destination == 77)
			price = 7;
		else
		if(start == 91 && destination == 78)
			price = 7;
		else
		if(start == 91 && destination == 79)
			price = 6;
		else
		if(start == 91 && destination == 80)
			price = 6;
		else
		if(start == 91 && destination == 81)
			price = 6;
		else
		if(start == 91 && destination == 82)
			price = 6;
		else
		if(start == 91 && destination == 83)
			price = 5;
		else
		if(start == 91 && destination == 84)
			price = 5;
		else
		if(start == 91 && destination == 85)
			price = 5;
		else
		if(start == 91 && destination == 86)
			price = 4;
		else
		if(start == 91 && destination == 87)
			price = 3;
		else
		if(start == 91 && destination == 88)
			price = 3;
		else
		if(start == 91 && destination == 89)
			price = 3;
		else
		if(start == 91 && destination == 90)
			price = 2;
		else
		if(start == 91 && destination == 91)
			price = 0;
		else
		if(start == 91 && destination == 92)
			price = 2;
		else
		if(start == 92 && destination == 0)
			price = 7;
		else
		if(start == 92 && destination == 1)
			price = 7;
		else
		if(start == 92 && destination == 2)
			price = 7;
		else
		if(start == 92 && destination == 3)
			price = 7;
		else
		if(start == 92 && destination == 4)
			price = 7;
		else
		if(start == 92 && destination == 5)
			price = 7;
		else
		if(start == 92 && destination == 6)
			price = 7;
		else
		if(start == 92 && destination == 7)
			price = 7;
		else
		if(start == 92 && destination == 8)
			price = 7;
		else
		if(start == 92 && destination == 9)
			price = 7;
		else
		if(start == 92 && destination == 10)
			price = 7;
		else
		if(start == 92 && destination == 11)
			price = 8;
		else
		if(start == 92 && destination == 12)
			price = 8;
		else
		if(start == 92 && destination == 13)
			price = 8;
		else
		if(start == 92 && destination == 14)
			price = 8;
		else
		if(start == 92 && destination == 15)
			price = 8;
		else
		if(start == 92 && destination == 16)
			price = 8;
		else
		if(start == 92 && destination == 17)
			price = 8;
		else
		if(start == 92 && destination == 18)
			price = 8;
		else
		if(start == 92 && destination == 19)
			price = 8;
		else
		if(start == 92 && destination == 20)
			price = 9;
		else
		if(start == 92 && destination == 21)
			price = 9;
		else
		if(start == 92 && destination == 22)
			price = 9;
		else
		if(start == 92 && destination == 23)
			price = 8;
		else
		if(start == 92 && destination == 24)
			price = 8;
		else
		if(start == 92 && destination == 25)
			price = 8;
		else
		if(start == 92 && destination == 26)
			price = 7;
		else
		if(start == 92 && destination == 27)
			price = 7;
		else
		if(start == 92 && destination == 28)
			price = 7;
		else
		if(start == 92 && destination == 29)
			price = 7;
		else
		if(start == 92 && destination == 30)
			price = 7;
		else
		if(start == 92 && destination == 31)
			price = 7;
		else
		if(start == 92 && destination == 32)
			price = 7;
		else
		if(start == 92 && destination == 33)
			price = 7;
		else
		if(start == 92 && destination == 34)
			price = 6;
		else
		if(start == 92 && destination == 35)
			price = 6;
		else
		if(start == 92 && destination == 36)
			price = 6;
		else
		if(start == 92 && destination == 37)
			price = 6;
		else
		if(start == 92 && destination == 38)
			price = 6;
		else
		if(start == 92 && destination == 39)
			price = 5;
		else
		if(start == 92 && destination == 40)
			price = 5;
		else
		if(start == 92 && destination == 41)
			price = 5;
		else
		if(start == 92 && destination == 42)
			price = 5;
		else
		if(start == 92 && destination == 43)
			price = 5;
		else
		if(start == 92 && destination == 44)
			price = 5;
		else
		if(start == 92 && destination == 45)
			price = 5;
		else
		if(start == 92 && destination == 46)
			price = 6;
		else
		if(start == 92 && destination == 47)
			price = 6;
		else
		if(start == 92 && destination == 48)
			price = 8;
		else
		if(start == 92 && destination == 49)
			price = 8;
		else
		if(start == 92 && destination == 50)
			price = 8;
		else
		if(start == 92 && destination == 51)
			price = 8;
		else
		if(start == 92 && destination == 52)
			price = 8;
		else
		if(start == 92 && destination == 53)
			price = 8;
		else
		if(start == 92 && destination == 54)
			price = 7;
		else
		if(start == 92 && destination == 55)
			price = 7;
		else
		if(start == 92 && destination == 56)
			price = 7;
		else
		if(start == 92 && destination == 57)
			price = 7;
		else
		if(start == 92 && destination == 58)
			price = 7;
		else
		if(start == 92 && destination == 59)
			price = 6;
		else
		if(start == 92 && destination == 60)
			price = 7;
		else
		if(start == 92 && destination == 61)
			price = 6;
		else
		if(start == 92 && destination == 62)
			price = 7;
		else
		if(start == 92 && destination == 63)
			price = 7;
		else
		if(start == 92 && destination == 64)
			price = 7;
		else
		if(start == 92 && destination == 65)
			price = 7;
		else
		if(start == 92 && destination == 66)
			price = 7;
		else
		if(start == 92 && destination == 67)
			price = 7;
		else
		if(start == 92 && destination == 68)
			price = 7;
		else
		if(start == 92 && destination == 69)
			price = 7;
		else
		if(start == 92 && destination == 70)
			price = 8;
		else
		if(start == 92 && destination == 71)
			price = 8;
		else
		if(start == 92 && destination == 72)
			price = 8;
		else
		if(start == 92 && destination == 73)
			price = 8;
		else
		if(start == 92 && destination == 74)
			price = 8;
		else
		if(start == 92 && destination == 75)
			price = 8;
		else
		if(start == 92 && destination == 76)
			price = 9;
		else
		if(start == 92 && destination == 77)
			price = 7;
		else
		if(start == 92 && destination == 78)
			price = 7;
		else
		if(start == 92 && destination == 79)
			price = 7;
		else
		if(start == 92 && destination == 80)
			price = 7;
		else
		if(start == 92 && destination == 81)
			price = 6;
		else
		if(start == 92 && destination == 82)
			price = 6;
		else
		if(start == 92 && destination == 83)
			price = 6;
		else
		if(start == 92 && destination == 84)
			price = 6;
		else
		if(start == 92 && destination == 85)
			price = 5;
		else
		if(start == 92 && destination == 86)
			price = 5;
		else
		if(start == 92 && destination == 87)
			price = 4;
		else
		if(start == 92 && destination == 88)
			price = 4;
		else
		if(start == 92 && destination == 89)
			price = 3;
		else
		if(start == 92 && destination == 90)
			price = 3;
		else
		if(start == 92 && destination == 91)
			price = 2;
		else
		if(start == 92 && destination == 92)
			price = 0;*/
		else
			price = 0;
			end
		end

endmodule // Select