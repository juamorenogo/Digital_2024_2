module uart_tx(
    input wire clk,           // Reloj principal
    input wire [7:0] data,    // Dato a transmitir
    input wire send,          // Señal para iniciar la transmisión
    output reg tx,            // Línea de transmisión UART
    output reg ready          // Señal para indicar que está listo para enviar más datos
);

    parameter CLK_FREQ = 25000000; // Frecuencia del reloj en Hz
    parameter BAUD_RATE = 9600;   // Velocidad en baudios

    localparam integer DIV = CLK_FREQ / BAUD_RATE;
    localparam integer BIT_COUNT = 10; // 1 start bit + 8 data bits + 1 stop bit

    reg [15:0] baud_counter = 0;
    reg [3:0] bit_index = 0;
    reg [BIT_COUNT-1:0] shift_reg = 0;
    reg sending = 0;

    always @(posedge clk) begin
        if (!sending && send) begin
            // Inicia la transmisión
            shift_reg <= {1'b1, data, 1'b0}; // Stop bit, data, start bit
            bit_index <= 0;
            sending <= 1;
            ready <= 0;
        end

        if (sending) begin
            if (baud_counter < DIV - 1) begin
                baud_counter <= baud_counter + 1;
            end else begin
                baud_counter <= 0;
                tx <= shift_reg[0]; // Envía el bit menos significativo
                shift_reg <= shift_reg >> 1; // Desplaza el siguiente bit
                bit_index <= bit_index + 1;

                if (bit_index == BIT_COUNT - 1) begin
                    sending <= 0; // Finaliza la transmisión
                    ready <= 1;   // Marca listo para otra transmisión
                end
            end
        end
    end
endmodule
