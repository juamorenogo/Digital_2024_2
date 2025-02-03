module largo_corto (
    input wire button,
    input wire clk,
    input wire reset,
    output reg led2,
    output reg led3,
    output reg ledb
);

    
    wire tick;
    wire [13:0] tick_total;  // Salida de 14 bits del baud_generator
    reg [31:0] delay_counter; // Contador para manejar el retardo de 1 segundo
    reg delay_active;         // Señal para indicar si el retardo está activo

    // Parámetros para definir los rangos
    parameter short_ticks = 3840;
    parameter long_ticks = 4800;

    // Señal de inicio para el baud_generator
    wire start = button;
    reg ledb = button;
    // Indicación visual del estado del botón

    // Instancia del baud_generator
    tick_generator tick_gen (
        .start(start),
        .clk(clk),
        .reset(reset),
        .tick_total(tick_total)
    );

    // Lógica principal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led2 <= 0;
            led3 <= 0;
            delay_counter <= 0;
            delay_active <= 0;
        end else if (!delay_active) begin
            if (!button) begin
                // Evaluar los ticks cuando el botón se suelta
                if (tick_total <= short_ticks) begin
                    led2 <= 1;
                    delay_active <= 1;
                end else if (tick_total >= long_ticks) begin
                    led3 <= 1;
                    delay_active <= 1;
                end
            end
        end else begin
            // Contador para manejar el retardo de 1 segundo
            if (delay_counter == 25000000) begin // Asumiendo reloj de 25 MHz
                led2 <= 0;
                led3 <= 0;
                delay_counter <= 0;
                delay_active <= 0;
            end else begin
                delay_counter <= delay_counter + 1;
            end
        end
    end

endmodule
