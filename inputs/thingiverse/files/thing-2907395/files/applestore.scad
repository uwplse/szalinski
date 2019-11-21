scale([1.05,.95,1]) applestore(); // scale([x,y,z])

module rine(width) {
    difference() {
        difference() {
            sphere(width);
            sphere(width-2);
        }
        translate([1,1,4]) sphere(width-1);
    }
}

module rine(width) {
    difference() {
        sphere(width);
        cube(width*2);
        sphere(width-2);
    }
}

module seed(height,width) {
    translate([0,0,-height]) circle(width);
}

module core(height,width) {
   translate([0,0,-height]) cylinder(width);
}

module stem() {
   rotate([2,2,4]) translate([0,0,-21]) sphere(2);
}

module ground() {
    translate([0,0,-15]) circle(25);
}

module applestore() {
    difference() {
        union() {
            rotate([180,0,0]) {
                color("darkgray") stem();
                color("green") rine(20);
                color("white") seed(-11,6); // seed(height,width)
                color("black") core(18,33); // core(height,width)
            }
            color("grey") ground();
        }
        translate([-13,-13,-41.25]) cube(26);
    }
}