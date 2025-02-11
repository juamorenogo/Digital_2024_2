module xor_cipher (
    input  wire [7:0] key,      // Llave actual funcional
    input  wire [7:0] ascii,  // Letra en código ascii 8bits
    output wire [7:0] ciphered  // letra encriptada con la llave actual
);
    
    assign ciphered = key ^ ascii; // Encriptación xor
    
endmodule
