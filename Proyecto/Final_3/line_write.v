`timescale 1ns / 1ps

module line_write(
    input clk,
    input [6:0] dir,
    input [7:0] char,
	input line_write_flag,
    output reg RS,
    output reg E,
    output reg D0,
    output reg D1,
    output reg D2,
    output reg D3,
    output reg D4,
    output reg D5,
    output reg D6,
    output reg D7,
    input start
);
	
	reg linwrt_start = 0;

	// Instantiate a clock-based timing module (Assuming it exists)
	ticks_generator_LCD d0 (
		.clk(clk),
		.start(linwrt_start),
		.ticks(ticks_wire)
	);

	always @(posedge clk) begin
		if(line_write_flag==2 or line_write_flag==1) begin
		
			if(line_write_flag==2) begin
				reg [7:0] DB;
				reg [1:0] state;
				reg enable_pulse = 0;
				reg [16:0] ticks_wire;
				reg [16:0] prev_ticks = 0;
				reg control = 0;
				line_write_flag <= 1;
				linwrt_start<=1;
			end

			if (line_write_flag==1) begin
				if (ticks_wire != prev_ticks) begin
					case (state)
						0: begin // Set cursor position
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0; // Command mode
								DB <= {1'b1,dir}; // Command to move cursor to 'dir'
								DB <= 
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						1: begin // escribir caracter
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 1; // modo de datos
								//DB <= char;
								DB <= 8'b01100001;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						2: begin
							line_write_flag<=0;
							linwrt_start<=1;
					endcase
					prev_ticks <= ticks_wire;
				end
			end


			E <= enable_pulse;
			D0 = DB[0];
			D1 = DB[1];
			D2 = DB[2];
			D3 = DB[3];
			D4 = DB[4];
			D5 = DB[5];
			D6 = DB[6];
		end
	end 
endmodule
