// Thickness of part surfaces. 3mm will give a robust part.
thickness = 3;
// Distance in mm that fin will go away from the fan.
fin_height = 22;
// Distance in mm between tilt section and mounting section.
spacer = 3;
// Distance into the fan that the fin tilts inward towards the fan.
fin_tilt = 30; // [0:50]
// The center-to-center distance between fan mounting holes, used for sizing the fan mount plate.
fan_mounting_hole_seperation = 81;
// Size of hole for the chassis mount screw.
fan_screw_hole_diameter = 5;
// Diameter in mm of your screw or screwdriver, whichever is larger. Or zero if you can mount from the other side.
access_hole_diameter = 7;

module fan_stand(thickness, space, height, tilt, fan_hole_sep)
{
	// Calculate sizes of parts (some calculations are done below).
	fan_dia = fan_mounting_hole_seperation + 2*fan_screw_hole_diameter;
	// These two are overridden below because OpenSCAD can't assign
	// values inside conditionals.
	mount_width = 2 * fan_screw_hole_diameter + 2 * thickness;
	width = fan_dia/2+thickness/2;

	// =============================== //
	// Fin
	// =============================== //

	module fin(screw_height) {
		adjusted_fin_height = height - space - thickness*2;
		difference() {
			union() {
				// spacer
				translate([0, thickness, 0])
				cube([width, spacer, thickness]);

				// fin
				translate([0, thickness+space, 0])
				rotate([0,90,0])
				linear_extrude(height=width) {
					// Trapazoidal polygon.
					polygon(points=[[0, thickness], [0, 0], [-thickness, 0],
						[-tilt, adjusted_fin_height], [-tilt, adjusted_fin_height+thickness]]);
				}
			}

			// Cut access hole for fan mount screw
			translate([fan_hole_sep/2, 2*thickness + height,screw_height]) 
			rotate([90,0,0])
			cylinder(h=height+2, r=access_hole_diameter/2, center = false, $fn=100);
		}


	}

	// =============================== //

	module fan_mount(x, y, z, screw_height) {
		difference() {
			cube([x, y, z]);

			// Cut fan mount screw hole
			translate([fan_hole_sep/2, thickness+1, screw_height]) 
			rotate([90,0,0])
			cylinder(h=thickness+2, r=fan_screw_hole_diameter/2, center = false, $fn=100);
		}
	}

	// =============================== //
	// Assembly
	// =============================== //

	module half_of_mount() {
		// Create half
		union() {
			// Fan mount (conditional accounts for small screw hole).
			if (mount_width < thickness) {
				fan_mount(width, thickness, thickness*3, z/3 * 2);
				fin(z/3 * 2);
			} else {
				fan_mount(width, thickness, mount_width, mount_width/3*2);
				fin(mount_width/3 * 2);
			}				
		}
	}

	// Create and join both halves.
	module complete_mount() {
		union() {
			// First half
			half_of_mount();

			// Second half
			mirror([1, 0, 0])
			half_of_mount();
		}
	}

	// Create mount and cut out the air hole.
	difference() {
		complete_mount();

		// Air cutout
		translate([0, thickness*1.5, fan_dia/2 + thickness*1.7]) rotate([90,0,0])
		cylinder(h=thickness*3, r=fan_dia/2, center = false, $fn=100);
	}
}

fan_stand(thickness, spacer, fin_height, fin_tilt, fan_mounting_hole_seperation);

