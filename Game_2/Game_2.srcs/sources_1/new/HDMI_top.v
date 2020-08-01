`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 14:44:07
// Design Name: 
// Module Name: HDMI_top
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


module HDMI_top(
 input clk_100MHz,
 output TMDS_Tx_Clk_N,
 output TMDS_Tx_Clk_P,
 output [2:0]TMDS_Tx_Data_N,
 output [2:0]TMDS_Tx_Data_P,
 
    input [1:0]snake,
    input [5:0]apple_x,
    input [4:0]apple_y,
    input [5:0]apple2_x,
    input [4:0]apple2_y,
    output [9:0]x_pos,
    output [9:0]y_pos,    
    output hsync,
    output vsync,
    output [11:0] color_out
 );
 wire clk_system;
 wire [23:0]RGB_Data;
 wire [23:0]RGB_In;
 wire RGB_HSync;
 wire RGB_VSync;
 wire RGB_VDE;
 wire [11:0]Set_X;
 wire [11:0]Set_Y;
 clk_wiz_0 clk_10(.clk_out1(clk_system),.clk_in1(clk_100MHz));
 //RGBToDvi instantiation
 rgb2dvi_0 rgb2dvi(
 .TMDS_Clk_p(TMDS_Tx_Clk_P),
 .TMDS_Clk_n(TMDS_Tx_Clk_N),
 .TMDS_Data_p(TMDS_Tx_Data_P),
 .TMDS_Data_n(TMDS_Tx_Data_N),
 .aRst(1),
 .vid_pData(RGB_Data),
 .vid_pVDE(RGB_VDE),
 .vid_pHSync(RGB_HSync),
 .vid_pVSync(RGB_VSync),
 .PixelClk(clk_system));
 Driver_HDMI Driver_HDMI0(
 .clk(clk_system), //Clock
 .Rst(1), //Reset signal, low reset
 .Video_Mode(0), //Video format, 0 is 1920*1080@60Hz, 1 is 1280*720@60Hz
 .RGB_In(RGB_In), //Input data
 .RGB_Data(RGB_Data), //Output Data
 .RGB_HSync(RGB_HSync), //Line signal
 .RGB_VSync(RGB_VSync), //Field signal
 .RGB_VDE(RGB_VDE), //Data valid signal
 .Set_X(Set_X), //Image coordinate X
 .Set_Y(Set_Y) //Image coordinate Y
 );

     HDMI_Control HDMI
(
		.clk(clk_system),
		.hsync(hsync),
		.vsync(vsync),
		.snake(snake),
        .color_out(color_out),
		.x_pos(x_pos),
		.y_pos(y_pos),
		.apple_x(apple_x),
		.apple_y(apple_y),
		.apple2_x(apple2_x),
        .apple2_y(apple2_y)
	);
endmodule
