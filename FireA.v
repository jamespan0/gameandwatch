module FireA(Left, Right, Esc, Enter,
		Reset, Enable, Rand, Clock, 
		VGAx, VGAy, VGAcol,
		Score, Lives,
	Quit);
	input Left;
	input Right;
	input Esc;
	input Enter;
	
	input Reset;
	input Enable;
	input [15:0]Rand;
	input Clock;
	
	input [8:0]VGAx;
	input [7:0]VGAy;
	output reg VGAcol;
	
	output Quit;
	
	reg [22:0]ticks;
	reg [2:0]frames;
	reg pause; //0: paused; 1: playing
	
	parameter tperf = 23'd5000000; //6.25*10^6 ticks per frame
	parameter fperb = 3'b100; //4 frames per beat
	
	reg [3:0]pixsource;	// 0000: white;	 	0001: smoke;		0010: balcony;		0011: amublance;
								// 0100: jumping;		0101: falling;		0110: corpse;		0111: trampoline;
								// 1000: Score; 		1001: miss;			101x:;				11xx:;
	reg [13:0]pixindex;
	reg [15:0]randhold;
	
	reg [1:0]position; //00:left; 01:centre; 10:right
	reg [1:0]direction; //0x:no movement; 10: right; 11: left
	reg [21:0]jumpers; //LSB: building; MSB: ambulance
	reg [1:0]corpses;
	reg [1:0]smoke;
	reg exit;
	
	output reg [9:0]Score;
	output reg [1:0]Lives; //Lives used
	
	always @ (posedge Clock) begin
		if (Reset || ~Enable) begin
			ticks = 23'h000000;
			frames = 3'o0;
			pause = 1'b0;
			position = 2'b00;
			direction = 2'b00;
			jumpers = 22'h000001;
			corpses = 2'b00;
			exit = 0;
			smoke = 2'b00;
			Score = 10'h000;
			Lives = 2'b00;
			pixsource = 4'h0;
			pixindex = 14'h0000;
			randhold = 16'h0000;
		end else if (Enable) begin
			ticks = ticks + pause;
			if (ticks == tperf) begin //every frame
				ticks = 23'h000000;
				frames = frames + 3'o1;
				smoke = smoke + 2'b01;
				if (direction[1]) begin //if input
					if (direction[0] && |position) begin //if left and position != 00
						position = position - 2'b01; //move left
					end else if (~direction[0] && ~position[1]) begin //if right and position !=10
						position = position + 2'b01; //move right
					end
					direction = 2'b00;
				end
			end
			if (frames == fperb) begin //every beat
				frames = 3'o0;
				randhold = Rand;
				Score = Score + (jumpers[21] ? 10'h001 : 10'h000); //increment Score
				corpses = 2'b00;
				if (jumpers[4] && |position) begin //if jumper dies left
					jumpers[4] = 1'b0;
					Lives = Lives + 2'b01;
					corpses = 2'b01;
					pause = 1'b0;
				end
				if (jumpers[12] && ~position[0]) begin //if jumper dies centre
					jumpers[12] = 1'b0;
					Lives = Lives + 2'b01;
					corpses = 2'b10;
					pause = 1'b0;
				end
				if (jumpers[18] && ~position[1]) begin //if jumper dies right
					jumpers[18] = 1'b0;
					Lives = Lives + 2'b01;
					corpses = 2'b11;
					pause = 1'b0;
				end
				jumpers = jumpers << 1; //move jumpers;
				jumpers[0] = jumpers[12] | ~|jumpers; //add new jumper or adds a jumper if none
			end
			
			pixsource = 4'h0;
			pixindex = 14'h0000;
		
			if (VGAx >=   0 && VGAx <  86 && VGAy >=   0 && VGAy <  39) begin //Smoke
				pixindex = 86 * (VGAy -   0) + VGAx -   0 + 3354 * smoke[0] + (smoke==2'b10 ? 6708 : 0);
				pixsource = 4'b0001;
			end
			if (VGAx >=   0 && VGAx <  28 && VGAy >=  39 && VGAy < 240) begin //Balcony
				pixindex = 28 * (VGAy -  39) + VGAx -   0;
				pixsource = 4'b0010;
			end
			if (VGAx >= 257 && VGAx < 320 && VGAy >= 155 && VGAy < 229) begin //Ambulance
				pixindex = 63 * (VGAy - 155) + VGAx - 257;
				pixsource = 4'b0011;
			end

			if (VGAy >= 4 && VGAy < 36) begin //Score
				if (VGAx >= 120 && VGAx < 148) begin //Left
					pixindex = (7 * ((VGAy -   4) >> 2)) + ((VGAx - 120) >> 2) + 56 * (Score / 100 % 10);
					pixsource = 4'b1000;
				end else if (VGAx >= 148 && VGAx < 176) begin //Mid
					pixindex = (7 * ((VGAy -   4) >> 2)) + ((VGAx - 148) >> 2) + 56 * (Score /  10 % 10);
					pixsource = 4'b1000;
				end else if (VGAx >= 176 && VGAx < 204) begin //Right
					pixindex = (7 * ((VGAy -   4) >> 2)) + ((VGAx - 176) >> 2) + 56 * (Score       % 10);
					pixsource = 4'b1000;
				end
			end
			
			if (VGAy >= 6 && VGAy < 34) begin //Miss
				if (VGAx >= 218 && VGAx < 246 && |Lives) begin //Left
					pixindex = 28 * (VGAy -   6) + VGAx - 218;
					pixsource = 4'b1001;
				end
				if (VGAx >= 253 && VGAx < 281 && Lives[1]) begin //Mid
					pixindex = 28 * (VGAy -   6) + VGAx - 253;
					pixsource = 4'b1001;
				end
				if (VGAx >= 288 && VGAx < 316 && &Lives) begin //Right
					pixindex = 28 * (VGAy -   6) + VGAx - 288;
					pixsource = 4'b1001;
				end
			end
			
			if (VGAy >= 180 && VGAy < 216) begin //Trampolines
				if (VGAx >=  26 && VGAx < 105 && ~|position) begin //Left
					pixindex = 79 * (VGAy - 180) + VGAx -  26;
					pixsource = 4'b0111;
				end
				if (VGAx >= 99 && VGAx < 178 && position[0]) begin //Mid
					pixindex = 79 * (VGAy - 180) + VGAx -  99;
					pixsource = 4'b0111;
				end
				if (VGAx >= 173 && VGAx < 252 && position[1]) begin //Right
					pixindex = 79 * (VGAy - 180) + VGAx - 173;
					pixsource = 4'b0111;
				end
			end
			
			if (VGAy >= 218 && VGAy < 238 && |corpses) begin //Corpses
				if (VGAx >=  36 && VGAx <  95 && ~corpses[1]) begin //Left
					pixindex = 59 * (VGAy - 218) + VGAx -  36;
					pixsource = 4'b0110;
				end
				if (VGAx >= 109 && VGAx < 168 && ~corpses[0]) begin //Mid
					pixindex = 59 * (VGAy - 218) + VGAx - 109;
					pixsource = 4'b0110;
				end
				if (VGAx >= 183 && VGAx < 242 && &corpses) begin //Right
					pixindex = 59 * (VGAy - 218) + VGAx - 183;
					pixsource = 4'b0110;
				end
			end
			
			if (VGAx >= 257 && VGAx < 282 && VGAy >= 141 && VGAy < 166 && jumpers[21]) begin //Jumper 22
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx - 257) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 257) +      (VGAy - 141) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx - 257) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 257) - 25 * (VGAy - 141) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx - 257) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 257) -      (VGAy - 141) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx - 257) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 257) + 25 * (VGAy - 141) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 233 && VGAx < 258 && VGAy >= 106 && VGAy < 131 && jumpers[20]) begin //Jumper 21
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx - 233) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 233) +      (VGAy - 106) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx - 233) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 233) - 25 * (VGAy - 106) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx - 233) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 233) -      (VGAy - 106) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx - 233) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 233) + 25 * (VGAy - 106) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 209 && VGAx < 234 && VGAy >= 141 && VGAy < 166 && jumpers[19]) begin //Jumper 20
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx - 209) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 209) +      (VGAy - 141) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx - 209) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 209) - 25 * (VGAy - 141) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx - 209) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 209) -      (VGAy - 141) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx - 209) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 209) + 25 * (VGAy - 141) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 200 && VGAx < 225 && VGAy >= 175 && VGAy < 200 && jumpers[18]) begin //Jumper 19
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 175) +      (VGAx - 200) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 200) +      (VGAy - 175) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 175) - 25 * (VGAx - 200) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 200) - 25 * (VGAy - 175) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 175) -      (VGAx - 200) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 200) -      (VGAy - 175) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 175) + 25 * (VGAx - 200) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 200) + 25 * (VGAy - 175) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 193 && VGAx < 218 && VGAy >= 141 && VGAy < 166 && jumpers[17]) begin //Jumper 18
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx - 193) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 193) +      (VGAy - 141) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx - 193) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 193) - 25 * (VGAy - 141) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx - 193) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 193) -      (VGAy - 141) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx - 193) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 193) + 25 * (VGAy - 141) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 184 && VGAx < 209 && VGAy >= 106 && VGAy < 131 && jumpers[16]) begin //Jumper 17
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx - 184) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 184) +      (VGAy - 106) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx - 184) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 184) - 25 * (VGAy - 106) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx - 184) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 184) -      (VGAy - 106) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx - 184) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 184) + 25 * (VGAy - 106) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 163 && VGAx < 188 && VGAy >=  72 && VGAy <  97 && jumpers[15]) begin //Jumper 16
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy -  72) +      (VGAx - 163) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 163) +      (VGAy -  72) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy -  72) - 25 * (VGAx - 163) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 163) - 25 * (VGAy -  72) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy -  72) -      (VGAx - 163) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 163) -      (VGAy -  72) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy -  72) + 25 * (VGAx - 163) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 163) + 25 * (VGAy -  72) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 142 && VGAx < 167 && VGAy >= 106 && VGAy < 131 && jumpers[14]) begin //Jumper 15
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx - 142) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 142) +      (VGAy - 106) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx - 142) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 142) - 25 * (VGAy - 106) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx - 142) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 142) -      (VGAy - 106) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx - 142) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 142) + 25 * (VGAy - 106) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 133 && VGAx < 158 && VGAy >= 141 && VGAy < 166 && jumpers[13]) begin //Jumper 14
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx - 133) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 133) +      (VGAy - 141) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx - 133) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 133) - 25 * (VGAy - 141) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx - 133) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 133) -      (VGAy - 141) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx - 133) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 133) + 25 * (VGAy - 141) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 126 && VGAx < 151 && VGAy >= 175 && VGAy < 200 && jumpers[12]) begin //Jumper 13
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 175) +      (VGAx - 126) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 126) +      (VGAy - 175) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 175) - 25 * (VGAx - 126) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 126) - 25 * (VGAy - 175) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 175) -      (VGAx - 126) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 126) -      (VGAy - 175) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 175) + 25 * (VGAx - 126) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 126) + 25 * (VGAy - 175) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 121 && VGAx < 146 && VGAy >= 141 && VGAy < 166 && jumpers[11]) begin //Jumper 12
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx - 121) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 121) +      (VGAy - 141) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx - 121) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 121) - 25 * (VGAy - 141) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx - 121) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 121) -      (VGAy - 141) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx - 121) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 121) + 25 * (VGAy - 141) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 116 && VGAx < 141 && VGAy >= 106 && VGAy < 131 && jumpers[10]) begin //Jumper 11
				case (randhold[12:10])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx - 116) + 625 * randhold[9:8];
					1: pixindex =        25 * (VGAx - 116) +      (VGAy - 106) + 625 * randhold[9:8];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx - 116) + 625 * randhold[9:8];
					3: pixindex = 600 +       (VGAx - 116) - 25 * (VGAy - 106) + 625 * randhold[9:8];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx - 116) + 625 * randhold[9:8];
					5: pixindex = 624 -  25 * (VGAx - 116) -      (VGAy - 106) + 625 * randhold[9:8];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx - 116) + 625 * randhold[9:8];
					7: pixindex =  24 -       (VGAx - 116) + 25 * (VGAy - 106) + 625 * randhold[9:8];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >= 108 && VGAx < 133 && VGAy >=  72 && VGAy <  97 && jumpers[ 9]) begin //Jumper 10
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy -  72) +      (VGAx - 108) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx - 108) +      (VGAy -  72) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy -  72) - 25 * (VGAx - 108) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx - 108) - 25 * (VGAy -  72) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy -  72) -      (VGAx - 108) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx - 108) -      (VGAy -  72) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy -  72) + 25 * (VGAx - 108) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx - 108) + 25 * (VGAy -  72) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  90 && VGAx < 115 && VGAy >=  37 && VGAy <  62 && jumpers[ 8]) begin //Jumper  9
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy -  37) +      (VGAx -  90) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  90) +      (VGAy -  37) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy -  37) - 25 * (VGAx -  90) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  90) - 25 * (VGAy -  37) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy -  37) -      (VGAx -  90) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  90) -      (VGAy -  37) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy -  37) + 25 * (VGAx -  90) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  90) + 25 * (VGAy -  37) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  71 && VGAx <  96 && VGAy >=  72 && VGAy <  97 && jumpers[ 7]) begin //Jumper  8
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy -  72) +      (VGAx -  71) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  71) +      (VGAy -  72) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy -  72) - 25 * (VGAx -  71) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  71) - 25 * (VGAy -  72) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy -  72) -      (VGAx -  71) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  71) -      (VGAy -  72) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy -  72) + 25 * (VGAx -  71) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  71) + 25 * (VGAy -  72) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  64 && VGAx <  89 && VGAy >= 106 && VGAy < 131 && jumpers[ 6]) begin //Jumper  7
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx -  64) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  64) +      (VGAy - 106) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx -  64) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  64) - 25 * (VGAy - 106) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx -  64) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  64) -      (VGAy - 106) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx -  64) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  64) + 25 * (VGAy - 106) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  58 && VGAx <  83 && VGAy >= 141 && VGAy < 166 && jumpers[ 5]) begin //Jumper  6
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx -  58) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  58) +      (VGAy - 141) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx -  58) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  58) - 25 * (VGAy - 141) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx -  58) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  58) -      (VGAy - 141) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx -  58) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  58) + 25 * (VGAy - 141) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  53 && VGAx <  78 && VGAy >= 175 && VGAy < 200 && jumpers[ 4]) begin //Jumper  5
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy - 175) +      (VGAx -  53) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  53) +      (VGAy - 175) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy - 175) - 25 * (VGAx -  53) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  53) - 25 * (VGAy - 175) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy - 175) -      (VGAx -  53) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  53) -      (VGAy - 175) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy - 175) + 25 * (VGAx -  53) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  53) + 25 * (VGAy - 175) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  48 && VGAx <  73 && VGAy >= 141 && VGAy < 166 && jumpers[ 3]) begin //Jumper  4
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy - 141) +      (VGAx -  48) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  48) +      (VGAy - 141) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy - 141) - 25 * (VGAx -  48) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  48) - 25 * (VGAy - 141) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy - 141) -      (VGAx -  48) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  48) -      (VGAy - 141) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy - 141) + 25 * (VGAx -  48) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  48) + 25 * (VGAy - 141) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  42 && VGAx <  67 && VGAy >= 106 && VGAy < 131 && jumpers[ 2]) begin //Jumper  3
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy - 106) +      (VGAx -  42) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  42) +      (VGAy - 106) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy - 106) - 25 * (VGAx -  42) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  42) - 25 * (VGAy - 106) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy - 106) -      (VGAx -  42) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  42) -      (VGAy - 106) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy - 106) + 25 * (VGAx -  42) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  42) + 25 * (VGAy - 106) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  34 && VGAx <  59 && VGAy >=  72 && VGAy <  97 && jumpers[ 1]) begin //Jumper  2
				case (randhold[4:2])
					0: pixindex =        25 * (VGAy -  72) +      (VGAx -  34) + 625 * randhold[1:0];
					1: pixindex =        25 * (VGAx -  34) +      (VGAy -  72) + 625 * randhold[1:0];
					2: pixindex = 600 +       (VGAy -  72) - 25 * (VGAx -  34) + 625 * randhold[1:0];
					3: pixindex = 600 +       (VGAx -  34) - 25 * (VGAy -  72) + 625 * randhold[1:0];
					4: pixindex = 624 -  25 * (VGAy -  72) -      (VGAx -  34) + 625 * randhold[1:0];
					5: pixindex = 624 -  25 * (VGAx -  34) -      (VGAy -  72) + 625 * randhold[1:0];
					6: pixindex =  24 -       (VGAy -  72) + 25 * (VGAx -  34) + 625 * randhold[1:0];
					7: pixindex =  24 -       (VGAx -  34) + 25 * (VGAy -  72) + 625 * randhold[1:0];
				endcase
				pixsource = 4'b0101;
			end
			if (VGAx >=  16 && VGAx <  41 && VGAy >=  37 && VGAy <  62 && jumpers[ 0]) begin //Jumper  1
				pixindex = 25 * (VGAy  - 37) + VGAx -  16;
				pixsource = 4'b0100;//spawn
			end
			
			if (Left && ~Right && pause) begin
				direction = 2'b11;
			end else if (Right && ~Left && pause) begin
				direction = 2'b10;
			end
			if (Esc) begin
				exit = ~pause;
				pause = 0;
			end else if (Enter) begin
				exit = &Lives ? 1 : exit;
				pause = ~&Lives;
			end
		end //if (Enable)
	end //always @ (posedge Clock)
	
	wire smokeCol;
	SmokeSprite smoke_sprite_firea(pixindex[13:0], Clock, smokeCol);
	wire balconyCol;
	BalconySprite balcony_sprite_firea(pixindex[12:0], Clock, balconyCol);
	wire ambulanceCol;
	AmbulanceSprite ambulance_sprite_firea(pixindex[12:0], Clock, ambulanceCol);
	wire jumperCol;
	JumperSprite jumper_sprite_firea(pixindex[9:0], Clock, jumperCol);
	wire fallingCol;
	FallingSprite falling_sprite_firea(pixindex[11:0], Clock, fallingCol);
	wire corpseCol;
	FireCorpseSprite corpse_sprite_firea(pixindex[10:0], Clock, corpseCol);
	wire trampolineCol;
	TrampolineSprite trampoline_sprite_firea(pixindex[11:0], Clock, trampolineCol);
	wire ScoreCol;
	NumbersSprite numbers_sprite_firea(pixindex[9:0], Clock, ScoreCol);
	wire missCol;
	MissSprite miss_sprite_firea(pixindex[9:0], Clock, missCol);
	
	always @* begin
		case (pixsource)
			4'b0001: VGAcol = smokeCol;
			4'b0010: VGAcol = balconyCol;
			4'b0011: VGAcol = ambulanceCol;
			4'b0100: VGAcol = jumperCol;
			4'b0101: VGAcol = fallingCol;
			4'b0110: VGAcol = corpseCol;
			4'b0111: VGAcol = trampolineCol;
			4'b1000: VGAcol = ScoreCol;
			4'b1001: VGAcol = missCol;
			default: VGAcol = 1;
		endcase
	end
	
	assign Quit = exit;
endmodule
