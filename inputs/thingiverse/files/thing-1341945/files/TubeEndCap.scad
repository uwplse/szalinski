// Hole diameter
inner_diameter = 25;

// Total height
total_height = 10;

// Wall thickness at top
upper_wall_thickness = 1;

// Wall thickness at bottom
lower_wall_thickness = 5;

// Bottom thickness
bottom_thickness = 1;
// Outer rounding radius
bottom_radius = 6;

/* [Hidden] */
smooth = 180;	// Number of facets of rounding cylinder
pad = 0.1;	// Padding to maintain manifold

hole_radius = inner_diameter/2;

difference() {
	union() {
		// Tube cap
		difference() {
			// Outer
            cylinder(total_height,hole_radius+lower_wall_thickness,hole_radius+upper_wall_thickness, center=false,$fn=smooth);
			// Inner (hole)
            translate([0,0,bottom_thickness])
				cylinder(total_height-bottom_thickness+pad,hole_radius,hole_radius,center=false,$fn=smooth);
		}
	}		
	
	// Bottom outer rounding
	difference() {
		rotate_extrude(convexity=10,  $fn = smooth)
			translate([hole_radius+lower_wall_thickness-bottom_radius+pad,-pad,0])
				square(bottom_radius+pad,bottom_radius+pad);
		rotate_extrude(convexity=10,  $fn = smooth)
			translate([hole_radius+lower_wall_thickness-bottom_radius,bottom_radius,0])
				circle(r=bottom_radius,$fn=smooth);
	}
}