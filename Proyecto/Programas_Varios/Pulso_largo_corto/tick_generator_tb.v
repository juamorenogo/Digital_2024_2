module tick_generator_tb;

    reg clk;
    reg reset;
    reg start;
    wire [14:0] tick_total;

    // Instancia del baud_generator
    tick_generator uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .tick_total(tick_total)
    );

    // Generador de reloj (25 MHz)
    initial begin
        clk = 0;
        forever #20 clk = ~clk; // Período de 40 ns
    end

    // Estímulos de prueba
    initial begin
        reset = 1;
        start = 0;
        #100 reset = 0;

        #200 start = 1;    // Inicia el conteo
        #1000000000 start = 0;
    end

    // Monitor de la salida
    initial begin
        $monitor("Time=%0t | Start=%b | Ticks=%d", $time, start, tick_total);
    end
endmodule
