`timescale 1ns / 1ps

module line_write(
    input clk,
    input [6:0] dir,
    input [7:0] char,
    output reg RS,
    output reg E,
    output reg D0,
    output reg D1,
    output reg D2,
    output reg D3,
    output reg D4,
    output reg D5,
    output reg D6,
    output reg D7
);
    reg [7:0] DB;
    reg state = 0;
    reg enable_pulse = 0;
    reg [16:0] ticks_wire;
    reg [16:0] prev_ticks = 0;
    reg control = 0;

    // Instantiate a clock-based timing module (Assuming it exists)
    ticks_generator d0 (
        .clk(clk),
        .start(1),
        .ticks(ticks_wire)
    );

    always @(posedge clk) begin
		if (ticks_wire != prev_ticks) begin
			case (state)
				0: begin // Set cursor position
					if(control==0) begin
						enable_pulse <= 0;
						control <= 1;
						RS <= 0; // Command mode
						DB <= {1'b1,dir}; // Command to move cursor to 'dir'
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
						DB <= char;
					end else begin
						enable_pulse <= 1;
						control <= 0;
						state <= state + 1;
					end
				end
			endcase
			prev_ticks <= ticks_wire;
		end
    end

    // **Segundo always** para manejar el Enable `E` de manera separada
    always @(posedge clk) begin
        E <= enable_pulse;
    end

    // Asignar los bits de DB a las salidas D0-D7
    always @(*) begin
        D0 = DB[0];
        D1 = DB[1];
        D2 = DB[2];
        D3 = DB[3];
        D4 = DB[4];
        D5 = DB[5];
        D6 = DB[6];
        D7 = DB[7];
    end

endmodule
