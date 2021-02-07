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
	
	wire [7:0] qout;
	wire [7:0] tin;
	
	assign tin[0] = SW[1];
	assign tin[1] = qout[0] & tin[0];
	assign tin[2] = qout[1] & tin[1];
	assign tin[3] = qout[2] & tin[2];
	assign tin[4] = qout[3] & tin[3];
	assign tin[5] = qout[4] & tin[4];
	assign tin[6] = qout[5] & tin[5];
	assign tin[7] = qout[6] & tin[6];
	
	T_ff bit1 (tin[0], KEY[0], SW[0], qout[0]);
	T_ff bit2 (tin[1], KEY[0], SW[0], qout[1]);
	T_ff bit3 (tin[2], KEY[0], SW[0], qout[2]);
	T_ff bit4 (tin[3], KEY[0], SW[0], qout[3]);
	T_ff bit5 (tin[4], KEY[0], SW[0], qout[4]);
	T_ff bit6 (tin[5], KEY[0], SW[0], qout[5]);
	T_ff bit7 (tin[6], KEY[0], SW[0], qout[6]);
	T_ff bit8 (tin[7], KEY[0], SW[0], qout[7]);
	
	hex_decoder displayCount0 (qout[3:0], HEX0); //display Data
	hex_decoder displayCount1 (qout[7:4], HEX1); //display Data

endmodule

module T_ff(T, clock, reset, Q);
	
	input wire T, clock, reset;
	output reg Q;
	
	always@(posedge clock)
	begin
		if(reset == 0)
			Q <= 0;
		else
			if(T)
				Q <= ~Q;
			else
				Q <= Q;
	end
	
endmodule

//module counter_8bit(Q, clock, enable, clear_b);
//	
//	input clock, enable, clear_b;
//	
//	output reg [7:0] Q;
//	
//	always@(posedge clock)
//		begin
//			if(clear_b == 0)
//				Q <= 0;
//			else if(enable)
//				Q <= Q+1;
//		end
//	
//endmodule

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
