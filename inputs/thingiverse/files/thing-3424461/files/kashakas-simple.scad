// kashakas, take 2 - scruss 2019

//CUSTOMIZER VARIABLES

// Shell diameter, mm
diameter    = 48;
// String thickness, mm
string      =  4;
// Shell wall, mm
wall        =  1.6;

// CUSTOMIZER VARIABLES END

module naff() { }       // to make Customizer look no further

// smooth sides based on size
$fn         =  4 * (1 + floor(diameter / 4));

module one_side() {
    difference() {
        circle(d = diameter - 4 * wall);
        translate([2 * wall + (string - diameter) / 2, 0]) {
            square(diameter, center = true);
        }
    }
}

module shell() {
    rotate_extrude()difference() {
        difference() {
            offset(r = 2 * wall)one_side();
            offset(r = wall)one_side();
        }
        translate([0, -diameter])square(diameter);
    }
}

shell();
