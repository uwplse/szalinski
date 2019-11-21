// Sizes of objectcs in pictures
// battery size 102,5x54,5x11
// tuner size 112 x 63 x 23
// ft817 case size 135 x 38 x 165

//CUSTOMIZER VARIABLES

opening_width = 55; 

//Box wall thickness
wall = 2; 

// front margin to curved area
front_to_curve = 29;

// external height of the box
h = 12; 

// min lenght of the box 
minlen = 102.5; 

//CUSTOMIZER VARIABLES END

/* [Hidden] */
$fn = 30;

translate([0, 0, h]) rotate([180, 0, 0])  // upside down  to see it better in customizer
    difference() {
        semiround_box([opening_width + wall*2, max(opening_width + wall + front_to_curve, minlen), h]); // main box
        if (opening_width + wall + front_to_curve < minlen) {
            // reduce plastic!!
            // hole is a wall bigger than needed to avoid rendering ghosts
            translate([wall, opening_width + wall + front_to_curve, -wall])
                cube([opening_width, minlen - (opening_width + wall + front_to_curve) - wall, h]);
        }
        translate([wall, 0, 0])
            cube([opening_width, front_to_curve, h - wall]); // front opening
        translate([wall, front_to_curve, 0])
            rotate([0, 90, 0])
                scale([(h-wall)/opening_width, 1, 1])
                    cylinder(opening_width, r=opening_width, $fn=100); // curved reflector
    }

module semiround_box(size, r = 2) {
    x = size[0];
    y = size[1];
    z = size[2];
    hull() {
        for (i = [0, 1]) {
			for (j = [0, 1]) {
                translate([r+i*(x-2*r),r+j*(y-2*r),r+(z-2*r)])
                    sphere(r);
			}
		}
        for (i = [0, 1]) {
			for (j = [0, 1]) {
                translate([r+i*(x-2*r),r+j*(y-2*r),0])
                    cylinder(r, r=r);
			}
		}
    }
}