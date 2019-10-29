// The diameter of the dowel hole in mm (you may want to add a mm or two for clearance)
dowel_d = 13;

// The diameter of the flange for mounting the dowel holder (in mm)
flange_d = 0;

/* [Dowel Customization] */

// The height of the dowel holder in mm (inclusive of the height of the flange)
dowel_h = 20;

// The thickness of the wall holding the dowele in mm
dowel_wall = 5;

/* [Flange Customization] */

// The height of the flange in mm
flange_h = 4;

// The diameter (in mm) for the holes placed for mounting the holder (0 disables the holes)
flange_hole_d = 6;

/* [Hidden] */

holder_d = dowel_d + dowel_wall*2;
$fn = 50;

module holder() {
    difference() {
        union() {
            cylinder(d = holder_d, h=dowel_h);
            translate([0, -holder_d/2, 0]) cube([dowel_d/2 + dowel_wall, holder_d, dowel_h]);
        }
        translate([0, 0, flange_h]) union() {
            cylinder(d=dowel_d, h=100);
            translate([0, -dowel_d/2, 0]) cube([100, dowel_d, 100]);
        }
    }
}

module flange() {
    difference() {
        cylinder(d = flange_d, h = flange_h);
        if (flange_hole_d > 0) {
            for (xy = [ [0, 1], [-1, 0], [0, -1] ]) {
                delta = (holder_d + (flange_d - holder_d)/2)/2;
                translate([xy[0] * delta, xy[1] * delta, 0]) cylinder(d=flange_hole_d, h=100);
            }
        }
    }
}

holder();
if (flange_d > 0) {
    flange();
}