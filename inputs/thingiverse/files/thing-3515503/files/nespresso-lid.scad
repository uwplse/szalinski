module original_lid() {
    difference() {
        import("./original_lid.stl");
        translate([-40, -27, 1]) {
            rotate([0, 90, 0]) {
                cylinder(r=1.5, h=80, $fn=50);
            }
        }
    }
}

module top() {
    difference() {
        translate([0, 0, 8]) {
            cylinder(d=92.5, h=1.5, $fn=50);
        }
        translate([-92.5/2, -50, 7]) {
            cube([92.5, 50, 3]);
        }            
    }
    translate([-92.5/2, -25.5, 8]) {
        cube([92.5, 26, 1.5]);
    }
    translate([-85/2, -25.5, 5]) {
        cube([85, 1.5, 3]);
    }
    translate([-85/2, -24, 7]) {
        cube([85, 1.5, 2]);
    }    
}

module lid() {
    original_lid();
    top();
}


lid();