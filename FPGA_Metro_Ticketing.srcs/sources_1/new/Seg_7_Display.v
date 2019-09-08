`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Digilent Inc.
// Engineer: Thomas Kappenman
//
// Create Date:    03/03/2015 09:08:33 PM
// Design Name:
// Module Name:    seg7decimal
// Project Name: Nexys4DDR Keyboard Demo
// Target Devices: Nexys4DDR
// Tool Versions:
// Description: 7 segment display driver
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module seg7decimal(
    input [31:0] eightnum,
    input stat,
    input clk,
    output reg [6:0] seg,
    output reg [7:0] an,
    output wire dp);
    
    wire [2:0] s; // select digit
    reg [3:0] digit;
    wire [7:0] aen;
    reg [19:0] clkdiv;
    reg [32:0] num;
    
    assign dp  = 1; // turn off decimal point
    assign ss = clkdiv[4:0];
    assign s   = clkdiv[19:17];
    assign aen = 8'b11111111; // all turned off initially
    
    // quad 4to1 MUX.
    integer i;
    always @(posedge clk) begin// or posedge clr)
        if (stat == 4'h3)
            ;
            // case (ss)
            //     0:
        else begin
            if (eightnum[7:0] >= 4'd10) begin // 十进�????
                num[3:0] = eightnum[7:0] % 4'd10;
                num[7:4] = eightnum[7:0] / 4'd10;
                end
            else
                num[7:0] = eightnum[7:0];
                
            if (eightnum[15:8] >= 4'd10) begin // 十进�?????
                num[11:8] = eightnum[15:8] % 4'd10;
                num[15:12] = eightnum[15:8] / 4'd10;
                end
            else
                num[15:8] = eightnum[15:8];

            if (eightnum[23:16] >= 4'd10) begin // 十进�?????
                num[19:16] = eightnum[23:16] % 4'd10;
                num[23:20] = eightnum[23:16] / 4'd10;
                end
            else
                num[23:16] = eightnum[23:16];

            if (eightnum[31:24] >= 4'd10) begin // 十进�?????
                num[27:24] = eightnum[31:24] % 4'd10;
                num[31:28] = eightnum[31:24] / 4'd10;
                end
            else
                num[31:24] = eightnum[31:24];
        end
        case(s)
            0:digit = num[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to num[3:0]
            1:digit = num[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to num[7:4]
            2:digit = num[11:8]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to num[11:8
            3:digit = num[15:12]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to num[15:12]
            4:digit = num[19:16]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to num[3:0]
            5:digit = num[23:20]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to num[7:4]
            6:digit = num[27:24]; // s is 10 -->2 ;  digit gets assigned 4 bit value assigned to num[11:8
            7:digit = num[31:28]; // s is 11 -->3 ;  digit gets assigned 4 bit value assigned to num[15:12]
            default:digit = num[3:0];
        endcase
    end
    
    //decoder or truth-table for 7seg display values
    always @(*)
        if (stat == 4'h3)
            case(digit)
                // 0 is lit // 1 is unlit //
                //////////<---MSB-LSB<---
                //////////////gfedcba////////////////////////////////////////////           	a
                0:seg   = 7'b1000000;////0000												   __
                1:seg   = 7'b1111001;////0001												f/	  /b
                2:seg   = 7'b0100100;////0010												  g
                3:seg   = 7'b0110000;////0011                                              	 __
                4:seg   = 7'b0011001;////0100										 	 e /   /c
                5:seg   = 7'b0010010;////0101										       __
                6:seg   = 7'b0000010;////0110                                              d
                7:seg   = 7'b1111000;////0111
                8:seg   = 7'b0000000;////1000
                9:seg   = 7'b0010000;////1001
                'hA:seg = 7'b0001000;
                'hB:seg = 7'b0000011;
                'hC:seg = 7'b1000110;
                'hD:seg = 7'b0100001;
                'hE:seg = 7'b0000110;
                'hF:seg = 7'b0001110;
                default: seg = 7'b0000000; // U
            endcase
        else
            case(digit)
                // 0 is lit // 1 is unlit //
                //////////<---MSB-LSB<---
                //////////////gfedcba////////////////////////////////////////////           	a
                0:seg   = 7'b1000000;////0000												   __
                1:seg   = 7'b1111001;////0001												f/	  /b
                2:seg   = 7'b0100100;////0010												  g
                3:seg   = 7'b0110000;////0011                                              	 __
                4:seg   = 7'b0011001;////0100										 	 e /   /c
                5:seg   = 7'b0010010;////0101										       __
                6:seg   = 7'b0000010;////0110                                              d
                7:seg   = 7'b1111000;////0111
                8:seg   = 7'b0000000;////1000
                9:seg   = 7'b0010000;////1001
                'hA:seg = 7'b0001000;
                'hB:seg = 7'b0000011;
                'hC:seg = 7'b1000110;
                'hD:seg = 7'b0100001;
                'hE:seg = 7'b0000110;
                'hF:seg = 7'b0001110;
                default: seg = 7'b0000000; // U
            endcase
    
    always @(*) begin
        an = 8'b11111111;
        if (aen[s] == 1)
            an[s] = 0;
    end
        
	//clkdiv
        
	always @(posedge clk) begin
		clkdiv <= clkdiv+1;
	end
           
endmodule

module Disp_minus (input clk,
                   output wire [6:0] seg,
                   output wire an,
                   output wire dp);
    assign seg = 7'b1000000;
    assign an = 1;
endmodule // Disp_minus 还未�?????验过