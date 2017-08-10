module GameAndWatch(CLOCK_50, KEY,
		VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B,
		PS2_CLK, PS2_DAT,
	AUD_ADCDAT,
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,
	I2C_SDAT,
	AUD_XCK,
	AUD_DACDAT,
	I2C_SCLK,
		LEDR,
		HEX5, HEX4, HEX3, HEX2, HEX1, HEX0
	);
	
	input CLOCK_50;
	input [3:0]KEY;
	
	output VGA_CLK;
	output VGA_HS;
	output VGA_VS;
	output VGA_BLANK_N;
	output VGA_SYNC_N;
	output [9:0]VGA_R;
	output [9:0]VGA_G;
	output [9:0]VGA_B;
		
	inout PS2_CLK;
	inout PS2_DAT;
	
	input AUD_ADCDAT;
	inout AUD_BCLK;
	inout AUD_ADCLRCK;
	inout AUD_DACLRCK;
	inout I2C_SDAT;
	output AUD_XCK;
	output AUD_DACDAT;
	output I2C_SCLK;
	
	reg [8:0]VGAx;
	reg [7:0]VGAy;	
	reg [8:0]OTHx;
	reg [7:0]OTHy;
	reg [2:0]VGAcol;
	reg VGAwrite;
	
	output [6:0]HEX0;
	output [6:0]HEX1;
	output [6:0]HEX2;
	output [6:0]HEX3;
	output [6:0]HEX4;
	output [6:0]HEX5;
	output [9:0]LEDR;
	
	wire [15:0]rng;
	RNG rng_(CLOCK_50, ~KEY[0], rng);
	
	wire [7:0]keybutton;
	Keyboard keyboard_(CLOCK_50, ~KEY[0], PS2_CLK, PS2_DAT, keybutton);
	
	wire colSplash;
	wire quitSplash;
	wire konami;
	wire [3:0]prog;
	Splash splash_ (
		keybutton, //keyboard
		~KEY[0], //reset
		(state==stateSplash), //enable
		CLOCK_50,
		OTHx, OTHy, colSplash, //vga
		AUD_ADCDAT,AUD_BCLK,AUD_ADCLRCK,AUD_DACLRCK,AUD_DACDAT,I2C_SCLK,I2C_SDAT,AUD_XCK, //audio
		konami,
		quitSplash,
		prog);
	assign LEDR[9:0] = (state==stateMenu) && ~(10'b1111111111 << prog);
		

	/*
		1A: Z;
		1B: S;
		1C: A;
		1D: W;
		22: X;
		23: D;
		3B: J;
		42: K;
		5A: Enter;
		6B: Num4 & Left;
		72: Num2 & Down;
		73: Num5;
		74: Num6 & Right;
		75: Num8 & Up;
		76: Esc;
	*/
	
	wire colMenu;
	wire [3:0]gameChoice;
	Menu menu_ (
		(keybutton == 8'h6B) || (keybutton == 8'h1C), //left
		(keybutton == 8'h74) || (keybutton == 8'h23), //right
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],					 //reset
		(state==stateMenu),	 //enable
		CLOCK_50, 
		OTHx,	OTHy,colMenu,	 //VGA
		gameChoice,
	);
	
	wire colFireA;
	wire quitFireA;
	wire [9:0]scoreFireA;
	wire [1:0]livesFireA; 
	FireA fire_a(
		(keybutton == 8'h6B) || (keybutton == 8'h1C) || (keybutton == 8'h1A) || (keybutton == 8'h3B), //left
		(keybutton == 8'h74) || (keybutton == 8'h23) || (keybutton == 8'h22) || (keybutton == 8'h42), //right
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0], 				 //reset
		(state==stateFireA),	 //enable
		rng, 						 //random
		CLOCK_50, 
		OTHx, OTHy, colFireA, //vga
		scoreFireA,
		livesFireA,
		quitFireA
	);
	
	wire colFireB;
	wire quitFireB;
	wire [9:0]scoreFireB;
	wire [1:0]livesFireB; 
	FireB fire_b(
		(keybutton == 8'h6B) || (keybutton == 8'h1C) || (keybutton == 8'h1A) || (keybutton == 8'h3B), //left
		(keybutton == 8'h74) || (keybutton == 8'h23) || (keybutton == 8'h22) || (keybutton == 8'h42), //right
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],              //reset
		(state==stateFireB),  //enaable
		rng,                  //random
		CLOCK_50,             
		OTHx, OTHy, colFireB, //vga
		scoreFireB,
		livesFireB,
		quitFireB
	);
	
	wire colOctoA;
	wire quitOctoA;
	wire [9:0]scoreOctoA;
	wire [1:0]livesOctoA; 
	OctoA octo_a(
		(keybutton == 8'h6B) || (keybutton == 8'h1C) || (keybutton == 8'h1A) || (keybutton == 8'h3B)
			|| (keybutton == 8'h75) || (keybutton == 8'h1D), //up
		(keybutton == 8'h74) || (keybutton == 8'h23) || (keybutton == 8'h22) || (keybutton == 8'h42)
			|| (keybutton == 8'h72) || (keybutton == 8'h1B), //down
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],					 //reset
		(state==stateOctoA),	 //enable
		CLOCK_50, 
		OTHx, OTHy, colOctoA, 
		scoreOctoA,
		livesOctoA,
		quitOctoA
	);
	
	wire colOctoB;
	wire quitOctoB;
	wire [9:0]scoreOctoB;
	wire [1:0]livesOctoB; 
	OctoB octo_B(
		(keybutton == 8'h6B) || (keybutton == 8'h1C) || (keybutton == 8'h1A) || (keybutton == 8'h3B)
			|| (keybutton == 8'h75) || (keybutton == 8'h1D), //up
		(keybutton == 8'h74) || (keybutton == 8'h23) || (keybutton == 8'h22) || (keybutton == 8'h42)
			|| (keybutton == 8'h72) || (keybutton == 8'h1B), //down
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],					 //reset
		(state==stateOctoB),	 //enable
		rng,                  //random
		CLOCK_50, 
		OTHx, OTHy, colOctoB, 
		scoreOctoB,
		livesOctoB,
		quitOctoB
	);
	
	wire colFlagA;
	wire quitFlagA;
	wire [9:0]scoreFlagA;
	wire [1:0]livesFlagA; 
	FlagA flag_a(
		(keybutton == 8'h1C),
		(keybutton == 8'h1A),
		(keybutton == 8'h1B),
		(keybutton == 8'h22),
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],					 //reset
		(state==stateFlagA),  //enaable
		rng,                  //random
		CLOCK_50,
		OTHx, OTHy, colFlagA,
		scoreFlagA,
		livesFlagA,
		quitFlagA
	);
	
	wire colFlagB;
	wire quitFlagB;
	wire [9:0]scoreFlagB;
	wire [1:0]livesFlagB; 
	FlagB flag_b(
		(keybutton == 8'h1C),
		(keybutton == 8'h1A),
		(keybutton == 8'h1B),
		(keybutton == 8'h22),
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		~KEY[0],					 //reset
		(state==stateFlagB),  //enaable
		rng,                  //random
		CLOCK_50,
		OTHx, OTHy, colFlagB,
		scoreFlagB,
		livesFlagB,
		quitFlagB
	);
	
	reg [1:0]cad;
	wire [2:0]colBros ;
	wire quitBros ;
	wire [9:0]scoreBros ;
	wire [1:0]livesBros ; 
	Bros  bros_ (
		(keybutton == 8'h75) || (keybutton == 8'h1D), //up
		(keybutton == 8'h72) || (keybutton == 8'h1B), //down
		(keybutton == 8'h76), //esc
		(keybutton == 8'h5A) || (keybutton == 8'h73), //enter
		konami,
		~KEY[0],					 //reset
		(state==stateBros ),  //enaable
		rng,                  //random
		CLOCK_50,
		OTHx, OTHy, colBros ,
		scoreBros ,
		livesBros ,
		quitBros 
	);
	/*
		1A: Z;
		1B: S;
		1C: A;
		1D: W;
		22: X;
		23: D;
		3B: J;
		42: K;
		5A: Enter;
		6B: Num4 & Left;
		72: Num2 & Down;
		73: Num5;
		74: Num6 & Right;
		75: Num8 & Up;
		76: Esc;
	*/
	
	reg [3:0]state;
	parameter stateSplash = 4'b0000;
	parameter stateMenu   = 4'b0001;
	parameter stateFireA  = 4'b0010;
	parameter stateFireB  = 4'b0011;
	parameter stateOctoA  = 4'b0100;
	parameter stateOctoB  = 4'b0101;
	parameter stateFlagA  = 4'b0110;
	parameter stateFlagB  = 4'b0111;
	parameter stateBros   = 4'b1000;
	
	reg [9:0]scoreDisp;
	reg [1:0]livesDisp;
	
	always @ (posedge CLOCK_50) begin
		if (~KEY[0]) begin
			VGAx = 8'h00;
			VGAy = 7'h00;
			VGAcol = 3'o0;
			OTHx = 8'h00;
			OTHy = 7'h00;
			cad = 2'b00;
			state = stateSplash;
		end else begin
			VGAwrite = 1'b1;
			if (OTHx >= 319) begin
				OTHx = 0;
				if (OTHy >= 239) begin
					OTHy = 0;
				end else begin
					OTHy = OTHy + 7'h01;
				end
			end else begin
				OTHx = OTHx + 8'h01;
			end
			VGAx = (OTHx <= 1 ? OTHx + 318 : OTHx - 2);
			VGAy = (OTHx <= 1 ? (OTHy == 0 ? 239 : OTHy - 1) : OTHy);
			case (state)
				stateSplash: begin
					VGAcol = {2'b00, colSplash};
					scoreDisp = -1;
					livesDisp = -1;
					if (quitSplash) state = stateMenu;
				end stateMenu: begin
					VGAcol = {2'b00, colMenu};
					scoreDisp = -1;
					livesDisp = -1;
					state = gameChoice;
				end stateFireA: begin
					VGAcol = {2'b00, colFireA};
					scoreDisp = scoreFireA;
					livesDisp = livesFireA;
					if (quitFireA) state = stateMenu;
				end stateFireB: begin
					VGAcol = {2'b00, colFireB};
					scoreDisp = scoreFireB;
					livesDisp = livesFireB;
					if (quitFireB) state = stateMenu;
				end stateOctoA: begin
					VGAcol = {2'b00, colOctoA};
					scoreDisp = scoreOctoA;
					livesDisp = livesOctoA;
					if (quitOctoA) state = stateMenu;
				end stateOctoB: begin
					VGAcol = {2'b00, colOctoB};
					scoreDisp = scoreOctoB;
					livesDisp = livesOctoB;
					if (quitOctoB) state = stateMenu;
				end stateFlagA: begin
					VGAcol = {2'b00, colFlagA};
					scoreDisp = scoreFlagA;
					livesDisp = livesFlagA;
					if (quitFlagA) state = stateMenu;
				end stateFlagB: begin
					VGAcol = {2'b00, colFlagB};
					scoreDisp = scoreFlagB;
					livesDisp = livesFlagB;
					if (quitFlagB) state = stateMenu;
				end stateBros : begin
					VGAcol = colBros ;
					scoreDisp = scoreBros ;
					livesDisp = livesBros ;
					if (quitBros ) state = stateMenu;
				end
			endcase
			if (keybutton == 8'h11 || keybutton == 8'h14 || keybutton == 8'h71) begin
				cad = cad + 1;
			end else if (keybutton != 8'h00) begin
				cad = 0;
			end
			if (cad == 2'b11 && (state==stateMenu)) state = stateBros ;
		end
	end
	
	wire [6:0] hx2;
	wire [6:0] hx1;
	wire [6:0] hx0;
	wire [6:0] hx5;
	
	HexDisp h_score_l((scoreDisp / 100) % 10, hx2);
	HexDisp h_score_m((scoreDisp /  10) % 10, hx1);
	HexDisp h_score_r((scoreDisp      ) % 10, hx0);
	HexDisp h_lives_ (3 - livesDisp, hx5);
	
	assign HEX5 = (state[3:1] == 3'b000) ? 7'b0000110 : hx5;
	assign HEX4 = (state[3:1] == 3'b000) ? 7'b1000110 : 7'b1111111;
	assign HEX3 = (state[3:1] == 3'b000) ? 7'b0000110 : 7'b1111111;
	assign HEX2 = (state[3:1] == 3'b000) ? 7'b0100100 : hx2;
	assign HEX1 = (state[3:1] == 3'b000) ? 7'b0011001 : hx1;
	assign HEX0 = (state[3:1] == 3'b000) ? 7'b1111001 : hx0;
	
	vga_adapter VGA(.resetn(KEY[0]), .clock(CLOCK_50),
		.colour(VGAcol),.x(VGAx),.y(VGAy),.plot(VGAwrite),
		.VGA_R(VGA_R),.VGA_G(VGA_G),.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),.VGA_VS(VGA_VS),.VGA_BLANK(VGA_BLANK_N),
		.VGA_SYNC(VGA_SYNC_N),.VGA_CLK(VGA_CLK)
	);
	defparam VGA.RESOLUTION = "320x240";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
	defparam VGA.BACKGROUND_IMAGE = "Splash.mif";
	
endmodule

module HexDisp (N, Out);
	input [3:0]N;
	output reg [6:0]Out;

	always @ *
	begin
		case(N)
			 0: Out = 7'b1000000;
			 1: Out = 7'b1111001;
			 2: Out = 7'b0100100;
			 3: Out = 7'b0110000;
			 4: Out = 7'b0011001;
			 5: Out = 7'b0010010;
			 6: Out = 7'b0000010;
			 7: Out = 7'b1111000;
			 8: Out = 7'b0000000;
			 9: Out = 7'b0010000;
			-1: Out = 7'b1111111;
			default: Out = 7'b0111111;
		endcase
	end
endmodule
