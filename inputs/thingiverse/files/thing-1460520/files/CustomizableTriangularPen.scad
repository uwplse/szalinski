// Text for the first face of the triangular pen body
Face_1_Text = "FACE 1";
// Text for the second face of the triangular pen body
Face_2_Text = "FACE 2";
// Text for the third face of the triangular pen body
Face_3_Text = "FACE 3";
// Number of pens
Pen_Count = 1;
// Pen body height in millimeters (increase this if you are using long text)
Pen_Height = 100;
// Printing vertically is slower but good for high volume of pens with less warping.  Printing horizontally is faster and lets you change the filament colors mid print for high contrast on the face 1 text.
Orientation = "Horizontal"; // [Vertical:Vertical,Horizontal:Horizontal]
// Text depth in millimeters
Text_Depth = .5;
// Text font size
Text_Font_Size = 9;
// Text font name from https://www.google.com/fonts 
Text_Font = "Rubik Mono One";
// Tolerance for Ink Stick Diameter and Ink Tip Diameter (increase this if the ink stick does not fit into the pen)
Tolerance = .7;
// Ink Tip Diameter (black plastic part behind the cone of the bic pen ink stick)
Ink_Tip_Diameter = 4 + Tolerance;
// Ink Tip Length (black plastic part behind the cone of the bic pen ink stick)
Ink_Tip_Length = 10;
// Ink Stick Diameter (transparent plastic tube part of the bic pen ink stick)
Ink_Stick_Diameter = 3 + Tolerance;
// Ink Stick Length (transparent plastic tube part of the bic pen ink stick)
Ink_Stick_Length = 121;

/* [Hidden] */
FaceWidth = 12;
P1x = 0;
P1y = 0;
P2x = FaceWidth;
P2y = 0;
P3x = (P2x - P1x)/2;
P3y = ((P2x - P1x) * sqrt(3)) / 2;
FaceDepth = P3y;
Cx = (P1x + P2x + P3x) / 3;
Cy = (P1y + P2y + P3y) / 3;
CircumferentialLength = .01;

for(x =[0:Pen_Count-1])
{

	if(Orientation == "Vertical") {
		//offset to keep all the odd numbered pens in line
		offset = x%2==0 ? 0 : 3.5;
		//space out the pens
		translate([x*(FaceWidth/2) + x,offset,0])
		//rotate so each face can be seen when previewing 5 or more
		rotate ([0,0,x*60]) 
		//make a pen
		PenBarrel();
	} else {
		//space out the pens
		translate([x*(FaceWidth) + x,0,Cy])
		//rotate so face 1 will be down for filament color change
		rotate ([90,0,0]) 
		//make a pen
		PenBarrel();
	}
}

module PenBarrel() 
{
	//Make the triangular pen barrel then cut out the face text and the ink stick 
	difference(){		
		//Taper the triangular barrel with a cone at the tip
		intersection(){
			// Tip Cone
			translate([0,0, Pen_Height])
			rotate ([0,180,0])
			union(){
				cylinder(h = 20, d1 = Ink_Tip_Diameter, d2 = 40, $fs = CircumferentialLength );
				translate([0,0, 20])
				cylinder(h = Pen_Height, d = 40, $fs = CircumferentialLength);
			}
			//Triangular pen barrel
			linear_extrude(height = Pen_Height){	
				//Triangle
				translate([-Cx,-Cy,0])
				polygon(points=[[P1x,P1y],[P2x,P2y],[P3x,P3y]]);
			}		
		}
		union(){		
			FaceTextExtrude(Face_1_Text);
			rotate ([0,0,-120]) {
				FaceTextExtrude(Face_2_Text);
			}
			rotate ([0,0,120]) {			
				FaceTextExtrude(Face_3_Text);
			}		
		}		
		InkStick();
	}
}

module InkStick() 
{
	//Ink stick
	translate([0,0,-.01])
	cylinder(h = Pen_Height + .02, d = Ink_Stick_Diameter, $fs = CircumferentialLength);
	//Ink tip
	translate([0,0,Pen_Height - Ink_Tip_Length + .001])
	cylinder(h = Ink_Tip_Length + .02, d = Ink_Tip_Diameter, $fs = CircumferentialLength);
}

module FaceTextExtrude(FaceText) 
{
	translate([0,Text_Depth-Cy - .01,Pen_Height/2 - 2])
	rotate ([90,90,0]) 
	linear_extrude(height=Text_Depth + .01, convexity=4)
	text(str(FaceText),size=Text_Font_Size,font=Text_Font,valign="center", halign="center");
}
