module Splash(
	Key,
	Reset, Enable, Clock,
	VGAx, VGAy, VGAcol,
	AUD_ADCDAT,AUD_BCLK,AUD_ADCLRCK,AUD_DACLRCK,AUD_DACDAT,I2C_SCLK,I2C_SDAT,AUD_XCK,
	Konami, Quit, Progress);
	
	input [7:0]Key;
	input Reset;
	input Enable;
	input Clock;
	input [8:0]VGAx;
	input [7:0]VGAy;
	
	output VGAcol;
	output Konami;
	output Quit;
	
	input AUD_ADCDAT;
	inout AUD_BCLK;
	inout AUD_ADCLRCK;
	inout AUD_DACLRCK;
	inout I2C_SDAT;
	output AUD_XCK;
	output AUD_DACDAT;
	output I2C_SCLK;
	
	output reg [3:0]Progress;
	
	reg [11:0]audiotime;
	reg [14:0]frame;
	parameter audiomax = 12'd3125;
	parameter audioframes = 16'h49EF;
	wire [31:0]audiolevel;
	
	SplashSound splash_sound(frame, Clock, audiolevel);

	Audio_Controller aud(
		.CLOCK_50(Clock),
		.reset(Reset),
		.left_channel_audio_out (audiolevel),
		.right_channel_audio_out (0),
		.write_audio_out (audiotime == 0),
		.AUD_ADCDAT (AUD_ADCDAT),
		.AUD_BCLK (AUD_BCLK),
		.AUD_ADCLRCK (AUD_ADCLRCK),
		.AUD_DACLRCK (AUD_DACLRCK),
		.AUD_XCK (AUD_XCK),
		.AUD_DACDAT (AUD_DACDAT)
	);	
	avconf #(.USE_MIC_INPUT(1)) avc (
		.I2C_SCLK (I2C_SCLK),
		.I2C_SDAT (I2C_SDAT),
		.CLOCK_50 (Clock),
		.reset (Reset)
	);
	
	always @ (posedge Clock) begin
		if (Reset) begin
			Progress = 0;
			audiotime = 0;
			frame = 0;
		end else if (Enable) begin
			audiotime = audiotime + (frame < audioframes);
			if (audiotime == audiomax) begin
				audiotime = 0;
				frame = frame + 1;
			end
			if (Key != 8'h5A && Key != 8'h00 && Key != 8'hF0) begin
				case (Progress)
					4'b0000: Progress = (Key == 8'h75) ? 4'b0001 : 4'b0000;
					4'b0001: Progress = (Key == 8'h75) ? 4'b0010 : 4'b0000;
					4'b0010: Progress = (Key == 8'h72) ? 4'b0011 : {2'b00, (Key == 8'h75), 1'b0};
					4'b0011: Progress = (Key == 8'h72) ? 4'b0100 : {3'b000, (Key == 8'h75)};
					4'b0100: Progress = (Key == 8'h6B) ? 4'b0101 : {3'b000, (Key == 8'h75)};
					4'b0101: Progress = (Key == 8'h74) ? 4'b0110 : {3'b000, (Key == 8'h75)};
					4'b0110: Progress = (Key == 8'h6B) ? 4'b0111 : {3'b000, (Key == 8'h75)};
					4'b0111: Progress = (Key == 8'h74) ? 4'b1000 : {3'b000, (Key == 8'h75)};
					4'b1000: Progress = (Key == 8'h32) ? 4'b1001 : {3'b000, (Key == 8'h75)};
					4'b1001: Progress = (Key == 8'h1C) ? 4'b1010 : {3'b000, (Key == 8'h75)};
				endcase
			end
		end
	end
	
	assign Quit = (Key == 8'h5A);
	assign Konami = (Progress == 4'b1010);
	
	SplashSprite splash_sprite((320*VGAy + VGAx), Clock, VGAcol);
endmodule

module SplashSprite(address,clock,q);
	input	[16:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Splash.mif",
		altsyncram_component.numwords_a = 76800,
		altsyncram_component.widthad_a = 17,
		altsyncram_component.width_a = 1;
endmodule

module SplashSound(address,clock,q);
	input	[14:0]address;
	input clock;
	output [31:0]q;
	tri1	  clock;
	wire [31:0] sub_wire0;
	wire [31:0] q = sub_wire0[31:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Announcer.mif",
		altsyncram_component.numwords_a = 18932,
		altsyncram_component.widthad_a = 15,
		altsyncram_component.width_a = 32;
endmodule
