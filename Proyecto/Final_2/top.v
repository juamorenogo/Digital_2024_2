module top(    
	input wire clk,
	input wire clear_button
	input wire button,
	input wire del_button,
	input wire fin_button,
	output ledshort,
	output lednull,
	output ledlong,
	output led_button_primigenio  //LOS ELEGIDOS
	output led_button_trilogia
	output led_button_chorizo
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
	
	reg [7:0] letra,
	
	//parámetros conectores del bloque de write
	reg [7:0] ascii;
	reg valid;
	reg [7:0] ciphered;
	reg [7:0] decrypted;
	reg [7:0] key_inuse;
	reg write_flag = 0;

	
	initial begin 

		//valors iniciales para variables dinámicas
		reg dir_frst = 7'h05;                                                               
		reg dir_scnd = 7'h45;
		reg dir_thrd = 7'h19;
		reg base_key = 8'b10101010;
		
		assign key_inuse = base_key;
	
		//config inicial para la LCD
		clean clean_inst (
			.clk(clk),
			.RS(RS),
			.E(E),
			.D0(D0),
			.D1(D1),
			.D2(D2),
			.D3(D3),
			.D4(D4),
			.D5(D5),
			.D6(D6),
			.D7(D7)
		);
	end
	
	always @(posedge clk) begin
		
		//lector de botones a morse
		araque button_to_morse (
			.clk(clk),
			.button(button),
			.del_button(del_button),
			.fin_button(fin_button),
			.write_flag(write_flag),
			.ledshort(ledshort),
			.lednull(lednull),
			.ledlong(ledlong)
			.led_v1(led_button_primigenio),
			.led_v2(led_button_trilogia),
			.led_v3(led_button_chorizo)
		);
	
		if (write_flag==5) begin //bloque write
			// Traducción
			morse_to_ascii morse_to_ascii_inst (
				.morse_in(letra),
				.ascii_out(ascii),
				.valid(valid)
			);
			// Cifrado
			xor_cipher xor_cipher_inst (
				.key(key_inuse),
				.ascii(ascii),
				.ciphered(ciphered)
			);
			// Escribir en pantalla letra cifrada
			line_write linea1_write (
				.clk(clk),
				.dir(dir_frst),
				.char(ciphered),
				.RS(RS),
				.E(E),
				.D0(D0),
				.D1(D1),
				.D2(D2),
				.D3(D3),
				.D4(D4),
				.D5(D5),
				.D6(D6),
				.D7(D7)
			);
			// Descifrado
			xor_cipher xor_decipher_inst (
				.key(key_inuse),
				.ascii(ciphered),
				.ciphered(decrypted)
			);
			// Escritura en pantalla letra descifrada
			line_write linea3_write (
				.clk(clk),
				.dir(dir_thrd),
				.char(decrypted),
				.RS(RS),
				.E(E),
				.D0(D0),
				.D1(D1),
				.D2(D2),
				.D3(D3),
				.D4(D4),
				.D5(D5),
				.D6(D6),
				.D7(D7)
			);
			//Se ajustan para las nuevas direcciones de los cursores
			dir_frst <= dir_frst+1;                                                               
			dir_scnd <= dir_scnd+1;
			dir_thrd <= dir_thrd+1;
			//Ajuste de la variable de control de condicional
			write_flag <= 0;
		end
			
		if (clear_button) begin 
			//Randomizador de llave
			lfsr_keygen lfsr_keygen_inst (
				.clk(clk),
				.clear(clear),
				.key_work(key_inuse),
				.key_out(key_inuse)
			);
			//Se limpia/resetea la lcd y los datos mostrados
			clean clean_inst (
				.clk(clk),
				.RS(RS),
				.E(E),
				.D0(D0),
				.D1(D1),
				.D2(D2),
				.D3(D3),
				.D4(D4),
				.D5(D5),
				.D6(D6),
				.D7(D7)
			);
			
			//Se reinician las direcciones de los cursores
			dir_frst <= 7'h05;                                                               
			dir_scnd <= 7'h45;
			dir_thrd <= 7'h19;
			
		end
	end
	
endmodule 