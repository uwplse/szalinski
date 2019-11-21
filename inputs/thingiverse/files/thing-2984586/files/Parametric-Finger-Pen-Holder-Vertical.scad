// parametric finger pen holder, remix for MMC
// of their https://www.thingiverse.com/thing:2802074
// scruss - 2018-06
// *** All dimensions millimetres because of course they are ***

//CUSTOMIZER VARIABLES

// Measured finger circumference, mm
finger_perimeter = 60;
// Measured pen circumference, mm
pen_perimeter = 31.4;

// CUSTOMIZER VARIABLES END

module naff() { }       // to make Customizer look no further

// derived diameters
finger_d = finger_perimeter / PI;
pen_d = pen_perimeter / PI;

// fixed design parameters
$fn = 64;	            // OpenSCAD arc smoothness: fairly high
finger_wall = 2.0;		// wall thickness, finger side
pen_wall = 1.5;			// wall thickness, pen side
overall_height = 18;	// total height of holder
pen_height = 10;		// height of (shorter) pen holder
bar = 0.75 * pen_d;		// length of separator between finger and pen
pen_centre_x = bar + (pen_d + finger_d) / 2; // x-coord of centre of pen
finger_cut_angle = 50;	// angle cut out from finger side, degrees
pen_cut_angle = 60;		// angle cut out from pen side

// length - which we need for the side details - depends on
//  the segments we left out of the finger and pen side
overall_length = ((finger_d / 2) + finger_wall) * cos(finger_cut_angle / 2) + pen_centre_x + ((pen_d / 2) + pen_wall) * cos(pen_cut_angle / 2);
// model isn't symmetrical, so we need to calculate minimum
//  coord for correct placement
min_x = 0 - ((finger_d / 2) + finger_wall) * cos(finger_cut_angle / 2);

/*  sine rule fillet - scruss 2018-06
    circle radius r1, centre at origin
    circle radius r2, centre at [x, 0]
  requires 
    fillet radius (x - r1)
    centre *polar* coords [ x, 2 * asin((r2 + x - r1) / (2 * x)) ] 
*/
module sine_fillet(r1 = 20, r2 = 10, x = 40) {
    angle = 2 * asin((r2 + x - r1) / (2 * x));
    difference() {
        polygon([
            [0, 0],
            [x * cos(-angle), x * sin(-angle)],
            [x, 0],
            [x * cos(angle), x * sin(angle)]
        ]);
        union() {
            translate([x * cos(angle), x * sin(angle)]) {
                circle(r = x - r1, center = true);
            }
            translate([x * cos(-angle), x * sin(-angle)]) {
                circle(r = x - r1, center = true);
            }
        }
    }
}

// generate two circles with fillet web between them
module filleted_circles(r1 = 20, r2 = 10, x = 40) {
    union() {
        sine_fillet(r1, r2, x);
        circle(r = r1, center=true);
        translate([x, 0])circle(r = r2, center=true);
    }
}

// cut a triangular segment out of a circle origin 0,0
module segment(start_angle  = -30,
               end_angle    =  30,
               radius       =  10) {
    scale(radius)polygon([
                   [0,                 0],
                   [cos(start_angle),  sin(start_angle)],
                   [cos(end_angle),    sin(end_angle)]
    ]);
}

// 2D model of the finger and pen holes, XY plane
module plan_outline() {
    // positive then negative offset results in smoothed corners
    offset(r=0.5)offset(r=-0.5)difference() {
        filleted_circles((finger_d / 2) + finger_wall, (pen_d / 2) + pen_wall, pen_centre_x);
        // this union is the finger and pen holes
        union() {
            circle(d=finger_d, center=true);
            segment(180 - finger_cut_angle / 2, 180 + finger_cut_angle / 2, finger_d);
            translate([pen_centre_x, 0]) {
                circle(d=pen_d, center=true);
                segment(-pen_cut_angle / 2, pen_cut_angle / 2, pen_d);
            }
        }
    }
}

// 2D model of the vertical profile, XZ plane
module elevation_outline() {
    // again with the offset ... offset smoothing
    offset(r=2)offset(r=-2)translate([min_x, -overall_height / 2]) {
        difference() {
            // side profile is basically a rectangle ...
            square([overall_length, overall_height]);
            union() {
                // ... less a rounded relief out the TR corner for pen
                translate([finger_d + 2 * finger_wall + overall_height - pen_height, overall_height])hull() {
                    circle(r=overall_height - pen_height);
                    translate([finger_d, 0])circle(r=overall_height - pen_height);
                }
                // ... also less a rounded gap in the finger grip
                translate([-finger_d / 6, overall_height / 3])offset(r=1)offset(r=-1)square([finger_d, overall_height / 3]);
            }
        }
    }
}

// intersect extrusions of the 2D profiles at 90 degrees to make model
intersection() {
    linear_extrude(height=overall_height, center=true)plan_outline();
    rotate([90, 0, 0]) {
        linear_extrude(height=2 * overall_height, center=true)elevation_outline();
    }
}
