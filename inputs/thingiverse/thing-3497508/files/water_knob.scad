$fn = 180;
difference() {
    cylinder(20, d=27, true);
    translate([0, 0, -0.01]) {
        cylinder(15.5, d=18.55, true);
    }
    translate([0,0,-0.01]) {
        difference() {
            cylinder(2, d=27.01, true);
            translate([0, 0, -0.01]) {
                cylinder(2.1, d=23.15, true);
            }
        }
    }
    //translate([0, 0, 58]) {
    //    sphere(40);
    //}
    
    for (i = [0:10])
    {
        translate([17 * cos(i * 36), 17 * sin(i * 36), 0]){
            cylinder(20.01, d=10, true);
        }
    }
    
    // translate([0, 0, 19]) {
    //    difference() {
    //        cylinder(5, d1=30, d2=20, true);
    //        cylinder(5, d1=28, d2=19, true);
    //    }
    //}

}

translate([0, 0, 7]) {
    difference() {
        cylinder(12, d=10, true);
        union() {
            translate([-2.25, -2.25, -0.01]) {
                cube([4.5, 4.5, 6.02], false);
            }
            translate([0, 0, 6]) {
                cylinder(4, d=4, true);
            }
        }
    }
}
