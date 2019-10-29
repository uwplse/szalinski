//--------------------------------------------------------
// Customizer settings and variable defs

// preview[view:south east, tilt:top diagonal]

/* [Dimensions] */
// Thickness of bearing replacement(mm)
Height = 6.9;
// Replacement is a Bolt or a Ball Bearing Sphere
Bolt_or_Ball = "Bolt";  // [Bolt, Ball]
Bolt_type = "M10";      // [M6,M8,M10,M12,M14,manual]
Manual_width = 12;      // [4:0.5:20]
Manual_sides = 6;       // [4,6,8]
// (mm) 
Ball_diameter = 18;     // [4:0.5:20]
// Fidget Spinner Bearing we are replacing (diameter in mm)
Bearing_diameter = 22;
// Round the corners for aesthetics. (Do this last as it takes a while)
Smooth = "no";         // [yes,no]

/* [Hidden] */
// everything defined below here is not visible to customizer
hole_dia = Bolt_type=="M10"   ? 16.92 
			: Bolt_type=="M8" ? 13.92
			: Bolt_type=="M6" ? 10.92
			: Bolt_type=="M12" ? 18.92
			: Bolt_type=="M14" ? 21.92
			: Manual_width;
split_gap = 2; //mm

//
Delta = 0.1;
cyl_res = 100;
rounding = 2;

//
module pretty_cylinder() {
	if (Smooth=="yes") {
		minkowski() {
			cylinder(d=Bearing_diameter-rounding, h=Height-rounding, center=true, $fn=cyl_res);
			sphere(d=rounding, center=true, $fn=12);
		}
	} else {
		cylinder(d=Bearing_diameter, h=Height, center=true, $fn=cyl_res);
	}
}

module bolt() {
	difference() {
		// bearing
		pretty_cylinder();
		//cylinder(d=Bearing_diameter, h=Height, center=true, $fn=cyl_res);
		// hole
		cylinder(d=hole_dia, h=Height+Delta*2, center=true, $fn=Manual_sides);
		
	}
}

module ball () {
	difference() {
		// bearing
		pretty_cylinder();
		//cylinder(d=Bearing_diameter, h=Height, center=true, $fn=cyl_res);
		// hole
		sphere(d=Ball_diameter, center=true, $fn=50);
		// split
		translate([0,Bearing_diameter/2,0])
		cube(size=[split_gap,Bearing_diameter,Height+Delta*2], center=true);
		
	}
}

if (Bolt_or_Ball == "Bolt")
	bolt();
else
	ball();