module Bros (Up, Down, Esc, Enter,
		Konami,
		Reset, Enable, Rand, Clock, 
		VGAx, VGAy, VGAcol,
		Score, Lives,
	Quit);
	input Up;
	input Down;
	input Esc;
	input Enter;
	
	input Konami;
	
	input Reset;
	input Enable;
	input [15:0]Rand;
	input Clock;
	
	input [8:0]VGAx;
	input [7:0]VGAy;
	output reg [2:0]VGAcol;
	
	output Quit;
	
	reg [22:0]ticks;
	reg [3:0]frames;
	reg pause; //0: paused; 1: playing
	
	parameter tperf = 23'd5000000; //6.25*10^6 ticks per frame
	parameter fperb = 4'b1000; //8 frames per beat
	
	reg [1:0]pixsource;	// 00: white;	01: mario;
								// 10: wall;	11: Score
	reg [9:0]pixindex;
	
	reg [1:0]fleft ;
	reg [1:0]mleft ;
	reg [1:0]mright;
	reg [1:0]fright;
	
	reg [1:0]position; //00:top; 11:bottom
	reg [1:0]direction; //0x:no movement; 10: down; 11: up
	reg exit;
	
	output reg [9:0]Score;
	output reg [1:0]Lives; //Lives used
	
	always @ (posedge Clock) begin
		if (Reset || ~Enable) begin
			ticks = 0;
			frames = 0;
			pause = 0;
			position = 0;
			direction = 0;
			Score = 0;
			Lives = 0;
			pixsource = 0;
			pixindex = 0;
			exit = 0;
		end else if (Enable) begin
			ticks = ticks + pause;
			if (ticks == tperf) begin //every frame
				ticks = 0;
				frames = frames + 1;
				if (direction[1]) begin //if input
					if (direction[0] && |position) begin //if up and position != 00
						position = position - 1; //move up
					end else if (~direction[0] && ~&position) begin //if down and position !=11
						position = position + 1; //move down
					end
					direction = 2'b00;
				end
			end
			if (frames == fperb) begin //every beat
				frames = 0;
				case (Lives)
					2'b00: begin
						if (position == fright) begin
							Score = Score + 1;
						end else begin
							Lives = Lives + 1;
							pause = 0;
						end
					end 2'b01: begin
						if (position == mright) begin
							Score = Score + 1;
						end else begin
							Lives = Lives + 1;
							pause = 0;
						end
					end 2'b10: begin 
						if (position == mleft) begin
							Score = Score + 1;
						end else begin
							Lives = Lives + 1;
							pause = 0;
						end
					end
				endcase
				
				fleft = mleft;
				mleft = mright;
				mright = fright;
				fright = Rand[1:0];
			end
			
			pixindex = 0;
			pixsource = 0;
			
			if (VGAy <  64 || VGAy >= 176) begin
				pixsource = 2'b10;
			end else
			
			if (VGAx >=  16 && VGAx <  32) begin
				if (VGAy <  72 || VGAy >= 168) begin
					pixsource = 2'b10;
				end else if (VGAy >=  72 && VGAy <  96 && fleft != 2'b00) begin
					pixsource = 2'b10;
				end else if (VGAy >=  96 && VGAy < 120 && fleft != 2'b01) begin
					pixsource = 2'b10;
				end else if (VGAy >= 120 && VGAy < 144 && fleft != 2'b10) begin
					pixsource = 2'b10;
				end else if (VGAy >= 144 && VGAy < 168 && fleft != 2'b11) begin
					pixsource = 2'b10;
				end
			end else if (VGAx >= 104 && VGAx < 120) begin
				if (VGAy <  72 || VGAy >= 168) begin
					pixsource = 2'b10;
				end else if (VGAy >=  72 && VGAy <  96 && mleft != 2'b00) begin
					pixsource = 2'b10;
				end else if (VGAy >=  96 && VGAy < 120 && mleft != 2'b01) begin
					pixsource = 2'b10;
				end else if (VGAy >= 120 && VGAy < 144 && mleft != 2'b10) begin
					pixsource = 2'b10;
				end else if (VGAy >= 144 && VGAy < 168 && mleft != 2'b11) begin
					pixsource = 2'b10;
				end
			end else if (VGAx >= 200 && VGAx < 216) begin
				if (VGAy <  72 || VGAy >= 168) begin
					pixsource = 2'b10;
				end else if (VGAy >=  72 && VGAy <  96 && mright != 2'b00) begin
					pixsource = 2'b10;
				end else if (VGAy >=  96 && VGAy < 120 && mright != 2'b01) begin
					pixsource = 2'b10;
				end else if (VGAy >= 120 && VGAy < 144 && mright != 2'b10) begin
					pixsource = 2'b10;
				end else if (VGAy >= 144 && VGAy < 168 && mright != 2'b11) begin
					pixsource = 2'b10;
				end
			end else if (VGAx >= 296 && VGAx < 312) begin
				if (VGAy <  72 || VGAy >= 168) begin
					pixsource = 2'b10;
				end else if (VGAy >=  72 && VGAy <  96 && fright != 2'b00) begin
					pixsource = 2'b10;
				end else if (VGAy >=  96 && VGAy < 120 && fright != 2'b01) begin
					pixsource = 2'b10;
				end else if (VGAy >= 120 && VGAy < 144 && fright != 2'b10) begin
					pixsource = 2'b10;
				end else if (VGAy >= 144 && VGAy < 168 && fright != 2'b11) begin
					pixsource = 2'b10;
				end
			end else
			
			if (VGAx >=  62 && VGAx <  74 && Lives == 2'b10) begin
				if (VGAy >=  76 && VGAy <  92 && position == 2'b00) begin
					pixindex = 12 * (VGAy -  76) + VGAx -  62;
					pixsource = 2'b01;
				end else if (VGAy >= 100 && VGAy < 116 && position == 2'b01) begin
					pixindex = 12 * (VGAy - 100) + VGAx -  62;
					pixsource = 2'b01;
				end else if (VGAy >= 124 && VGAy < 140 && position == 2'b10) begin
					pixindex = 12 * (VGAy - 124) + VGAx -  62;
					pixsource = 2'b01;
				end else if (VGAy >= 148 && VGAy < 164 && position == 2'b11) begin
					pixindex = 12 * (VGAy - 148) + VGAx -  62;
					pixsource = 2'b01;
				end
			end else if (VGAx >= 154 && VGAx < 166 && Lives == 2'b01) begin
				if (VGAy >=  76 && VGAy <  92 && position == 2'b00) begin
					pixindex = 12 * (VGAy -  76) + VGAx - 154;
					pixsource = 2'b01;
				end else if (VGAy >= 100 && VGAy < 116 && position == 2'b01) begin
					pixindex = 12 * (VGAy - 100) + VGAx - 154;
					pixsource = 2'b01;
				end else if (VGAy >= 124 && VGAy < 140 && position == 2'b10) begin
					pixindex = 12 * (VGAy - 124) + VGAx - 154;
					pixsource = 2'b01;
				end else if (VGAy >= 148 && VGAy < 164 && position == 2'b11) begin
					pixindex = 12 * (VGAy - 148) + VGAx - 154;
					pixsource = 2'b01;
				end
			end else if (VGAx >= 246 && VGAx < 258 && Lives == 2'b00) begin
				if (VGAy >=  76 && VGAy <  92 && position == 2'b00) begin
					pixindex = 12 * (VGAy -  76) + VGAx - 246;
					pixsource = 2'b01;
				end else if (VGAy >= 100 && VGAy < 116 && position == 2'b01) begin
					pixindex = 12 * (VGAy - 100) + VGAx - 246;
					pixsource = 2'b01;
				end else if (VGAy >= 124 && VGAy < 140 && position == 2'b10) begin
					pixindex = 12 * (VGAy - 124) + VGAx - 246;
					pixsource = 2'b01;
				end else if (VGAy >= 148 && VGAy < 164 && position == 2'b11) begin
					pixindex = 12 * (VGAy - 148) + VGAx - 246;
					pixsource = 2'b01;
				end
			end
			
			if (VGAx >= 186 && VGAx < 312 && VGAy >= 8 && VGAy <  56) begin
				pixsource = 2'b11;
				if (VGAx >= 270) begin
					pixindex = (7 * ((VGAy -   8) / 6)) + ((VGAx - 270) / 6) + 56 * (Score       % 10);
				end else if (VGAx >= 228) begin
					pixindex = (7 * ((VGAy -   8) / 6)) + ((VGAx - 228) / 6) + 56 * (Score /  10 % 10);
				end else begin
					pixindex = (7 * ((VGAy -   8) / 6)) + ((VGAx - 186) / 6) + 56 * (Score / 100 % 10);
				end 
			end 
			
			if (Up && ~Down && pause) begin
				direction = 2'b11;
			end else if (Down && ~Up && pause) begin
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
	
	wire [2:0]brickCol;
	BrickSprite brick_sprite_brosa(16 * ((VGAy + 4) % 8) + (VGAx % 16), Clock, brickCol);	
	wire [2:0]marioCol;
	MarioSprite mario_sprite_brosa(pixindex[7:0], Clock, marioCol);
	wire ScoreCol;
	NumbersSprite numbers_sprite_brosa(pixindex[9:0], Clock, ScoreCol);
	
	always @* begin
		case (pixsource)
			2'b01: VGAcol = {marioCol[2:1], (marioCol[2] ? Konami : marioCol[0])};
			2'b10: VGAcol = {brickCol[2:1], Konami};
			2'b11: begin
				if (ScoreCol) begin
					VGAcol = {brickCol[2:1], Konami};
				end else begin
					VGAcol = {2'b00, ~Konami};
				end
			end
			default: VGAcol = 3'b001;
		endcase
	end
	
	assign Quit = exit;
endmodule
