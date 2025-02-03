module baud_generator;

    // Entradas y salidas
    reg clk;               // Señal de reloj
    reg reset;             // Señal de reinicio
    reg [11:0] counter;    // Contador interno
    reg [3:0] ticks_counter; // Contador de ticks
    wire tick;             // Salida del tick generado

    // Parámetros
    localparam clk_f = 25000000;          // Frecuencia del reloj (25 MHz)
    localparam baud_rate = 9600;         // Baud rate deseado
    localparam div = clk_f / baud_rate;  // Calcula el divisor (2604)
    localparam max_ticks = 10;           // Número total de ticks a generar

    // Señal de tick
    assign tick = (counter == div);

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

    // Monitor para depurar
    initial begin
        $monitor("Time=%0t | Reset=%b | Tick=%b | Counter=%d | Ticks Counter=%d", 
                 $time, reset, tick, counter, ticks_counter);
        #50000000 $finish; 
    end

endmodule


