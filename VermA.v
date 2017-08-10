module VermA(Left, Right, Sinist, Dexter,
		Esc, Enter,
		Reset, Enable, Rand, Clock, 
		VGAx, VGAy, VGAcol,
		Quit
	);
	input Left;   //move left
	input Right;  //move right
	input Sinist; //strike left
	input Dexter; //strike right
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
	
	parameter tperf = 23'd6250000; //6.25*10^6 ticks per frame - 2 ticks per frame while testing
	parameter fperb = 3'b100; //4 frames per beat
	
	reg [2:0]pixsource;	//000: white;	001: score;	010: miss
								//011: escape;
								//100: left;	101: right;
								//110: dirt;	111: mole;
	reg [14:0]pixindex;
	
	reg      position; //0:left; 1:right
	reg [2:0]direction; //0xx:no change;
	//100: move right; 101: move left; 110: right hammer; 111: left hammer
	reg [2:0]escape;
	reg exit; 
	
	reg [2:0]fleft;  //mole far left;  000: no mole; 
	reg [2:0]mleft;  //mole mid left;  001: entry;
	reg [2:0]mright; //mole mid right; 010-100: etc;
	reg [2:0]fright; //mole far right; 100: visible;
	
	reg [9:0]score;
	reg [1:0]lives; //lives used
	
	always @ (posedge Clock) begin
		if (Reset || ~Enable) begin
			ticks = 0;
			frames = 0;
			pause = 0;
			position = 0;
			direction = 0;
			escape = 0;
			fleft = 0;
			mleft = 0;
			mright = 0;
			fright = 0;
			score = 0;
			lives = 0;
		end else if (Enable) begin
			ticks = ticks + 1;
			if (ticks == tperf) begin //every frame
				ticks = 0;
				frames = frames + 1;
				if (frames == fperb)	begin
					frames = 0;
					if (pause) begin
						fleft  = fleft  + |fleft ; //advance moles by one
						mleft  = mleft  + |mleft ; 
						mright = mright + |mright; 
						fright = fright + |fright; 
						if (fleft == 6) begin
							lives = lives + 1;
							escape = 3'b100;
							pause = 0;
							fleft = 0;
						end else 
						if (mleft == 6) begin
							lives = lives + 1;
							escape = 3'b101;
							pause = 0;
							mleft = 0;
						end else 
						if (mright == 6) begin
							lives = lives + 1;
							escape = 3'b110;
							pause = 0;
							mright = 0;
						end else 
						if (fright == 6) begin
							lives = lives + 1;
							escape = 3'b111;
							pause = 0;
							fright = 0;
						end else begin
							escape = 0;
						end
						if (escape) begin
							fleft = 0;
							mleft = 0;
							mright = 0;
							fright = 0;
						end
						if (~|(fleft | mleft | mright | fright)) begin //if no moles
							case (Rand%4)
								0: fleft = 1;
								1: mleft = 1;
								2: mright = 1;
								3: fright = 1;
							endcase
						end else if (~|(fleft[2:1]  | mleft[2:1] |
											 mright[2:1] | fright[2:1]))
							begin //if new mole needed
							case (~(8*|fleft + 4*|mleft + 2*|mright + 1*|fright))
								4'b001: begin //fright has mole
									case (Rand%3)
										0: fleft = 1;
										1: mleft = 1;
										2: mright = 1;
									endcase
								end 4'b0010: begin //mright has mole
									case (Rand%3)
										0: fleft = 1;
										1: mleft = 1;
										2: fright = 1;
									endcase
								end 4'b0011: begin //mright && fright have moles
									case (Rand%2)
										0: fleft = 1;
										1: mleft = 1;
									endcase
								end 4'b0100: begin //mleft has mole
									case (Rand%3)
										0: fleft = 1;
										1: mright = 1;
										2: fright = 1;
									endcase
								end 4'b0101: begin //mleft && fright have moles
									case (Rand%2)
										0: fleft = 1;
										1: mright = 1;
									endcase
								end 4'b0110: begin //mleft && mright have moles
									case (Rand%2)
										0: fleft = 1;
										1: fright = 1;
									endcase
								end 4'b1000: begin //fleft has mole
									case (Rand%3)
										0: mleft = 1;
										1: mright = 1;
										2: fright = 1;
									endcase
								end 4'b1001: begin //fleft && fright have moles
									case (Rand%2)
										0: mleft = 1;
										1: mright = 1;
									endcase
								end 4'b1010: begin //fleft && mright have moles
									case (Rand%2)
										0: mleft = 1;
										1: fright = 1;
									endcase
								end 4'b1100: begin //fleft && mleft have moles
									case (Rand%2)
										0: mright = 1;
										1: fright = 1;
									endcase
								end
							endcase
						end
					end
				end //(frames == fperb)
				if (direction[2]) begin //if input
					if (direction[1]) begin //if hammer
						if (direction[0]) begin //if left hammer
							if (position) begin //if at right
								if (mleft == 5) begin //if mole
									score = score + 1; //increment score
									mleft = 0; //remove mole
								end
							end else begin //if at left;
								if (fleft == 5) begin //if mole
									score = score + 1; //increment score
									fleft = 0; //remove mole
								end
							end
						end else begin //if right hammer
							if (position) begin //if at right
								if (fright == 5) begin //if mole
									score = score + 1; //increment score
									fright = 0; //remove mole
								end
							end else begin //if at left;
								if (mright == 5) begin //if mole
									score = score + 1; //increment score
									mright = 0; //remove mole
								end
							end
						end //(direction[0]) begin 
					end else begin //if movement
						if (direction[0] == position) begin
							position = ~position; //swap position
						end
					end
					direction = 3'b000;
				end //(direction[2])
			end //(ticks == tperf)
			
		pixindex = 0;
		pixsource = 0;
	
	//reg [2:0]pixsource;	//000: white;	001: score;	010: miss
								//011: escape;
								//100: left;	101: right;
								//110: dirt;	111: mole;

		if (VGAy >=   2 && VGAy <  34) begin //Score
			if (VGAx >=  234 && VGAx <  262) begin //Left
				pixindex = (7 * ((VGAy -   2) >> 2)) + ((VGAx - 234) >> 2) + 56 * (score / 100 % 10);
				pixsource = 3'b001;
			end else if (VGAx >= 262 && VGAx < 290) begin //Mid
				pixindex = (7 * ((VGAy -   2) >> 2)) + ((VGAx - 262) >> 2) + 56 * (score /  10 % 10);
				pixsource = 3'b001;
			end else if (VGAx >= 290 && VGAx < 318) begin //Right
				pixindex = (7 * ((VGAy -   2) >> 2)) + ((VGAx - 290) >> 2) + 56 * (score       % 10);
				pixsource = 3'b001;
			end
		end
			
		if (VGAy >=   4 && VGAy <  32) begin //Miss
			if (VGAx >=   4 && VGAx <  32 && |lives) begin //Left
				pixindex = 28 * (VGAy -   4) + VGAx -   4;
				pixsource = 3'b010;
			end
			if (VGAx >=  39 && VGAx <  67 && lives[1]) begin //Mid
				pixindex = 28 * (VGAy -   4) + VGAx -  39;
				pixsource = 3'b010;
			end
			if (VGAx >=  74 && VGAx < 102 && &lives) begin //Right
				pixindex = 28 * (VGAy -   4) + VGAx -  74;
				pixsource = 3'b010;
			end
		end	
		
		if (VGAx >=  44 && VGAx < 128 && VGAy >=  36 && VGAy < 162 && ~position) begin //Left at left
			pixindex = 84 * (VGAy -  36) + VGAx -  44 + (direction = 3'b111 ? 0 : 10584);
			pixsource = 3'b100;
		end else if (VGAx >= 108 && VGAx < 192 && VGAy >=  36 && VGAy < 162 && position) begin //Left at right
			pixindex = 84 * (VGAy -  36) + VGAx - 108 + (direction = 3'b111 ? 0 : 10584);
			pixsource = 3'b100;
		end
		
		if (VGAx >=  128 && VGAx < 212 && VGAy >=  36 && VGAy < 162 && ~position) begin //Right at left
			pixindex = 84 * (VGAy -  36) + VGAx - 128 + (direction = 3'b110 ? 0 : 10584);
			pixsource = 3'b101;
		end else if (VGAx >= 212 && VGAx < 276 && VGAy >=  36 && VGAy < 162 && position) begin //Right at right
			pixindex = 84 * (VGAy -  36) + VGAx - 212 + (direction = 3'b110 ? 0 : 10584);
			pixsource = 3'b101;
		end
		
			
		if (VGAy >= 118 && VGAy < 136 && |escape) begin //Escape
			if (VGAx >= 203 && VGAx < 245 && escape == 3'b111) begin
				pixindex = 42 * (VGAy - 118) + VGAx - 203;
				pixsource = 3'b011;
			end
			if (VGAx >= 139 && VGAx < 181 && escape == 3'b110) begin
				pixindex = 42 * (VGAy - 118) + VGAx - 139;
				pixsource = 3'b011;
			end
			if (VGAx >=  75 && VGAx < 117 && escape == 3'b101) begin
				pixindex = 42 * (VGAy - 118) + VGAx -  75;
				pixsource = 3'b011;
			end
			if (VGAx >=  11 && VGAx <  53 && escape == 3'b100) begin
				pixindex = 42 * (VGAy - 118) + VGAx -  11;
				pixsource = 3'b011;
			end
		end
		
		if (VGAx >=  44 && VGAx <  84) begin //fleft
			if (VGAy >= 138 && VGAy < 162 && fleft == 3'b100) begin
				pixindex = 40 * (VGAy - 138) + VGAx -  44;
				pixsource = 3'b111;
			end else if (VGAy >= 173 && VGAy < 184 && fleft >= 3'b011) begin
				pixindex = 40 * (VGAy - 173) + VGAx -  44;
				pixsource = 3'b110;
			end else if (VGAy >= 195 && VGAy < 206 && fleft >= 3'b010) begin
				pixindex = 40 * (VGAy - 195) + VGAx -  44;
				pixsource = 3'b110;
			end else if (VGAy >= 217 && VGAy < 228 && fleft >= 3'b001) begin
				pixindex = 40 * (VGAy - 217) + VGAx -  44;
				pixsource = 3'b110;
			end 
		end else if (VGAx >= 120 && VGAx < 148) begin //mleft
			if (VGAy >= 138 && VGAy < 162 && mleft == 3'b100) begin
				pixindex = 40 * (VGAy - 138) + VGAx - 120;
				pixsource = 3'b111;
			end else if (VGAy >= 173 && VGAy < 184 && mleft >= 3'b011) begin
				pixindex = 40 * (VGAy - 173) + VGAx - 120;
				pixsource = 3'b110;
			end else if (VGAy >= 195 && VGAy < 206 && mleft >= 3'b010) begin
				pixindex = 40 * (VGAy - 195) + VGAx - 120;
				pixsource = 3'b110;
			end else if (VGAy >= 217 && VGAy < 228 && mleft >= 3'b001) begin
				pixindex = 40 * (VGAy - 217) + VGAx - 120;
				pixsource = 3'b110;
			end 
		end else if (VGAx >= 172 && VGAx < 212) begin //mright
			if (VGAy >= 138 && VGAy < 162 && mright == 3'b100) begin
				pixindex = 40 * (VGAy - 138) + VGAx - 172;
				pixsource = 3'b111;
			end else if (VGAy >= 173 && VGAy < 184 && mright >= 3'b011) begin
				pixindex = 40 * (VGAy - 173) + VGAx - 172;
				pixsource = 3'b110;
			end else if (VGAy >= 195 && VGAy < 206 && mright >= 3'b010) begin
				pixindex = 40 * (VGAy - 195) + VGAx - 172;
				pixsource = 3'b110;
			end else if (VGAy >= 217 && VGAy < 228 && mright >= 3'b001) begin
				pixindex = 40 * (VGAy - 217) + VGAx - 172;
				pixsource = 3'b110;
			end 
		end else if (VGAx >= 236 && VGAx < 276) begin //fright
			if (VGAy >= 138 && VGAy < 162 && fright == 3'b100) begin
				pixindex = 40 * (VGAy - 138) + VGAx - 236;
				pixsource = 3'b111;
			end else if (VGAy >= 173 && VGAy < 184 && fright >= 3'b011) begin
				pixindex = 40 * (VGAy - 173) + VGAx - 236;
				pixsource = 3'b110;
			end else if (VGAy >= 195 && VGAy < 206 && fright >= 3'b010) begin
				pixindex = 40 * (VGAy - 195) + VGAx - 236;
				pixsource = 3'b110;
			end else if (VGAy >= 217 && VGAy < 228 && fright >= 3'b001) begin
				pixindex = 40 * (VGAy - 217) + VGAx - 236;
				pixsource = 3'b110;
			end 
		end 
		
		if (Esc) begin
			exit = ~pause;
			pause = 0;
		end else if (Enter) begin
			pause = 1;
			escape = 0;
		end		
		
		if (Left && ~Right && ~Sinist && ~Dexter && pause) begin
				direction = 3'b101;
			end else if (~Left && Right && ~Sinist && ~Dexter && pause) begin
				direction = 3'b100;
			end else if (~Left && ~Right && Sinist && ~Dexter && pause) begin
				direction = 3'b111;
			end else if (~Left && ~Right && ~Sinist && Dexter && pause) begin
				direction = 3'b110;
			end
		end
	end //always @ (posedge Clock)
	
	wire scoreCol;
	NumbersSprite numbers_sprite_verma(pixindex[9:0], Clock, scoreCol);
	wire missCol;
	MissSprite miss_sprite_verma(pixindex[9:0], Clock, missCol);
	wire escapeCol;
	MoleEscapeSprite escape_sprite_verma(pixindex[9:0], Clock, escapeCol);
	wire leftCol;
	VermLeftSprite left_sprite_verma(pixindex[14:0], Clock, leftCol);
	wire rightCol;
	VermRightSprite right_sprite_verma(pixindex[14:0], Clock, rightCol);
	wire dirtCol;
	DirtSprite dirt_sprite_verma(pixindex[8:0], Clock, dirtCol);
	wire moleCol;
	MoleSprite mole_sprite_verma(pixindex[9:0], Clock, moleCol);
	
	always @* begin
		case (pixsource)
			3'b001: VGAcol = scoreCol;
			3'b010: VGAcol = missCol;
			3'b011: VGAcol = escapeCol;
			3'b100: VGAcol = leftCol;
			3'b101: VGAcol = rightCol;
			3'b110: VGAcol = dirtCol;
			3'b111: VGAcol = moleCol;
			default: VGAcol = 1;
		endcase
	end
	
	assign Quit = exit;
endmodule
