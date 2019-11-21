// Coil structure for HF antenna traps construction
// 2017-09-17
// by Frederic Rible F1OAT (frible@teaser)
// Idea credit F1HDI
// Helix module by Gael Lafond

/* [Global] */

// Through hole diameter
hole_diameter = 15.5;

// Coil external diameter, including wire
coil_diameter = 24.5;

// Wire diameter
wire_diameter = 2;

// Helical coil length
coil_length = 150;

// Total number of turns
nb_turns = 54;

// Thread depth as percentrage of wire diameter
depth = 25;

// Shoulders diameter
shoulder_diameter = 33;

// Shoulders length

shoulder_length = 20;

// Cylinders precision in number of facets
precision = 32;

/* [Hidden] */

cylinder_diameter = coil_diameter-2*wire_diameter*(1-depth/100);
epsilon = 0.01;

slot_depth = wire_diameter*1.5+6;
slot_width = wire_diameter + 1;

/*
 * =====================================
 *   This is public Domain Code
 *   Contributed by: Gael Lafond
 *   24 March 2017
 * =====================================
 *
 * This is my attempt at creating a predictable
 * helix that can be created from any polygon.
 *
 * It works in a very similar fashion to rotate_extrude,
 * with a height parameter.
 *
 * The height of the final object is equal to the
 * height parameter + the height of the provided polygon.
 */

module helix_extrude(angle=360, height=100, $fn=30) {
	// Thickness of polygon used to create an helix segment
	epsilon = 0.001;

	// Number of segments to create.
	//   I reversed ingenering rotate_extrude
	//   to provide a very similar behaviour.
	nbSegments = floor(abs(angle * $fn / 360));

	module helix_segment() {
		// The segment is "render" (cached) to save (a lot of) CPU cycles.
		render() {
			// NOTE: hull() doesn't work on 2D polygon in a 3D space.
			//   The polygon needs to be extrude into a 3D shape
			//   before performing the hull() operation.
			//   To work around that problem, we create extremely
			//   thin shape (using linear_extrude) which represent
			//   our 2D polygon.
			hull() {
				rotate([90, 0, 0])
					linear_extrude(height=epsilon) children();

				translate([0, 0, height / nbSegments])
					rotate([90, 0, angle / nbSegments])
						linear_extrude(height=epsilon) children();
			}
		}
	}

	union() {
		for (a = [0:nbSegments-1])
			translate([0, 0, height / nbSegments * a])
				rotate([0, 0, angle / nbSegments * a])
					helix_segment() children();
	}
}

// Section by F1OAT

module shoulder() {
    union() {
        L1 = (shoulder_diameter - cylinder_diameter)/2;
        L2 = shoulder_length - L1;
        cylinder(h=L2, d=shoulder_diameter, $fd=precision);
        translate([0, 0, L2]) {
            cylinder(h=L1, d1=shoulder_diameter, d2=cylinder_diameter, $fd=precision);
        }
    }
}

module wire() {
    helix_extrude(angle=360*nb_turns, height=coil_length, $fn=precision) {
        translate([coil_diameter/2-wire_diameter/2, 0, 0]) {
            // Use square instead of circle to decrease the rendering time
            *circle(r=wire_diameter/2);
            rotate([0, 0, 45])square(size=wire_diameter, center=true);
        }
    }
}

module coil() {
    difference() {
        cylinder(h=coil_length, d=cylinder_diameter, center=false, $fn=precision);
        rotate([0, 0, 240]) wire();
    }
}

difference()
{
    union() {
        shoulder();
        translate([0, 0, shoulder_length]) coil();
        translate([0, 0, coil_length+2*shoulder_length]) rotate([180, 0, 0]) shoulder();
    }
    translate([0, 0, -epsilon]) cylinder(h=coil_length+2*shoulder_length+2*epsilon, d=hole_diameter, center=false, $fn=precision);
    translate([0, shoulder_diameter/2, coil_length+shoulder_length-epsilon]) union() {
        rotate([0, 0, 220]) 
            translate([-slot_width, 0, 0])
                cube([slot_width, slot_depth, shoulder_length+2*epsilon], center=false);
    }
}


