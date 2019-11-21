// How far away does the negative need to be (mm)?
tlength=65; //Spacing tube depth

lense=47.5*1; //F mount diameter
tube=lense+6; //Tube Diameter

// make the negative face
difference () {
    translate([0,0,-tlength/2]) cylinder(h=2,r=lense/2,$fn=100);
    translate([0,0,-tlength/2+1]) cylinder(h=4,r=11, center=true);
}


// Make the tube
difference() {
    translate([0,0,0]) cylinder(h=tlength,r=lense/2+3,$fn=100, center=true);
    translate([0,0,0]) cylinder(h=tlength+2,r=lense/2,$fn=100, center=true);
}

// Make the mount
intersection() {
    translate([0,0,tlength/2-2]) rotate([0,7,0]) rotate_extrude(convexity = 10, $fn = 100)  translate([tube/2-3, 0, 0]) circle(r = 1.7, $fn = 4);
    translate([0,0,0]) cube([tube/2,tube/2,tlength]);
}

rotate([0,0,120])
intersection() {
    translate([0,0,tlength/2-2]) rotate([0,7,0]) rotate_extrude(convexity = 10, $fn = 100)  translate([tube/2-3, 0, 0]) circle(r = 1.7, $fn = 4);
    translate([0,0,0]) cube([tube/2,tube/2,tlength]);
}

rotate([0,0,-120])
intersection() {
    translate([0,0,tlength/2-2]) rotate([0,7,0]) rotate_extrude(convexity = 10, $fn = 100)  translate([tube/2-3, 0, 0]) circle(r = 1.7, $fn = 4);
    translate([0,0,0]) cube([tube/2,tube/2,tlength]);
}