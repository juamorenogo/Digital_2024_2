module main (
    input wire clk,         // Reloj del sistema
    input wire reset,       // Botón de reset
    input wire btn,         // Botón para cambiar el mensaje transmitido
    input wire rx,          // UART RX
    output wire tx,         // UART TX
    output reg led          // LED indicador
);

    // Declaración de los mensajes como `reg`
    reg [7:0] apagado [0:7];
    reg [7:0] encendido [0:9];

    // Inicialización de los mensajes
    initial begin
        // Mensaje "Apagado"
        apagado[0] = 8'h41; // 'A'
        apagado[1] = 8'h70; // 'p'
        apagado[2] = 8'h61; // 'a'
        apagado[3] = 8'h67; // 'g'
        apagado[4] = 8'h61; // 'a'
        apagado[5] = 8'h64; // 'd'
        apagado[6] = 8'h6F; // 'o'
        apagado[7] = 8'h20; // ' '

        // Mensaje "Encendido"
        encendido[0] = 8'h45; // 'E'
        encendido[1] = 8'h6E; // 'n'
        encendido[2] = 8'h63; // 'c'
        encendido[3] = 8'h65; // 'e'
        encendido[4] = 8'h6E; // 'n'
        encendido[5] = 8'h64; // 'd'
        encendido[6] = 8'h69; // 'i'
        encendido[7] = 8'h64; // 'd'
        encendido[8] = 8'h6F; // 'o'
        encendido[9] = 8'h20; // ' '
    end

    reg [3:0] char_index;   // Índice para caracteres
    reg tx_start;
    reg [7:0] tx_data;
    wire tx_busy;

    // Instancia del transmisor UART
    uart_tx tx_inst (
        .clk(clk),
        .reset(reset),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy)
    );

    // Receptor UART
    wire [7:0] rx_data;
    wire rx_ready;
    uart_rx rx_inst (
        .clk(clk),
        .reset(reset),
        .rx(rx),
        .rx_data(rx_data),
        .rx_ready(rx_ready)
    );

    // FSM para transmisión continua
    reg [1:0] tx_state;
    localparam TX_IDLE = 2'b00, TX_SEND = 2'b01, TX_NEXT = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            tx_state <= TX_IDLE;
            char_index <= 0;
            tx_start <= 0;
            tx_data <= 8'h00;
        end else begin
            case (tx_state)
                TX_IDLE: begin
                    if (!tx_busy) begin
                        tx_start <= 1;
                        if (btn) begin
                            tx_data <= encendido[char_index];
                        end else begin
                            tx_data <= apagado[char_index];
                        end
                        tx_state <= TX_SEND;
                    end else begin
                        tx_start <= 0;
                    end
                end
                TX_SEND: begin
                    tx_start <= 0;
                    tx_state <= TX_NEXT;
                end
                TX_NEXT: begin
                    if (!tx_busy) begin
                        char_index <= char_index + 1;
                        if (btn) begin
                            if (char_index == 9) char_index <= 0;
                        end else begin
                            if (char_index == 7) char_index <= 0;
                        end
                        tx_state <= TX_IDLE;
                    end
                end
            endcase
        end
    end

    // FSM para recepción de "Encendido"
    reg [3:0] rx_char_index;
    reg [9:0] rx_match; // Registros para verificar el mensaje completo
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led <= 0;
            rx_char_index <= 0;
            rx_match <= 10'b0;
        end else if (rx_ready) begin
            // Verificar coincidencia carácter por carácter
            if (rx_data == encendido[rx_char_index]) begin
                rx_match[rx_char_index] <= 1'b1;
                rx_char_index <= rx_char_index + 1;
                if (rx_char_index == 9) begin
                    rx_char_index <= 0;
                    if (&rx_match[9:0]) begin
                        led <= 1; // Enciende el LED si "Encendido" es recibido completo
                    end
                    rx_match <= 10'b0;
                end
            end else begin
                rx_char_index <= 0;
                rx_match <= 10'b0; // Reinicia si hay un error
            end
        end
    end
endmodule

