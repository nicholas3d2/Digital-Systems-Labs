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
	
	wire Enable;
	wire [15:0]selRate;
	wire [15:0]rateout;
	wire [3:0]display;
	
	RateSelect rateMux (SW[1:0], CLOCK_50, selRate);
	
	downCount rateCount (selRate, rateout, CLOCK_50, SW[9]);
	
	assign Enable = (rateout == 16'd0)?1:0;
	
	counter4bit upCount (display, CLOCK_50, Enable, SW[9]);
	
	hex_decoder displayCount (display, HEX0);

endmodule

module RateSelect (Select, Clock, Rate);
	
	input wire [1:0]Select;
	input wire Clock;
	output reg [15:0] Rate;
	
	always@(*)
	begin
		case(Select)
			2'b00: Rate = Clock;
			2'b01: Rate = 16'd4999;
			2'b10: Rate = 16'd9999;
			2'b11: Rate = 16'd19999;
			default: Rate = Clock;
		
		endcase
	end
	
endmodule

module downCount (D, Q, Clock, Reset);
	
	input wire [15:0]D;
	input wire Clock, Reset;
	output reg [15:0]Q;
	
	always@(posedge Clock)
	begin
		if(Reset == 1)
			Q <= D;
		else if(Q == 16'd0)
			Q <= D;
		else
			Q <= Q - 1;
			
	end
	
endmodule

module counter4bit(Q, Clock, Enable, Reset);
	
	input wire Clock, Enable, Reset;
	output reg [3:0]Q;
	
	always@(posedge Clock)
	begin
		if(Reset == 1)
			Q <= 0;
//		else if(Q == 4'b1111)
//			Q <= 0;
		else if(Enable)
			Q <= Q + 1;
	end

endmodule


module hex_decoder(c, s);

	input wire [3:0] c;
	output wire [6:0] s;
	
	assign s[0] = ~(~c[2]&~c[0] | c[1]&c[0]&~c[3] | c[2]&c[1] | c[0]&~c[3]&c[2] | ~c[1]&~c[0]&c[3] | c[3]&~c[2]&~c[1]);
	assign s[1] = ~(~c[2]&~c[0] | ~c[1]&~c[0]&~c[3] | ~c[3]&~c[2] | c[1]&c[0]&~c[3] | c[3]&c[0]&~c[1]);
	assign s[2] = ~(c[3]&~c[2] | ~c[1]&c[0] | ~c[3]&c[2] | c[1]&c[0]&~c[3] | ~c[3]&~c[2]&~c[1]);
	assign s[3] = ~(~c[1]&~c[0]&~c[2] | ~c[1]&c[0]&c[2] | c[3]&c[2]&~c[1] | c[1]&c[0]&~c[2] | ~c[3]&~c[2]&c[1] | c[1]&~c[0]&c[2]);
	assign s[4] = ~(~c[0]&~c[2] | c[1]&~c[0] | c[3]&c[2] | c[1]&c[3]);
	assign s[5] = ~(~c[1]&~c[0] | ~c[3]&~c[1]&c[2] | c[3]&~c[2] | c[1]&c[3] | c[1]&~c[0]&c[2]);
	assign s[6] = ~(c[3]&~c[2] | c[1]&c[3] | c[1]&~c[0] | ~c[3]&c[2]&~c[1] | ~c[1]&c[0]&c[2] | c[1]&~c[3]&~c[2]);
	
endmodule
