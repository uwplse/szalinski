//Puzzle piece types are Start, Middle, and End.  If you are making a long puzzle chain, you only need one Start and one End piece.
Piece_type = "Middle"; // [Start,Middle,End]
//ALL DIMENSIONS ARE IN MILIMETERS (25.4mm = 1 inch) Suggested Length values: 25.4-76.2 
Length = 76.2;
//Suggested Width values: 25.4-76.2 (Half the Length will make a nice rectangle; equal to Length creates a square).
Width = 38.1;
//Suggested Hength values: 15.24-30.48 (Don't make this big unless you want very thick pieces). 
Height = 15.24;
//Choose a value less than Height to create a raised border; choose a value greater than Height to created a raised center; make this equal to Height to have no Border.
Inset = 5.715;
//This is the height of your text.  It needs to be bigger than the Inset value or else it wont be visible.
Text_Height = 7.62;
//Suggested Border Thickness values: 1.905-11.43
Border_Thickness = 3.81;
//This controls what type of shape the mating part of the puzzle piece will be.
Mate_type = "Triangle"; // [Circle,Triangle,Square,Rectangle]
//This controls the length of the connecting bar between two puzzle pieces.  You want this to be greated than zero so the pieces will link together.
Mate_Length = 5.715;
//This controls the size of the male/female mating ends of the puzzle piece. Suggested values: 7.62-2
Mate_Size = 7.62;
//Type your text here. Use the additional text boxes (2-6) if you want to write several lines of text.
Your_Text_Line_1 = "Customize me, I dare you!";
Your_Text_Line_2 = "";
Your_Text_Line_3 = "";
Your_Text_Line_4 = "";
Your_Text_Line_5 = "";
Your_Text_Line_6 = "";
//Choose your preferred font (i.e: Arial, Times New Roman).
Font_Type = "Arial:style=Regular"; // ["Arial:style=Bold","Arial:style=Italic","Times New Roman:style=Regular","Times New Roman:style=Bold","Times New Roman:style=Italic","Comic Sans MS:style=Regular"]
//This value is sensitive. Change it by small increments until you get the size you wish. Values smaller than 3 may be too small to print properly.
Font_Size = 3.6195;
//Select "Manual" to position your text line with the following Horizontal and Vertical options.  Select "Center" to automatically center your text horizontally, then adjust it Vertically.  Currently the "Center" option will not accurately center if you have the Square mate chosen.
Text_Alignment = "center"; // [Manual, center]
Move_Text_Line_1_Horiziontally = 19.05;
Move_Text_Line_1_Vertically = 17.907;
Move_Text_Line_2_Horiziontally = 19.05;
Move_Text_Line_2_Vertically = 11.43;
Move_Text_Line_3_Horiziontally = 19.05;
Move_Text_Line_3_Vertically = 5.715;
Move_Text_Line_4_Horiziontally = 19.05;
Move_Text_Line_4_Vertically = 0;
Move_Text_Line_5_Horiziontally = 19.05;
Move_Text_Line_5_Vertically = -8.1643;
Move_Text_Line_6_Horiziontally = 19.05;
Move_Text_Line_6_Vertically = -11.43;
Space_Between_Letters = 1;


module createText(x,y, text_1){	
	if (Text_Alignment == "Manual"){
		translate([x, y, 0]) {
			linear_extrude(Text_Height) {
				text(text = text_1, size = Font_Size, font = Font_Type, halign = Text_Alignment, spacing = Space_Between_Letters);
			}
		}
	}
	if (Text_Alignment == "center") {
		if (Piece_type == "Start"){
			translate([(Length-Border_Thickness)/2, y, 0]) {
				linear_extrude(Text_Height) {
					text(text = text_1, size = Font_Size, font = Font_Type, halign = Text_Alignment, spacing = Space_Between_Letters);
				}
			}
		}
		if (Piece_type == "Middle"){
			translate([(Length+Mate_Length+Mate_Size-Border_Thickness)/2, y, 0]) {
				linear_extrude(Text_Height) {
					text(text = text_1, size = Font_Size, font = Font_Type, halign = Text_Alignment, spacing = Space_Between_Letters);
				}
			}
		}
		if (Piece_type == "End"){
			translate([(Length+Mate_Length+Mate_Size-Border_Thickness)/2, y, 0]) {
				linear_extrude(Text_Height) {
					text(text = text_1, size = Font_Size, font = Font_Type, halign = Text_Alignment, spacing = Space_Between_Letters);
				}
			}
		}
	}
}

