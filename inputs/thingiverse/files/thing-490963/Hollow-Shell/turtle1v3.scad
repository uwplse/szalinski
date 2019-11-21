
// preview[view:south west, tilt:bottom diagonal]

// Radius of cube in mm (center to faceted surface along short axis)
shell_radius=25;


border_radius=shell_radius/8;
cut_radius=shell_radius/3;

rotate([180,0,0]) 
scale([1.5,1,1])
difference() {
	union() {
		//outer shell, intentionally chunky
		sphere(shell_radius, $fn=12); 
		// spin a circle in another circle for donut, 
		// then "hull" it for pancake.  This is the
		// border around the bottom
		hull() {
			rotate_extrude($fn=100)
			translate([shell_radius, -border_radius/2, 0])
			circle(r = border_radius, $fn=40);
		} 
		// spin a circle in another circle for donut, 
		// then "hull" it for pancake.  Then rotate and
		// translate it out to the sides for border around
		// end openings (x2 with opposite translations)
		scale([1,1.5,1])
		rotate([0,90,0])
		translate([0,0,shell_radius-border_radius/2])
		hull() {
			rotate_extrude($fn=100)
			translate([cut_radius, -border_radius, 0])
			circle(r = border_radius, $fn=40);
		}
		scale([1,1.5,1])
		rotate([0,90,0])
		translate([0,0,-shell_radius+border_radius/2])
		hull() {
			rotate_extrude($fn=100)
			translate([cut_radius, border_radius, 0])
			circle(r = border_radius, $fn=40);
		}
	}

	// Difference away the inner sphere (smooth for strength)
	sphere(shell_radius-shell_radius/10, $fn=100);

	// Difference away bottom half to make it a half-shell
	translate([-shell_radius*2,-shell_radius*2,0]) cube(shell_radius*4);

	// Difference away cylinder for end openings
	rotate([0,90,0]) translate([0,0,-shell_radius*2]) scale([1,1.5,1]) cylinder(h=shell_radius*4,r=cut_radius,$fn=30);

	// Difference away a little at the ends to make them smooth
	translate([shell_radius-shell_radius/50-border_radius/2,-shell_radius,-shell_radius]) cube(shell_radius*2);
	translate([-shell_radius*3+shell_radius/50+border_radius/2,-shell_radius,-shell_radius]) cube(shell_radius*2);
}

