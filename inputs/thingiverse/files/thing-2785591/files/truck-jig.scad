difference() {
    cube([77.56, 55.64, 10]);

    // bottom holes
    translate([7.85, 7.12, -5])
        cylinder(20, 3.05, 3.05);
    translate([7.85, 49.05, -5])
        cylinder(20, 3.05, 3.05);

    // top holes (short)
    translate([61.20, 7.12, -5])
        cylinder(20, 3.05, 3.05);
    translate([61.20, 49.05, -5])
        cylinder(20, 3.05, 3.05);

    // top holes (long)
    translate([71.22, 7.12, -5])
        cylinder(20, 3.05, 3.05);
    translate([71.22, 49.05, -5])
        cylinder(20, 3.05, 3.05);
    
    // center line cutout
    translate([0, 26.82, 7.5])
        cube([77.65, 2, 10]);
}