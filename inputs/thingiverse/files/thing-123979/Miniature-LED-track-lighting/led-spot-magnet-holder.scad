/*
 * A holder to make miniature spotlights out of LEDs.
 *
 * This uses two square magnets to make contact with a power supply. The magnets
 * connect to a resistor (on the - side) and a wire on the + side. There are
 * two holes that go through the holder to the LED itself.
 *
 * All units here are in mm.
 */

// Size of the magnets (mm).
magnet_size=4.1;

// Distance from the center of the holder to the edge of the magnets.
center_offset=3;

// Diameter of the center hole.
center_hole=2;

// Height of the housing above the magnet.
height_above_magnets=2;

// Distance from the edge of the magnet to the edge of the housing.
magnet_to_wall=2;

// Size of the polarity keying. This is a notch cut out of the body, marking
// the cathode (-). This is the same as the flat spot on LEDs.
key_size=1.25;

// Length of the resistor channel (this is the length of your resistor, plus a
// little wiggle room for the leads).
resistor_x=7;

// Width of the resistor channel (this is the width of your resistor).
resistor_y=2;

// Size of the hole for the resistor. This should probably be the same as the
// center_hole.
resistor_hole=2;

/////////////////////////////////////////////////////////////////////

resistor_z=magnet_size;

top_h=height_above_magnets;

body_radius = magnet_size + center_offset + magnet_to_wall;
body_height=magnet_size+top_h;

/*
 * Rotate the body to make it printable on an extrusion printer.
 */
rotate([-180,0,0]){
	magnet_holder();
}

/*
 * The body of the holder.
 */
module magnet_holder(){
	difference(){
		// The main body of the holder.
		cylinder(h=body_height,r=body_radius,$fn=50);

		// Polarity key (this marks the cathode).
		translate([body_radius - key_size,-body_radius,0])
			cube([key_size, body_radius*2, body_height]);

		// Left magnet (anode, positive).
		translate([-magnet_size/2-center_offset,0,magnet_size/2]){
			magnet();
		}
		// Hole in the center for the cathode.
		cylinder(h=magnet_size+top_h,r=center_hole/2,$fn=20);

		// Channel to pass wire from the magnet to the center hole.
		translate([-4,-center_hole/2,0])
			cube([4,center_hole,magnet_size]);

		// Right magnet (cathode, negative).
		translate([magnet_size/2+center_offset,0,magnet_size/2]){
			magnet();
		}

		// Hole for resistor connected to the cathode.
		translate([center_offset+resistor_y/2,magnet_size/2-resistor_y/2,0]){
			rotate([0,0,-45]){
				translate([-resistor_x,-resistor_y/2,0]){
						cube([resistor_x,resistor_y,resistor_z]);

					// Hole for wire on other side of resistor.
					translate([0,resistor_y/2,0]){
						cylinder(h=magnet_size+top_h,r=resistor_hole/2,$fn=20);
					}
				}
			}
		}
	}
}

/*
 * An individual square magnet cavity.
 */
module magnet(){
	cube([magnet_size,magnet_size,magnet_size],center=true);
}
