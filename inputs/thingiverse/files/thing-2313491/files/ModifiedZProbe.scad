$fn=20;
block_len = 5;
intersection() {
    difference() {
        union() {
            translate([0,0,40])
                import("Z-Probe.stl");
            if (block_len > 0) {
                translate([20,28,0])
                    cube([25,block_len+18,7]);
                translate([32,43,7])
                    cube([13,block_len+3,7]);
            }
        }
        translate([6.5,35,7])
            cylinder(d=12.5, h=200);
        translate([6.5,35,-1])
            cylinder(d=4, h=200);
        hull() {
            translate([38.5,32,-10])
                cylinder(d=3, h=100);
            translate([38.5,38,-10])
                cylinder(d=3, h=100);
        }
        translate([4, 42.5, -10]) 
            cube([16, 17, 50]);
        translate([4, 13, -10]) 
            cube([13, 17, 50]);
        translate([8.5,0,5])
            cube([6.5, 100, 100]);
    }
//    translate([-5,20, 0])
//        cube([60, 50, 14]);
}
// Belt teeth grips
for (i = [0, 5, 10]) {
    translate([8.5,40-i,5.5]) {
        cube([6.5, 2.5, 0.8]);
    }
}


translate([8.5,30,4]) {
    cube([6.5, 12.5, 1.5]);
}
// Replacement block next to grips
translate([4, 26, 0]) {
    cube([13, 4, 5.5]);
}