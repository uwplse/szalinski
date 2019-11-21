union() {

    difference() {
        translate([0,-10,0])cube([70,20,5]);
        translate([5,5,0])cylinder(h=10, r=1.7, $fs=0.01);
        translate([65,5,0])cylinder(h=10, r=1.7, $fs=0.01);
        translate([5,5,2.5])cylinder(10,3.2,3.2, $fn=6);
        translate([65,5,2.5])cylinder(10,3.2,3.2, $fn=6);
    }

    difference() {
        union() {
            translate([10,-10,0])cube([10,20,16]);
            translate([50,-10,0])cube([10,20,16]);
        }
        translate([10,-5,5])cube([50,15,6]);
    }
}