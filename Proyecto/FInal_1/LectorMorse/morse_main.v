`timescale 1ns / 1ps

module morse_main (
input wire clk,
input wire button,
input wire del_button,
input wire fin_button,
output led0,
output led1,
output led2,
output led3,
output led4,
output led_v1,
output led_v2,
output led_v3,
output ledshort,
output lednull,
output ledlong
);
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Modulo Debouncer de boton principal
reg PB_state, PB_down, PB_up ; // PB_STATE = 1 --> BOTON ABIERTO 
Debouncer pdb (
	.clk(clk),.PB(button), .PB_state(PB_state),
	.PB_down(PB_down), .PB_up(PB_up)
);
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Modulo Debouncer de boton del_button
reg PB_state_del, PB_down_del, PB_up_del ; // PB_STATE = 1 --> BOTON ABIERTO 
Debouncer pdb_del (
	.clk(clk),.PB(del_button), .PB_state(PB_state_del),
	.PB_down(PB_down_del), .PB_up(PB_up_del)
);
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Modulo Debouncer de boton fin_button
reg PB_state_fin, PB_down_fin, PB_up_fin ; // PB_STATE = 1 --> BOTON ABIERTO 
Debouncer pdb_fin (
	.clk(clk),.PB(fin_button), .PB_state(PB_state_fin),
	.PB_down(PB_down_fin), .PB_up(PB_up_fin)
);
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


// Modulo ticks
wire start;
reg [16:0] ticks_press;

ticks_generator ticki (
.clk(clk),
.start(start),
.ticks(ticks_press)

);
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Logica de guardado de letra morse (1) --> Maximo de bits necesarios por letra : 5
// Pulso corto = 0
// Pulso Largo = 1

reg [9:0] letra = 5'b00000_00000; // 5'b11111
reg [2:0] control1 = 3'b000; 

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
// Logica CORTO - LARGO
reg [2:0] contador = 3'b000; 
reg start_signal = 1'b0;

always @(posedge clk) begin
// PULSO LARGO - CORTO 
  //Señal de inicio 
                if(PB_state & ~PB_down) begin // BOTON ABIERTO = 1
                        start_signal <= 1'b0;

                        
                end else if(~(PB_state & ~PB_down)) begin // BOTON CERRADO = 0
                        start_signal <= 1'b1;
                end

  // Logica de tipo de pulso
  // Logica de reset de letra
  //LOGICA AL BORRAR
                if(PB_down_del) begin 
                                
                                letra <= {2'b00, letra[4:2]};
                                
   //LOGICA SIN BORRAR                             
                end else if (PB_state_del & ~PB_down_del) begin               
  
                                led_v1 <= 1'b0;
                                
                                if (ticks_press > 17'b0 &&  ticks_press < 2000) begin // PULSO CORTO 10
                                                ledshort <=1'b1;
                                                ledlong <= 1'b0;
                                                lednull <= 1'b0;
                                                if(PB_down) begin
                                                                letra <= {letra[7:0], 2'b10 }; // Operacion de concatenacion y desplazamiento
                                                end
                                end else if(ticks_press >= 4000 && ticks_press <= 7000 ) begin // PULSO LARGO 11
                                                ledshort <=1'b1;
                                                ledlong <= 1'b1;
                                                lednull <= 1'b0;
                                                if(PB_down) begin
                                                                letra <= {letra[7:0], 2'b11 }; // Operacion de concatenacion y desplazamiento
                                                end
                                end else if (ticks_press > 7000) begin // PULSO VACIO 00
                                                ledshort<= 1'b1;
                                                ledlong <= 1'b1;
                                                lednull <= 1'b1;
                                                if(PB_down) begin
                                                                letra <= {letra[7:0], 2'b00 }; // Operacion de concatenacion y desplazamiento
                                                end
                                end else if (ticks_press == 0) begin 
                                                ledshort<= 1'b0;
                                                ledlong <= 1'b0;
                                                lednull <= 1'b0;
                                end
                end


// BINARIOS A LETRA

                if(PB_down_fin) begin // LOGICA DE ENVIO DE VECTOR PARA SU TRADUCCION
                                $display("awa");
                end else if (PB_state_fin & ~PB_down_fin) begin
                                led_v3 = 1'b0;
                end   
                
//Para prendido y apagado 
                if(~PB_state_del) begin
                                led_v1 <= 1'b1;
                end

                 if(~PB_state_fin) begin
                                led_v3 <= 1'b1;
                end
            
end
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Asignaciones varias
assign start = start_signal;

//Asignaciones leds variables
assign led_v2 = button;
//assign led_v1 = del_button;
//assign led_v3 = fin_button;

//Asignaciones leds funcionales


assign led0 = letra[4];
assign led1 = letra[3];
assign led2 = letra[2];
assign led3 = letra[1];
assign led4 = letra[0];


//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


endmodule
