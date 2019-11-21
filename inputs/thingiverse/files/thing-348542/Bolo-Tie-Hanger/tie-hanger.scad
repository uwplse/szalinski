// Hanger length in cm
hanger_length = 25 ;	// [15:35]

// Width bar/loop in mm
width_of_bar = 10  ;	// [5:15]

// rotate([0, 0, 45])
translate([-10 * hanger_length / 2 - width_of_bar / 2, 54.5, 0])
tie_hanger(hanger_length * 10, width_of_bar) ;

module tie_hanger(length, width) {
    gap = 15 ;	// gap between slots
    r = width / 2 ;
    s = sin(45) ;

    // The main bar
    difference() {
        cube(size=[length, width * 2, width]) ;
        for (i = [gap + r:gap + width:(length - width - gap) / 2]) {
            translate([length / 2 + i - r, -1, -1])
            cube(size=[width, width + 1, width + 2]) ;
            translate([length / 2 - i - r, -1, -1])
            cube(size=[width, width + 1, width + 2]) ;
        }
    }

    // tips on the end
    translate([0, -r * 4, 0]) cube(size=[width, width * 2, width]) ;
    translate([length - r * 2, -r * 4, 0]) cube(size=[width, width * 4, width]) ;

    // The center hanger part
    color("red")
    union() {
        translate([length / 2 - r, -20, 0]) cube(size=[width, 20, width]) ;
        translate([length / 2 - 20 - r, -20, 0]) rotate([0, 0, -90]) eigth(width) ;

        translate([length / 2 - 20 - r + (40 + width) * s,
                   -20 - (40 + width) * s, 0])
        rotate([0, 0, 90]) eigth(width) ;

        translate([length / 2 - 20  - r + (40 + width) * s,
                   -20 - 2 * (20 + r) * s, 0])
        rotate([0, 0, 180])
        intersection() {
            ring(width) ;
            translate([-21 - width, -1, -1])
            cube(size=[42 + 2 * width, 22 + width, width + 2]) ;
        }
    }
}

module eigth(w) {
    $fn = 120 ;
    r = 20 ;
    intersection() {
        ring(w, r) ;
        cube(size=[r + w, r + w, w + 2]) ;
        rotate([0, 0, 45]) cube(size=[r + w, r + w, w + 2]) ;
    }
}

module ring(w) {
    rotate_extrude() translate([20, 0, 0]) square([w, w]) ;
}