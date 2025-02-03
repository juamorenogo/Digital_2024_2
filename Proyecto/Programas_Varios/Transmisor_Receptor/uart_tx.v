module uart_tx (
    input wire clk,          // Reloj del sistema
    input wire reset,        // Reset del sistema
    input wire tx_start,     // Señal para iniciar la transmisión
    input wire [7:0] tx_data,// Datos a transmitir
    output reg tx,           // Línea de transmisión UART
    output reg tx_busy       // Indicador de transmisión en curso
);

parameter BAUD_RATE = 9600;
parameter CLK_FREQ = 25000000; // Frecuencia del reloj en Hz
parameter BAUD_TICK = CLK_FREQ / BAUD_RATE;

// Estados de la máquina de estados
localparam IDLE = 0;
localparam START_BIT = 1;
localparam DATA_BITS = 2;
localparam STOP_BIT = 3;

reg [1:0] state = IDLE;
reg [15:0] baud_counter = 0;
reg [2:0] bit_index = 0;
reg [7:0] shift_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        tx <= 1'b1; // Línea UART inactiva (nivel alto)
        tx_busy <= 1'b0;
        baud_counter <= 0;
        bit_index <= 0;
    end else begin
        case (state)
            IDLE: begin
                tx <= 1'b1;
                tx_busy <= 1'b0;
                if (tx_start) begin
                    shift_reg <= tx_data;
                    tx_busy <= 1'b1;
                    state <= START_BIT;
                end
            end
            START_BIT: begin
                tx <= 1'b0; // Bit de inicio
                if (baud_counter < BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    state <= DATA_BITS;
                end
            end
            DATA_BITS: begin
                tx <= shift_reg[bit_index];
                if (baud_counter < BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    if (bit_index < 7) begin
                        bit_index <= bit_index + 1;
                    end else begin
                        bit_index <= 0;
                        state <= STOP_BIT;
                    end
                end
            end
            STOP_BIT: begin
                tx <= 1'b1; // Bit de parada
                if (baud_counter < BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    state <= IDLE;
                    tx_busy <= 1'b0;
                end
            end
        endcase
    end
end

endmodule

