
module keepers() {
difference() {
    translate([0,0,0]) circle(d=6, $fn=30);
    translate([0,0,0]) circle(d=3.2, $fn=30);
    }
}
module fan() {
difference() {
    translate([0,0,0]) square([40,40]);
    translate([6,6,0]) square([28,28]);
    }
}
module openframe() {
    linear_extrude(4) {
            union() {
            translate([0,0,0]) fan();
            translate([8,8,0]) keepers();
            translate([8,32,0]) keepers();
            translate([32,8,0]) keepers();
            translate([32,32,0]) keepers();
            }
    }
}
module sidesupport() {
        linear_extrude(2) { hull() {
        translate([-61.4,39]) circle(d=1);
        translate([0,39]) circle(d=1);
        translate([0,0]) circle(d=1);
        }
    }
}
module invertedframe() {
    rotate([90,0,0]) {
            union() {   
                translate([0,0,0]) openframe();
                translate([0,0.5,4]) rotate([0,90,0]) sidesupport();
                translate([38,0.5,4]) rotate([0,90,0]) sidesupport();
        }
    }
}
module probemount() { difference() {
    translate([9,0,0]) rotate([90,270,0]) cube([20,36,5]);
    translate([-21,0,8]) rotate([90,0,0]) cylinder(h=5, d=5, $fn=12);
    translate([3,0,8]) rotate([90,0,0]) cylinder(h=5, d=5, $fn=12);
    hull() {
            translate([-14.5,0,10]) rotate([90,0,0]) cylinder(h=5, d=3, $fn=12);
            translate([-14.5,0,5]) rotate([90,0,0]) cylinder(h=5, d=3, $fn=12);
            }   
    hull() {
            translate([-3.5,0,10]) rotate([90,0,0]) cylinder(h=5, d=3, $fn=12);
            translate([-3.5,0,5]) rotate([90,0,0]) cylinder(h=5, d=3, $fn=12);
            }
    }
}
module unit() {
    union () {
                invertedframe();
                translate([0,-10,39.5]) cube([40,10,8]);
                translate([0,-65.8,39.5]) cube([40,10,8]);
                translate([29,-60.8,22]) probemount();
    }
}
difference() {
    translate([42,0,0]) rotate([0,0,180]) unit();
    hull() {
            translate([40,24,22]) rotate([0,90,0]) cylinder(h=4, d=10, $fn=90);
            translate([40,36,30]) rotate([0,90,0]) cylinder(h=4, d=10, $fn=90);
            translate([40,24,30]) rotate([0,90,0]) cylinder(h=4, d=10, $fn=90);
            }
    translate([0,4,44]) rotate([0,90,0]) cylinder(h=44, d=4.3, $fn=12);
    translate([0,61,44]) rotate([0,90,0]) cylinder(h=44, d=4.3, $fn=12);
}