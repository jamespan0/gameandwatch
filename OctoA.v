module OctoA(Up, Down, Esc, Enter,
		Reset, Enable, Clock, 
		VGAx, VGAy, VGAcol, 
		Score, Lives,
	Quit);
	input Up;
	input Down;
	input Esc;
	input Enter;
	
	input Reset;
	input Enable;
	input Clock;
	
	input [8:0]VGAx;
	input [7:0]VGAy;
	output reg VGAcol;
	
	output Quit;
	
	reg [22:0]ticks;
	reg [2:0]frames; //tentacles move on frame 0, 2, 4 & 6, boat to treasure;
	reg pause; //0: paused; 1: playing
	
	parameter tperf = 23'd6250000; //6.25*10^6 ticks per frame - 2 ticks per frame while testing
	
	reg [5:0]pixsource;	//			00000: background;
								// 		00001: corpse;
								// 00010-00111: Diver0 - Diver5;
								// 		01000: TentacleAB1;
								// 01001-01010: TetnacleA2 - TentacleA3;
								// 01011-01101: TentacleB2 - TentacleB4;
								// 01110-10010: TentacleC1 - TentacleC5;
								// 10011-10110: TentacleD1 - TentacleD4;
								// 10111-11001: TentacleE1 - TentacleE3;
								// 		11010: Score;
								// 		11011: Miss;
	reg [12:0]pixindex;
	
	reg [2:0]position;	//000:boat; 101:treasure
	reg [1:0]direction;	// 0x:no movement; 10: down; 11: up
	reg      treas;		//  1: holding treasure; 0 if not
	
	reg [1:0]tentA; // 00: fully retracted;  11: fully extended
	reg [2:0]tentB; //000: fully retracted; 100: fully extended
	reg [2:0]tentC; //000: fully retracted; 101: fully extended
	reg [2:0]tentD; //000: fully retracted; 100: fully extended
	reg [1:0]tentE; // 00: fully retracted;  11: fully extended
	
	reg corpses;
	reg exit;
	
	reg [1:0]dirAB; //x0 for extending; x1 for retracting; 0x for A; 1x for B
	reg      dirC;  // 0 for extending;  1 for retracting;
	reg      dirD;  // 0 for extending;  1 for retracting;
	reg      dirE;  // 0 for extending;  1 for retracting;
	
	output reg [9:0]Score;
	output reg [1:0]Lives; //Lives used
	
	always @ (posedge Clock) begin
		if (Reset || ~Enable) begin
			ticks = 0;
			frames = 1; //start with tentacle C
			pause = 0;
			position = 0;
			direction = 0;
			tentA = 0;
			tentB = 0;
			tentC = 0;
			tentD = 0;
			tentE = 0; //all tentacles start fully retracted
			dirAB = 0;
			dirC  = 0;
			dirD  = 0;
			dirE  = 0; //all tentacles start extending; top tentacle starts branching upwards;
			treas = 0;
			Score = 0;
			corpses = 0;
			exit = 0;
			Lives = 0;
			pixsource = 0;
			pixindex = 0;
		end else if (Enable) begin
			ticks = ticks + pause;
			if (ticks == tperf) begin //every frame
				if (frames == 0) begin //tentacle AB
					if (dirAB[1]) begin //tentacle B
						if (dirAB[0]) begin //retracting
							tentB = tentB - 1;
							dirAB = (tentB == 3'b000) ? 2'b00 : 2'b11; //if fully retracted, extend tentA
						end else begin //extending
							tentB = tentB + 1;
							dirAB = (tentB == 3'b100) ? 2'b11 : 2'b10; //if fully extended, reverse			
						end
					end else begin //tentacle A
						if (dirAB[0]) begin //retracting
							tentA = tentA - 1;
							dirAB = (tentA == 2'b00) ? 2'b10 : 2'b01; //if fully retracted, extend tentB
						end else begin //extending
							tentA = tentA + 1;
							dirAB = (tentA == 2'b11) ? 2'b01 : 2'b00; //if fully extended, reverse 			
						end
					end
				end else if (frames == 2) begin //tentacle C
					if (dirC) begin //retracting
						tentC = tentC - 1;
						dirC = (tentC == 3'b000) ? 0 : 1; //if fully retracted, reverse dirC
					end else begin //extending
						tentC = tentC + 1;
						dirC = (tentC == 3'b101) ? 1 : 0; //if fully extended, reverse dirC			
					end
				end else if (frames == 4) begin //tentacle D
					if (dirD) begin //retracting
						tentD = tentD - 1;
						dirD = (tentD == 3'o0) ? 0 : 1; //if fully retracted, reverse dirD
					end else begin //extending
						tentD = tentD + 1;
						dirD = (tentD == 3'o4) ? 1 : 0; //if fully extended, reverse dirD			
					end
				end else if (frames == 6) begin //tentacle E
					if (dirE) begin //retracting
						tentE = tentE - 1;
						dirE = (tentE == 2'b_00) ? 0 : 1; //if fully retracted, reverse dirE
					end else begin //extending
						tentE = tentE + 1;
						dirE = (tentE == 2'b_11) ? 1 : 0; //if fully extended, reverse dirE			
					end
				end
				ticks = 0;
				frames = frames + 1;
				if (direction[1]) begin //if input
					if (direction[0] && |position) begin //if up and position != 000
						position = position - 1; //move up
					end else if (~direction[0] && (position != 3'b101)) begin //if down and position !=101
						position = position + 1; //move down
					end
					direction = 2'b00;
				end
				if (position == 3'b101) begin // if at treasure
					treas = 1;
				end else if (position == 3'b000) begin //if at boat
					Score = Score + treas; //increment Score if treasure
					treas = 0;
				end
				corpses = 0;
				if (
					(position == 3'b001 && tentA == 2'b_11) || 
					(position == 3'b010 && tentB == 3'b100) || 
					(position == 3'b011 && tentC == 3'b101) || 
					(position == 3'b100 && tentD == 3'b100) || 
					(position == 3'b101 && tentE == 2'b_11)
				) begin //if dead
					position = 0;
					treas = 0;
					Lives = Lives + 1;
					corpses = 1;
					tentC = 3'o2;
					tentD = 3'o4;
					dirD = 1'b1;
					pause = 0;
				end
			end
			
			pixindex = 0;
			pixsource = 0;

			if (VGAy >=   0 && VGAy <  32) begin //Score
				if (VGAx >=  154 && VGAx <  182) begin //Left
					pixindex = (7 * ((VGAy      ) >> 2)) + ((VGAx - 154) >> 2) + 56 * (Score / 100 % 10);
					pixsource = 5'b11010;
				end else if (VGAx >= 182 && VGAx < 210) begin //Mid
					pixindex = (7 * ((VGAy      ) >> 2)) + ((VGAx - 182) >> 2) + 56 * (Score /  10 % 10);
					pixsource = 5'b11010;
				end else if (VGAx >= 210 && VGAx < 238) begin //Right
					pixindex = (7 * ((VGAy      ) >> 2)) + ((VGAx - 210) >> 2) + 56 * (Score       % 10);
					pixsource = 5'b11010;
				end
			end
			
			if (VGAy >=   0 && VGAy <  32) begin //Miss
				if (VGAx >=  58 && VGAx <  80 && ~Lives[1]) begin //Mid ##-
					pixindex = 22 * (VGAy      ) + VGAx -  58;
					pixsource = 5'b11011;
				end
				if (VGAx >=  88 && VGAx < 110 && ~|Lives) begin //Right ###
					pixindex = 22 * (VGAy      ) + VGAx -  88;
					pixsource = 5'b11011;
				end
			end
			
			if (VGAx >=  94 && VGAx < 146 && VGAy >=  80 && VGAy < 106 && ((tentA >= 1 ) || (tentB >= 1))) begin //tentAB1
				pixindex = 52 * (VGAy -  80) + VGAx -  94;
				pixsource = 5'b01000;
			end
			
			if (VGAx >=  64 && VGAx < 100 && VGAy >=  90 && VGAy < 106 && (tentA >= 2)) begin //tentA2
				pixindex = 36 * (VGAy -  90) + VGAx -  64;
				pixsource = 5'b01001;
			end
			if (VGAx >=  22 && VGAx <  70 && VGAy >=  74 && VGAy < 100 && (tentA >= 3)) begin //tentA3
				pixindex = 48 * (VGAy -  74) + VGAx -  22;
				pixsource = 5'b01010;
			end
			
			if (VGAx >=  78 && VGAx < 110 && VGAy >= 107 && VGAy < 128 && (tentB >= 2)) begin //tentB2
				pixindex = 32 * (VGAy - 107) + VGAx -  78;
				pixsource = 5'b01011;
			end
			if (VGAx >=  70 && VGAx <  90 && VGAy >= 128 && VGAy < 150 && (tentB >= 3)) begin //tentB3
				pixindex = 20 * (VGAy - 128) + VGAx -  70;
				pixsource = 5'b01100;
			end
			if (VGAx >=  54 && VGAx <  84 && VGAy >= 146 && VGAy < 188 && (tentB >= 4)) begin //tentB4
				pixindex = 30 * (VGAy - 146) + VGAx -  54;
				pixsource = 5'b01101;
			end			
			
			if (VGAx >= 124 && VGAx < 152 && VGAy >= 114 && VGAy < 136 && (tentC >= 1)) begin //tentC1
				pixindex = 28 * (VGAy - 114) + VGAx - 124;
				pixsource = 5'b01110;
			end
			if (VGAx >= 124 && VGAx < 142 && VGAy >= 130 && VGAy < 154 && (tentC >= 2)) begin //tentC2
				pixindex = 18 * (VGAy - 130) + VGAx - 124;
				pixsource = 5'b01111;
			end
			if (VGAx >= 122 && VGAx < 136 && VGAy >= 145 && VGAy < 167 && (tentC >= 3)) begin //tentC3
				pixindex = 14 * (VGAy - 145) + VGAx - 122;
				pixsource = 5'b10000;
			end
			if (VGAx >= 120 && VGAx < 132 && VGAy >= 157 && VGAy < 176 && (tentC >= 4)) begin //tentC4
				pixindex = 12 * (VGAy - 157) + VGAx - 120;
				pixsource = 5'b10001;
			end
			if (VGAx >= 116 && VGAx < 133 && VGAy >= 173 && VGAy < 200 && (tentC >= 5)) begin //tentC5
				pixindex = 17 * (VGAy - 173) + VGAx - 116;
				pixsource = 5'b10010;
			end
			
			if (VGAx >= 170 && VGAx < 194 && VGAy >= 135 && VGAy < 156 && (tentD >= 1)) begin //tentD1
				pixindex = 24 * (VGAy - 135) + VGAx - 170;
				pixsource = 5'b10011;
			end
			if (VGAx >= 172 && VGAx < 190 && VGAy >= 150 && VGAy < 176 && (tentD >= 2)) begin //tentD2
				pixindex = 18 * (VGAy - 150) + VGAx - 172;
				pixsource = 5'b10100;
			end
			if (VGAx >= 180 && VGAx < 194 && VGAy >= 156 && VGAy < 179 && (tentD >= 3)) begin //tentD3
				pixindex = 14 * (VGAy - 156) + VGAx - 180;
				pixsource = 5'b10101;
			end
			if (VGAx >= 170 && VGAx < 196 && VGAy >= 177 && VGAy < 212 && (tentD >= 4)) begin //tentD4
				pixindex =  26 * (VGAy - 177) + VGAx - 170;
				pixsource = 5'b10110;
			end
			
			if (VGAx >= 214 && VGAx < 232 && VGAy >= 147 && VGAy < 170 && (tentE >= 1)) begin //tentE1
				pixindex = 18 * (VGAy - 147) + VGAx - 214;
				pixsource = 5'b10111;
			end
			if (VGAx >= 214 && VGAx < 232 && VGAy >= 162 && VGAy < 186 && (tentE >= 2)) begin //tentE2
				pixindex = 18 * (VGAy - 162) + VGAx - 214;
				pixsource = 5'b11000;
			end
			if (VGAx >= 215 && VGAx < 240 && VGAy >= 180 && VGAy < 212 && (tentE >= 3)) begin //tentE3
				pixindex = 25 * (VGAy - 180) + VGAx - 215;
				pixsource = 5'b11001;
			end
			
			if (VGAx >=  19 && VGAx <  48 && VGAy >=   0 && VGAy <  34 && position == 3'b000 && ~&Lives) begin //Diver 0
				pixindex = 29 * (VGAy      ) + VGAx -  19;
				pixsource = 5'b00010;
			end
			if (VGAx >=  20 && VGAx <  74 && VGAy >=  42 && VGAy <  88 && position == 3'b001) begin //Diver 1
				pixindex = 54 * (VGAy -  42) + VGAx -  20 + (treas ? 2484 : 0);
				pixsource = 5'b00011;
			end
			if (VGAx >=  28 && VGAx <  68 && VGAy >= 155 && VGAy < 213 && position == 3'b010) begin //Diver 2
				pixindex = 40 * (VGAy - 155) + VGAx -  28 + (treas ? 2320 : 0);
				pixsource = 5'b00100;
			end
			if (VGAx >=  96 && VGAx < 138 && VGAy >= 173 && VGAy < 229 && position == 3'b011) begin //Diver 3
				pixindex = 42 * (VGAy - 173) + VGAx -  96 + (treas ? 2352 : 0);
				pixsource = 5'b00101;
			end
			if (VGAx >= 149 && VGAx < 195 && VGAy >= 178 && VGAy < 234 && position == 3'b100) begin //Diver 4
				pixindex = 55 * (VGAy - 178) + VGAx - 149 + (treas ? 3080 : 0);
				pixsource = 5'b00110;
			end
			if (VGAx >= 210 && VGAx < 259 && VGAy >= 179 && VGAy < 237 && position == 3'b101) begin //Diver 5
				pixindex = 49 * (VGAy - 179) + VGAx - 210 + (tentE[1] ? 2842 : 0);
				pixsource = 5'b00111;
			end
			
			if (VGAx >= 138 && VGAx < 211 && VGAy >= 118 && VGAy < 180 && corpses) begin //corpses
				pixindex = 73 * (VGAy - 118) + VGAx - 138;
				pixsource = 5'b00001;
			end
			
			if (Esc) begin
				exit = ~pause;
				pause = 0;
			end else if (Enter) begin
				exit = &Lives ? 1 : exit;
				pause = ~&Lives;
			end
			if (Up && ~Down && pause) begin
				direction = 2'b11;
			end else if (Down && ~Up && pause) begin
				direction = 2'b10;
			end
		end //if (Enable)
	end //always @ (posedge Clock)
	
	wire backgroundCol;
	OctoBackgroundSprite background_sprite_octoa(VGAy * 320 + VGAx, Clock, backgroundCol);	
	wire ScoreCol;
	NumbersSprite numbers_sprite_octoa(pixindex[9:0], Clock, ScoreCol);
	wire lifeCol;
	OctoLifeSprite life_sprite_octoa(pixindex[9:0], Clock, lifeCol);
	wire tentacleAB1Col;
	TentacleAB1Sprite tentacle_ab1_sprite_octoa(pixindex[10:0], Clock, tentacleAB1Col);
	wire tentacleA2Col;
	TentacleA2Sprite tentacle_a2_sprite_octoa(pixindex[9:0], Clock, tentacleA2Col);
	wire tentacleA3Col;
	TentacleA3Sprite tentacle_a3_sprite_octoa(pixindex[10:0], Clock, tentacleA3Col);
	wire tentacleB2Col;
	TentacleB2Sprite tentacle_b2_sprite_octoa(pixindex[9:0], Clock, tentacleB2Col);
	wire tentacleB3Col;
	TentacleB3Sprite tentacle_b3_sprite_octoa(pixindex[8:0], Clock, tentacleB3Col);
	wire tentacleB4Col;
	TentacleB4Sprite tentacle_b4_sprite_octoa(pixindex[10:0], Clock, tentacleB4Col);
	wire tentacleC1Col;
	TentacleC1Sprite tentacle_c1_sprite_octoa(pixindex[9:0], Clock, tentacleC1Col);
	wire tentacleC2Col;
	TentacleC2Sprite tentacle_c2_sprite_octoa(pixindex[8:0], Clock, tentacleC2Col);
	wire tentacleC3Col;
	TentacleC3Sprite tentacle_c3_sprite_octoa(pixindex[8:0], Clock, tentacleC3Col);
	wire tentacleC4Col;
	TentacleC4Sprite tentacle_c4_sprite_octoa(pixindex[7:0], Clock, tentacleC4Col);
	wire tentacleC5Col;
	TentacleC5Sprite tentacle_c5_sprite_octoa(pixindex[8:0], Clock, tentacleC5Col);
	wire tentacleD1Col;
	TentacleD1Sprite tentacle_d1_sprite_octoa(pixindex[8:0], Clock, tentacleD1Col);
	wire tentacleD2Col;
	TentacleD2Sprite tentacle_d2_sprite_octoa(pixindex[8:0], Clock, tentacleD2Col);
	wire tentacleD3Col;
	TentacleD3Sprite tentacle_d3_sprite_octoa(pixindex[8:0], Clock, tentacleD3Col);
	wire tentacleD4Col;
	TentacleD4Sprite tentacle_d4_sprite_octoa(pixindex[9:0], Clock, tentacleD4Col);
	wire tentacleE1Col;
	TentacleE1Sprite tentacle_e1_sprite_octoa(pixindex[8:0], Clock, tentacleE1Col);
	wire tentacleE2Col;
	TentacleE2Sprite tentacle_e2_sprite_octoa(pixindex[8:0], Clock, tentacleE2Col);
	wire tentacleE3Col;
	TentacleE3Sprite tentacle_e3_sprite_octoa(pixindex[9:0], Clock, tentacleE3Col);
	wire corpseCol;
	OctoCorpseSprite corpse_sprite_octoa(pixindex[12:0], Clock, corpseCol);
	wire diver0Col;
	Diver0Sprite diver0_sprite_octoa(pixindex[9:0], Clock, diver0Col);
	wire diver1Col;
	Diver1Sprite diver1_sprite_octoa(pixindex[12:0], Clock, diver1Col);
	wire diver2Col;
	Diver2Sprite diver2_sprite_octoa(pixindex[12:0], Clock, diver2Col);
	wire diver3Col;
	Diver3Sprite diver3_sprite_octoa(pixindex[12:0], Clock, diver3Col);
	wire diver4Col;
	Diver4Sprite diver4_sprite_octoa(pixindex[12:0], Clock, diver4Col);
	wire diver5Col;
	Diver5Sprite diver5_sprite_octoa(pixindex[12:0], Clock, diver5Col);
	
	always @* begin
		case (pixsource)
			5'b00001: VGAcol = corpseCol;
			5'b00010: VGAcol = diver0Col;
			5'b00011: VGAcol = diver1Col;
			5'b00100: VGAcol = diver2Col;
			5'b00101: VGAcol = diver3Col;
			5'b00110: VGAcol = diver4Col;
			5'b00111: VGAcol = diver5Col;
			5'b01000: VGAcol = tentacleAB1Col;
			5'b01001: VGAcol = tentacleA2Col;
			5'b01010: VGAcol = tentacleA3Col;
			5'b01011: VGAcol = tentacleB2Col;
			5'b01100: VGAcol = tentacleB3Col;
			5'b01101: VGAcol = tentacleB4Col;
			5'b01110: VGAcol = tentacleC1Col;
			5'b01111: VGAcol = tentacleC2Col;
			5'b10000: VGAcol = tentacleC3Col;
			5'b10001: VGAcol = tentacleC4Col;
			5'b10010: VGAcol = tentacleC5Col;
			5'b10011: VGAcol = tentacleD1Col;
			5'b10100: VGAcol = tentacleD2Col;
			5'b10101: VGAcol = tentacleD3Col;
			5'b10110: VGAcol = tentacleD4Col;
			5'b10111: VGAcol = tentacleE1Col;
			5'b11000: VGAcol = tentacleE2Col;
			5'b11001: VGAcol = tentacleE3Col;
			5'b11010: VGAcol = ScoreCol;
			5'b11011: VGAcol = lifeCol;
			default: VGAcol = backgroundCol;
		endcase
	end
	
	assign Quit = exit;
endmodule
