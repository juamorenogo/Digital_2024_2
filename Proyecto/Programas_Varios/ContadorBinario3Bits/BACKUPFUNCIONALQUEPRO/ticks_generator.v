`timescale 1ns / 1ps

module ticks_generator (
    input clk,          // Señal de reloj
    input start,        // Señal de inicio (botón presionado)
    output reg [3:0] ticks  // Salida de los ticks generados
);

    // Parámetros
    localparam clk_f = 25000000;          // Frecuencia del reloj (25 MHz)
    localparam baud_rate = 9600.0; 
    
    localparam integer div = clk_f / baud_rate; // Divisor para obtener la frecuencia deseada (9600 baudios)
    localparam w_div = $clog2(div + 1);
    
    localparam max_ticks = 10;           
    localparam w_maxticks = $clog2(max_ticks + 1);
    
    // Registros internos
    reg [w_div-1:0] counter;       // Contador para el número de ciclos de reloj
    reg [w_maxticks-1:0] ticks_counter; // Contador de los ticks generados

    
    always @(posedge clk) begin // ENCIENDE LED POR BOTON CERRADO
        if(start) begin
            ticks <= 4'b1100; 
        end else if (~start) begin // APAGA LED POR BOTON ABIERTO
            ticks <= 4'b0011; 
        end
    end

endmodule
