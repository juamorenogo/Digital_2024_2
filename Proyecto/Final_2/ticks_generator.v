`timescale 1ns / 1ps

module ticks_generator (
    input clk,          // Señal de reloj
    input start,        // Señal de inicio (botón presionado)
	input reg baud_rate_1,
    output reg [16:0] ticks  // Salida de los ticks generados
);

    // Parámetros
    localparam clk_f = 25000000;          // Frecuencia del reloj (25 MHz)
    localparam baud_rate = baud_rate_1; 
    
    localparam integer div = clk_f / baud_rate; // Divisor para obtener la frecuencia deseada (9600 baudios) 2604
    localparam w_div = $clog2(div + 1); // 12 con 9600 y 25Mhz
    
    localparam max_ticks = 96000;           
    localparam w_maxticks = $clog2(max_ticks + 1); // 17 con 96000
    
    // Registros internos
    reg [w_div-1:0] counter;       // Contador para el número de ciclos de reloj sub_ticks --> (2604) [11:0]
    reg [w_maxticks-1:0] ticks_counter; // Contador de los ticks generados (1) --> 96000    [16:0]

    /*
    always @(posedge clk) begin // ENCIENDE LED POR BOTON CERRADO
        if(start) begin
            ticks <= 4'b1100; 
        end else if (~start) begin // APAGA LED POR BOTON ABIERTO
            ticks <= 4'b0011; 
        end
    end
    */

    always @(posedge clk) begin
    if (start) begin
        ticks <= ticks_counter;
        //ticks <= 17'b1;
         if (ticks_counter < max_ticks) begin
            if (counter == div) begin
                    counter <= 0;
                    ticks_counter <= ticks_counter + 1;
            end else begin
                    counter <= counter + 1;
            end
        end
        
    end else if (~start) begin
        ticks <= 17'b0;
        ticks_counter <= 0;
        counter <= 0;
    end
end
endmodule
