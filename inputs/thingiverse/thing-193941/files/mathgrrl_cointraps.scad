// mathgrrl customizable coin traps

//////////////////////////////////////////////////////////////////////////
// PARAMETERS ////////////////////////////////////////////////////////////

// ignore this variable
$fn = 24*1;

// Choose the type of coin you want and leave the size below as 0. They'll all look basically the same in the output window but they are different sizes.
coin_type = 0; // [0:Enter Manually,19.05:US Penny,21.21:US Nickel,17.91:US Dime,24.26:US Quarter,30.61:US Half Dollar,26.49:US Presidential Dollar,23.25:Euro,20:Japanese Yen,40:Chinese Yuan,25:Indian Rupee,20.5:Russion Ruble,22.5:British Pound,26.5:Canadian Dollar,23.2:Swiss Franc,23:Polish Zloty,27:Brazillian Real,21:Mexican Peso,25:Australian Dollar]

// *OR* choose "Enter Manually" above and then type in any diameter you like, in millimeters. Values between 15 and 35 mm work the best. 
coin_size = 0; 

// this chooses one of the above for the diameter
coin_diameter = max(coin_type,coin_size);

// other parameters based on the coin diameter
coin_radius = coin_diameter/2;
corner_radius = coin_diameter/10;
corner_distance=coin_radius-corner_radius+1;
cylinder_radius=coin_radius-1.5*corner_radius;
cylinder_bevel_distance=corner_distance+2*corner_radius;
cylinder_bevel_radius=cylinder_radius+corner_radius/2;
sphere_radius=coin_radius+1;

//////////////////////////////////////////////////////////////////////////
// RENDERS ///////////////////////////////////////////////////////////////

// build the trap
difference(){
	box_hull();			// enclosing box area with rounded edges5
	cylinder_holes();	// three cylindrical holes
	cylinder_bevels(); 	// six spherical holes to bevel the holes
	sphere_hole();		// one spherical hole for coin clearance
}

//////////////////////////////////////////////////////////////////////////
// MODULES ///////////////////////////////////////////////////////////////

// overall rounded cube shape
module box_hull(){
	hull(){
		translate([corner_distance,corner_distance,corner_distance])
			sphere(corner_radius);
		translate([-corner_distance,corner_distance,corner_distance])
			sphere(corner_radius);
		translate([corner_distance,-corner_distance,corner_distance])
			sphere(corner_radius);
		translate([corner_distance,corner_distance,-corner_distance])
			sphere(corner_radius);
		translate([-corner_distance,-corner_distance,corner_distance])
			sphere(corner_radius);
		translate([-corner_distance,corner_distance,-corner_distance])
			sphere(corner_radius);
		translate([corner_distance,-corner_distance,-corner_distance])
			sphere(corner_radius);
		translate([-corner_distance,-corner_distance,-corner_distance])
			sphere(corner_radius);
	}
}

// holes for the sides
module cylinder_holes(){
	rotate([0,0,0])
		translate([0,0,-(coin_radius+5)])
			cylinder(coin_diameter+10,cylinder_radius,cylinder_radius);
	rotate([90,0,0])
		translate([0,0,-(coin_radius+5)])
			cylinder(coin_diameter+10,cylinder_radius,cylinder_radius);
	rotate([0,90,0])
		translate([0,0,-(coin_radius+5)])
			cylinder(coin_diameter+10,cylinder_radius,cylinder_radius);
}

// beveling for the side holes
module cylinder_bevels(){
	translate([cylinder_bevel_distance,0,0])
		sphere(cylinder_bevel_radius);
	translate([0,cylinder_bevel_distance,0])
		sphere(cylinder_bevel_radius);
	translate([0,0,cylinder_bevel_distance])
		sphere(cylinder_bevel_radius);
	translate([-cylinder_bevel_distance,0,0])
		sphere(cylinder_bevel_radius);
	translate([0,-cylinder_bevel_distance,0])
		sphere(cylinder_bevel_radius);
	translate([0,0,-cylinder_bevel_distance])
		sphere(cylinder_bevel_radius);
}

// center hole to guarantee coin clearance
module sphere_hole(){
	sphere(sphere_radius);
}


