`timescale 1ns / 1ps

module count_3 (
input wire clk,
input wire button,
output led1,
output led2,
output led3,
output ledb,
output led0,
output ledshort,
output led_up,
output ledlong
);
//--------------------------------
// Modulo Debouncer
reg PB_state, PB_down, PB_up ; // PB_STATE = 1 --> BOTON ABIERTO 
Debouncer pdb (
	.clk(clk),.PB(button), .PB_state(PB_state),
	.PB_down(PB_down), .PB_up(PB_up)
);
//--------------------------------
// Modulo ticks
wire start;
reg [3:0] ticks_press;

ticks_generator ticki (
.clk(clk),
.start(start),
.ticks(ticks_press)

);
//--------------------------------

reg [2:0] contador = 3'b000; 
reg start_signal = 1'b0;

always @(posedge clk) begin
// CONTADOR BINARIO
                if(PB_down) begin // Solo funciona con PB_down el contador wtf xd 
                        if (contador == 8) begin
                                contador <= 0;
                        end else begin
                                contador <= contador + 1;
                        end               
                end  

                if(PB_up) begin
                        $display("waowaowao");
                        //start_signal <= 1'b0;
                end

                if(PB_state) begin // BOTON ABIERTO = 1
                        start_signal <= 1'b0;

                        
                end else if(~PB_state) begin // BOTON CERRADO = 0
                        start_signal <= 1'b1;
                end

                  if(ticks_press == 12) begin
                        led_up <=1'b0;
                        led0 <= 1'b1;
                end else if (ticks_press == 3) begin
                        led_up <=1'b1;
                        led0 <= 1'b0;
                end else begin
                        led_up <=1'b0;
                        led0 <= 1'b0;
                end

end

assign led1 = contador[0]; 
assign led2 = contador[1]; 
assign led3 = contador[2]; 
assign start = start_signal;
//assign led0 = PB_up;
//assign ledb = PB_down; // No muestra nada, ya que no mantiene el estado perse
//assign led0 = ticks_press;
//assign led_up = PB_state;

//-------------------------------------------------


endmodule
