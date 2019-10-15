// This is a strap lock for the Tom Tailor Mesenger Bag "Kentucky".
// The part will prevent the shift of the buckle and the belt and ensure that
// both pieces will always stay in the same position.
//
// Designed by Timo Heinz aka Timothy McPrint
// Date: 2017-07-27
// This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
// (https://creativecommons.org/licenses/by-nc-sa/4.0/)


$fn=50;

buckle_inner_width=40;
buckle_inner_height=12; //including the straps!
buckle_diameter=5;
buckle_tolerance=0.1; //tolerance of the plugs and the counter parts (will influence both parts) (you need to adjust this to your printer and printer settings!)
buckle_general_tolerance=0.2; //tolerance of the outer buckle
lock_diameter=4.0;


module CreateLock()
{
	difference()
	{
		cube([buckle_inner_width+1*buckle_diameter,
			  buckle_inner_height-4*buckle_general_tolerance,
			  buckle_diameter],
			  center=true);
		rotate([90,0,0]) //make the pins:
		{
			translate([-buckle_inner_width/2-buckle_diameter/2,buckle_diameter/2,0])
				cylinder(r=buckle_diameter/2+buckle_general_tolerance,
						 h=buckle_inner_height-buckle_general_tolerance+0.1,
						 center=true);
			translate([buckle_inner_width/2+buckle_diameter/2,buckle_diameter/2,0])
				cylinder(r=buckle_diameter/2+buckle_general_tolerance,
						 h=buckle_inner_height+0.1,
						 center=true);
		}
	}
}


//This will add two pins/plugs to the part for the male part of the fitting:
module MakeMale(radius)
{
	translate([-buckle_inner_width/2+2*lock_diameter,
	           0,
	           buckle_diameter]
	         )
		cylinder(r=radius,h=buckle_diameter,center=true);
	translate([buckle_inner_width/2-2*lock_diameter,
	           0,
	           buckle_diameter]
	         )
		cylinder(r=radius,h=buckle_diameter,center=true);
}


//The male parts will be copied and stretched in height (later a difference() will remove the parts and leave two holes):
module MakeFemale( radius )
{
	scale([1,1,3])
		translate([0,0,-buckle_diameter])
			MakeMale( radius );
}


//First make the male lock:
CreateLock();
MakeMale( lock_diameter/2 - buckle_tolerance );

//Now the female lock (as a variant of the male one):
translate([0,2*buckle_inner_height,0])
difference()
{
	CreateLock();
	MakeFemale( lock_diameter/2 + buckle_tolerance );
}
