`timescale 1ns / 1ps

module baud_generator_tb;

    reg clk;               // Señal de reloj
    reg reset;             // Señal de reinicio
    wire tick;             // Salida del módulo: Tick generado

    // Instancia del módulo bajo prueba (DUT - Device Under Test)
    baud_generator dut (
        .clk(clk),
        .reset(reset),
        .tick(tick)        // Conecta correctamente el puerto tick
    );

    // Generación del reloj (25 MHz, período de 40 ns)
    initial begin
        clk = 0;
        forever #20 clk = ~clk; // Período de 40 ns
    end

    initial begin
     reset = 0;
     #5 reset = 1;
     #100 reset = 0;
    end

    // Bloque para generación de ondas .vcd
    initial begin
        $dumpfile("baud_generator_tb.vcd"); // Archivo de salida de ondas
        $dumpvars(0, baud_generator_tb);    // Captura todas las señales del módulo
        $display("Dumping waves to baud_generator_tb.vcd...");
    end

    // Generación de estímulos
    initial begin
        // Monitor para observar señales en la simulación
        $monitor("Time=%0t | Reset=%b | Tick=%b", $time, reset, tick);

        // Inicializa la señal de reinicio
        reset = 1;  // Activa el reinicio
        #100;       // Mantiene el reinicio activo por 100 ns
        reset = 0;  // Desactiva el reinicio
        #500000;    // Simula durante 500,000 ns para observar los ticks

        // Finaliza la simulación
        $display("Simulation finished.");
        $finish;
    end

endmodule
