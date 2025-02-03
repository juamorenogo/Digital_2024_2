module pro (
    input wire clk,   // Reloj de entrada desde el pin 60
    input wire button,
    output reg led,   // Salida para controlar el LED en el pin 141
    output reg led1,
    output reg led2,
    output reg led3
);

    assign led2 = button;
    // Parámetros
    parameter clk_f = 25000000;  // Frecuencia del reloj 
    parameter t_blink = 1;    // Período total del parpadeo en segundos

    // Calcular el número de ciclos del reloj para 1 segundo
    localparam  integer counter_max = clk_f * (t_blink);

    // Determinar el ancho necesario para el contador
    
    localparam counter_width = $clog2(counter_max + 1); // Determina los bits necesarios

    // Contador
    reg [counter_width-1:0] counter = 0;

    always @(posedge clk) begin
        if (counter < counter_max - 1) begin
            counter <= counter + 1; // Incrementa el contador
        end else begin
            counter <= 0;          // Reinicia el contador
            led <= ~led;           // Invierte el estado del LED
            led1 <= ~led1;           // Invierte el estado del LED
            led3 <= ~led3;           // Invierte el estado del LED
        end
    //$display("Time: %0t | Counter: %0d | LED : %b",$time,counter,led);
    end

endmodule
