`timescale 1ns / 1ps

module tick_generator (
    input wire start,
    input wire clk,
    input wire reset,
    //output reg [14:0] tick_total,  // Total de ticks registrados
    output reg led1,               // LED para < 24000 ticks
    output reg led2                // LED para >= 24000 ticks
);

    // Parámetros
    localparam clk_f = 25000000;         // Frecuencia del reloj (25 MHz)
    localparam baud_rate = 9600.0;       // Frecuencia de ticks
    localparam integer div = clk_f / baud_rate; // Divisor -> 2604
    localparam w_div = $clog2(div + 1);

    // Máximo de ticks durante 5 segundos
    localparam max_ticks = 48000;          
    localparam w_maxticks = $clog2(max_ticks + 1);

    reg [w_div-1:0] counter;            // Contador para generar ticks
    reg [w_maxticks-1:0] ticks_counter; // Contador de ticks totales

    // Señal de tick
    wire tick = (counter == div);

    // Bloque secuencial para manejar el conteo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            ticks_counter <= 0;
            tick_total <= 0;
            led1 <= 0;
            led2 <= 0;
        end else if (!start) begin
            // Cuando el botón (start) vuelve a 0, almacena el total y decide qué LED encender
            tick_total <= ticks_counter; // Almacena el número total de ticks

            if (ticks_counter >= 24000) begin
                led2 <= 1; // Pulso largo
                led1 <= 0;
            end else begin
                led1 <= 1; // Pulso corto
                led2 <= 0;
            end

            // Reinicia los contadores
            counter <= 0;
            ticks_counter <= 0;
        end else begin
            // Incrementar el contador cuando el botón está presionado
            if (counter == div) begin
                counter <= 0;
                ticks_counter <= ticks_counter + 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
