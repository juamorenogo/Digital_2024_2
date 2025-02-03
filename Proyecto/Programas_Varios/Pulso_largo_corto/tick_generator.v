`timescale 1ns / 1ps

module tick_generator (

input wire start,
input wire clk,
input wire reset,
output reg [14:0] tick_total 

);

    // Parámetros
    localparam clk_f = 25000000;          // Frecuencia del reloj (25 MHz)
    localparam baud_rate = 9600.0; 
    
    localparam integer div = clk_f / baud_rate; // Default --> 2604
    localparam w_div = $clog2(div + 1);
    
    localparam max_ticks = 9600;           
    localparam w_maxticks = $clog2(max_ticks +1);

    localparam tick_cada = 1.0 / baud_rate; 
    localparam duracion_total = tick_cada* max_ticks;
    
    reg [w_div-1:0] counter;
    reg [w_maxticks-1:0] ticks_counter; 
    

    // Señal de tick
    assign tick = (counter == div);

   // Bloque secuencial para manejar el conteo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            ticks_counter <= 0;
            tick_total <= 0;
        end else if (!start) begin
            // Cuando start vuelve a 0, almacena el total y reinicia el contador
            tick_total <= ticks_counter;
            counter <= 0;
            ticks_counter <= 0;
        end else begin
            // Contar ticks cuando start está en alto
            if (counter == div) begin
                counter <= 0;
                ticks_counter <= ticks_counter + 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule


