//Customizable Crush Tube
//by eriqjo, March 2016


//CUSTOMIZER VARIABLES

//Height of tube, mm
Tube_Height = 25;

//Diameter of center hole, mm
Hole_Diameter = 10;

//Width of inner ring, mm
Inner_Width = 4;

//Outer diameter of tube, mm
Outer_Diameter = 60;

//Width of outer rings, mm
Outer_Width = 4;

//Number of spokes
Spoke_Quantity = 6; // [3:18]

//Width of spokes, mm
Spoke_Width = 2;

//Number of additional rings
Additional_Rings = 1;

//Width of additional rings, mm
Add_Ring_Width = 2;

//CUSTOMIZER VARIABLES END

errorFree = false;
errorFree = true;

if (errorFree){
	difference(){
		union(){
			spokes();
			outerRing();
			extraRings();
			centerRing();
		}//union
		centerHole();
	}//diff
}//if

else{
	//TODO error messages here
}//else

module spokes(){
	spokeAngle = 360/Spoke_Quantity;
	for (i=[0:Spoke_Quantity-1]){
		rotate([0, 0, i*spokeAngle])
			translate([((Outer_Diameter/2)-(Outer_Width/2))/2, 0, 0])
				cube([(Outer_Diameter/2)-(Outer_Width/2), Spoke_Width, Tube_Height], center = true);
	}//for
}//module spokes

module outerRing(){
	difference(){
		cylinder(h = Tube_Height, d = Outer_Diameter, center = true);
		cylinder(h = Tube_Height + 1, d = Outer_Diameter - (2 * Outer_Width), center = true);
	}//difference
}//module outerRing

module extraRings(){
	dimA = (Hole_Diameter/2) + Inner_Width;
	dimB = (Outer_Diameter/2) - dimA - Outer_Width;
	dimR = (dimB/(Additional_Rings + 1));
	if (Additional_Rings > 0){
		for(i = [1 : Additional_Rings]){
			difference(){
				cylinder(h = Tube_Height, r = dimA + i*dimR + Add_Ring_Width/2, center = true);
				cylinder(h = Tube_Height + 1, r = dimA + i*dimR - Add_Ring_Width/2, center = true);
			}//difference
		}//for
	}//if
}//module extraRings

module centerRing(){
	cylinder(h = Tube_Height, d = Hole_Diameter + Inner_Width, center = true);
}//module centerRing

module centerHole(){
	cylinder(h = Tube_Height + 1, d = Hole_Diameter, center = true);
}//module centerHole


















