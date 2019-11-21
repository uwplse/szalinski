include <MCAD/boxes.scad>

// Define the distance between surface an kinect-sensor-base (in millimeters!)
riser_distance = 32;

/* [Hidden] */
$fn=200;
// define inner dimensions (how big the box will be inside)
w = 83;
l = 70;
h = (riser_distance+8);
cr = 25;
cable = 8;
wall = 6;
wiggle = 2; // wiggle room added to inside of box

//origins
o_x = ((w+wall*2)/2); // left
o_y = ((l+wall*2)/2); // front
o_z = ((h+wall)/2); // bottom

cable_guide_w = 8;
cable_guide_h = h+wall*2;
union() {
	difference() {
	    // outside box needs to fit whatever object is defined above
        translate([o_x,o_y,o_z])
        roundedBox([w+wall*2, l+wall*2, h+wall], cr + wall/2, true);

		union() {
            //spheric hole at the bottom of the box to save material and Time
            translate([o_x,o_y,0])
            resize(newsize=[w,l,((riser_distance-wiggle)*2)+wiggle]) sphere (r=riser_distance-wiggle);
            
            // inside box
			translate([o_x,o_y,((h+wiggle*2+10)/2)+riser_distance])
            roundedBox([w+wiggle*2, l+wiggle*2, h+wiggle*2+10], cr, true);

			// cable guide
			translate([o_x, o_y-l/2-wiggle*2, (cable_guide_h/2)+riser_distance+2]) {
				rotate([90,0,0])
                roundedBox([cable_guide_w, cable_guide_h, wall], 2, true);
			}

		}
	}
}