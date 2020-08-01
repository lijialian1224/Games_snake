`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 14:15:58
// Design Name: 
// Module Name: Eating
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


module Eatting(
	input clk,
	input rst,
	
	input [5:0]head_x,
	input [5:0]head_y,
	
	output reg [5:0]apple_x,
	output reg [4:0]apple_y,
	output reg [5:0]apple2_x,
    output reg [4:0]apple2_y,

	output reg add_cube,
	output reg add_cube2
);

	reg [31:0]clk_cnt;
	reg [10:0]random_num;
	reg [10:0]random_num2;
	
	always@(posedge clk) begin
		random_num <= random_num + 999;  //用加法产生随机数  
		//随机数高5位为食物X坐标 低5位为苹果Y坐标
		random_num2 <= random_num2 + 999;
	end
	always@(posedge clk or negedge rst) begin
		if(!rst) begin
			clk_cnt <= 0;
			apple_x <= 24;
			apple_y <= 10;
			apple2_x <= 14;
            apple2_y <= 8;
			add_cube <= 0;
			add_cube2 <= 0;
		end
		else begin
			clk_cnt <= clk_cnt+1;
			if(clk_cnt == 250_000) begin
				clk_cnt <= 0;
				if(apple_x == head_x && apple_y == head_y) begin
					add_cube <= 1;
					apple_x <= (random_num[10:5] > 33) ? (random_num[10:5] - 25) : (random_num[10:5] == 0) ? 1 : random_num[10:5];
					apple_y <= (random_num[4:0] > 28) ? (random_num[4:0] - 3) : (random_num[4:0] == 0) ? 1:random_num[4:0];
				end   //判断随机数是否超出频幕坐标范围 将随机数转换为下个苹果的X Y坐标
				else if(apple2_x == head_x && apple2_y == head_y) begin
                    add_cube2 <= 1;
                    apple2_x <= (random_num2[10:5] > 33) ? (random_num2[10:5] - 25) : (random_num2[10:5] == 0) ? 1 : random_num2[10:5];
                    apple2_y <= (random_num2[4:0] > 28) ? (random_num2[4:0] - 3) : (random_num2[4:0] == 0) ? 1:random_num2[4:0];
                end
				else begin 
				add_cube2 <=0;
				add_cube <=0;
				end
			end
		end
	end
endmodule
