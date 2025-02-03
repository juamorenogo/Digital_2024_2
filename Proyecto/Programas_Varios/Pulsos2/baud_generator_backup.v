`timescale 1ns / 1ps
module baud_generator (
);

    // Entradas y salidas
    reg clk;               // Señal de reloj
    reg reset;             // Señal de reinicio
    wire tick;             // Salida del tick generado
    // Parámetros
    localparam clk_f = 25000000;          // Frecuencia del reloj (25 MHz)
    localparam baud_rate = 9600.0; 
    
    localparam integer div = clk_f / baud_rate; // Default --> 2604
    localparam w_div = $clog2(div + 1);
    
    localparam max_ticks = 96000;           
    localparam w_maxticks = $clog2(max_ticks +1);

    localparam tick_cada = 1.0 / baud_rate; 
    localparam duracion_total = tick_cada* max_ticks;
    
    reg [w_div-1:0] counter;
    reg [w_maxticks-1:0] ticks_counter; 
    
    // Bloque secuencial para manejar el contador
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            ticks_counter <= 0;
        end else if (ticks_counter < max_ticks) begin
            if (counter == div) begin
                counter <= 0;
                ticks_counter <= ticks_counter + 1;
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // Generación del reloj (25 MHz, período de 40 ns)
    initial begin
        clk = 0; 
        forever #20 clk = ~clk; // Período de 40 ns
    end

    // Generación de estímulos para reset
    initial begin
        reset = 1;  // Activa el reinicio
        #100 reset = 0;  // Desactiva el reinicio
    end

reg [31:0] simulated_time; // Tiempo total simulado en nanosegundos

// Incrementa el tiempo simulado en cada ciclo de reloj
always @(posedge clk or posedge reset) begin
    if (reset)
        simulated_time <= 0;
    else
        simulated_time <= simulated_time + 40; // Incrementa 40 ns por ciclo
end

// Bloque para verificar la duración total
initial begin
    //wait (ticks_counter == max_ticks); 
    $display("----------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    $display("Tiempo total simulado: %0d ns", simulated_time); // Muestra el tiempo total
    $display("w_maxticks: %0d", w_div);
    $display("----------------------------------------------------------------------------------------------------------------------------------------------------------------------");
    #20
    $finish(0);
end
endmodule


