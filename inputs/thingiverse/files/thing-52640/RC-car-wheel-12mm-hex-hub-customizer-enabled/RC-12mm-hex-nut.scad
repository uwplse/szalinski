include <MCAD/shapes.scad>;

$fn = 50;	// rounded edge quality (# of faces per 360 degrees)

hex_mm = 12;		// adjust hex size, default 12
// HEX PART HEIGHT -- MODIFY THIS!
hex_height = 6;	// adjust your rim offset, default 6
pin_depth = 2.3;	// adjust for deeper or shallower pin engagement depth, default 2.3
pin_length = 11.2;	// length of axle pin, default 11.2
pin_width = 2.3;	// width of axle pin, default 2.3
axle_hole = 3;		// axle hole diameter, default 3
flare_height = 2;	// flare lead-in up the side of the hex body, default 2

difference(){	// put hole all the way through
	union(){	// combine fillet shape (base) with rest of hex body
		difference(){	// cut rectangular slot from hex body
			translate([0,0,(hex_height-flare_height-((hex_height-6)/2))]) hexagon(hex_mm,(hex_height-flare_height));	// 12mm hex
			 translate([0,0,(hex_height-(pin_depth/2))]) rotate([90,90,90]) cylinder(pin_length,(pin_depth/2),(pin_depth/2), center = true);	// pin cut-out cylinder
			 translate([(pin_length/2*-1),(pin_width/2*-1),(hex_height-(pin_depth/2))]) cube(size=[pin_length,pin_width,pin_depth+1], center = false);	// pin cut-out rectangle
		}
		difference(){	// clear anything extending beyond hex_mm size
			cylinder(flare_height,5.5,7);	// flared-out cylinder to create fillet
			difference(){	// chop off extra bits of flared-out cylinder
				hexagon((hex_mm+3),(flare_height*2));	// hex "od"
				hexagon(hex_mm,(flare_height*2));		// hex "id"
				}
		}
	}
	cylinder(hex_height,axle_hole,axle_hole);
}