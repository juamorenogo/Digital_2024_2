module uart_rx (
    input wire clk,          // Reloj del sistema
    input wire reset,        // Reset del sistema
    input wire rx,           // Línea de recepción UART
    output reg [7:0] rx_data,// Datos recibidos
    output reg rx_ready      // Indicador de datos recibidos
);

parameter BAUD_RATE = 9600;
parameter CLK_FREQ = 25000000; // Frecuencia del reloj en Hz
parameter BAUD_TICK = CLK_FREQ / BAUD_RATE;
parameter HALF_BAUD_TICK = BAUD_TICK / 2;

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
        rx_ready <= 1'b0;
        baud_counter <= 0;
        bit_index <= 0;
        shift_reg <= 0;
    end else begin
        case (state)
            IDLE: begin
                rx_ready <= 1'b0;
                if (rx == 1'b0) begin // Detecta bit de inicio
                    state <= START_BIT;
                    baud_counter <= 0;
                end
            end
            START_BIT: begin
                if (baud_counter < HALF_BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    state <= DATA_BITS;
                end
            end
            DATA_BITS: begin
                if (baud_counter < BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    shift_reg <= {rx, shift_reg[7:1]};
                    if (bit_index < 7) begin
                        bit_index <= bit_index + 1;
                    end else begin
                        bit_index <= 0;
                        state <= STOP_BIT;
                    end
                end
            end
            STOP_BIT: begin
                if (baud_counter < BAUD_TICK - 1) begin
                    baud_counter <= baud_counter + 1;
                end else begin
                    baud_counter <= 0;
                    rx_data <= shift_reg;
                    rx_ready <= 1'b1;
                    state <= IDLE;
                end
            end
        endcase
    end
end

endmodule

