`timescale 1ns / 1ps

module clean(
    input clk,
	input clean_flag,
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

	reg start_clean = 0;

	ticks_generator_LCD d0 (
		.clk(clk),
		.start(start_clean), // Start = 0 --> No esta contando // Start = 1 --> Si esta contando
		.ticks(ticks_wire)
	);

	always @(posedge clk) begin
		if(clean_flag==2 or clean_flag==1) begin
			
			if(clean_flag==2) begin
				reg [7:0] DB;  // Registro para almacenar los datos a enviar
				reg [3:0] state = 0;
				reg enable_pulse = 0; // Señal de control para E 
				reg [7:0] char_index = 0;
				reg [16:0] ticks_wire;
				reg [16:0] prev_ticks = 0;
				reg control=0;
			
				// mensajes a escribir en el display
				reg [7:0] message [0:14];
				
				initial begin
					// configuración de los mensajes (Base:, Encr:, Decr:)
					message[0]  = "B"; message[1]  = "a"; message[2]  = "s"; message[3]  = "e"; message[4]  = ":";
					message[5]  = "E"; message[6]  = "n"; message[7]  = "c"; message[8]  = "r"; message[9]  = ":";
					message[10] = "D"; message[11] = "e"; message[12] = "c"; message[13] = "r"; message[14] = ":";
				end
				
				clean_flag<=1;
				start_clean<=1;
			end
			
			
			if(clean_flag==1) begin
				if (ticks_wire != prev_ticks) begin
					case (state)
						0: begin // configuración a modo 8 bits, 2 líneas
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0;
								DB <= 8'b00111100;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						1: begin // clear Display
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0;
								DB <= 8'b00000001;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						2: begin // return Home
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0;
								DB <= 8'b00000010;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						3: begin // display ON, sin cursor
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0;
								DB <= 8'b00001100;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state  <= state + 1;
							end
						end

						4: begin // dirección de la primera línea
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 0;
								DB <= 8'hC0; // Dirección 0x00
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						5: begin // escribir "Base:"
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;
								RS <= 1;
								DB <= message[char_index];
								char_index <= char_index + 1;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								if (char_index == 5) begin
									state <= state + 1;
								end
							end
						end
						6: begin // dirección de la PRIMERA línea
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;					
								RS <= 0;
								DB <= 8'h80; // Dirección 0x00
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						7: begin // escribir "Encr:"
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;		
								RS <= 1;
								DB <= message[char_index];
								char_index <= char_index + 1;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								if (char_index == 10) begin
									state <= 8;
								end
							end
						end
						8: begin // dirección de la TERCERA línea
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;		
								RS <= 0;
								DB <= 8'h94; // Dirección 0x40
							end else begin
								enable_pulse <= 1;
								control <= 0;
								state <= state + 1;
							end
						end
						9: begin // escribir "Decr:"
							if(control==0) begin
								enable_pulse <= 0;
								control <= 1;	
								RS <= 1;
								DB <= message[char_index];
								char_index <= char_index + 1;
							end else begin
								enable_pulse <= 1;
								control <= 0;
								if (char_index == 15) begin
									state <= 10;
								end
							end
						end
						10: begin // salir del módulo "clean"
							clean_flag <= 0;
							start_clean <= 1;
						end
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
			D7 = DB[7];
		end
	end

endmodule

