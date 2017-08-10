module BoatA(Left, Right, Reset, Rand, Clock, VGAx, VGAy, VGAcol, Quit);
	input Left;
	input Right;
	input Reset;
	input [15:0]Rand;
	input Clock;
	
	output VGAx;
	output VGAy;
	output VGAcol;
	output Quit;
	
	reg [21:0]ticks;
	reg [2:0]frames;
	
	parameter tperf = 22'd2; //3.125*10^6 ticks per frame - 2 ticks per frame while testing
	parameter fperb = 4'b1000; //8 frames per beat
	
	reg [1:0]position; //00:left; 01:centre; 10:right
	reg [1:0]direction; //0x:no movement; 10: right; 11: left
	reg [5:0]flcrew; //LSB: deck; MSB: water
	reg [5:0]mlcrew; //LSB: deck; MSB: water
	reg [5:0]mrcrew; //LSB: deck; MSB: water
	reg [5:0]frcrew; //LSB: deck; MSB: water
	reg [2:0]corpses;
	reg [2:0]leftvol; //crew in left boat;
	reg [2:0]rightvol; //crew in right boat;
	
	reg [9:0]score;
	reg [1:0]lives; //lives used
	
	always @ (posedge Clock) begin
		if (Reset) begin
			ticks = 0;
			frames = 0;
			position = 1;
			direction = 0;
			flcrew = 0;
			mlcrew = 0;
			mrcrew = 0;
			frcrew = 0;
			corpses = 0;
			leftvol = 0;
			rightvol = 0;
			score = 0;
			lives = 0;
		end else begin
			ticks = ticks + 1;
			if (ticks == tperf) begin //every frame
				ticks = 0;
				frames = frames + 1;
				if (direction[1]) begin //if input
					if (direction[0] && |position) begin //if left and position != 00
						position = position - 1; //move left
					end else if (~direction[0] && ~position[1]) begin //if right and position !=10
						position = position + 1; //move right
					end
					direction = 2'b00;
				end
				if (~|position) begin //empty boat and score
					score = score + leftvol;
					leftvol = 0;
				end else if (position[1]) begin
					score = score + rightvol;
					rightvol = 0;
				end
			end
			if (frames == fperb) begin //every beat
				frames = 0;
				corpses = 3'b000;
				if (flcrew[5]) begin //if crew about to fall in water
					if (position[0] && ~leftvol[2]) begin //if boat under crew && has room
						leftvol = leftvol + 1;
					end else begin
						lives = lives + 1;
						corpses = 3'b100;
					end
				end else if (mlcrew[5]) begin
					if (position[1] && ~leftvol[2]) begin
						leftvol = leftvol + 1;
					end else begin
						lives = lives + 1;
						corpses = 3'b101;
					end
				end else if (mrcrew[5]) begin
					if (~|position && ~rightvol[2]) begin
						rightvol = rightvol + 1;
					end else begin
						lives = lives + 1;
						corpses = 3'b110;
					end
				end else if (frcrew[5]) begin
					if (position[1] && ~rightvol[2]) begin
						rightvol = rightvol + 1;
					end else begin
						lives = lives + 1;
						corpses = 3'b111;
					end
				end
				flcrew = flcrew << 1; //move crew
				mlcrew = mlcrew << 1;
				mrcrew = mrcrew << 1;
				frcrew = frcrew << 1;
				case (Rand%4) //add crew
					0: flcrew[0] = 1;
					1: mlcrew[0] = 1;
					2: mrcrew[0] = 1;
					3: frcrew[0] = 1;
				endcase
			end //(frames == fperb)
			if (Left && ~Right) begin
				direction = 2'b11;
			end else if (Right && ~Left) begin
				direction = 2'b10;
			end
		end //always @ (posedge Clock)
	end
	
	assign VGAx = 0;
	assign VGAy = 0;
	assign VGAcol = 0;
	assign Quit = 0;
endmodule
