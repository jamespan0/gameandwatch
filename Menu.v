module Menu(Left, Right, Esc, Enter, Reset, Enable, Clock, VGAx, VGAy, VGAcol, GameChoice);
	input Left;
	input Right;
	input Esc;
	input Enter;
	input Reset;
	input Enable;
	input Clock;
	input [8:0]VGAx;
	input [7:0]VGAy;
	
	output reg VGAcol;
	output reg [3:0]GameChoice;
	
	reg [3:0]select;

	reg [1:0]current, next;
	reg go, ab, back;
	
	parameter gameChoose = 2'b00;
	parameter difficultyChoose = 2'b01;
	
	parameter stateSplash = 4'b0000;
	parameter stateMenu   = 4'b0001;
	parameter stateFireA  = 4'b0010;
	parameter stateFireB  = 4'b0011;
	parameter stateOctoA  = 4'b0100;
	parameter stateOctoB  = 4'b0101;
	parameter stateFlagA  = 4'b0110;
	parameter stateFlagB  = 4'b0111;
	
	reg [3:0]pixsource;	// 0000: black;	 	0001: title;		0010: fire;			0011: octo;
								// 0100: flag;			0101: a/b;			0110: firetext;	0111: octotext;
								// 1000: flagtext;	1001: ~a/b;
	reg [12:0]pixindex;
	
	always @ (posedge Clock) begin
		case (current)
		gameChoose: begin
			if (Reset) begin
				GameChoice = stateMenu;
				select = stateFireA;
				go = 0;
				back = 0;
				ab = 0;
			end else if (Enable) begin
				if (Left) begin
					if (select == stateFireA)
						select = stateFlagA;
					else
						select = select - 2;
				end else if (Right) begin
					if (select == stateFlagA)
						select = stateFireA;
					else
						select = select + 2;
				end else if (Enter) begin
					back = 0;
					go = 1;
				end
			end else begin
				go = 0;
				select = stateFireA;
			end
			
		end
		difficultyChoose: begin
			if (Reset) begin
				GameChoice = stateMenu;
				select = stateFireA;
			end else if (Enable) begin
				if (Left) begin		
					select[0] = select[0] - 1;
				end else if (Right) begin
					select[0] = select[0] + 1;
				end else if (Enter) begin
					GameChoice = select;
				end else if (Esc) begin
					back = 1;
					go = 0;
					select[0] = 0;
				end
			end else begin
				select = stateFireA;
				GameChoice = stateMenu;
			end
		end
		default: begin
			GameChoice = stateMenu;
			select = stateFireA;
			go = 0;
			back = 0;
			ab = 0;
		end

		endcase
	end

	always @ * begin
		case (current)
		gameChoose: begin
			if (go == 1) begin
				next = difficultyChoose;
			end else if (!Enable) begin
				next = gameChoose;
			end else begin
				next = gameChoose;
			end
		end
		difficultyChoose: begin
			if (Reset) begin
				next = gameChoose;
			end else if (back == 1) begin
				next = gameChoose;
			end else if (Enter) begin
				next = gameChoose;
			end else if (!Enable) begin
				next = gameChoose;
			end else begin
				next = difficultyChoose;
			end
		end
		default: next = gameChoose;
		endcase
	end		
	
	always @ (posedge Clock) begin
		if(Reset) begin
			pixindex = 13'h0000;
			pixsource = 4'b0000;
		end else if (Enable) begin
			if (VGAx >= 60 && VGAx < 260 && VGAy >= 30 && VGAy < 60) begin
				pixindex = 200 * (VGAy - 30) + (VGAx - 60);
				pixsource = 4'b0001;
			end else if (VGAx >= 20 && VGAx < 100 && VGAy >= 80 && VGAy < 160) begin
				pixindex = 80 * (VGAy - 80) + (VGAx - 20);
				pixsource = 4'b0010;
			end else if (VGAx >= 120 && VGAx < 200 && VGAy >= 80 && VGAy < 160) begin
				pixindex = 80 * (VGAy - 80) + (VGAx - 120);
				pixsource = 4'b0011;
			end else if (VGAx >= 220 && VGAx < 300 && VGAy >= 80 && VGAy < 160) begin
				pixindex = 80 * (VGAy - 80) + (VGAx - 220);
				pixsource = 4'b0100;
			end else if (VGAx >= 40 && VGAx < 280 && VGAy >= 190 && VGAy < 200) begin
				if (current == gameChoose) begin
					if (select == stateFireA) begin
						if (VGAx >= 40 && VGAx < 80) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 40);
							pixsource = 4'b0110;
						end else begin
							pixsource = 4'b0000;
						end
					end else if (select == stateOctoA) begin
						if (VGAx >= 140 && VGAx < 180) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 140);
							pixsource = 4'b0111;
						end else begin
							pixsource = 4'b0000;
						end
					end else if (select == stateFlagA) begin
						if (VGAx >= 240 && VGAx < 280) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 240);
							pixsource = 4'b1000;
						end else begin
							pixsource = 4'b0000;
						end
					end
				end else if (current == difficultyChoose) begin
					if (select == stateFireA || select == stateFireB) begin
						if (VGAx >= 40 && VGAx < 60) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 40);
							
							if (select == stateFireA) pixsource = 4'b1001;
							else if (select == stateFireB) pixsource = 4'b0101;
						end else if (VGAx >= 60 && VGAx < 80) begin
							pixindex = 20 + 40 * (VGAy - 190) + (VGAx - 60);
							
							if (select == stateFireA) pixsource = 4'b0101;
							else if (select == stateFireB) pixsource = 4'b1001;
						end else begin
							pixsource = 4'b0000;
						end
					end else if (select == stateOctoA || select == stateOctoB) begin
						if (VGAx >= 140 && VGAx < 160) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 140);
							
							if (select == stateOctoA) pixsource = 4'b1001;
							else if (select == stateOctoB) pixsource = 4'b0101;
						end else if (VGAx >= 160 && VGAx < 180) begin
							pixindex = 20 + 40 * (VGAy - 190) + (VGAx - 160);
							
							if (select == stateOctoA) pixsource = 4'b0101;
							else if (select == stateOctoB) pixsource = 4'b1001;
						end else begin
							pixsource = 4'b0000;
						end
					end else if (select == stateFlagA || select == stateFlagB) begin
						if (VGAx >= 240 && VGAx < 260) begin
							pixindex = 40 * (VGAy - 190) + (VGAx - 240);
							
							if (select == stateFlagA) pixsource = 4'b1001;
							else if (select == stateFlagB) pixsource = 4'b0101;
						end else if (VGAx >= 260 && VGAx < 280) begin
							pixindex = 20 + 40 * (VGAy - 190) + (VGAx - 260);
							
							if (select == stateFlagA) pixsource = 4'b0101;
							else if (select == stateFlagB) pixsource = 4'b1001;
						end else begin
							pixsource = 4'b0000;
						end
					end
				end
			end else begin
				pixsource = 4'b0000;
			end
			
			current = next;
		end
	end
	
	wire titleCol;
	TitleSprite title_sprite_menu(pixindex[12:0], Clock, titleCol);
	wire fireCol;
	MenuFireSprite fire_sprite_menu(pixindex[12:0], Clock, fireCol);
	wire octoCol;
	MenuOctoSprite octo_sprite_menu(pixindex[12:0], Clock, octoCol);
	wire flagCol;
	MenuFlagSprite flag_sprite_menu(pixindex[12:0], Clock, flagCol);
	wire abCol;
	ABSprite ab_sprite_menu(pixindex[8:0], Clock, abCol);
	wire firetextCol;
	MenuFireTextSprite firetext_sprite_menu(pixindex[8:0], Clock, firetextCol);
	wire octotextCol;
	MenuOctoTextSprite octotext_sprite_menu(pixindex[8:0], Clock, octotextCol);
	wire flagtextCol;
	MenuFlagTextSprite flagtext_sprite_menu(pixindex[8:0], Clock, flagtextCol);
	
	always @ (posedge Clock) begin
		case (pixsource)
		4'b0001: VGAcol = ~titleCol;
		4'b0010: VGAcol = ~fireCol;
		4'b0011: VGAcol = ~octoCol;
		4'b0100: VGAcol = ~flagCol;
		4'b0101: VGAcol = ~abCol;
		4'b0110: VGAcol = ~firetextCol;
		4'b0111: VGAcol = ~octotextCol;
		4'b1000: VGAcol = ~flagtextCol;
		4'b1001: VGAcol = abCol;
		4'b1010: VGAcol = 1;
		default: VGAcol = 0;
		endcase
	end
endmodule

