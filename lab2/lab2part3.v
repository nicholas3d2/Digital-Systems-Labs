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

	hex_decoder display1 (SW, HEX0);

endmodule


module hex_decoder(c, s);

	input [3:0] c;
	output [6:0] s;
	
	assign s[0] = ~(~c[2]&~c[0] | c[1]&c[0]&~c[3] | c[2]&c[1] | c[0]&~c[3]&c[2] | ~c[1]&~c[0]&c[3] | c[3]&~c[2]&~c[1]);
	assign s[1] = ~(~c[2]&~c[0] | ~c[1]&~c[0]&~c[3] | ~c[3]&~c[2] | c[1]&c[0]&~c[3] | c[3]&c[0]&~c[1]);
	assign s[2] = ~(c[3]&~c[2] | ~c[1]&c[0] | ~c[3]&c[2] | c[1]&c[0]&~c[3] | ~c[3]&~c[2]&~c[1]);
	assign s[3] = ~(~c[1]&~c[0]&~c[2] | ~c[1]&c[0]&c[2] | c[3]&c[2]&~c[1] | c[1]&c[0]&~c[2] | ~c[3]&~c[2]&c[1] | c[1]&~c[0]&c[2]);
	assign s[4] = ~(~c[0]&~c[2] | c[1]&~c[0] | c[3]&c[2] | c[1]&c[3]);
	assign s[5] = ~(~c[1]&~c[0] | ~c[3]&~c[1]&c[2] | c[3]&~c[2] | c[1]&c[3] | c[1]&~c[0]&c[2]);
	assign s[6] = ~(c[3]&~c[2] | c[1]&c[3] | c[1]&~c[0] | ~c[3]&c[2]&~c[1] | ~c[1]&c[0]&c[2] | c[1]&~c[3]&~c[2]);
	
endmodule
