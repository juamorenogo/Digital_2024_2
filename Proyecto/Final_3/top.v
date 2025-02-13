module top(    
	input wire clk,
	input wire clear_button,
	input wire button,
	input wire del_button,
	input wire fin_button,
	output ledshort,
	output lednull,
	output ledlong,
	output led_v1,
	output led_v2,
	output led_v3,
	output reg RS,
	output reg E,
	output reg D0,
	output reg D1,
	output reg D2,
	output reg D3,
	output reg D4,
	output reg D5,
	output reg D6,
	output reg D7,
	output led_1,
	output led_2,
	output led_3,
	output led_4,
	output led_5
);	
	reg [7:0] letra;
	reg dir_frst = 7'h05;                           
	reg dir_scnd = 7'h45;
	reg dir_thrd = 7'h19;
	reg top_state = 0;
	reg top_start;
	
	//Flags
	reg [1:0] clean_flag;
	reg [1:0] line_write_flag;
	
	localparam initiate_LCD = 1;
	
	clean clean_inst (
		.clk(clk),
		.clean_flag(clean_flag), //FLAG
		.RS(RS),
		.E(E),
		.D0(D0),
		.D1(D1),
		.D2(D2),
		.D3(D3),
		.D4(D4),
		.D5(D5),
		.D6(D6),
		.D7(D7)
	);

	morse_reader button_to_ascii (
		.clk(clk),
		.button(button),
		.del_button(del_button),
		.fin_button(fin_button),
		.ledshort(ledshort),
		.lednull(lednull),
		.ledlong(ledlong),
		.led_v1(led_v1),
		.led_v2(led_v2),
		.led_v3(led_v3),
		.led_1(led_1),
		.led_2(led_2),
		.led_3(led_3),
		.led_4(led_4),
		.led_5(led_5),
		.ascii(letra)
	);
	
	line_write line_write_inst (
		.clk(clk),
		.dir(dir_frst),
		.char(letra),
		.RS(RS),
		.line_write_flag(line_write_flag), //FLAG
		.E(E),
		.D0(D0),
		.D1(D1),
		.D2(D2),
		.D3(D3),
		.D4(D4),
		.D5(D5),
		.D6(D6),
		.D7(D7)
	);
	
	ticks_generator_LCD top_ticks (
		.clk(clk),
		.start(top_start),
		.ticks(ticks_wire)
	);
	
	always @(posedge clk) begin
		if (top_ticks_wire != top_prev_ticks) begin
			case (top_state)
				0: begin
					clean_flag<=2;
					top_state<=top_state+1;
				end
				1: begin
					line_write_flag<=2;
					top_state<=top_state+1;
				end
			endcase
		top_prev_ticks <= top_ticks_wire;
	end

endmodule
