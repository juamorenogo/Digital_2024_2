`timescale 1ns / 1ps

module final1 (
	input wire clk,
	input wire button,
	input wire del_button,
	input wire fin_button,
	output led_1,
	output led_2,
	output led_3,
	output led_4,
	output led_5,
	output led_6,
	output led_7,
	output led_8,
	output led_9,
	output led_10,
	output ledshort,
	output lednull,
	output ledlong,
	input wire show,
	output reg RS,
	output reg RW,
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
assign RW= 1'b0;
	//---------------------------------------------------INSTANCIAS DE VARIOS MÓDULOS + VARIABLES
	
	
	//-----------MORSE READER	
	reg [7:0] ascii;
	reg [7:0] ciphered;
	reg [7:0] key;
	integer counter_index_save = -1;
	
	
	
	//-----------MORSE READER

	reg [9:0] letra_final = 10'b0;
	reg PB_state, PB_down, PB_up ; //Debouncer Entry
	reg PB_state_del, PB_down_del, PB_up_del ; //Debouncer Delete
	reg PB_state_fin, PB_down_fin, PB_up_fin ; //Debouncer Send
	reg PB_state_show, PB_down_show, PB_up_show; //Debouncer Send
	wire start;
	reg [16:0] ticks_press;
	reg [9:0] letra = 10'b00000_00000; //guardado de letra morse
	reg [2:0] control1 = 3'b000; 	
	reg [2:0] contador = 3'b000; 
	reg start_signal = 1'b0;

	Debouncer pdb (
		.clk(clk),
		.PB(button),
		.PB_state(PB_state),
		.PB_down(PB_down),
		.PB_up(PB_up)
	);                  
	Debouncer pdb_del (
		.clk(clk),
		.PB(del_button), 
		.PB_state(PB_state_del),
		.PB_down(PB_down_del), 
		.PB_up(PB_up_del)
	);
	Debouncer pdb_fin (
		.clk(clk),
		.PB(fin_button), 
		.PB_state(PB_state_fin),
		.PB_down(PB_down_fin), 
		.PB_up(PB_up_fin)
	);
	Debouncer pdb_show (
		.clk(clk),
		.PB(show), 
		.PB_state(PB_state_show),
		.PB_down(PB_down_show), 
		.PB_up(PB_up_show)
	);
	ticks_generator ticki (
		.clk(clk),
		.start(start),
		.ticks(ticks_press)
	);


	//-----------LCD

	reg enable_pulse = 0; // Señal de control para E
	reg control=0;	
	reg [7:0] DB;  // Registro para almacenar los datos a enviar
	reg [3:0] state = 0;
	reg [3:0] char_index = 0;
	reg [16:0] ticks_wire;
	reg [16:0] prev_ticks = 0;
	reg [7:0] base_word [0:15];
  reg [7:0] encr_word [0:15];
  reg [7:0] decr_word [0:15];	
	reg [7:0] message_1l [0:4];
	reg [7:0] message_2l [0:4];
	reg [7:0] message_3l [0:4];
	reg [7:0] to_write1l [0:14];
	reg [7:0] to_write2l [0:14];
	reg [7:0] to_write3l [0:14];
	integer i;
	reg [7:0] key = 8'b1110_01110;
	integer variable=0;
	
	ticks_generator_lcd d0 (
		.clk(clk),
		.start(1'b1), // Start = 0 --> No esta contando // Start = 1 --> Si esta contando
		.ticks(ticks_wire)
	);





	//---------------------------------------------------INITIAL'S
	
	initial begin
		
		base_word[0] = " "; base_word[1] = " "; base_word[2] = " "; base_word[3] = " "; base_word[4] = " "; base_word[5] = " "; base_word[6] = " "; base_word[7] = " "; base_word[8] = " "; base_word[9] = " ";

		encr_word[0] = " "; encr_word[1] = " "; encr_word[2] = " "; encr_word[3] = " "; encr_word[4] = " "; encr_word[5] = " "; encr_word[6] = " "; encr_word[7] = " "; encr_word[8] = " "; encr_word[9] = " ";

		decr_word[0] = " "; decr_word[1] = " "; decr_word[2] = " "; decr_word[3] = " "; decr_word[4] = " "; decr_word[5] = " "; decr_word[6] = " "; decr_word[7] = " "; decr_word[8] = " "; decr_word[9] = " ";

        message_1l[0]  = "B"; message_1l[1]  = "a"; message_1l[2]  = "s"; message_1l[3]  = "e"; message_1l[4]  = ":";

        message_2l[0] = "E"; message_2l[1] = "n"; message_2l[2] = "c"; 
        message_2l[3] = "r"; message_2l[4] = ":";

        message_3l[0] = "D"; message_3l[1] = "e"; message_3l[2] = "c"; 
        message_3l[3] = "r"; message_3l[4] = ":";
    end
	
	//---------------------------------------------------BLOQUE ALWAYS
	
	

	always @(posedge clk) begin

		if(PB_state & ~PB_down) begin // BOTON ABIERTO = 1
			start_signal <= 1'b0;				
		end else if(~(PB_state & ~PB_down)) begin // BOTON CERRADO = 0
			start_signal <= 1'b1;
		end


		if(PB_down_del) begin 			
			letra <= {2'b00, letra[9:2]};



			
		end else if (PB_state_del & ~PB_down_del) begin               
			if (ticks_press > 17'b0 &&  ticks_press < 2000) begin // PULSO CORTO 10
				ledshort <=1'b1;
				ledlong <= 1'b0;
				lednull <= 1'b0;
				if(PB_down) begin
					letra <= {letra[7:0], 2'b10 }; // Operacion de concatenacion y desplazamiento
				end
			end else if(ticks_press >= 4000 && ticks_press <= 7000 ) begin // PULSO LARGO 11
				ledshort <=1'b1;
				ledlong <= 1'b1;
				lednull <= 1'b0;
				if(PB_down) begin
					letra <= {letra[7:0], 2'b11 }; // Operacion de concatenacion y desplazamiento
				end
			end else if (ticks_press > 7000) begin // PULSO VACIO 00
				ledshort<= 1'b1;
				ledlong <= 1'b1;
				lednull <= 1'b1;
				if(PB_down) begin
					letra <= {letra[7:0], 2'b00 }; // Operacion de concatenacion y desplazamiento
				end
			end else if (ticks_press == 0) begin 
				ledshort<= 1'b0;
				ledlong <= 1'b0;
				lednull <= 1'b0;
			end
		end

		if(~PB_down_fin) begin // BOTON ABIERTO = 1 // BOTON FINAL
			$display("abierto");
		end else if(PB_down_fin) begin // BOTON CERRADO = 0 --> Envio de datos al final
					case (letra)
					10'b00_00_00_00_00: ascii <= ""; // ESPACIO: sin entrada (00 00 00 00 00)
					10'b10_11_00_00_00: ascii <= "A"; // A: .-   (10 11 00 00 00)
					10'b11_10_10_10_00: ascii <= "B"; // B: -... (11 10 10 10 00)
					10'b11_10_11_10_00: ascii <= "C"; // C: -.-. (11 10 11 10 00)
					10'b11_10_10_00_00: ascii <= "D"; // D: -..  (11 10 10 00 00)
					10'b10_00_00_00_00: ascii <= "E"; // E: .    (10 00 00 00 00)
					10'b10_10_11_10_00: ascii <= "F"; // F: ..-. (10 10 11 10 00)
					10'b11_11_10_00_00: ascii <= "G"; // G: --.  (11 11 10 00 00)
					10'b10_10_10_10_00: ascii <= "H"; // H: .... (10 10 10 10 00)
					10'b10_10_00_00_00: ascii <= "I"; // I: ..   (10 10 00 00 00)
					10'b10_11_11_11_00: ascii <= "J"; // J: .--- (10 11 11 11 00)
					10'b11_10_11_00_00: ascii <= "K"; // K: -.-  (11 10 11 00 00)
					10'b10_11_10_10_00: ascii <= "L"; // L: .-.. (10 11 10 10 00)
					10'b11_11_00_00_00: ascii <= "M"; // M: --   (11 11 00 00 00)
					10'b11_10_00_00_00: ascii <= "N"; // N: -.   (11 10 00 00 00)
					10'b11_11_11_00_00: ascii <= "O"; // O: ---  (11 11 11 00 00)
					10'b10_11_11_10_00: ascii <= "P"; // P: .--. (10 11 11 10 00)
					10'b11_11_10_11_00: ascii <= "Q"; // Q: --.- (11 11 10 11 00)
					10'b10_11_10_00_00: ascii <= "R"; // R: .-.  (10 11 10 00 00)
					10'b10_10_10_00_00: ascii <= "S"; // S: ...  (10 10 10 00 00)
					10'b11_00_00_00_00: ascii <= "T"; // T: -    (11 00 00 00 00)
					10'b10_10_11_00_00: ascii <= "U"; // U: ..-  (10 10 11 00 00)
					10'b10_10_10_11_00: ascii <= "V"; // V: ...- (10 10 10 11 00)
					10'b10_11_11_00_00: ascii <= "W"; // W: .--  (10 11 11 00 00)
					10'b11_10_10_00_00: ascii <= "X"; // X: -..- (11 10 10 00 00)
					10'b11_10_11_11_00: ascii <= "Y"; // Y: -.-- (11 10 11 11 00)
					10'b11_11_10_10_00: ascii <= "Z"; // Z: --.. (11 11 10 10 00)
					10'b11_11_11_11_11: ascii <= "0"; // 0: -----
					10'b10_11_11_11_11: ascii <= "1"; // 1: .----
					10'b10_10_11_11_11: ascii <= "2"; // 2: ..---
					10'b10_10_10_11_11: ascii <= "3"; // 3: ...--
					10'b10_10_10_10_11: ascii <= "4"; // 4: ....-
					10'b10_10_10_10_10: ascii <= "5"; // 5: .....
					10'b11_10_10_10_10: ascii <= "6"; // 6: -....
					10'b11_11_10_10_10: ascii <= "7"; // 7: --...
					10'b11_11_11_10_10: ascii <= "8"; // 8: ---..
					10'b11_11_11_11_10: ascii <= "9"; // 9: ----.
				endcase
	
				base_word[counter_index_save-1] <= ascii;
				ciphered <= key ^ letra;
				encr_word[counter_index_save-1] <= ciphered;

				counter_index_save <= counter_index_save + 1;
				
				if(counter_index_save==20) begin
					counter_index_save<=0;
				end
				letra <= 0;

				if(variable == 0)begin
					base_word[0]=" ";
					variable<=1;
					counter_index_save <= 0;
				end
		end
	end
	
    always @(posedge clk) begin

        // Construir los mensajes extendidos
        for (i = 0; i < 10; i = i + 1) begin
            to_write1l[i] <= message_1l[i];
            to_write2l[i] <= message_2l[i];
            to_write3l[i] <= message_3l[i];
        end
        for (i = 0; i < 20; i = i + 1) begin
            to_write1l[i+5] <= base_word[i];
            to_write2l[i+5] <= encr_word[i];
            to_write3l[i+5] <= decr_word[i];
        end
	
		if (ticks_wire != prev_ticks) begin
			case (state)
				0: begin // configuración a modo 8 bits, 2 líneas
				//led_9 <= 1'b0;
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
				5: begin // escribir "Base:+WORD"
					if(control==0) begin
						enable_pulse <= 0;
						control <= 1;
						RS <= 1;
						DB <= to_write1l[char_index];
						char_index <= char_index + 1;
					end else begin
						enable_pulse <= 1;
						control <= 0;
						if (char_index == 15) begin
							char_index <= 0;
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
						state <= state + 2;
					end
				end
				7: begin // escribir "Encr:++"
					if(control==0) begin
						enable_pulse <= 0;
						control <= 1;		
						RS <= 1;
						DB <= to_write2l[char_index];
						char_index <= char_index + 1;
					end else begin
						enable_pulse <= 1;
						control <= 0;
						if (char_index == 15) begin
							char_index <= 0;
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
				//led_9 <= 1'b1;
					if(control==0) begin
						enable_pulse <= 0;
						control <= 1;	
						RS <= 1;
						DB <= to_write2l[char_index];
						char_index <= char_index + 1;
					end else begin
						enable_pulse <= 1;
						control <= 0;
						if (char_index == 15) begin
							char_index <= 0;
							state <= 10;
						end
					end
				end
				10: begin //IDLE
					if (~(PB_state_show & ~PB_down_show)) begin
						state <= 0;
						//led_10<=1'b0;
					end else begin
						$display("awa");
						//led_10<= 1'b1;
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


	assign start = start_signal;

	//Asignaciones leds funcionales
	always @(posedge clk) begin
		if(button) begin
			led_v3 <= 1'b1;
		end else if (del_button) begin
			led_v3 <= 1'b1;
		end else if (fin_button) begin
			led_v3 <= 1'b1;
		end else begin
			led_v3 <= 1'b0;
		end
	end

assign led_1 = letra[0]; //LED PRENDIDO = BOTON ABIERTO 
assign led_2 = letra[1];
assign led_3 = letra[2];
assign led_4 = letra[3];
assign led_5 = letra[4];
assign led_6 = letra[5];
assign led_7 = letra[6];
assign led_8 = letra[7];
assign led_9 = letra[8];
assign led_10 = letra[9];


endmodule





