`timescale 1ns / 1ps
`default_nettype none

module main	(
	input wire CLOCK_50,            //On Board 50 MHz
	input wire [9:0] SW,            // On board Switches
	input wire [3:0] KEY,           // On board push buttons
	output wire [6:0] HEX0,         // HEX displays
	output wire [6:0] HEX1,         
	output wire [6:0] HEX2,         
	output wire [6:0] HEX3,         
	output wire [6:0] HEX4,         
	output wire [6:0] HEX5,         
	output wire [9:0] LEDR,         // LEDs
	output wire [7:0] x,            // VGA pixel coordinates
	output wire [6:0] y,
	output wire [2:0] colour,       // VGA pixel colour (0-7)
	output wire plot,               // Pixel drawn when this is pulsed
	output wire vga_resetn          // VGA resets to black when this is pulsed (NOT CURRENTLY AVAILABLE)
);    

	//Write code in here!
	wire c1,c2,c3;
	
	g7404 NOT_1 (.i(SW[9]), .o(c3));
	//(.i[0](SW[9]), .o[0](c3))
	g7408 AND_1 (.ia(SW[0]), .ib(c3), .o(c1));
	//(.ia[0](SW[0]), .ib[0](c3), .o[0](c1))
	g7408 AND_2 (.ia(SW[1]), .ib(SW[9]), .o(c2));
	//(.ia[1](SW[1]), .ib[1](SW[9]), .o[1](c2))
	g7432 OR_1 (.ia(c1), .ib(c2), .o(LEDR[0]));
	
endmodule

module g7404 (i, o);
	input i;
	//input [5:0]i;
	output o;
	//input [5:0]o;
	
	assign o = ~i;
endmodule

module g7408 (ia, ib, o);
	input ia, ib;
	//input [3:0]
	output o;
	//[3:0]
	
	assign o = ia & ib;
endmodule

module g7432 (ia, ib, o);
	input ia, ib;
	//[3:0]
	output o;
	//[3:0]
	
	assign o = ia | ib;
endmodule



