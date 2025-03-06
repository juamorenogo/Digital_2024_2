`timescale 1ns / 1ps

module LCD(
    input clk,
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
reg [7:0] DB;  // Registro para almacenar los datos a enviar
reg [3:0] state = 0;
reg enable_pulse = 0; // Señal de control para E 
reg [7:0] char_index = 0;
reg [16:0] ticks_wire;
reg [16:0] prev_ticks = 0;
reg control=0;
	
	ticks_generator d0 (
		.clk(clk),
		.start(1), // Start = 0 --> No esta contando // Start = 1 --> Si esta contando
		.ticks(ticks_wire)
	);
    
    // mensajes a escribir en el display
    reg [7:0] message [0:14];
	
    initial begin
        // configuración de los mensajes (Base:, Encr:, Decr:)
        message[0]  = "B"; message[1]  = "a"; message[2]  = "s"; message[3]  = "e"; message[4]  = ":";
        message[5]  = "E"; message[6]  = "n"; message[7]  = "c"; message[8]  = "r"; message[9]  = ":";
        message[10] = "D"; message[11] = "e"; message[12] = "c"; message[13] = "r"; message[14] = ":";
    end
	
    
    always @(posedge clk) begin
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
						DB <= 8'h80; // Dirección 0x00
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
				6: begin // dirección de la segunda línea
					if(control==0) begin
						enable_pulse <= 0;
						control <= 1;					
						RS <= 0;
						DB <= 8'hC0; // Dirección 0x14
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
				8: begin // dirección de la tercera línea
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

