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
	
	wire [7:0]left;
	wire [7:0]right;
	wire [7:0]tomux;
	wire [7:0]todff;
	wire [7:0]Qff;
	
	assign LEDR = Qff;
	
	mux2to1 m0a (right[0], left[0], ~KEY[2], tomux[0]);
	mux2to1 m0b (SW[0], tomux[0], ~KEY[1], todff[0]);
	flipflop FF0 (todff[0], Qff[0], ~KEY[0], SW[9]);
//	assign right[1] = Qff[0];
//	assign left[7] = Qff[0];
	
	mux2to1 m1a (right[1], left[1], ~KEY[2], tomux[1]);
	mux2to1 m1b (SW[1], tomux[1], ~KEY[1], todff[1]);
	flipflop FF1 (todff[1], Qff[1], ~KEY[0], SW[9]);
//	assign right[2] = Qff[1];
//	assign left[0] = Qff[1];
	
	mux2to1 m2a (right[2], left[2], ~KEY[2], tomux[2]);
	mux2to1 m2b (SW[2], tomux[2], ~KEY[1], todff[2]);
	flipflop FF2 (todff[2], Qff[2], ~KEY[0], SW[9]);
//	assign right[3] = Qff[2];
//	assign left[1] = Qff[2];
	
	mux2to1 m3a (right[3], left[3], ~KEY[2], tomux[3]);
	mux2to1 m3b (SW[3], tomux[3], ~KEY[1], todff[3]);
	flipflop FF3 (todff[3], Qff[3], ~KEY[0], SW[9]);
//	assign right[4] = Qff[3];
//	assign left[2] = Qff[3];
	
	mux2to1 m4a (right[4], left[4], ~KEY[2], tomux[4]);
	mux2to1 m4b (SW[4], tomux[4], ~KEY[1], todff[4]);
	flipflop FF4 (todff[4], Qff[4], ~KEY[0], SW[9]);
//	assign right[5] = Qff[4];
//	assign left[3] = Qff[4];
	
	mux2to1 m5a (right[5], left[5], ~KEY[2], tomux[5]);
	mux2to1 m5b (SW[5], tomux[5], ~KEY[1], todff[5]);
	flipflop FF5 (todff[5], Qff[5], ~KEY[0], SW[9]);
//	assign right[6] = Qff[5];
//	assign left[4] = Qff[5];
	
	mux2to1 m6a (right[6], left[6], ~KEY[2], tomux[6]);
	mux2to1 m6b (SW[6], tomux[6], ~KEY[1], todff[6]);
	flipflop FF6 (todff[6], Qff[6], ~KEY[0], SW[9]);
//	assign right[7] = Qff[6];
//	assign left[5] = Qff[6];
	
	mux2to1 m7a (right[7], left[7], ~KEY[2], tomux[7]);
	mux2to1 m7b (SW[7], tomux[7], ~KEY[1], todff[7]);
	flipflop FF7 (todff[7], Qff[7], ~KEY[0], SW[9]);
//	assign right[0] = Qff[7];
//	assign left[6] = Qff[7];
	cases c(~KEY[1], ~KEY[2], ~KEY[3], KEY[0], right, left, Qff);
	
endmodule

module cases(parallelload, rotateright, ASright, clock, R, L, Qff);
	
	input wire parallelload;
	input wire rotateright;
	input wire ASright;
	input wire clock;
	input wire [7:0]Qff;
	
	output reg [7:0]L;
	output reg [7:0]R;


always@(*)
	begin
		
		if(parallelload && rotateright && ASright)
		begin//arithmetic shift right
			R[1] <= Qff[0];
			L[7] <= Qff[7]; //value of 7 always on left!
			
			R[2] <= Qff[1];
			L[0] <= Qff[1];
			
			R[3] <= Qff[2];
			L[1] <= Qff[2];
			
			R[4] <= Qff[3];
			L[2] <= Qff[3];
			
			R[5] <= Qff[4];
			L[3] <= Qff[4];
			
			R[6] <= Qff[5];
			L[4] <= Qff[5];
			
			R[7] <= Qff[6];
			L[5] <= Qff[6];
			
			R[0] <= Qff[7];
			L[6] <= Qff[7];
		end	
		else 
		begin//regular assignments for left/right rotation
			R[1] <= Qff[0];
			L[7] <= Qff[0];
			
			R[2] <= Qff[1];
			L[0] <= Qff[1];
			
			R[3] <= Qff[2];
			L[1] <= Qff[2];
			
			R[4] <= Qff[3];
			L[2] <= Qff[3];
			
			R[5] <= Qff[4];
			L[3] <= Qff[4];
			
			R[6] <= Qff[5];
			L[4] <= Qff[5];
			
			R[7] <= Qff[6];
			L[5] <= Qff[6];
			
			R[0] <= Qff[7];
			L[6] <= Qff[7];
		end
	end

endmodule

module mux2to1(x, y, s, m);
    input wire x; //select 0
    input wire y; //select 1
    input wire s; //select signal
    output wire m; //output
  
    //assign m = s & y | ~s & x;
    // OR
    assign m = s ? y : x;

endmodule

module flipflop(d, q, clock, reset);
	input wire d, clock, reset;
	
	output reg q;
	
	always@(posedge clock)
	begin
		if(reset == 1)
			q <= 0;
		else
			q <=d;
	end
	
endmodule
