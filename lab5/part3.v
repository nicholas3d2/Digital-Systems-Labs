`timescale 1ns / 1ps
`default_nettype none

module main (
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
	
	wire [11:0]letter;
	wire [11:0]rate;
	wire enable;
	wire [11:0]Q;
	
	LUT lutmux(SW[2:0], letter);
	
	downCount rateDivider(rate, CLOCK_50, KEY[0]);
	
	assign enable = (rate == 12'd0)?1:0;
	
	shiftRegister_12bit shiftReg(letter, Q, CLOCK_50, enable, KEY[1], KEY[0]);
	
	assign LEDR[0] = Q[11];
	
endmodule

module LUT (sel, LUTout);

	input wire [2:0]sel;
	
	output reg [11:0]LUTout;
	
	always@(*)
	begin
		case(sel)
		
			3'b000: LUTout = 12'b010111000000; //A
			3'b001: LUTout = 12'b011101010100; //B
			3'b010: LUTout = 12'b011101011101; //C
			3'b011: LUTout = 12'b011101010000; //D
			3'b100: LUTout = 12'b010000000000; //E
			3'b101: LUTout = 12'b010101110100; //F
			3'b110: LUTout = 12'b011101110100; //G
			3'b111: LUTout = 12'b010101010000; //H
			default: LUTout = 12'b010111000000;
		
		endcase
	end

endmodule

module downCount (Q, Clock, Reset);
	
	input wire Clock, Reset;
	output reg [11:0]Q;
	
	always@(posedge Clock, negedge Reset)
	begin
		if(Reset == 0)
			Q <= 12'd2499;
		else if(Q == 12'd0)
			Q <= 12'd2499;
		else
			Q <= Q - 1;
			
	end
	
endmodule

module shiftRegister_12bit (D, Q, clock, enable, load, reset);
	
	input wire enable, clock, load, reset;
	input wire [11:0]D;
	
	output reg [11:0]Q;
	
	always@(posedge clock, negedge reset)
	begin
	
		if(reset == 0)
			Q <= 0;
		else if(load == 0)
			Q <= D;
		else if(enable)
			Q <= Q << 1;
		
	end
	
	
endmodule
