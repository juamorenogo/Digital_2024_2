`timescale 1ns / 1ps

module morse_to_ascii_tb;

  reg [9:0] morse_in; // Entrada del código Morse
  wire [7:0] ascii_out; // Salida en ASCII
  wire valid; // Indica si la conversión es válida

  // Instancia del módulo a probar
  morse_to_ascii uut (
    .morse_in(morse_in),
    .ascii_out(ascii_out),
    .valid(valid)
  );

  initial begin
    $dumpfile("morse_to_ascii_tb.vcd");
    $dumpvars(0, morse_to_ascii_tb);
    
    // Prueba: Letra "E" en Morse (.) -> Código 10'b10_00_00_00_00
    morse_in = 10'b10_00_00_00_00;
    #10;
    $display("Morse: %b -> ASCII: %c (Valido: %b)", morse_in, ascii_out, valid);
    
    // Prueba: Letra "T" en Morse (-) -> Código 10'b11_00_00_00_00
    morse_in = 10'b11_00_00_00_00;
    #10;
    $display("Morse: %b -> ASCII: %c (Valido: %b)", morse_in, ascii_out, valid);
    
    // Prueba: Letra "A" en Morse (.-) -> Código 10'b10_11_00_00_00
    morse_in = 10'b10_11_00_00_00;
    #10;
    $display("Morse: %b -> ASCII: %c (Valido: %b)", morse_in, ascii_out, valid);
    
    // Finaliza la simulación
    $finish;
  end

endmodule
