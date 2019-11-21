/*  
**  Name:  Customizable Coin Container_3d_model
**  Author:  Chris Benson  @TheExtruder
**  Created:  2/24/2017
*/
part = "both" ; // [first:Container Only,second:Cap Only,both:Container and Cap]

numberOfCoins = 10; //[1:1:100]

//in millimeters
coinHeight = 3;
//in millimeters
coinDiameter = 41;
//in millimeters.  The final height will this value + the wall thickness.
capHeight = 5;

wallThickness = 1;

/* [Hidden] */
$fn = 100;

print_part();

module print_part() {
	if (part == "first") {
		//container
        CreateContainer();
	} else if (part == "second") {
		//cap
        CreateCap();
	} else if (part == "both") {
		CreateContainerAndCap();
	} else {
		CreateContainerAndCap();
	}
}

module CreateContainer(){
    CreateCylinder(numberOfCoins * coinHeight, coinDiameter, wallThickness);
}

module CreateCap(){
    CreateCylinder(capHeight, coinDiameter + wallThickness * 2, wallThickness);
}

module CreateContainerAndCap(){
    CreateContainer();
    translate([coinDiameter + wallThickness + 5,0,0])
        CreateCap();
}

module CreateCylinder(height,innerDiameter,wallThinkness){
    union(){
        //bottom
        cylinder(wallThickness, d=innerDiameter + (wallThickness * 2), true);
        
        translate([0,0,wallThickness]){
            difference(){
                //outer wall
                cylinder(height, d=innerDiameter + (wallThickness * 2), true);
                //inner wall
                cylinder(height, d=innerDiameter, true);
            }
        }
    }
}