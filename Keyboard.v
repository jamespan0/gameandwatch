module Keyboard(CLOCK_50, Reset, PS2_CLK, PS2_DAT, Key);
	input CLOCK_50;
	input Reset;
	
	inout PS2_CLK;
	inout PS2_DAT;
	
	output reg [7:0]Key;
	
	wire [7:0]key_data;
	wire key_pressed;
	
	reg [7:0]memory;
	
	PS2_Controller PS2 (
		.CLOCK_50(CLOCK_50),
		.reset(Reset),
		.PS2_CLK(PS2_CLK),
		.PS2_DAT(PS2_DAT),
		.received_data(key_data),
		.received_data_en(key_pressed)
	);
	
	always @(posedge CLOCK_50) begin
		if (Reset) begin
			Key = 8'h00;
			memory = 8'h00;
		end else if(key_pressed) begin
			if (key_data == 8'hE0) begin
				Key = 8'h00;
			end else if (key_data == memory && key_data != 8'h00) begin
				Key = 8'h00;
			end else if (key_data == 8'hF0) begin
				memory = 8'hF0;
				Key = 8'hF0;
			end else if (memory == 8'hF0) begin
				Key = 8'h00;
				memory = 8'h00;
			end else begin
				Key = key_data;
				memory = key_data;
			end
		end else begin
			Key = 8'h00;
		end
	end
endmodule
