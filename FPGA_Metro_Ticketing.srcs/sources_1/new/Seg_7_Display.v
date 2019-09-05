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
module seg7decimal(input [7:0] eightnum,
                   input clk,
                   output reg [6:0] seg,
                   output reg [1:0] an,
                   output wire dp);
    
    wire [2:0] s;
    reg [3:0] digit;
    wire [1:0] aen;
    reg [19:0] clkdiv;
    
    assign dp  = 1; // turn off decimal point
    assign s   = clkdiv[19:17];
    assign aen = 8'b11111111; // all turned off initially
    
    // quad 4to1 MUX.
    
    always @(posedge clk)// or posedge clr)
    
    case(s)
        0:digit = eightnum[3:0]; // s is 00 -->0 ;  digit gets assigned 4 bit value assigned to eightnum[3:0]
        1:digit = eightnum[7:4]; // s is 01 -->1 ;  digit gets assigned 4 bit value assigned to eightnum[7:4]       
        default:digit = eightnum[3:0];
    endcase
    
    //decoder or truth-table for 7seg display values
    always @(*)
    
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
        an = 2'b11;
        if (aen[s] == 1)
            an[s] = 0;
    end
        
	//clkdiv
        
	always @(posedge clk) begin
		clkdiv <= clkdiv+1;
	end
           
endmodule
