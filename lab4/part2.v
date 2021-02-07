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

	wire [7:0] ALUout;
	wire [7:0] Regout;
	simpleALU alu (Regout, SW[3:0], Regout[3:0], KEY[3:1], ALUout);
	reg_8bit register (ALUout, Regout, SW[9], KEY[0]);
	
	assign LEDR = Regout;
	
	hex_decoder displayData (SW[3:0], HEX0); //display Data
	hex_decoder display0a (4'b0000, HEX1); //display 0
	hex_decoder display0b (4'b0000, HEX2); //display 0
	hex_decoder display0c (4'b0000, HEX3); //display 0
	hex_decoder displayALUa (Regout[3:0], HEX4); //display ALU
	hex_decoder displayALUb (Regout[7:4], HEX5); //display ALU
	
	
endmodule

module simpleALU(register, A, B, func, ALU);
	
	input wire [7:0] register;
	input wire [2:0] func;
	input wire [3:0] A;
	input wire [3:0] B;
	
	wire [4:0] S;
	
	output reg [7:0] ALU;
	
	wire c1, c2, c3;
	fulladder FA0 (A[0], B[0], 0, S[0], c1);
	fulladder FA1 (A[1], B[1], c1, S[1], c2);
	fulladder FA2 (A[2], B[2], c2, S[2], c3);
	fulladder FA3 (A[3], B[3], c3, S[3], S[4]);  //addition using fulladders
	
		always@(*)
			begin
				case(func)
					3'b111: ALU = {8'b000, S};
					3'b110:	ALU = A + B; //addition using + operator
					3'b101:	ALU = {8'b0000, B}; //sign extension of B to 8 bits
					3'b100:	ALU = {7'd0, |{A,B}};	//output 8'b00000001 if at least 1 of 8 bits in the 2 inputs is 1 using a single OR
					3'b011:	ALU = {7'd0, &{A,B}};	//output 8'b00000001 if all of the 8 bits in the 2 inputs are 1 using a single AND 				
					3'b010:	ALU = A << B;	//left shift A by B bits
					3'b001: ALU = A * B; //multiplication using * operator
					3'b000:	ALU = register; //ALU just holds register value
					
					default: ALU = 8'bxxxxxxxx;
					
				endcase
			end
				
				
endmodule


module fulladder (a,b,ci,s,co);

	input wire a,b,ci;
	output wire s,co;
	
	assign s = a ^ b ^ ci;
	assign co = a & b | a & ci | b & ci;
	
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

module reg_8bit(D, Q, Resetn, Clock);

	input wire [7:0] D;
	input wire Resetn, Clock;
	
	output reg [7:0] Q;
	
	always@(posedge Clock)
	begin
		if(Resetn == 0) //active low reset
			Q <= 0;
		else
			Q <= D;
	end

endmodule
