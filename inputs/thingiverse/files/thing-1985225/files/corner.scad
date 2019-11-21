$fn=30 * 1;

width=80;    // [25:200]
height=70;   // [25:200]
depth=40;    // [5:200]
thickness=2; // [0.5:5]
with_nailmount="no"; // [yes,no]

module poly(x1, x2, x3, y1, y2, z1, z2) {
    polyhedron(
        points=[
            [x1, y1, z1],  // 0
            [x2, y1, z2],  // 1
            [x3, y1, z2],  // 2
            [x1, y2, z2]], // 3
        faces=[[3, 0, 1],
               [3, 1, 2],
               [2, 0, 3],
               [1, 2, 3],
               [1, 0, 2]]);
}

module nailmount(d) {
    ot = d - .3;
    it = d - ot;
    rotate([90, 270, 0]) {
        // Outside (uneven circles)
       hull() {
            translate([d, 0, 0]) cylinder(h=d, r=2.5);
            translate([3 + d, 0, 0]) cylinder(h=d, r=1.5);
        }
        // Inside bits (even circles)
        hull() {
            translate([d, 0, 0]) cylinder(h=ot, r=2.5);
            translate([3 + d, 0]) cylinder(h=ot, r=2.5);
        }
    }
}

module vase(w, h, d, t) {
    ih = (d - (2*t)) / (d/h);
    iw = (d - (2*t)) / (d / (w/2));
    rotate([90, 0, 0]) {
        difference() {
            poly(0, w/2, -w/2, 0, d, 0, h);
            poly(0, iw-t, -iw+t, t, d-(2*t), h-ih, h+.1);
        }
    }
}

module vase_with_nailmount(w, h, d, t) {
    difference() {
        vase(w, h, d, t);
        translate([0, t-.20001, h*.75]) nailmount(t-.2);
    }
}

if (with_nailmount == "yes") {
    vase_with_nailmount(width, h=height, d=depth, t=thickness);
} else {
    vase(width, h=height, d=depth, t=thickness);
}
