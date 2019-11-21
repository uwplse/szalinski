//Width of the bracket itself
bracket_width = 7.5;
//Thickness of the walls of the bracket
bracket_wall = 5;

//Makerbot frame depth (measured from the front to the interior)
depth = 53;
//Makerbot frame height (measured from the top to the interior)
height = 45;
//Makerbot frame thickness (the thickness of the panels)
thickness = 8;

//Width of your phone
phone_width = 80;
//Thickness of your phone
phone_depth = 9;
//Phone overhang
phone_overhang = 5;

//Does the phone mount go over the screen or the back?
_back_mount = 1; // [0:Front, 1:Back]
back_mount = _back_mount == 1;

/* [Hidden] */

linear_extrude(bracket_width) {
	square([bracket_wall, depth + bracket_wall * 2]);
	translate([bracket_wall, 0])
		square([height + bracket_wall, bracket_wall]);
	translate([height + bracket_wall, bracket_wall])
		square([bracket_wall, phone_depth + bracket_wall]);
	translate([bracket_wall, depth + bracket_wall])
		square([thickness, bracket_wall]);
	translate([bracket_wall * 2 + height + phone_width, 0])
		square([bracket_wall, phone_depth + bracket_wall * 2]);
	
	if(back_mount) {
		translate([bracket_wall + height, bracket_wall + phone_depth/*0*/])
			square([phone_width + bracket_wall * 2, bracket_wall]);
		translate([bracket_wall * 2 + height + phone_width - phone_overhang, 0/*bracket_wall + phone_depth*/])
			square([phone_overhang, bracket_wall]);
		translate([height + bracket_wall * 2, 0/*bracket_wall + phone_depth*/])
			square([phone_overhang, bracket_wall]);
	} else {
		translate([bracket_wall + height, 0])
			square([phone_width + bracket_wall * 2, bracket_wall]);
		translate([bracket_wall * 2 + height + phone_width - phone_overhang, bracket_wall + phone_depth])
			square([phone_overhang, bracket_wall]);
		translate([height + bracket_wall * 2, bracket_wall + phone_depth])
			square([phone_overhang, bracket_wall]);
	}
}