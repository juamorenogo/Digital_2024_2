module LCD_1(
    input clk,
    output rs, rw, ena,
    output [7:0] dat
);

    parameter COUNT_MAX = 800000 ;
    parameter INIT = 0;

    reg [7:0] data;
    reg rs_reg, rw_reg;
    reg [$clog2(COUNT_MAX)-1:0] counter;
    reg [5:0] current, next;
    reg clkr;

    initial begin
        data = 0;
        rs_reg = 0;
        rw_reg = 0;
        counter = 0;
        current = 0;
        next = 0;
        clkr = 0;
    end

    always @(posedge clk) begin
        if (counter == COUNT_MAX-1) begin
            clkr <= ~clkr;
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end
    end

    always @(posedge clkr) begin
        current <= next;
        case (current)
        INIT: begin rs_reg <= 0; data <= 8'h38; next <= 1; end
        1: begin rs_reg <= 0;  data <= 8'h06; next <= 2; end
        2: begin rs_reg <= 0;  data <= 8'h0c; next <= 3; end
        3: begin rs_reg <= 0;  data <= 8'h01; next <= 4; end
        4: begin rs_reg <= 1;  data <= "H"; next <= 5; end
        5: begin rs_reg <= 1;  data <= "o"; next <= 6; end
        6: begin rs_reg <= 1;  data <= "l"; next <= 7; end
        7: begin rs_reg <= 1;  data <= "a"; next <= 8; end
        8: begin rs_reg <= 1;  data <= " "; next <= 9; end
        9: begin rs_reg <= 1;  data <= "b"; next <= 10; end
        10: begin rs_reg <= 1;  data <= "i"; next <= 11; end
        11: begin rs_reg <= 1;  data <= "e"; next <= 12; end
        12: begin rs_reg <= 1;  data <= "n"; next <= 13; end
        13: begin rs_reg <= 1;  data <= "v"; next <= 14; end
        14: begin rs_reg <= 1;  data <= "e"; next <= 15; end
        15: begin rs_reg <= 1;  data <= "n"; next <= 16; end
        16: begin rs_reg <= 1;  data <= "i"; next <= 17; end
        17: begin rs_reg <= 1;  data <= "d"; next <= 18; end
        18: begin rs_reg <= 1;  data <= "o"; next <= 19; end
        19: begin rs_reg <= 1;  data <= "s"; next <= 20; end
        20: begin rs_reg <= 0;  data <= 8'hC0; next <= 21; end
        21: begin rs_reg <= 1;  data <= "1"; next <= 22; end
        22: begin rs_reg <= 1;  data <= "2"; next <= 23; end
        23: begin rs_reg <= 1;  data <= "3"; next <= 24; end
        24: begin rs_reg <= 1;  data <= "4"; next <= 25; end
        25: begin rs_reg <= 1;  data <= "5"; next <= INIT; end
            default: next = INIT;
        endcase
    end

    assign ena= clkr;
    assign rs = rs_reg;
    assign rw = rw_reg;
    assign dat = data;

endmodule 
