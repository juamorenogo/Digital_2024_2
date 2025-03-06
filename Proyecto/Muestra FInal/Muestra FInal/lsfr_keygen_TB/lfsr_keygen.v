module lfsr_keygen (
    input wire clk,
    input wire clear,        // Botón clear
    input wire [7:0] key_work, // Key base 
    output reg [7:0] key_out   // Nueva Key (afuera del módulo, sobreescribir esta llave a la antigua)
);
    
    reg [7:0] lfsr;
    wire feedback;
    
    assign feedback = lfsr[4] ^ lfsr[3]; //XOR de retroalimentación con bit 5 y 4.
    
    always @(posedge clk) begin
        if (clear) begin
            lfsr <= key_work;  // Reset LFSR with the base key
            lfsr <= {lfsr[6:0], feedback}; // Shift with feedback
            key_out <= lfsr; // Update key output
        end else begin
			key_out <= key_work
		end
    end
    
endmodule
