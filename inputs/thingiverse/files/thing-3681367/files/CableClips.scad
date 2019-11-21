// Wall thickness
thickness = 2.0; // 1.0-3.0

// Length of the clips
w = 10.0; // 5.0-20.0

// Diameter of first cable
dia1 = 6.5; // 3.0-10.0

// Diameter of second cable
dia2 = 7.0; // 3.0-10.0

/* [Hidden] */
// Roundness
fn = 100;
// Size of opening to push cables in
angle = 60;

// --- code starts here ---
union() {
	// first diameter
	translate([0, (dia1+thickness)/2, 0]) union() {
        difference() {
            cylinder(h=w, $fn=fn, d=dia1+2*thickness, center=true);
            cylinder(h=w+1, $fn=fn, d=dia1, center=true);
            linear_extrude(height=w+1, center=true) polygon(points=[[0, 0], [0, -2*(dia1+2*thickness)], [sin(angle)*2*(dia1+2*thickness), cos(angle)*2*(dia1+thickness)]]);
        }
        translate([sin(angle)*(dia1+thickness)/2, cos(angle)*(dia1+thickness)/2]) cylinder(h=w, $fn=fn, d=thickness, center=true);
    }
	// second diameter
	translate([0, -(dia2+thickness)/2, 0]) union() {
        difference() {
            cylinder(h=w, $fn=fn, d=dia2+2*thickness, center=true);
            cylinder(h=w+1, $fn=fn, d=dia2, center=true);
            linear_extrude(height=w+1, center=true) polygon(points=[[0, 0], [0, 2*(dia2+2*thickness)], [sin(angle+180)*2*(dia2+2*thickness), cos(angle+180)*2*(dia2+thickness)]]);
        }
        translate([sin(angle+180)*(dia2+thickness)/2, cos(angle+180)*(dia2+thickness)/2]) cylinder(h=w, $fn=fn, d=thickness, center=true);
    }
    // add overlap between the two halfs (makes object manifold)
    cylinder(h=w, $fn=fn, d=thickness, center=true);
}
