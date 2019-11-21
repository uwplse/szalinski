x_length = 2;
y_length = 2;

// The stanley cases have two bins on either side of the handle.  Those bins need to only have nubs on the corners.  The side bins should also be 2 for both x an y
middle_nubs = "yes"; // [yes,no]

// ignore variable values
middle = middle_nubs == "yes";

module stanley_base(x, y, middle=true) {
    hull() {
        translate([3,3,0]) cylinder(1,3,3,$fn=25);
        translate([39*x-3,3,0]) cylinder(1,3,3,$fn=25);
        translate([3,53.5*y-3,0]) cylinder(1,3,3,$fn=25);
        translate([39*x-3,53.5*y-3,0]) cylinder(1,3,3,$fn=25);
    }
    if (middle) {
        intersection() {
            union() {
                for (i = [0:x]) {
                    for (j = [0:y]) {
                        translate([39*i,53.5*j,0]) cylinder(3,8,7.7,$fn=100);
                    }
                }
            }
            union() {
                for (i = [1:x]) {
                    for (j = [1:y]) {
                        translate([39*(i-1), 53.5*(j-1), 0]) translate([3,3,0]) cube([33,47.5,3.1]);
                    }
                }
            }
        }
    } else {
        intersection() {
            union() {
                translate([39*0,53.5*0,0]) cylinder(3,8,7.7,$fn=100);
                translate([39*0,53.5*y,0]) cylinder(3,8,7.7,$fn=100);
                translate([39*x,53.5*0,0]) cylinder(3,8,7.7,$fn=100);
                translate([39*x,53.5*y,0]) cylinder(3,8,7.7,$fn=100);
           }
           union() {
                for (i = [1:x]) {
                    for (j = [1:y]) {
                        translate([39*(i-1), 53.5*(j-1), 0]) translate([3,3,0]) cube([33,47.5,3.1]);
                    }
                }
            }
        }
    }
}

stanley_base(x_length, y_length, middle);