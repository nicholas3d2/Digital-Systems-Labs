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
	wire c1, c2, c3;
	
	fulladder FA0 (SW[4], SW[0], SW[8], LEDR[0], c1);
	fulladder FA1 (SW[5], SW[1], c1, LEDR[1], c2);
	fulladder FA2 (SW[6], SW[2], c2, LEDR[2], c3);
	fulladder FA3 (SW[7], SW[3], c3, LEDR[3], LEDR[9]);

	
	
endmodule

module fulladder (a,b,ci,s,co);

	input wire a,b,ci;
	output wire s,co;
	
	assign s = a ^ b ^ ci;
	assign co = a & b | a & ci | b & ci;
	
endmodule
