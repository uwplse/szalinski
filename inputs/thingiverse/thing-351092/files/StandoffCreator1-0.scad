//Standoff Customizer v0.0.8 
//by eriqjo February 20, 2015

//REVISION HISTORY
//v1.0  Fix issues with customizer
//v0.0.8 Increased max height to 45, added option for hole/flat top
//V0.0.7 A different approach to making an array of standoffs
//v0.0.6 Added option for array of standoffs
//v0.0.5 Added feature for rectangular foot on bottom of standoff
//v0.0.4 Changed all cylinders to radius based
//v0.0.1 Initial release of standoff customizer

//CUSTOMIZER VARIABLES

/* [Body Parameters] */

//Type of standoff(s) to create
Style = 2; // [1:Single, 2:Array]

//Choose shape of the main body
Body_Shape = 3; // [1:Round, 2:Square, 3:Hex]

//Define the height of the body, mm
Body_Height = 25; // [3:45]

//Define the diameter of the body, mm
Body_Diameter = 6;

//Choose the style of the top section
Top_Style = 2; //[1:Male, 2:Female, 3:Flat]

//Outer diameter of threaded portion, mm
Thread_Dia = 3;

//Define the height/depth of the top feature, mm
Thread_Height = 15;

//Define thickness of the base, mm
Base_Thickness = 2;


/* [Single Options] */

//Features to include on base
Base_Type = 3; // [1:Hole Only, 2:Rectangular Base Only, 3:Base and Hole, 4:Neither]

//Define the diameter of the bottom clearance hole, mm
Bottom_Hole_Dia = 3;

//Define length in x-direction, mm
Base_X = 12;

//Define length in y-direction, mm
Base_Y = 35;

/* [Array Options] */

//Number of columns, x-direction
Columns = 3;

//Center-to-Center distance for columns, mm
X_Offset = 45;

//Number of rows, y-direction
Rows = 2;

//Center-to-Center distance for rows, mm
Y_Offset = 30;

//How far past the edge of the standoffs the base extends, mm
Added_Base = 3;

//CUSTOMIZER VARIABLES END

bodyR = Body_Diameter/2;
bottomR = Bottom_Hole_Dia/2;
threadR = Thread_Dia/2;


module makeBody(shape) {

//round************************************************************************************************
	if(shape == 1) {	//round
		if(Top_Style == 1){   //male
			union(){
				translate([0, 0, Body_Height/2])
					cylinder(Body_Height, r = bodyR, center = true, $fn = 12);
				translate([0,0, Body_Height + Thread_Height/2 - 0.1])
					cylinder(Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
			} //u
		}// if topstyle = 1
		
				if(Top_Style == 2){   //female
			difference(){
				translate([0, 0, Body_Height/2])
					cylinder(Body_Height, r = bodyR, center = true, $fn = 12);
				translate([0,0, Body_Height - Thread_Height/2 + 0.1])
					cylinder(Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
			} //d
		}// if topstyle = 2
		
		if(Top_Style == 3){   //flat
			translate([0, 0, Body_Height/2])
				cylinder(Body_Height, r = bodyR, center = true, $fn = 12);							
		}// if topstyle = 3	
				
	} //if
	
	
//square****************************************************************************************************
	if(shape == 2) {	//square
		if(Top_Style == 1){  //male
			union(){
				translate([0,0, Body_Height + Thread_Height/2 - 0.1])
					cylinder(h = Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
				translate([0,0, Body_Height/2])
					cube([Body_Diameter, Body_Diameter, Body_Height], center = true);
			} //u
		} //if topstyle = 1
		
		if(Top_Style == 2){  //female
			difference(){
				translate([0,0, Body_Height/2])
					cube([Body_Diameter, Body_Diameter, Body_Height], center = true);
				translate([0,0, Body_Height - Thread_Height/2 + 0.1])
					cylinder(h = Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
			} //d
		} //if topstyle = 2		
		
		if(Top_Style == 3){  //flat
			translate([0,0, Body_Height/2])
				cube([Body_Diameter, Body_Diameter, Body_Height], center = true);
		} //if topstyle = 3	
		
	} //if square
	
	
//hex**********************************************************************************************************
	if(shape == 3) {	//hex
		if(Top_Style == 1){  //male
			union(){
				translate([0,0, Body_Height + Thread_Height/2 - 0.1])
					cylinder(h = Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
				cylinder(h = Body_Height, r = bodyR, center = false, $fn = 6);
			} //u
		} // if topstyle = 1
		
		if(Top_Style == 2){  //female
			difference(){
				cylinder(h = Body_Height, r = bodyR, center = false, $fn = 6);
				translate([0,0, Body_Height - Thread_Height/2 + 0.1])
					cylinder(h = Thread_Height + 0.1, r = threadR, $fn = 12, center = true);
			} //u
		} // if topstyle = 2
		
		if(Top_Style == 3){ // flat
			cylinder(h = Body_Height, r = bodyR, center = false, $fn = 6);
		}//if topstyle = 3
	} //if hex
	
	
} //module

module makeBase(){
	if(Base_Type == 2 || Base_Type == 3){
	 translate([0, 0, Base_Thickness/2])
		cube([Base_X, Base_Y, Base_Thickness], center = true);	
	} //if
} //module

module makeHole(){
	if(Base_Type == 1 || Base_Type == 3){
		translate([0, 0, (Body_Height - 1)/2])
			cylinder(h = Body_Height - 0.9, r = bottomR, $fn = 12, center = true);
	} //if
} //module

//Runtime
if (Style == 1){   //single standoff
	difference(){
		union(){
			makeBody(Body_Shape);
			makeBase();
		} //u
		makeHole();
	} //d
} //if



//The new way

baseShift = Body_Diameter/2 + Added_Base;
baseX = (Columns - 1) * X_Offset + Body_Diameter + (2 * Added_Base);
baseY = (Rows - 1) * Y_Offset + Body_Diameter + (2 * Added_Base);

if (Style == 2){  //array

	union(){
		for (j = [0 : Rows - 1]){     //replace 3 with Rows
			translate([0,j * Y_Offset,0])
				for( i = [0 : Columns - 1]){   //replace 4 with Columns
					translate([i * X_Offset,0,0])
						makeBody(Body_Shape);
				}//for
		}//for
		translate([-baseShift, -baseShift, -Base_Thickness + 0.1])
			cube(size = [baseX, baseY, Base_Thickness], center = false);
	} //union
}//if
