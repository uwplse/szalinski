
/* [Size and Shape Settings] */

// Inner radius (to fit forearm)
ir = 30; // [2:100]

// Radius of inner loops
or1 = 6; // [1:50]

// Radius of outer loops
or2 = 8; // [1:50]

// Number of loop segments
segments = 16; // [1:100]

// Height of bracelet
h = 8; // [1:200]

/* [Advanced] */

// Diameter of perimeters in mm
perim = 0.7;

// Accuracy of cylindrical surfaces
$fn=64; // [8:128]


/* [Hidden] */


//ensure segments are less than 2*pi*ir / 2*or1;

ang1 = 360 / segments;

cr1 = ir + or1;

o = cr1 * sin(ang1/2);
a1 = or1 + or2 - perim;
a = sqrt(a1*a1 - o*o);

cr2 = cr1 * cos(ang1/2) + a;

delta = asin((cr2 * sin(ang1/2)) / a1 );

tau = atan(o / (sqrt(a1*a1 - o*o)));

// has delta exceeded 90 degrees?
a2 = cr1 / cos(ang1/2);


module bracelet() {

	/*
	The bracelet shape is built in 2D then extruded for speed and robustness.

	By creating a union of all the circle shapes before punching out all the little circles,
	it ensures nice clean joins between the various loops.
	*/

	color("red")
		linear_extrude(height=h)
		difference() {
			// loop shapes
			union() {
				// inner ring
				for (i=[0:segments-1])
					rotate([0,0,i*ang1])
					translate([cr1,0,0])
					if (cr2 < a2) {
						pieSlice(or1,(90-delta)+90,360-(90-delta)-90);
					} else {
						pieSlice(or1,delta,360-delta);
					}


				// outer ring
				for (i=[0:segments-1])
					rotate([0,0,i*ang1 + ang1/2])
					translate([cr2,0,0])
					rotate([0,0,180])
					pieSlice(or2,tau,360-tau);
			}

			// subtract away lots of circles to make the loops hollow
			// inner ring
			for (i=[0:segments-1])
				rotate([0,0,i*ang1])
				translate([cr1,0,0])
				circle(r=or1-perim);

			// outer ring
			for (i=[0:segments-1])
				rotate([0,0,i*ang1 + ang1/2])
				translate([cr2,0,0]) circle(r=or2-perim);

		}
}



bracelet();


/*
Utilities - from MCAD/2DShapes.scad
*/

module pieSlice(size, start_angle, end_angle) //size in radius(es)
{
    rx = ((len(size) > 1)? size[0] : size);
    ry = ((len(size) > 1)? size[1] : size);
    trx = rx* sqrt(2) + 1;
    try = ry* sqrt(2) + 1;
    a0 = (4 * start_angle + 0 * end_angle) / 4;
    a1 = (3 * start_angle + 1 * end_angle) / 4;
    a2 = (2 * start_angle + 2 * end_angle) / 4;
    a3 = (1 * start_angle + 3 * end_angle) / 4;
    a4 = (0 * start_angle + 4 * end_angle) / 4;
    if(end_angle > start_angle)
        intersection() {
		if(len(size) > 1)
        	ellipse(rx*2,ry*2);
		else
			circle(rx);
        polygon([
            [0,0],
            [trx * cos(a0), try * sin(a0)],
            [trx * cos(a1), try * sin(a1)],
            [trx * cos(a2), try * sin(a2)],
            [trx * cos(a3), try * sin(a3)],
            [trx * cos(a4), try * sin(a4)],
            [0,0]
       ]);
    }
}
