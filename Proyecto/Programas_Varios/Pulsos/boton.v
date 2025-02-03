module boton (
    input wire clk,        // Reloj principal
    input wire button,     // Botón para detectar pulsaciones
    output reg [7:0] pulse_type  // Salida del tipo de pulso: "S", "M", o "L"
);

    // Parámetros
    parameter integer clk_f = 25000000;    // Frecuencia del reloj (25 MHz)
    parameter integer short_limit = clk_f / 2;  // Límite para pulsación corta (0.5 segundos)
    parameter integer long_limit = clk_f;       // Límite para pulsación larga (1 segundo)

    // Contadores
    reg [31:0] counter = 0;  // Contador para medir la duración del pulso
    reg button_prev = 0;     // Estado anterior del botón

    always @(posedge clk) begin
        if (button && !button_prev) begin
            // Inicio de una nueva pulsación
            counter <= 0;  // Reinicia el contador
        end else if (button) begin
            // Incrementa el contador mientras el botón esté presionado
            counter <= counter + 1;
        end else if (!button && button_prev) begin
            // Botón soltado, evalúa la duración
            if (counter < short_limit) begin
                pulse_type <= "S";  // Pulso corto
            end else if (counter >= long_limit) begin
                pulse_type <= "L";  // Pulso largo
            end else begin
                pulse_type <= "M";  // Pulso medio
            end
        end

        // Actualiza el estado anterior del botón
        button_prev <= button;
    end

endmodule
