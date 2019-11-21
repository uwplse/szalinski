//Simple Plug or Cap

//How thick do you want the solid end portion in mm?
End_Thickness = 3;

//Diameter of the solid end portion in mm (set equal to Tube Outer Diameter for a smooth cap).
End_Diameter = 60;

//Hole diameter in mm (this dimension is critical for a cap).
Tube_Inner_Diameter = 40;

//Outer diameter of the tube portion in mm (this dimension is critical for a plug).
Tube_Outer_Diameter = 44;

//Length of the tube portion in mm (Overall Height = this dimension + End Thickness).
Tube_Height = 25; 

/* [Hidden] */
res = 90;

module plug ()
{
	union()
	{
	cylinder(h = End_Thickness, r = End_Diameter/2, center = false, $fn = res);
	
		difference()
		{
		translate ([0,0,End_Thickness]) cylinder(h = Tube_Height, r = Tube_Outer_Diameter/2, center = false, $fn = res);
		translate ([0,0,End_Thickness]) cylinder(h = Tube_Height+1, r = Tube_Inner_Diameter/2, center = false, $fn = res);
		}
	}
}
plug();
