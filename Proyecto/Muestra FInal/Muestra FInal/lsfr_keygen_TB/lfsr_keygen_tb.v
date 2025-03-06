`timescale 1ns / 1ps

module lfsr_keygen_tb;

    reg clk;
    reg clear;
    reg [7:0] key_work;
    wire [7:0] key_out;

    // Instancia del módulo bajo prueba (DUT: Device Under Test)
    lfsr_keygen uut (
        .clk(clk),
        .clear(clear),
        .key_work(key_work),
        .key_out(key_out)
    );

    // Generación del reloj
    always #5 clk = ~clk; // Periodo de 10ns (100MHz)

    initial begin
        // Inicialización
        clk = 0;
        clear = 0;
        key_work = 8'b10101010; // Clave inicial

        // Inicio de la prueba
        #10 clear = 1; // Activar reset
        #10 clear = 0; // Desactivar reset
        
        // Varias iteraciones para ver el LFSR en acción
        repeat (10) #10;
        
        // Fin de la simulación
        #50 $finish;
    end

    // Guardar resultados para GTKWave
    initial begin
        $dumpfile("lfsr_keygen_tb.vcd");
        $dumpvars(0, tb_lfsr_keygen);
    end

endmodule
