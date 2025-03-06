module morse_to_ascii (
  input [9:0] morse_in, // Entrada
  output reg [7:0] ascii_out, // Salida: código ASCII de la letra
  output reg valid // Salida: indica si la entrada es válida
);

  /*
    Codificación de Morse:
    - Pulso corto (.)  = 10
    - Pulso largo (-)  = 11
    - Pulso vacío ( )  = 00
  */

  always @(morse_in) begin
    valid = 1'b1; // Asumimos entrada válida inicialmente
    case (morse_in)
      10'b0000_0000_00: ascii_out = " "; // ESPACIO: sin entrada (00 00 00 00 00)
      10'b10_11_00_00_00: ascii_out = "A"; // A: .-   (10 11 00 00 00)
      10'b11_10_10_10_00: ascii_out = "B"; // B: -... (11 10 10 10 00)
      10'b11_10_11_10_00: ascii_out = "C"; // C: -.-. (11 10 11 10 00)
      10'b11_10_10_00_00: ascii_out = "D"; // D: -..  (11 10 10 00 00)
      10'b10_00_00_00_00: ascii_out = "E"; // E: .    (10 00 00 00 00)
      10'b10_10_11_10_00: ascii_out = "F"; // F: ..-. (10 10 11 10 00)
      10'b11_11_10_00_00: ascii_out = "G"; // G: --.  (11 11 10 00 00)
      10'b10_10_10_10_00: ascii_out = "H"; // H: .... (10 10 10 10 00)
      10'b10_10_00_00_00: ascii_out = "I"; // I: ..   (10 10 00 00 00)
      10'b10_11_11_11_00: ascii_out = "J"; // J: .--- (10 11 11 11 00)
      10'b11_10_11_00_00: ascii_out = "K"; // K: -.-  (11 10 11 00 00)
      10'b10_11_10_10_00: ascii_out = "L"; // L: .-.. (10 11 10 10 00)
      10'b11_11_00_00_00: ascii_out = "M"; // M: --   (11 11 00 00 00)
      10'b11_10_00_00_00: ascii_out = "N"; // N: -.   (11 10 00 00 00)
      10'b11_11_11_00_00: ascii_out = "O"; // O: ---  (11 11 11 00 00)
      10'b10_11_11_10_00: ascii_out = "P"; // P: .--. (10 11 11 10 00)
      10'b11_11_10_11_00: ascii_out = "Q"; // Q: --.- (11 11 10 11 00)
      10'b10_11_10_00_00: ascii_out = "R"; // R: .-.  (10 11 10 00 00)
      10'b10_10_10_00_00: ascii_out = "S"; // S: ...  (10 10 10 00 00)
      10'b11_00_00_00_00: ascii_out = "T"; // T: -    (11 00 00 00 00)
      10'b10_10_11_00_00: ascii_out = "U"; // U: ..-  (10 10 11 00 00)
      10'b10_10_10_11_00: ascii_out = "V"; // V: ...- (10 10 10 11 00)
      10'b10_11_11_00_00: ascii_out = "W"; // W: .--  (10 11 11 00 00)
      10'b11_10_10_00_00: ascii_out = "X"; // X: -..- (11 10 10 00 00)
      10'b11_10_11_11_00: ascii_out = "Y"; // Y: -.-- (11 10 11 11 00)
      10'b11_11_10_10_00: ascii_out = "Z"; // Z: --.. (11 11 10 10 00)
      10'b11_11_11_11_11: ascii_out = "0"; // 0: -----
      10'b10_11_11_11_11: ascii_out = "1"; // 1: .----
      10'b10_10_11_11_11: ascii_out = "2"; // 2: ..---
      10'b10_10_10_11_11: ascii_out = "3"; // 3: ...--
      10'b10_10_10_10_11: ascii_out = "4"; // 4: ....-
      10'b10_10_10_10_10: ascii_out = "5"; // 5: .....
      10'b11_10_10_10_10: ascii_out = "6"; // 6: -....
      10'b11_11_10_10_10: ascii_out = "7"; // 7: --...
      10'b11_11_11_10_10: ascii_out = "8"; // 8: ---..
      10'b11_11_11_11_10: ascii_out = "9"; // 9: ----.
      default: begin
        ascii_out = 8'h00; // Carácter nulo para entrada inválida
        valid = 1'b0; // Señalizar entrada inválida
      end
    endcase
  end

endmodule

