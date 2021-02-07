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
	
	wire resetn, draw, s_clear, load_x;
	assign resetn = KEY[0];
	assign draw = ~KEY[1];
	assign s_clear = ~KEY[2];
	assign load_x = ~KEY[3];
	
	assign plot = writeEn;
	wire ld_x, ld_y, ld_colour, inc_x, inc_y;
	wire [7:0] x_val;
	wire [6:0] y_val;
	wire writeEn;
	wire clear;
	
	control c0(CLOCK_50, resetn, draw, s_clear, load_x, x_val, y_val, writeEn, inc_x, inc_y, ld_x, ld_y, ld_colour, clear);
	
	datapath d0(CLOCK_50, resetn, inc_c, inc_y, ld_x, ld_y, ld_colour, clear, SW[9:7], SW[6:0], SW[6:0], x_val, y_val, colour, x, y);
	
	
endmodule

module control(clk, resetn, draw, s_clear, load_x, x_val, y_val, writeEn, inc_x, inc_y, ld_x, ld_y, ld_colour, clear);

	input clk, resetn, draw, s_clear, load_x;
	input [7:0] x_val;
	input [6:0] y_val;
	output reg ld_x, ld_y, ld_colour, inc_y, inc_x, writeEn, clear;
	
	reg [4:0] current_state, next_state;
	
	localparam LOAD_X = 4'd0, LOAD_X_WAIT = 4'd1, LOAD_Y = 4'd2, LOAD_Y_WAIT = 4'd3, 
					DRAW_X = 4'd4, DRAW_Y = 4'd5, CLEAR_X = 4'd6, CLEAR_Y = 4'd7, CLEAR_WAIT = 4'd8;
					
	always@(*)
	begin: state_table
		case(current_state)
				LOAD_X: next_state = s_clear ? CLEAR_WAIT : (load_x ? LOAD_X_WAIT : LOAD_X);
				CLEAR_WAIT: next_state = s_clear ? CLEAR_WAIT : CLEAR_X;
				LOAD_X_WAIT: next_state = load_x ? LOAD_X_WAIT : LOAD_Y;
				LOAD_Y: next_state = draw ? LOAD_Y_WAIT : LOAD_Y;
				LOAD_Y_WAIT: next_state = draw ? LOAD_Y_WAIT : DRAW_X;
				DRAW_X: next_state = x_val < 3 ? DRAW_X : DRAW_Y;
				DRAW_Y: next_state = y_val < 3 ? DRAW_X : LOAD_X;
				CLEAR_X: next_state = x_val < 159 ? CLEAR_X : CLEAR_Y;
				CLEAR_Y: next_state = y_val < 119 ? CLEAR_X : LOAD_X;
				
			default: next_state = LOAD_X;
		endcase
	end
	
	
	always@(*)
	begin: enable_signals
		ld_x = 0;
		ld_y = 0;
		ld_colour = 0;
		writeEn = 0;
		inc_y = 0;
		inc_x = 0;
		clear = 0;
		
		case(current_state)
			
			LOAD_X: begin
				ld_x = 1;
			end
			
			LOAD_Y: begin
				ld_y = 1;
				ld_colour = 1;
			end
			
			DRAW_X: begin
				writeEn = 1;
				inc_x = 1;
			end
			
			DRAW_Y: begin
				inc_y = 1;
			end
			
			CLEAR_WAIT: begin
				clear = 1;
				ld_x = 1;
				ld_y = 1;
			end
			
			CLEAR_X: begin
				clear = 1;
				writeEn = 1;
				inc_x = 1;
			end
			
			CLEAR_Y: begin
				clear = 1;
				inc_y = 1;
			end
			
		endcase
	end
	
	always@(posedge clk)
	begin: state_FFs
		if(!resetn)
			current_state <= LOAD_X;
		else
			current_state <= next_state;
	end

endmodule

module datapath(clk, resetn, inc_x, inc_y, ld_x, ld_y, ld_colour, clear, in_colour, in_x, in_y, x_val, y_val, colour, x, y);

		input clk, resetn, ld_x, ld_y, ld_colour, inc_x, inc_y, clear;
		input [2:0]in_colour;
		input [6:0]in_x;
		input [6:0]in_y;
		output [2:0]colour;
		output [7:0]x;
		output [6:0]y;
		
		output reg [7:0] x_val;
		output reg [6:0] y_val;
		
		reg [7:0]init_x;
		reg [6:0]init_y;
		reg [2:0]sel_colour;
		
		
		always@(posedge clk)begin
		
			if(!resetn)begin
				init_x <= 8'b0;
				init_y <= 7'b0;
				sel_colour <= 3'b0;
				x_val <= 8'b0;
				y_val <= 7'b0;
			end
			else begin
				if(ld_x) begin
					init_x <= clear ? 8'b0 : {1'b0, in_x};
					y_val <= 7'd0;
				end
				if(ld_y) begin
					init_y <= clear ? 7'b0 : in_y;
				end
				if(ld_colour) begin
					sel_colour <= in_colour;
				end
				if(inc_x) begin
					x_val <= x_val + 1;
				end
				if(inc_y) begin
					y_val <= y_val + 1;
					x_val <= 8'd0;
				end
			end
			
		
		end
		
		assign x = init_x + x_val;
		assign y = init_y + y_val;
		assign colour = clear ? 3'b000 : sel_colour;

endmodule
