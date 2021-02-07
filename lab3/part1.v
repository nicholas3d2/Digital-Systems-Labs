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
	mux7to1 a (SW[6:0], SW[9:7], LEDR[0]);
	
endmodule

module mux7to1 (In, Sel, Out);
	
	input wire [6:0] In;
	input wire [2:0] Sel;
	output reg Out;
	
	always @(*)
		begin
			case(Sel[2:0])
				3'b000: Out = In[0];
				3'b001: Out = In[1];
				3'b010: Out = In[2];
				3'b011: Out = In[3];
				3'b100: Out = In[4];
				3'b101: Out = In[5];
				3'b110: Out = In[6];
				default: Out = In[0];
			endcase
		end
endmodule


