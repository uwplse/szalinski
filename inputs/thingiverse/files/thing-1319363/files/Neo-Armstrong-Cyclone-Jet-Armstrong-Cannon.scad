
l=48;

translate([5,5,5]) {
    sphere(r=5, $fn=100);
}

translate([15,5,0]) {
    difference() {
        union() {
            cylinder(r=5, h=l, $fn=100);
            translate([0,0,l-10]) {
                cylinder(r1=5, r2=6, h=2, $fn=100);
            }
            translate([0,0,l-8]) {
                cylinder(r1=6, r2=5, h=8, $fn=100);
            }
        }
        translate([0,0,1]) {
            cylinder(r=4, h=l+1, $fn=100);
        }
    }
}

translate([25,5,5]) {
    sphere(r=5, $fn=100);
}


