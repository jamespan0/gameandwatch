module FlagA(Alpha, Zulu, Sierra, Xray,
		Esc, Enter,
		Reset, Enable, Rand, Clock,
		VGAx, VGAy, VGAcol, 
		Score, Lives,
		Quit
	);
	input Alpha;
	input Zulu;
	input Sierra;
	input Xray;
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
	
	reg [33:0]ticks;
	reg pause; //0: paused; 1: playing
	
	parameter tperf = 26'd50000000; //5*10^8 ticks per frame - 4 ticks per frame while testing
	
	reg [2:0]pixsource;	//000: white;	001: timer	010: Score;	011: miss
								//100: left;	101: right;
	reg [15:0]pixindex;
	
	reg [2:0]direction; //0xx:no movement; 100: alpha; 101: zulu; 110: sierra; 111: xray
	reg      turn; //0: semaphorist; 1: player
	reg [15:0]seed; 
	reg [9:0]moves;
	reg [9:0]correct;
	reg corpse;
	reg exit;
	
	output reg [9:0]Score;
	output reg [1:0]Lives; //Lives used
	
	reg [15:0]curr;
	wire [15:0]next;
	
	newnum FlagNa(curr, next);
	
	always @ (posedge Clock) begin
		if (Reset || ~Enable) begin
			ticks = 0;
			pause = 0;
			direction = 0;
			turn = 0;
			seed = Rand;
			curr = Rand;
			moves = 0;
			Score = 0;
			correct = 0;
			Lives = 0;
			corpse = 0;
			pixsource = 0;
			pixindex = 0;
			exit = 0;
		end else if (Enable) begin
			ticks = ticks + pause;
			if (ticks == tperf) begin
				ticks = 0;
				if (turn) begin //if player's turn
					if (direction[2] && direction[1:0] == curr[1:0]) begin //if right button pushed
						if (moves == correct) begin
							moves = 0;
							Score = Score + 1;
							correct = correct + 1;
							turn = 0;
							curr = seed;
						end else begin
							curr = next;
							moves = moves + 1;
						end
					end else begin //if wrong or no button pushed
						moves = 0;
						pause = 0;
						correct = 0;
						Lives = Lives + 1;
						corpse = 1;
						turn = 0;
						seed = Rand;
						curr = Rand;
					end
					direction = 3'b000;
				end else begin //if semaphorist's turn
					//display flag
					if (moves == correct) begin
						moves = 0;
						turn = 1;
						curr = seed;
					end else begin
						curr = next;
						moves = moves + 1;
					end
				end
			end
			
			pixindex = 0;
			pixsource = 0;			
			
			if (VGAx >=  32 && VGAx < (288 - (ticks << 8)/tperf) && VGAy >=  11 && VGAy <  75 && turn) begin
					pixsource = 3'b001;				
			end

			if (VGAy >=  86 && VGAy < 114) begin //Score
				if (VGAx >= 218 && VGAx < 246) begin //Left
					pixindex = (7 * ((VGAy -  86) >> 2)) + ((VGAx - 218) >> 2) + 56 * (Score / 100 % 10);
					pixsource = 3'b010;
				end else if (VGAx >= 253 && VGAx < 281) begin //Mid
					pixindex = (7 * ((VGAy -  86) >> 2)) + ((VGAx - 253) >> 2) + 56 * (Score /  10 % 10);
					pixsource = 3'b010;
				end else if (VGAx >= 288 && VGAx < 316) begin //Right
					pixindex = (7 * ((VGAy -  86) >> 2)) + ((VGAx - 288) >> 2) + 56 * (Score       % 10);
					pixsource = 3'b010;
				end
			end
			
			if (VGAy >= 126 && VGAy < 154) begin //Miss
				if (VGAx >= 218 && VGAx < 246 && |Lives) begin //Left
					pixindex = 28 * (VGAy - 126) + VGAx - 218;
					pixsource = 3'b011;
				end
				if (VGAx >= 253 && VGAx < 281 && Lives[1]) begin //Mid
					pixindex = 28 * (VGAy - 126) + VGAx - 253;
					pixsource = 3'b011;
				end
				if (VGAx >= 288 && VGAx < 316 && &Lives) begin //Right
					pixindex = 28 * (VGAy - 126) + VGAx - 288;
					pixsource = 3'b011;
				end
			end
			
			if (turn) begin
				if (VGAx >=  12 && VGAx < 108 && VGAy >=  80 && VGAy < 228) begin //Left
					pixindex = 96 * (VGAy -  80) + VGAx -  12;
					pixsource = 3'b100;
				end
				if (VGAx >=  108 && VGAx < 204 && VGAy >=  80 && VGAy < 228) begin //Right
					pixindex = 96 * (VGAy -  80) + VGAx - 108;
					pixsource = 3'b101;
				end
			end else begin
				if (VGAx >=  12 && VGAx < 108 && VGAy >=  80 && VGAy < 228) begin //Left
					pixindex = 96 * (VGAy -  80) + VGAx -  12 +
						(corpse ? 42624 : 
							(ticks > (tperf >> 2)
								? (curr[1:0] == 2'b00 ? 14208 : 0) + (curr[1:0] == 2'b01 ? 28416 : 0)
								: 0
							)
						);
					pixsource = 3'b100;
				end
				if (VGAx >=  108 && VGAx < 204 && VGAy >=  80 && VGAy < 228) begin //Right
					pixindex = 96 * (VGAy -  80) + VGAx - 108 +
						(corpse ? 42624 : 
							(ticks > (tperf >> 2)
								? (curr[1:0] == 2'b10 ? 14208 : 0) + (curr[1:0] == 2'b11 ? 28416 : 0)
								: 0
							)
						);
					pixsource = 3'b101;
				end
			end
			
			if (Esc) begin
				exit = ~pause;
				pause = 0;
			end else if (Enter) begin
				exit = &Lives ? 1 : exit;
				pause = ~&Lives;
				corpse = 0;
			end
			
			if (Alpha && ~Zulu && ~Sierra && ~Xray && turn && pause) begin //if alpha button pressed
				direction = 3'b100;
				ticks = tperf - 1; //run next tick
			end else if (~Alpha && Zulu && ~Sierra && ~Xray && turn && pause) begin
				direction = 3'b101;
				ticks = tperf - 1;
			end else if (~Alpha && ~Zulu && Sierra && ~Xray && turn && pause) begin
				direction = 3'b110;
				ticks = tperf - 1;
			end else if (~Alpha && ~Zulu && ~Sierra && Xray && turn && pause) begin
				direction = 3'b111;
				ticks = tperf - 1;
			end
		end
	end
	
	wire ScoreCol;
	NumbersSprite numbers_sprite_octoa(pixindex[9:0], Clock, ScoreCol);
	wire missCol;
	MissSprite miss_sprite_firea(pixindex[9:0], Clock, missCol);
	wire leftCol;
	FlagLeftSprite left_sprite_flaga(pixindex[15:0], Clock, leftCol);
	wire rightCol;
	FlagRightSprite right_sprite_flaga(pixindex[15:0], Clock, rightCol);
	
	always @* begin
		case (pixsource)
			3'b001: VGAcol = 0;
			3'b010: VGAcol = ScoreCol;
			3'b011: VGAcol = missCol;
			3'b100: VGAcol = leftCol;
			3'b101: VGAcol = rightCol;
			default: VGAcol = 1;
		endcase
	end
	
	assign Quit = exit;
endmodule

module newnum(currrand, nextrand);
	input [15:0]currrand;
	output [15:0]nextrand;
	
	assign nextrand = (currrand >> 2)
			| ((currrand[0] ^ currrand[1] ^ currrand[4] ^ currrand[6]) << 14)
			| ((currrand[1] ^ currrand[2] ^ currrand[5] ^ currrand[7]) << 15)
		;
endmodule
