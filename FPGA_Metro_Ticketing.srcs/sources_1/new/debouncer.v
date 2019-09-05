`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/08/26 10:54:16
// Design Name: 
// Module Name: debouncer
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

// 1.按键消抖
module key_debounce(  
	input clk,
	input rst_n,
	input [4:0] key_in,
	output [4:0] button_out
	);

	reg [19:0] count;
	reg [4:0] key_scan;
	always@(posedge clk or negedge rst_n)
	begin
		if(~rst_n)
			count <=20'd0;
		else//20ms为去抖时�?
	        begin
	            if(count === 20'd999_999)
	                begin
	                    count <= 20'd0;
	                    key_scan <= key_in;
	                end 
	            else 
	                count <= count + 20'd1;
	        end
	end
	reg[4:0]key_scan_r;
	always@(posedge clk)
		key_scan_r <= key_scan;
		
	wire [4:0]flag_key = key_scan_r[4:0]&(~key_scan[4:0]);
	reg [4:0]temp_led;
	always @ (posedge clk or negedge rst_n) //�?测时钟的上升沿和复位的下降沿
		begin
			if (!rst_n) 
				temp_led <= 5'b00000;
			else
				begin
					if ( flag_key[0] ) temp_led=5'b00001; 
					else if ( flag_key[1] ) temp_led=5'b00010; 
					else if ( flag_key[2] ) temp_led=5'b00100; 
					else if ( flag_key[3] ) temp_led=5'b01000; 
					else if ( flag_key[4] ) temp_led=5'b10000; 
					else temp_led=5'b00000; 
				end
		end
	assign button_out[0] = temp_led[0];
	assign button_out[1] = temp_led[1];
	assign button_out[2] = temp_led[2];
	assign button_out[3] = temp_led[3];
	assign button_out[4] = temp_led[4];
endmodule

// 2.拨码�?关消�?
module switch_debounce(     
    input CLK,
    input RSTn,
    input [15:0] sw_in,
    output reg [15:0] sw_out=0
    );
    reg [1:0]next_state;
    reg [15:0]sw_temp;//表示sw_temp的bit位宽�?16，最高位为第15位，�?低位�?0
    reg time_20ms;//位宽默认�?1bit
    reg is_count;
    reg [28:0] count;
    always @ ( posedge CLK or negedge RSTn )
	    if( !RSTn )
		    begin
			    sw_temp <= 16'b0000000000000000;
			    next_state <= 2'd0;
			    is_count     <= 1'b0;
			    sw_out <= 16'b0000000000000000;
		    end
	    else
		    begin
			    case(next_state) 
				    2'b00:
					    if(sw_in!=16'b0000000000000000)//有按键输�?
						    begin
							    next_state<= 2'd1;
							    is_count<= 1'b1;//�?始计�?
							    sw_temp<= sw_in;
						    end
						else
						    begin
							    next_state<= 2'd0;
							    sw_temp<= 16'b0000000000000000;
							    is_count<= 1'b0;
						    end
				    2'b01:
					    if(time_20ms==1'b1 )//按键维持�?20ms
					    	begin
							    is_count<= 1'b0;//结束计数
							    next_state<= 2'd2;
					    	end
					    else
					    	begin
					    		sw_temp<= sw_in;
					    		if(sw_in!=sw_temp)
					    			begin
					    				is_count<=1'b0;
					    				next_state<= 2'd0;
					    			end
					    		else
								    begin
									    next_state<= 2'd1;
									    is_count<= 1'b1;//�?始计�?
								    end
					    	end
				    2'b10:
					    if(sw_in!=sw_temp || sw_in==16'b0000000000000000)//按键松开
						    begin
							    sw_out<= sw_temp;    
							    next_state<= 2'd3;
						    end
					    else
						    begin 
							    sw_out<= 16'b0000000000000000;
							    next_state<= 2'd2;
						    end
				    2'b11:
				    	begin
						    next_state<= 2'd0;
						    sw_out<= 16'b0000000000000000;
				    	end
				    default:
				    	next_state<= 2'd0;
			    endcase

			 end
	always @ ( posedge CLK or negedge RSTn )
		if(!RSTn)
		    begin
			    time_20ms<=1'b0;
			    count<=28'd0;
		    end
		else if(is_count==1'b1)
		    if(count==28'd100000)
			    begin
				    time_20ms<=1'b1;
				    count<=28'd0;
			    end
		    else
			    begin
				    time_20ms<=1'b0;
				    count<=count+1'd1;//
			    end
		else
		    begin
			    time_20ms<=1'b0;
			    count<=28'd0;
	    	end
endmodule