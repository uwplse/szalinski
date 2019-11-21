// ************* Credits part **************
// "Parametric Drawing Vase, Box,Caps..." 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//
//********************** License ******************
//** "Parametric Drawing Vase, Box,Caps..." by rr2s    **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
//
// ************* Declaration part *************



/* [Base] */
// Which one would you like to see ? If you want a box, made in the first box and then made your cap.
Type = "Box"; // [Vase:Vase,Box:Box,Cap:Box Cap]
// (Choose the drawing or image you want to print. It must be of 100X100 pixels the background should be black and the image must be white (or use invert colors))
Drawing = ""; // [image_surface:100x100]
//(You can change this value depending on your drawing or image, 128 is a good value for start.)
levelOfGrey = 128; //[1:256]
// Height of your object in mm. If you made a box cap check the height of the cap that you want. Height is not included height edge of cap, Because when the box is closed the edge of cap is in the box. For the cap I generally used 2 or 3 mm.)
Height = 60;
// (Wall thickness)
ThicknessWall = 2;
// if cap. Height Of Edge Cap
HeightOfEdgeCap = 5;

/* [Distorsion] */
//(Warning. if you use distorsion with box, the cap could not work. Allows you to rotate the shape. Negative values can be used.The values is in °.Use the value betwen -500 and 500)
Twist = 0;

//(Warning. if you use distorsion with box, the cap could not work. Number of times the object will be sliced for the distorsion.The minimum value is 2)
Slices = 2;
// (Warning. if you use distorsion with box, the cap could not work. Scale of the form in proportion to the height.The base is 1. Between 0.1 and 1 the base will be greater than the top. Supperior at 1 to the base will be smaller that the top.)
Scale = 1;
//resolution for twist
Resolution = 0;//[0:200]


/* [Settings] */
// (The basic size of your object is proportional to its place on your image. We assume that the image import and 100X100 pixel and the design takes on the image of your object will be 100mm in width and 100mm length). You can change the width or use a value corresponding to a percentage eg 50% use 50.
Width = 100;
// (On the same principle as the width you can change the length)
Length = 100;
/* [Slicer] */
// (For the vase, some slicer slice better if the object is plein.Cela avoids the retractions. Example for Cura select "SolidObject = true" . And in Cura and use the parameter. - Fill Density (%) = 0,  choose your shell thickness, and expert in tab => open expert settings => infill => solid infill top = Disable)
SolidObject = "false";// [true,false]


// ************* private variable *************
TH  = ThicknessWall;
H   = Height;
I   = Drawing;
LOF = levelOfGrey;
W   = (1*Width)/100;
L   = (1*Length)/100;
TW  = Twist;
SL  = Slices;
SC  = Scale;
R   = Resolution;
HC  = HeightOfEdgeCap;


// ************* Executable part *************
print_part();

module print_part() {
	if (Type == "Vase"){
		if (SolidObject == "false"){
			union() {
				cut();
				Ground();
			}
		}else{
				cut();
		}
	}else if (Type == "Box") {
			union() {
				cutBox();
				Ground();
			}
	}else{
			rotate([180,0,0]) union() {
								mirror([0,0,1]) Around();
								mirror([0,0,1]) boxCaps();
			}
	}
}



// ************* Module part projection *************

// projection Drawing on surface
module ProjectionOnSurface(){
	projection(cut = true)
	translate([0,0,-(LOF)])
    scale([W,L,256]) surface(file=I, center=true, convexity=5);
}


// ************* Module part Base *************
module Around(){
	translate([0,0,-1]) linear_extrude(H, twist = TW, slices = SL, scale = SC, $fn = R) minkowski(){
	ProjectionOnSurface();
	circle(TH);
	}
}

module Ground(){
	difference(){
	translate([0,0,-1]) linear_extrude(H, twist = TW, slices = SL, scale = SC, $fn = R) minkowski(){
	ProjectionOnSurface();
	circle(TH);
	}
	translate([0,0,(H+10)/+TH]) cube([100,100,H+10],center = true);
	}
}

// ************* Module part Cut Vase *************
module Thickness(){
	 translate([0,0,-1]) linear_extrude(H+1,twist = TW, slices = SL, scale = SC, $fn = R) ProjectionOnSurface();
}


// ************* Module part Base box *************
//caps
module boxCaps(){
	translate([0,0,-1]) linear_extrude(H+HC) ProjectionOnSurface();
}

// ************* Module part Cut Box *************
module ThicknessBox(){
	translate([0,0,-1]) linear_extrude(H+1, twist = TW, slices = SL, scale = SC, $fn = R) minkowski(){
	ProjectionOnSurface();
	circle(0.3);
	}
}

// ************* Module group : base and cut  *************

module cut(){
	if (SolidObject == "false"){
			difference(){
				Around();
				Thickness();
			}
	}else{
		Around();
	}
}

module cutBox(){
			difference(){
				Around();
				ThicknessBox();
			}
}







			




				

