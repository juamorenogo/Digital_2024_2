module morse_to_ascii (
  input [9:0] morse_in, // Entrada: vector de 10 bits (5 elementos de 2 bits)
  output reg [7:0] ascii_out, // Salida: código ASCII de la letra
  output reg valid // Salida: indica si la entrada es válida
);

  always @(morse_in) begin
    valid = 1'b1; // Asumimos entrada válida inicialmente
    case (morse_in)
      10'b1011010101: ascii_out = 8'h41; // A: .- (10 11 01 01 01)
      10'b1110101001: ascii_out = 8'h42; // B: -... (11 10 10 10 01)
      10'b1110101110: ascii_out = 8'h43; // C: -.-. (11 10 10 11 10)
      10'b1110101001: ascii_out = 8'h44; // D: -.. (11 10 10 01 01)
      10'b1001010101: ascii_out = 8'h45; // E: . (10 01 01 01 01)
      10'b1010111001: ascii_out = 8'h46; // F: ..-. (10 10 11 10 01)
      10'b1111101001: ascii_out = 8'h47; // G: --. (11 11 10 10 01)
      10'b1010101001: ascii_out = 8'h48; // H: .... (10 10 10 10 01)
      10'b1001100101: ascii_out = 8'h49; // I: .. (10 01 10 01 01)
      10'b1001111110: ascii_out = 8'h4A; // J: .--- (10 01 11 11 11 10)
      10'b1110101101: ascii_out = 8'h4B; // K: -.- (11 10 10 11 01)
      10'b1011101001: ascii_out = 8'h4C; // L: .-.. (10 11 10 10 01)
      10'b1111101101: ascii_out = 8'h4D; // M: -- (11 11 10 11 01)
      10'b1110111001: ascii_out = 8'h4E; // N: -. (11 10 11 10 01)
      10'b1111111110: ascii_out = 8'h4F; // O: --- (11 11 11 11 10)
      10'b1011111001: ascii_out = 8'h50; // P: .--. (10 11 11 10 01)
      10'b1111101111: ascii_out = 8'h51; // Q: --.- (11 11 10 11 11)
      10'b1011101001: ascii_out = 8'h52; // R: .-. (10 11 10 10 01)
      10'b1010100101: ascii_out = 8'h53; // S: ... (10 10 10 01 01)
      10'b1111100101: ascii_out = 8'h54; // T: - (11 11 10 01 01)
      10'b1001100111: ascii_out = 8'h55; // U: ..- (10 01 10 01 11)
      10'b1001101110: ascii_out = 8'h56; // V: ...- (10 01 10 11 10)
      10'b1001111101: ascii_out = 8'h57; // W: .-- (10 01 11 11 01)
      10'b1110100101: ascii_out = 8'h58; // X: -..- (11 10 10 01 01)
      10'b1110111101: ascii_out = 8'h59; // Y: -.-- (11 10 11 11 01)
      10'b1111101010: ascii_out = 8'h5A; // Z: --.. (11 11 10 10 10)
	  10'b1111111111: ascii_out = 8'h30; // 0: -----
      10'b1011111110: ascii_out = 8'h31; // 1: .----
      10'b1010111110: ascii_out = 8'h32; // 2: ..---
      10'b1010101110: ascii_out = 8'h33; // 3: ...--
      10'b1010101010: ascii_out = 8'h34; // 4: ....-
      10'b1010101001: ascii_out = 8'h35; // 5: .....
      10'b1110101001: ascii_out = 8'h36; // 6: -....
      10'b1111101001: ascii_out = 8'h37; // 7: --...
      10'b1111111001: ascii_out = 8'h38; // 8: ---..
      10'b1111111101: ascii_out = 8'h39; // 9: ----.
      default: begin
        ascii_out = 8'h00; // Carácter nulo para entrada inválida
        valid = 1'b0; // Señalizar entrada inválida
      end
    endcase
  end

endmodule