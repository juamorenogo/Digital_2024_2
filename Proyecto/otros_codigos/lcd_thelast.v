module lcd_thelast (
    input             clk,      
    input             reset,    // reset asíncrono (activo en alto)
    input  [8*10-1:0] word,     // 10 caracteres de 8 bits cada uno
    output reg        RS,       //
    output reg        E,        //
    output reg [7:0]  DB        //
);

  parameter integer PULSE_WIDTH    = 10;    // duración del pulso de E (en ciclos de clk)
  parameter integer COMMAND_DELAY  = 20000; // retardo posterior a cada comando/dato (en ciclos de clk)
  parameter WORD_LEN = 10; // cantidad de caracteres a escribir (ajustado con el input, pero creo que lo podemos incrementar a más)

  //estados
  localparam S_FUNC_SET         = 0,
             S_FUNC_SET_PULSE   = 1,
             S_FUNC_SET_WAIT    = 2,
             S_CLEAR            = 3,
             S_CLEAR_PULSE      = 4,
             S_CLEAR_WAIT       = 5,
             S_RETURN_HOME      = 6,
             S_RETURN_HOME_PULSE= 7,
             S_RETURN_HOME_WAIT = 8,
             S_DISPLAY_ON       = 9,
             S_DISPLAY_ON_PULSE = 10,
             S_DISPLAY_ON_WAIT  = 11,
             S_WRITE            = 12,
             S_WRITE_PULSE      = 13,
             S_WRITE_WAIT       = 14,
             S_DONE             = 15;

  reg [3:0]  state;         // estado actual
  reg [31:0] delay_counter; // contador para los retardos
  reg [3:0]  char_index;    // indice del carácter que se está enviando (0 si no hay palabra hasta un máximo de 10)
  wire [7:0] char_to_send;
  assign char_to_send = word[8*char_index +: 8]; // slicing [base +: width]: word[8*char_index +: 8] extrae del bus "word" según el índice.

  // Máquina de estados
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reinicio: se inicia la secuencia de inicialización del LCD
      state         <= S_FUNC_SET;
      delay_counter <= 0;
      char_index    <= 0;
      RS            <= 0;
      E             <= 0;
      DB            <= 8'b0;
    end else begin
      case (state)
        //*****************************************************
        // 1. Enviar comando "Function Set": 8-bit, 1 LÍNEA (0x30)
        //*****************************************************
        S_FUNC_SET: begin
          RS            <= 1'b0;   // Comando
          DB            <= 8'h30;  // 0x30: función set para 8 bits, 1 línea
          E             <= 1'b0;   // Inicialmente en 0
          delay_counter <= PULSE_WIDTH; // Configuración del contador para el pulso
          state         <= S_FUNC_SET_PULSE;
        end
        S_FUNC_SET_PULSE: begin
          E <= 1'b1; // Activa el pulso de enable
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            E             <= 1'b0;  // Fin del pulso
            delay_counter <= COMMAND_DELAY; // Retardo para que el comando se asiente
            state         <= S_FUNC_SET_WAIT;
          end
        end
        S_FUNC_SET_WAIT: begin
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else
            state <= S_CLEAR;
        end

        //*****************************************************
        // 2. Enviar comando "Clear Display" (0x01)
        //*****************************************************
        S_CLEAR: begin
          RS            <= 1'b0;   // Comando
          DB            <= 8'h01;  // 0x01: clear display
          delay_counter <= PULSE_WIDTH;
          state         <= S_CLEAR_PULSE;
        end
        S_CLEAR_PULSE: begin
          E <= 1'b1;
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            E             <= 1'b0;
            delay_counter <= COMMAND_DELAY;
            state         <= S_CLEAR_WAIT;
          end
        end
        S_CLEAR_WAIT: begin
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else
            state <= S_RETURN_HOME;
        end

        //*****************************************************
        // 3. Enviar comando "Return Home" (0x02)
        //*****************************************************
        S_RETURN_HOME: begin
          RS            <= 1'b0;
          DB            <= 8'h02;  // 0x02: return home
          delay_counter <= PULSE_WIDTH;
          state         <= S_RETURN_HOME_PULSE;
        end
        S_RETURN_HOME_PULSE: begin
          E <= 1'b1;
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            E             <= 1'b0;
            delay_counter <= COMMAND_DELAY;
            state         <= S_RETURN_HOME_WAIT;
          end
        end
        S_RETURN_HOME_WAIT: begin
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else
            state <= S_DISPLAY_ON;
        end

        //*****************************************************
        // 4. Enviar comando "Display On, no cursor" (0x0C)
        //*****************************************************
        S_DISPLAY_ON: begin
          RS            <= 1'b0;
          DB            <= 8'h0C;  // 0x0C: display on, cursor off
          delay_counter <= PULSE_WIDTH;
          state         <= S_DISPLAY_ON_PULSE;
        end
        S_DISPLAY_ON_PULSE: begin
          E <= 1'b1;
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            E             <= 1'b0;
            delay_counter <= COMMAND_DELAY;
            state         <= S_DISPLAY_ON_WAIT;
          end
        end
        S_DISPLAY_ON_WAIT: begin
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            // Una vez configurado el LCD, se inicia el envío de la palabra.
            char_index <= 0;
            state <= S_WRITE;
          end
        end

        //*****************************************************
        // 5. Enviar letra por letra (RS=1)
        //*****************************************************
        S_WRITE: begin
          if (char_index < WORD_LEN) begin
            RS <= 1'b1;         // Se envía dato
            // Se asigna el carácter a enviar, convertido a mayúsculas
            DB <= char_to_send;
            delay_counter <= PULSE_WIDTH;
            state <= S_WRITE_PULSE;
          end else begin
            // Si se han enviado todos los caracteres, se finaliza.
            state <= S_DONE;
          end
        end
        S_WRITE_PULSE: begin
          E <= 1'b1;
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            E             <= 1'b0;
            delay_counter <= COMMAND_DELAY;
            state         <= S_WRITE_WAIT;
          end
        end
        S_WRITE_WAIT: begin
          if (delay_counter != 0)
            delay_counter <= delay_counter - 1;
          else begin
            char_index <= char_index + 1;  // Avanza al siguiente carácter
            state <= S_WRITE;
          end
        end

        //*****************************************************
        // 6. Estado final: proceso terminado
        //*****************************************************
        S_DONE: begin
          // Se mantienen las señales en reposo.
          RS <= 1'b0;
          E  <= 1'b0;
          DB <= 8'b0;
        end

        default: state <= S_DONE;
      endcase
    end
  end

endmodule
