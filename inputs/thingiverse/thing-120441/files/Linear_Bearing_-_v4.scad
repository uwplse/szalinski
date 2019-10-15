/* [Linear Bearing] */

// Outer Diameter (mm)
outer_diameter = 14.8;
outer_radius = outer_diameter / 2;

// Inner Diameter (mm)
inner_diameter = 8;
inner_radius = inner_diameter / 2;

// Sidewall Thickness (mm)
sidewall_thickness = 2;

// Height (mm)
height = 12; 

// Split Bearing?
split_bearing = "Yes";  // [Yes,No]

/* [Hidden] */
resolution = 200;
fudge = .1;

module half_bearing() {
	rotate([0,0,-15]) 
	difference() {
		cylinder(r = outer_radius, h = height, $fn = resolution);
	
		translate([0,0,-fudge])
		cylinder(r = inner_radius, h = height + fudge * 2, $fn = resolution);
		
		for (r = [-90, -60, -30, 0, 30, 60, 90]) 
			rotate([0,0,r]) 
			translate([0,0,height/2 - fudge]) 
			cube([inner_radius/4,outer_radius * 2 - sidewall_thickness,height + fudge * 4], center = true);
	
		rotate([0,0,15]) 
		translate([0,-outer_radius * 1.1,-fudge]) 
		cube([outer_radius,outer_radius * 2.2,height + fudge * 4]);
	}
}

if (split_bearing == "Yes") {
	translate([-1,0,0])
	half_bearing();
	translate([1,0,0])
	rotate([0,0,180])
	half_bearing();
} else {
	half_bearing();
	rotate([0,0,180])
	half_bearing();
}

