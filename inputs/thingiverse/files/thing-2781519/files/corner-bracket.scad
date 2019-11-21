// Outside dimension of the square tube
a = 20;
// Wall thickness of the tube
b = 1.2;
// How far the prongs should extend into the tube. Ideally, about 1.5 times the dimension of the tube.
c = 30;
// Clearance. More clearance makes the prongs fit looser. 0.2 produces a sliding fit on my printer.
d = 0.2;
// Radius of the rounding on the prongs. 2 is about right.
f = 2;


// Nice rounding on the round edges
$fs=0.02;

// plug cross section
e = a-b-b-d-d;

// Rounded top cylinder
module rts(h, r) {
    cylinder(h-r, r=r);
    translate([0,0,h-r]) sphere(r=r);
}

// One prong
module prong() {
    translate([b+d, b+d,a]) hull() {
        translate([f,f,0]) rts(c, f);
        translate([e-f,f,0]) rts(c, f);
        translate([f,e-f,0]) rts(c, f);
        translate([e-f,e-f,0]) rts(c, f);
    }
}

// All three prongs and connection, rotated to print without support
difference() {
    rotate(a=atan(sqrt(2)), v=[1,1,0]) union() {
        cube([a, a, a], center=false);
        prong();
        rotate([-90,0,0]) translate([0,-a,0]) prong();
        rotate([0,-90,0]) translate([0,0,-a]) prong();
    };
    translate([0,0,-4*a]) cube([a*8, a*8, a*8], center=true);
}
