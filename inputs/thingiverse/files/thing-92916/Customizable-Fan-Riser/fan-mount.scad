// Thickness of part surfaces.
thickness = 3;
// Distance in mm that fan will be raised by. Any distance in mm greater than 2 x thickness.
height = 34;
// Center-to-center distance in mm between fan mounting holes, used for sizing the fan mount plate. i.e. an 80mm fan should be set to 71.5mm
fan_mounting_hole_seperation = 71.5;
// Center-to-center distance in mm between chassis mounting holes, used for positioning the mounting feet.
mount_hole_seperation = 100;
// Chassis mount screw hole diameter in mm.
mount_screw_hole_diameter = 5;
// Fan mount screw hole diameter in mm.
fan_screw_hole_diameter = 5;

module fan_stand(thickness, height, fan_hole_sep, mount_hole_sep)
{
	// Calculate sizes of parts (some calculations are done below).
	fan_dia = fan_mounting_hole_seperation + 2*fan_screw_hole_diameter;
	strut_tilt = (mount_hole_sep - fan_dia) / 2;
	// These two are overridden below because OpenSCAD can't assign
	// values inside conditionals.
	mount_width = 2 * fan_screw_hole_diameter;
	foot_width = 3 * thickness;

	// Mounting strut
	module mounting_strut() {
		tilt = strut_tilt;
		x1 = fan_dia/2;           //   p5 -- p4
		x2 = x1+thickness;        //  /     /
		x3 = x1+tilt+thickness;   // p6    p3
		x4 = x1+tilt;             // |     |
		z = height - thickness;   // p1 -- p2

		linear_extrude(height=thickness) {
			// Trapazoidal polygon.
			polygon(points=[[x1, 0], [x2, 0], [x2, thickness],
							[x3, z], [x4, z], [x1, thickness]]);
		}
	}

	module foot(size) {
		// Mounting foot
		footX = size;
		footY = thickness;
		footZ = footX;
		x = fan_dia/2 + strut_tilt - size/2;
	
		difference() {
			translate([x, height - thickness, 0])
				cube([footX, footY, footZ]);

			// Cut chassis mount screw hole
			translate([mount_hole_sep/2, height +1, size/2]) 
			rotate([90,0,0])
				cylinder(h=thickness+2, r=mount_screw_hole_diameter/2, center = false, $fn=100);
		}
	}

	module half_of_mount() {
		difference() {	
			// Create half
			union() {
				// Fan mount (conditional accounts for small screw hole).
				if (mount_width < thickness) {
					cube([fan_dia/2+thickness/2,thickness,thickness*3]);
				} else {
					cube([fan_dia/2+thickness/2,thickness,mount_width]);
				}

				// The strut.
				mounting_strut();
	
				// Mounting feet  (conditional accounts for small screw hole).
				if (mount_screw_hole_diameter < thickness) {
					foot(thickness * 3);
				} else {
					foot(mount_screw_hole_diameter * 3);
				}
			}
			// Cut fan mount screw hole
			translate([fan_hole_sep/2, thickness+1, mount_width/2]) 
			rotate([90,0,0])
			cylinder(h=thickness+2, r=fan_screw_hole_diameter/2, center = false, $fn=100);
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
		translate([0, thickness*1.5, fan_dia/2 + thickness*0.7]) rotate([90,0,0])
		cylinder(h=thickness*3, r=fan_dia/2, center = false, $fn=100);
	}
}

fan_stand(thickness, height, fan_mounting_hole_seperation, mount_hole_seperation);

