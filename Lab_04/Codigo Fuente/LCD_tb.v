`timescale 1ns / 1ps

module LCD_tb;
    reg clk;
    wire RS, E;
    wire D0, D1, D2, D3, D4, D5, D6, D7;
    
    // Instanciamos el módulo LCD
    LCD uut (
        .clk(clk),
        .RS(RS),
        .E(E),
        .D0(D0),
        .D1(D1),
        .D2(D2),
        .D3(D3),
        .D4(D4),
        .D5(D5),
        .D6(D6),
        .D7(D7)
    );
    
    // Generador de reloj
    always #5 clk = ~clk;
    
    initial begin
        // Inicialización
        clk = 0;
        
        // Ejecutamos la simulación por un tiempo determinado
        #1000;
        
        // Finalizar simulación
        $finish;
    end
    
    // Monitor para visualizar las señales
    initial begin
        $monitor("Time=%0t RS=%b E=%b D=%b%b%b%b%b%b%b%b", 
                 $time, RS, E, D7, D6, D5, D4, D3, D2, D1, D0);
    end
    
endmodule