module createMaleMate(temp = Height, point = 0){
	linear_extrude (temp){
		union(){
			translate ([Mate_Length, .125*Width]){
				if (Mate_type == "Circle") {circle(r = Mate_Size, $fn = 60);
				}
				if (Mate_type == "Triangle") {polygon (points = [[0, Mate_Size],
																 [Mate_Size, 0],
																 [0,-Mate_Size]]);
				}
				if (Mate_type == "Square") {polygon (points = [[0, Mate_Size/2],
															  [0, Mate_Size],
															  [2*Mate_Size, Mate_Size],
															  [2*Mate_Size, -Mate_Size],
															  [0, -Mate_Size]]);
				}
				if (Mate_type == "Rectangle") {polygon (points = [[0, Mate_Size/2],
															  [0, Mate_Size],
															  [Mate_Size, Mate_Size],
															  [Mate_Size, -Mate_Size],
															  [0, -Mate_Size]]);
				}
			}
			polygon (points = [[point,0],
							   [Mate_Length, 0],
							   [Mate_Length, .25*Width],
							   [point, .25*Width]]);
	   }
	}
}



module createCentralBlock(){
		union(){
			linear_extrude (Inset){
				translate ([Border_Thickness, Border_Thickness, 0]){
					square ([Length - 2*Border_Thickness, Width - 2*Border_Thickness]);
				}
			}
			linear_extrude (Height){
					difference(){
							square ([Length, Width]);
								translate ([Border_Thickness, Border_Thickness]){
									square ([Length-2*Border_Thickness, Width-2*Border_Thickness])
								;};
					}
		    }
		}
}
union(){
createText(x = Move_Text_Line_1_Horiziontally, y = Move_Text_Line_1_Vertically, text_1 = Your_Text_Line_1);
createText(x = Move_Text_Line_2_Horiziontally, y = Move_Text_Line_2_Vertically, text_1 = Your_Text_Line_2);
createText(x = Move_Text_Line_3_Horiziontally, y = Move_Text_Line_3_Vertically, text_1 = Your_Text_Line_3);
createText(x = Move_Text_Line_4_Horiziontally, y = Move_Text_Line_4_Vertically, text_1 = Your_Text_Line_4);
createText(x = Move_Text_Line_5_Horiziontally, y = Move_Text_Line_5_Vertically, text_1 = Your_Text_Line_5);
createText(x = Move_Text_Line_6_Horiziontally, y = Move_Text_Line_6_Vertically, text_1 = Your_Text_Line_6);
//Creates Starting Piece
if (Piece_type == "Start"){	
	
	union(){ 
		translate ([Length, .375*Width, 0]){
			createMaleMate();
			};
			createCentralBlock();
	}
};


//Creates a Middle Piece
if (Piece_type == "Middle"){
	union(){ 
			translate ([Length, .375*Width, 0]){
				createMaleMate();
			}
		difference(){
		createCentralBlock();
			translate ([0, .375*Width, -1]){createMaleMate(temp + 2, -1)
			;}
		}
	}
}


//Creates an End Piece
if (Piece_type == "End"){
		difference(){
			createCentralBlock();
			translate ([0, .375*Width, -1]){
				createMaleMate(temp + 2, -1);
			}
		}
	}
}