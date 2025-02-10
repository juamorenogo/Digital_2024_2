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
    reg [2:0] state = 0;  // Estado de la FSM
    reg enable_pulse = 0; // Señal de control para E 
	reg [16:0] ticks_wire;
	reg [16:0] prev_ticks = 0;
	
	ticks_generator d0 (
		.clk(clk),
		.start(1), // Start = 0 --> No esta contando // Start = 1 --> Si esta contando
		.ticks(ticks_wire)
	);
	
    always @(posedge clk) begin 
            if (ticks_wire != prev_ticks) begin
			case (state)
				0: begin // Configuración inicial
					enable_pulse <= 0; // Solicita un pulso de Enable
					RS <= 0; 
					DB <= 8'b00110000; 
					state <= 1;
				end
				1: begin
					enable_pulse <= 1; // Finaliza pulso
					state <= 2;
				end
				2: begin // Clear display
                    enable_pulse <= 0;
					RS <= 0;
					DB <= 8'b00000001;

					state <= 3;
				end
				3: begin
					enable_pulse <= 1;
					state <= 4;
				end
				4: begin // Display ON sin cursor
                    enable_pulse <= 0;
					RS <= 0;
					DB <= 8'b00001100;
					
					state <= 5;
				end
				5: begin
					enable_pulse <= 1;
					state <= 6;
				end
				6: begin // Escribir 'a'
					enable_pulse <= 0;
					RS <= 1;
					DB <= 8'b01100001;
					state <= 7;
				end
				7: begin
					enable_pulse <= 1;
					state <= 8;  // Mantenerse en este estado
				end
				8: begin
                    enable_pulse <=0;
                    state <=8;
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


