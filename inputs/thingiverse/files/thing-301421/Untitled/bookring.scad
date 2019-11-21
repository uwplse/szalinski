/* [Book Ring] */

// Diameter of central thumb hole.
thumb_hole_diameter = 17;

// Displacement of thumb hole above corner.
thumb_hole_offset = 0;	 			

wall_thickness = 3;

height = 10;

// Wing span from center to tip.
wing_length = 30;

// Angle of wings. Smaller angles hold the pages flatter.
angle = 25;

/* [Hidden] */

thumb_radius = thumb_hole_diameter / 2;
$fn = 50;

bookring(thumb_radius, wall_thickness, height);


module bookring(thumb_radius, wall, height) {
	difference() {
		union() {

			// Thumb hole stock
			translate([0, (thumb_radius + (wall / 2)) + thumb_hole_offset, 0])
				cylinder(r = (thumb_radius + wall), h = height);
			
			// Right wing
			rotate([0, 0, angle])
				union() {
					wing(wall);
					spar((thumb_radius * 2.25), ((thumb_radius * 2.25) + wall), wall);
					spar((wing_length - wall), (wing_length * 2), wall);
				}

			// Left wing
			rotate([0, 0, (-angle)])
				mirror([1, 0, 0]) {
					wing(wall);
					spar((thumb_radius * 2.25), ((thumb_radius * 2.25) + wall), wall);
					spar((wing_length - wall), (wing_length * 2), wall);
				}
		}
		
		// Thumb hole
		translate([0, (thumb_radius + (wall / 2)) +thumb_hole_offset, -0.5])
			cylinder(r = thumb_radius, h = height+1);
	}
}


module wing(wall) {
	difference() {
		
		// Exterior perimeter of wing (rounded triangle)
		hull() {
			cylinder(r = wall, h = height);

			translate([wing_length, 0, 0])
				cylinder(r = wall, h = height);

			translate([0, (thumb_radius * 1.5), 0])
				cylinder(r = wall, h = height);
		}

		// Interior perimeter (cutout)
		hull() {
			translate([0, 0, -0.5])
				cylinder(r = 0.1, h = height+1);

			translate([wing_length, 0, -0.5])
				cylinder(r = 0.1, h = height+1);

			translate([0, (thumb_radius * 1.5), -0.5])
				cylinder(r = 0.1, h = height+1);
		}
	}
}

module spar(innerradius, outerradius, wall) {
	intersection() {
		hull() {
			cylinder(r = wall, h = height);
			translate([wing_length, 0, 0])
				cylinder(r = wall, h = height);
			translate([0, (thumb_radius * 1.5), 0])
				cylinder(r = wall, h = height);
		}
		difference() {
			translate([0, thumb_radius, 0])
				cylinder(r = outerradius, h = height);
			translate([0, thumb_radius, -0.5])
				cylinder(r = innerradius, h = height+1);
		}
	}
}

