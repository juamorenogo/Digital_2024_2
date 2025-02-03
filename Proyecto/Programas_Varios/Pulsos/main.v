module main (
    input wire clk,        // Reloj principal
    input wire button,     // Botón para detectar pulsaciones
    output wire tx         // Salida UART
);

    // Señal para el tipo de pulso
    wire [7:0] pulse_type;

    // Instancia del módulo de detección de pulsos
    boton #(
        .clk_f(25000000)
    ) detector_inst (
        .clk(clk),
        .button(button),
        .pulse_type(pulse_type)
    );

    // Señales UART
    reg send_uart = 0;
    wire uart_ready;

    // Instancia del módulo UART
    uart_tx uart_inst (
        .clk(clk),
        .data(pulse_type),
        .send(send_uart),
        .tx(tx),
        .ready(uart_ready)
    );

    // Enviar el tipo de pulso por UART cuando esté listo
    always @(posedge clk) begin
        if (uart_ready) begin
            send_uart <= 1; // Inicia la transmisión
        end else begin
            send_uart <= 0; // Finaliza la transmisión
        end
    end

endmodule
