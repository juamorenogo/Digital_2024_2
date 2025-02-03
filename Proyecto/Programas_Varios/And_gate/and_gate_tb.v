`timescale 1ns / 1ps

module and_gate_tb;

reg [1:0] ins; // entradas
wire y;

//mapeo

wire a = ins[0];
wire b = ins[1];

//prueba

and_gate dut (
.a(a),
.b(b),
.y(y)
);

// Bloque inicial de estímulos
    initial begin
        // Configuración de salida para GTKWave
        $dumpfile("and_gate_tb.vcd");
        $dumpvars(0, dut);   // Volcar todas las señales del DUT


        for(ins = 0; ins != 4;ins = ins+1) begin
        #10;
        $display("I",ins);
        
        if (ins == 3) begin
        $finish(0);
        end
        
        end

        $finish(0);
    end

endmodule
