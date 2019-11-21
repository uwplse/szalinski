// simple parametric hook 0.2
// instruction poetry by byteborg, 2013
// karsten@rohrbach.de
// CC BY-NC 3.0

/* [Global] */
// How high should the hook be?
HEIGHT = 80; // [40:200]
// How deep should it reach?
DEPTH = 50;  // [15:150]
// Overall material thickness
ZTHICKNESS = 10; // [5:20]
// How long should the hook extend from the bottom half-circle?
LOOPLENGTH = 20;  // [0:100]
// Rounding factor
ROUNDING = 2; // [0.0:4.0]
// Mounting hole spacing
HOLESPACING = 20; // [0:100]
// Mounting hole diameter
HOLEDIA = 4; // [2.5, 3, 4, 5]

/* [Hidden] */
THICKNESS = ZTHICKNESS - ROUNDING*2;
q = .1;

print_part();

module screw() {
    rotate([0, 0, 30]) cylinder(h=15+ZTHICKNESS, r=(HOLEDIA+.2)/2, center=true, $fn=6);
    translate([0, 0, 15/2]) cylinder(h=5, r1=1.5, r2=6, center=true, $fn=72);
}

module print_part() {
    difference() {
        linear_extrude(height=ZTHICKNESS) {
            minkowski() {
                union() {
                    translate([0, 0]) square([THICKNESS, HEIGHT-DEPTH/2]);
                    translate([DEPTH-THICKNESS, 0]) square([THICKNESS, LOOPLENGTH]);
                    translate([DEPTH/2, q]) difference() {
                        circle(r=DEPTH/2, $fn=144);
                        translate([-DEPTH, q]) square([DEPTH*2, DEPTH]);
                        circle(r=DEPTH/2-THICKNESS, $fn=144);
                    }
                }
                circle(r=ROUNDING, $fn=32);
            }
        }
        translate([ZTHICKNESS - 9.6, HEIGHT-DEPTH/2-ZTHICKNESS/2-ROUNDING/2, ZTHICKNESS/2]) rotate([0, 90, 0]) {
            translate([0, 0, 0]) screw();
            translate([0, -HOLESPACING, 0]) screw();
        }
    }
}

//.
